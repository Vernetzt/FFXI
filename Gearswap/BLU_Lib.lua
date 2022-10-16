version = "3.0"

-- Saying hello
pName = player.name
windower.add_to_chat(8,'----- Welcome back to your BLU.lua, '..pName..' -----')

-- We're RDM so we're using Carm legs.
runspeedslot = 'legs'

--------------------------------------------------------------------------------------------------------------
-- HUD STUFF -- TO BE EXTERNALIZED
--------------------------------------------------------------------------------------------------------------
meleeing = M('AUTO', 'ON', 'OFF')
lock = M('OFF', 'ON')
mBurst = M(false)
runspeed = M('OFF', 'ON')
oldElement = elements.current
mBurstOldValue = mBurst.value
matchsc = M('AUTO', 'OFF', 'ON')
MB_Window = 0
dualwield = M('AUTO', '31', '11')
thMode = M('OFF', 'ON')
EvaMode = M('OFF', 'ON')
currentHaste = 30
TizonaAM3 = false
ammoLock = M('OFF', 'ON')
rangeLock = M('OFF', 'ON')
-- bow = M('OFF', 'ON')
lastIdle = ""
lastMelee = ""
flipforce = true
testforce = true

-- Old?
-- tickdelay = os.clock() + 5
-- time_start = 0

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

setupTextWindow()

Buff = 
    {
        ['Burst Affinity'] = false, 
        ['Chain Affinity'] = false, 
        ['Diffusion'] = false,
    }
    
function update_active_ja(name, gain)
    Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    Buff['Diffusion'] = buffactive['Diffusion'] or false
end

function buff_refresh(name,buff_details)
    -- Update JAs when a buff refreshes.
    update_active_ja()
    validateTextInformation()
    -- NEW
    updateDualWield()
    updateAftermath()

end

function buff_change(name,gain,buff_details)
    -- Update JAs when a buff is gained or lost.
    update_active_ja()
    validateTextInformation()
    -- NEW
    updateDualWield()
    updateAftermath()
    
    if player.equipment.main == 'Tizona' and name == "Aftermath: Lv.3" then
        if gain then
            add_to_chat(322, 'AM3 is on')
            send_command('timers create "Mythic AM3" 180 down')
            idle()
        else
            add_to_chat(322, 'AM3 is off')
            send_command('timers delete "Mythic AM3";gs c -cd AM3 Lost!!!')
            idle()
        end
    end

    autoDT(name,gain)
end

function BLU_lockMainHand( value )
    -- We want to force lock weapons
    if value == 'ON' then
        disable('main','sub','ranged')
        enable ('ammo')
        ammoLock:set('OFF')
        rangeLock:set('ON')
    -- If we are in auto or off mode, but not in zeroTP, we unlock everything
    elseif value == 'OFF' or 'AUTO' then
        enable('main','sub','ranged','ammo')
        ammoLock:set('OFF')
        rangeLock:set('OFF')
    end
    validateTextInformation()
end


function precast(spell)
    -- Get the spell mapping, since we'll be passing it to various functions and checks.
    local spellMap = get_spell_map(spell)
    local enfeebMap = get_enfeeb_map(spell)
    local bluMap = get_blu_map(spell)
    local spell_recasts = windower.ffxi.get_spell_recasts()

    -- Auto use Echo Drops if you are trying to cast while silenced --    
    if spell.action_type == 'Magic' and buffactive['Silence'] then 
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')     
        add_to_chat(322, '****** !! '..spell.name..' CANCELED - Using Echo Drops !! ******')
        return
    end       

	-- auto Nuke downgrade (T5 to T4 to T3 etc..) if the one you were trying is on recast timer. 
	-- It's a *bit* wonky when you spam the macro, so don't spam macros, or remove that part.
	if spell.action_type  == 'Magic' and spell_recasts[spell.recast_id] > 0 then
        cancel_spell()
        downgradenuke(spell)
        add_to_chat(322, '['..spell.name..' CANCELED - Spell on Cooldown, Downgrading]')
        send_command('input /recast "'..spell.name..'"')
        return
    end

    -- Checks for the TP threshold to lock weapons if over TP treshold -or- if we are in zeroTP mode 
    if meleeing.value == "AUTO" then
        -- if player.tp >= lockWeaponTP or meleeModes.current == 'zeroTP' then
        if player.tp >= lockWeaponTP then
            lock:set('ON')
        else
            lock:set('OFF')
        end
        BLU_lockMainHand(lock.value)
    end
	

	if spellMap == 'Utsusemi' then
        if buffactive[445] or buffactive[446] then
            cancel_spell()
            add_to_chat(322, '****** !! '..spell.english..' Canceled: [3+ IMAGES] !! ******')
        elseif (buffactive['Copy Image'] or buffactive['Copy Image (2)']) and spell.name == 'Utsusemi: Ichi' then
			windower.ffxi.cancel_buff(66)
			windower.ffxi.cancel_buff(444)
        end
	end

    -- Moving on to other types of magic
    if spell.type == 'WhiteMagic' or spell.type == 'BlackMagic' or spell.type == 'Ninjutsu' or spell.type == 'BlueMagic' or spell.type == 'Trust' then
     
        -- Stoneskin Precast
        if spell.name == 'Stoneskin' then
         
            windower.ffxi.cancel_buff(37)--[[Cancels stoneskin, not delayed incase you get a Quick Cast]]
            equip(sets.precast.stoneskin)
             
        -- Cure Precast
        elseif spell.name:match('Cure') or spell.name:match('Cura') then
         
            equip(sets.precast.cure)         
        -- Enhancing Magic
        elseif spell.skill == 'Enhancing Magic' then
         
            equip(sets.precast.enhancing)            
            if spell.target.type == 'SELF' and spell.name == 'Sneak' then
                windower.ffxi.cancel_buff(71)--[[Cancels Sneak]]
            end
        else       
            -- For everything else we go with max fastcast
            equip(sets.precast.casting)                
        end
    end
    -- Job Abilities
    -- We use a catch all here, if the set exists for an ability, use it
    -- This way we don't need to write a load of different code for different abilities, just make a set
    if sets.precast[spell.name] then
        equip(sets.precast[spell.name])        
    end
end
 
function midcast(spell)
    -- Get the spell mapping, since we'll be passing it to various functions and checks.
    local spellMap = get_spell_map(spell)
    local enfeebMap = get_enfeeb_map(spell)
    local bluMap = get_blu_map(spell)

    -- No need to annotate all this, it's fairly logical. Just equips the relevant sets for the relevant magic
    -- Curing
    if spell.name:match('Cure') or spell.name:match('Cura') or bluMap == 'BluHealing' then
        if spell.target.type == 'SELF' then
            equip(sets.midcast.cure.self)
        else
            equip(sets.midcast.cure.normal)
        end
    elseif spell.name:match('White Wind') then
        equip(sets.midcast.cure.wind)

    -- elseif spell.name:match('Utsusemi') then
    --     -- equip(sets.midcast.utsu)

    -- Blue Magic
    -- Redo logic and mappings
    elseif spell.skill == 'Blue Magic' then
        if bluMap == 'BluSTR' then
            equip(sets.midcast.BluSTR)
        elseif bluMap == 'BluDEX' then
            equip(sets.midcast.BluDEX)
        elseif bluMap == 'BluVIT' then
            equip(sets.midcast.BluVIT)
        elseif bluMap == 'BluAGI' then
            equip(sets.midcast.BluAGI)
        elseif bluMap == 'BluMACC' then
            -- EVASION RULE WIP
            if spell.name:match('Dream Flower') or spell.name:match('Yawn') or spell.name:match('Sheep Song') then
                if idleModes.value == 'eva' or meleeModes.value == 'eva' then
                    equip(sets.midcast.BluEVA)
                else 
                    equip(sets.midcast.BluMACC)
                end
            else
                equip(sets.midcast.BluMACC)
            end
        elseif bluMap == 'BluStun' then
            equip(sets.midcast.BluStun)
        elseif bluMap == 'BluDark' then
            equip(sets.midcast.BluDark)
            SashLogic(spell)
        elseif bluMap == 'BluLight' then
            equip(sets.midcast.BluLight)
        elseif bluMap == 'BluBreath' then
            equip(sets.midcast.BluBreath)
        -- elseif bluMap == 'BluEarth' then
        --     equip(sets.midcast.BluEarth)
        elseif bluMap == 'BluINT' then
            if mBurst.value == true and Buff['Burst Affinity'] then
                equip(sets.midcast.MB[nukeModes.current])
            else
                equip(sets.midcast.nuking[nukeModes.current])
            end
            
            -- Obi / Orph logic
            if spell.skill ~= 'Enhancing Magic' and spellMap ~= 'Helix' then
                SashLogic(spell)
            end

            -- EVASION RULE WIP
            if spell.name:match('Entomb') then
                if idleModes.value == 'eva' or meleeModes.value == 'eva' then
                    equip(sets.midcast.BluEVA)
                end
            end

        elseif spell.name:match('Battery Charge') then
            equip(sets.midcast.refresh)

        elseif spell.name:match('Barrier Tusk') then
            equip(sets.midcast.phalanx)

        elseif bluMap == 'BluBuff' then
            equip(sets.midcast.BluBuff)
            if Buff['Diffusion'] then
                equip({feet=RELIC.Feet})
            end
        elseif bluMap == 'BluSkill' then
            equip(sets.midcast.BluSkill)
            if Buff['Diffusion'] then
                equip({feet=RELIC.Feet})
            end
        elseif bluMap == 'BluFastRecast' then
            equip(sets.midcast.BluFastRecast)
        end

    -- Enhancing
    elseif spell.skill == 'Enhancing Magic' then

        if spell.name:match('Protect') or spell.name:match('Shell') then
            equip({rring="Sheltered Ring"})
        elseif spell.name:match('Refresh') then
            equip(sets.midcast.refresh)
        elseif spell.name:match('Regen') then
            equip(sets.midcast.regen)
        elseif spell.name:match('Aquaveil') then
            equip(sets.midcast.aquaveil)
        elseif spell.name:match('Phalanx') then
            equip(sets.midcast.phalanx)
        elseif spell.name:match('Stoneskin') then
            equip(sets.midcast.stoneskin)
        else
            equip(sets.midcast.enhancing) -- fall back to duration if not specified above 
        end


    -- Enfeebling
    elseif spell.skill == 'Enfeebling Magic' then
        equip(sets.midcast.BluMACC)

    elseif spell.type == 'Trust' then
        equip(sets.precast.casting)

    -- Nuking
    elseif spell.type == 'BlackMagic' then
        if mBurst.value == true then
            equip(sets.midcast.MB[nukeModes.current])
        else
            equip(sets.midcast.nuking[nukeModes.current])
        end

        -- Obi / Orph logic
        if spell.skill ~= 'Enhancing Magic' and spellMap ~= 'Helix' then
            SashLogic(spell)
        end
    
    -- Fail safe
    elseif spell.type ~= "WeaponSkill" then
        equip(sets.midcast.casting)
    end
    -- And our catch all, if a set exists for this spell name, use it
    if sets.midcast[spell.name] then
        equip(sets.midcast[spell.name])
    -- Catch all for tiered spells (use mapping), basically if no set for spell name, check set for spell mapping. AKA Drain works for all Drain tiers.
    elseif sets.midcast[spellMap] then
        equip(sets.midcast[spellMap])
    end
    -- Weapon skills
    -- sets.me["Insert Weaponskill"] are basically how I define any non-magic spells sets, aka, WS, JA, Idles, etc.
    if sets.me[spell.name] then
        equip(sets.me[spell.name])

        -- Sanguine BBlade belt optim
        if spell.name == 'Sanguine Blade' then
            -- Dark day and dark weather
            if spell.element == world.day_element and spell.element == world.weather_element then
                equip(sets.midcast.Obi)
            -- Double dark weather aka Dynamis
            elseif spell.element == world.weather_element and get_weather_intensity() == 2 then
                equip(sets.midcast.Obi)
            else
                equip(sets.midcast.Orpheus)                
            end
        end

    end

    -- Th Mode: See Function
    if thMode.value == 'ON' then
        autoTH(spell)
    end
    
end

function aftercast(spell)

    -- Checks for the TP threshold to lock weapons if over TP treshold -or- if we are in zeroTP mode 
    if meleeing.value == "AUTO" then
        -- if player.tp >= lockWeaponTP or meleeModes.current == 'zeroTP' then
        if player.tp >= lockWeaponTP then
            lock:set('ON')
        else
            lock:set('OFF')
        end
        BLU_lockMainHand(lock.value)
    end

    update_active_ja()
    updateDualWield()
    updateAftermath()
    
    -- updateTimers()
    if not spell.interrupted then
        if spell.english == "Sheep Song" then
            send_command('wait 30;gs c -cd '..spell.name..': [Off In 10~30 Seconds!];wait 10;gs c -cd '..spell.name..': [Off In 0~20 Seconds!]')
            send_command('timers create "Sheep Song" 40 down')
        elseif spell.english == "Yawn" then
            send_command('wait 60;gs c -cd '..spell.name..': [Off In 10~30 Seconds!];wait 10;gs c -cd '..spell.name..': [Off In 0~20 Seconds!]')
            send_command('timers create "Yawn" 70 down')
        elseif spell.english == "Dream Flower" then
            send_command('wait 80;gs c -cd '..spell.name..': [Off In 10~40 Seconds!];wait 10;gs c -cd '..spell.name..': [Off In 0~30 Seconds!]')
            send_command('timers create "Dream Flower" 90 down')
       elseif spell.english == "Entomb" then
            send_command('timers create "Entomb Petrification" 60 down')
        end 
    end

    idle()

end


function idle()
    -- This function is called after every action, and handles which set to equip depending on what we're doing
    -- We check if we're meleeing because we don't want to idle in melee gear when we're only engaged for trusts
    -- Write better DW and AM3 logic
    if player.status=='Engaged' then
        if player.equipment.main == "Tizona" then
            updateAftermath()
        end
        if dualwield.value == 'AUTO' then
            if currentHaste == 30 then
                if TizonaAM3 == true then
                    equip(sets.me.melee[meleeModes.value..'dw'].TizAM3)
                else
                    equip(sets.me.melee[meleeModes.value..'dw'])
                end
            elseif currentHaste == 47 then
              if TizonaAM3 == true then
                    equip(sets.me.melee[meleeModes.value..'dw11'].TizAM3)
                else
                    equip(sets.me.melee[meleeModes.value..'dw11'])
                end
            end
          else
            if dualwield.value == "11" then
                if TizonaAM3 == true then
                    equip(sets.me.melee[meleeModes.value..'dw11'].TizAM3)
                else
                    equip(sets.me.melee[meleeModes.value..'dw11'])
                end
             else
                if TizonaAM3 == true then
                    equip(sets.me.melee[meleeModes.value..'dw'].TizAM3)
                else
                    equip(sets.me.melee[meleeModes.value..'dw'])
                end
            end
          end
    else
        equip(sets.me.idle[idleModes.value])
        -- Checks MP for Fucho-no-Obi
        if player.mpp < 51 then
            equip(sets.me.latent_refresh)          
        end       
    end
    equip({main = mainWeapon.current, sub = subWeapon.current})
end
 
function status_change(new,old)
    if new == 'Engaged' then  
        -- If we engage check our meleeing status
        idle()

        -- TH
        if thMode.value == 'ON' then
            equip(sets.Utility.TH)
            add_to_chat(322, 'Test TH on new engage')
        end

    elseif new=='Resting' then
     
        -- We're resting
        equip(sets.me.resting)          
    else
        idle()
    end
end

function self_command(command)
    hud_command(command)
    local commandArgs = command
     
    if #commandArgs:split(' ') >= 2 then
        commandArgs = T(commandArgs:split(' '))
        
        if commandArgs[1] == 'toggle' then
            if commandArgs[2] == 'melee' then
                meleeing:cycle()
                BLU_lockMainHand(meleeing.value)

            elseif commandArgs[2] == 'runspeed' then
                runspeed:cycle()
                updateRunspeedGear(runspeed.value, runspeedslot)

            elseif commandArgs[2] == 'idlemode' then
                flipforce = true
                idleModes:cycle()
                idle()

            elseif commandArgs[2] == 'meleemode' then
                flipforce = true
                meleeModes:cycle()
                idle()

            -- NEW
            elseif commandArgs[2] == 'dualwield' then
                dualwield:cycle()
                idle()

            elseif commandArgs[2] == 'forcedt' then
                forceDT()
                idle()           

            elseif commandArgs[2] == 'thmode' then
                thMode:cycle()
                if player.status=='Engaged' and thMode.value == 'ON' then
                    equip(sets.Utility.TH)
                else
                    idle()
                end

            -- elseif commandArgs[2] == 'bow' then
            --     bow:cycle()
            --     RDM_lockMainHand(meleeing.value)
            --     idle()

            --     if bow.value == 'ON' then
            --         enable('ranged','ammo')
            --         equip({ranged=ambuBow})
            --         disable('ranged','ammo')
            --     end

            elseif commandArgs[2] == 'mainweapon' then
                if commandArgs[3] then
                    mainWeapon:set(commandArgs[3])
                else
                    mainWeapon:cycle()
                end

                idle()
                if announceState then
                    add_to_chat(322, 'Main: '..mainWeapon.value..'')
                end

            elseif commandArgs[2] == 'subweapon' then
                if commandArgs[3] then
                    subWeapon:set(commandArgs[3])
                else
                    subWeapon:cycle()
                end
                
                idle()
                if announceState then
                    add_to_chat(322, 'Sub: '..subWeapon.value..'')
                end

            elseif commandArgs[2] == 'weapons' then
                if commandArgs[3] == 'TizTP' then
                    mainWeapon:set('Tizona')
                    subWeapon:set(TpBonus)
                elseif commandArgs[3] == 'TizNae' then
                    mainWeapon:set('Tizona')
                    subWeapon:set('Naegling')
                elseif commandArgs[3] == 'MaxKaja' then
                    mainWeapon:set('Maxentius')
                    subWeapon:set('Kaja Rod')
                elseif commandArgs[3] == 'MaxTP' then
                    mainWeapon:set('Maxentius')
                    subWeapon:set(TpBonus)
                end

                idle()
                if announceState then
                    add_to_chat(322, 'Main: '..mainWeapon.value..'')
                    add_to_chat(322, 'Sub: '..subWeapon.value..'')
                end

            elseif commandArgs[2] == 'nukemode' then
                nukeModes:cycle()      

            elseif commandArgs[2] == 'matchsc' then
                matchsc:cycle()               
            end
            validateTextInformation()
        end
        
        if commandArgs[1]:lower() == 'scholar' then
            handle_strategems(commandArgs)

        elseif commandArgs[1]:lower() == 'nuke' then
            if not commandArgs[2] then
                windower.add_to_chat(123,'No element type given.')indower.add_to_chat(123,'No element type given.')
                return
            end
            
            local nuke = commandArgs[2]:lower()
            
            if (nuke == 'cycle' or nuke == 'cycledown') then
                if nuke == 'cycle' then
                    elements:cycle()
                    oldElement = elements.current
                elseif nuke == 'cycledown' then 
                    elements:cycleback() 
                    oldElement = elements.current
                end               
                validateTextInformation()

            elseif (nuke == 'enspellup' or nuke == 'enspelldown') then
                if nuke == 'enspellup' then
                    enspellElements:cycle()
                elseif nuke == 'enspelldown' then 
                    enspellElements:cycleback()
                end     
                validateTextInformation()

            elseif (nuke == 'air' or nuke == 'ice' or nuke == 'fire' or nuke == 'water' or nuke == 'lightning' or nuke == 'earth' or nuke == 'light' or nuke == 'dark') then
                local newType = commandArgs[2]
                elements:set(newType)                  
                validateTextInformation()

            elseif not nukes[nuke] then
                windower.add_to_chat(123,'Unknown element type: '..tostring(commandArgs[2]))
                return              
            elseif nuke == 'enspell' then
                send_command('@input /ma "'..nukes[nuke][enspellElements.current]..'"')     
            else        
                -- Leave out target; let Shortcuts auto-determine it.
                --recast = windower.ffxi.get_spell_recasts(nukes[nuke][elements.current])
                --if recast > 0 
                send_command('@input /ma "'..nukes[nuke][elements.current]..'"')     
            end
        end
    end
end


-- Checks if auto and then sets var for engage logic.
-- Find better dynamic solution for better accuracy or rewrite buff logic.
function updateDualWield()
    if dualwield.value == 'AUTO' then
        if ( (buffactive[33] and not (buffactive.march or buffactive[580] or buffactive[604] or buffactive[228])) or --30% Haste and nothing else pretty much.
            (buffactive[13] and (buffactive.march or buffactive[604]) and (buffactive[580] or buffactive[604] or buffactive[228])) or --Honor March/MG alone very roughly negates slow, leaving you just needing a second.
            (buffactive[565] and buffactive.march == 2 and buffactive[580] and (buffactive[604] or buffactive[228])) ) then
            -- 30% haste
            currentHaste = 30
        elseif ( (buffactive[33] and (buffactive[580] or buffactive.march or buffactive[604] or buffactive[228])) or -- Flutter and Geo or march or MG or embrava
                (buffactive[580] and (buffactive.march or buffactive[604] or buffactive[228])) or -- Geo and march or MG or embrava
                (buffactive.march == 2 and (buffactive[604] or buffactive[228])) or -- March x2 and MG or Embrava
                (buffactive[13] and (buffactive.march == 2 or buffactive[580]) and (buffactive[604] or buffactive[228])) ) then -- Slow, but likez the mad buffs 'n shiz, yo.
            -- Capped Haste?
            currentHaste = 47
        end
    else
        -- Defaulting for next use.
        currentHaste = 30
    end
end

function updateAftermath(name, gain)
    if buffactive["aftermath: Lv.3"] and player.equipment.main == 'Tizona' then
        TizonaAM3 = true
    else
        TizonaAM3 = false
        send_command('timers delete "Mythic AM3"')
    end
end

function autoDT(name,gain)
    local name2
    name2 = string.lower(name)
    if S{"terror","petrification","sleep","stun"}:contains(name2) then
      if gain then
        equip(sets.Utility.AutoDT)
      else
        idle()
      end
    elseif name2 == "Doom" then
      if gain then
          -- equip(sets.Utility.Doom)
          send_command('@input /p Doomed')
          -- disable('ring1','ring2','waist')
      else
        send_command('@input /p Doom is off')
        -- enable('ring1','ring2','waist')
      end
    elseif name2 == "charm" then
      if gain then
          send_command('@input /p Charmed')
      else
          send_command('@input /p Charm is off')
      end
    elseif name2 == "Mighty Guard" then
      if gain then
      else
        -- send_command('gs c -cd Mighty Guard Lost!')
      end
    end
end

function updateTimers(spell)
    if not spell.interrupted then
        if spell.english == "Sheep Song" then
            -- send_command('wait 30;gs c -cd '..spell.name..': [Off In 10~30 Seconds!];wait 10;gs c -cd '..spell.name..': [Off In 0~20 Seconds!]')
            send_command('timers create "Sheep Song" 40 down')
        elseif spell.english == "Yawn" then
            -- send_command('wait 60;gs c -cd '..spell.name..': [Off In 10~30 Seconds!];wait 10;gs c -cd '..spell.name..': [Off In 0~20 Seconds!]')
            send_command('timers create "Yawn" 70 down')
        elseif spell.english == "Dream Flower" then
            -- send_command('wait 80;gs c -cd '..spell.name..': [Off In 10~40 Seconds!];wait 10;gs c -cd '..spell.name..': [Off In 0~30 Seconds!]')
            send_command('timers create "Dream Flower" 90 down')
       elseif spell.english == "Entomb" then
            send_command('timers create "Entomb Petrification" 60 down')
        end 
    end
end

function forceDT()
    if flipforce == true then
        lastIdle = idleModes.value
        lastMelee = meleeModes.value
        idleModes:set('dt')
        meleeModes:set('dt')
        flipforce = false
    else
        idleModes:set(lastIdle)
        meleeModes:set(lastMelee)
        flipforce = true
    end  
end

function autoTH(spell)
    if thMode.value == 'ON' then
        spellname = string.lower(spell.name)
        -- Add "spells" you wish TH gear to equip on
        if S{"entomb"}:contains(spellname) then
            equip(sets.Utility.TH)
        end
    end
end
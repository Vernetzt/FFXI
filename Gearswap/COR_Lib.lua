version = "3.0"

-- Saying hello
pName = player.name
windower.add_to_chat(8,'----- Welcome back to your RDM.lua, '..pName..' -----')

-- We're RDM so we're using Carm legs.
runspeedslot = 'legs'

--------------------------------------------------------------------------------------------------------------
-- HUD STUFF -- TO BE EXTERNALIZED
--------------------------------------------------------------------------------------------------------------
meleeing = M('OFF', 'ON')
lock = M('OFF', 'ON')
mBurst = M(false)
runspeed = M('OFF', 'ON')
oldElement = elements.current
mBurstOldValue = mBurst.value
matchsc = M('OFF', 'ON', 'AUTO')
MB_Window = 0
dualwield = M('AUTO', '31', '11')
bow = M('OFF', 'ON')
thMode = M('OFF', 'ON')
currentHaste = 30

lastIdle = ""
lastMelee = ""
flipforce = true

ammo_warning_limit = 10
warned = M(false)
flurry = 0
snapshot = M('AUTO','0','15','30')

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

setupTextWindow()

Buff = 
    {
        ['Triple Shot'] = false
    }
    
-- Reset the state vars tracking strategems.
function update_active_ja(name, gain)
    Buff['Triple Shot'] = buffactive['Triple Shot'] or false
end

function buff_refresh(name,buff_details)
    -- Update JA and statagems when a buff refreshes.
    update_active_ja()
    validateTextInformation()
    updateDualWield()
end

function buff_change(name,gain,buff_details)
    -- Update JA and statagems when a buff is gained or lost.
    update_active_ja()
    validateTextInformation()
    updateDualWield()
    updateSnapshot()
    get_flury_value(name,gain)
    autoDT(name,gain)

end

function COR_weaponLock( value )
    -- We want to force lock weapons
    if value == 'ON' then
        disable('main','sub','ranged')

    -- If we are in auto or off mode
    elseif value == 'OFF' or 'AUTO' then
        enable('main','sub','ranged')
    end
    validateTextInformation()
end

function precast(spell)
    -- Get the spell mapping, since we'll be passing it to various functions and checks.
    local spellMap = get_spell_map(spell)
    local enfeebMap = get_enfeeb_map(spell)
	local spell_recasts = windower.ffxi.get_spell_recasts()

    -- Check that proper ammo is available if we're using ranged attacks or similar.
    do_bullet_checks(spell, spellMap)

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
        if spell.type == 'BlackMagic' then
            downgradenuke(spell)
            add_to_chat(322, '['..spell.name..' CANCELED - Spell on Cooldown, Downgrading]')
        else
            add_to_chat(322, '['..spell.name..' CANCELED - Spell on Cooldown]')
        end
        send_command('input /recast "'..spell.name..'"')
        return
    end     
	
	-- Checks for the TP threshold to lock weapons if over TP treshold
    if meleeing.value == "AUTO" then
        -- if player.tp >= lockWeaponTP or meleeModes.current == 'zeroTP' then
        if player.tp >= lockWeaponTP then
            lock:set('ON')
        else
            lock:set('OFF')
        end
        COR_weaponLock(lock.value)
    end
    

    -- Auto downgrade Phalanx II to Pahalanx I when casting on self, saves macro space so you can set your phalanx macro to cast phalanx2 on <stpt>
    if spell.target.type == 'SELF' and spell.name == "Phalanx II" then
        cancel_spell()
        send_command('input /ma "Phalanx" <me>') 
		add_to_chat(322, '****** ['..spell.name..' detected on self. Downgraded to Phalanx] ******')
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

    


    ----------------------------------------------------------------------------------------
    -- PRESHOT RANGED LOGIC
    ----------------------------------------------------------------------------------------
    if spell.action_type == 'Ranged Attack' then
        special_ammo_check()
        if flurry == 2 then
            equip(sets.precast.RA.Flurry2)
        elseif flurry == 1 then
            equip(sets.precast.RA.Flurry1)
        else
            equip(sets.precast.RA) 
        end
        
    elseif spell.type == 'WeaponSkill' then
        if spell.skill == 'Marksmanship' then
            special_ammo_check()
        end
    end

    -- Moving on to other types of magic
    if spell.type == 'WhiteMagic' or spell.type == 'BlackMagic' or spell.type == 'Ninjutsu' or spell.type == 'Trust' then
     
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

        elseif spell.name:match('Utsusemi') then       
            equip(sets.precast.utsu)

        else       
            -- For everything else we go with max fastcast
            equip(sets.precast.casting)                
        end
    end

    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
        if sets.precast.PhantomRoll[spell.name] then
            equip(sets.precast.PhantomRoll[spell.name])
        else
            equip(sets.precast.PhantomRoll)
        end
        if luzafMode.value == 'ON' then
            equip(sets.precast.LuzafRing)
        end
    end

    if spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
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

    -- No need to annotate all this, it's fairly logical. Just equips the relevant sets for the relevant magic
    -- Curing
    if spell.name:match('Cure') or spell.name:match('Cura') then
        if spell.element == world.weather_element or spell.element == world.day_element then
            if spell.target.type == 'SELF' then
                equip(sets.midcast.cure.weather.self)
            else
                equip(sets.midcast.cure.weather)
            end
        else
            if spell.target.type == 'SELF' then
                equip(sets.midcast.cure.self)
            else
                equip(sets.midcast.cure.normal)
            end
        end
    elseif spell.name:match('Utsusemi') then       
        equip(sets.midcast.utsu)
    
    ----------------------------------------------------------------------------------------
    -- MIDSHOT RANGED LOGIC
    ----------------------------------------------------------------------------------------

    elseif spell.type == 'CorsairShot' then
        if (spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot') then
           SashLogic(spell)
            if quickdrawModes.value == 'Potency' then
                equip(sets.midcast.Quickdraw.Potency)
            elseif quickdrawModes.value == 'STP' then
                equip(sets.midcast.Quickdraw.STP)
            end
        end
    elseif spell.action_type == 'Ranged Attack' then
        if Buff['Triple Shot'] then
            equip(sets.midcast.RA.triple[rangedModes.value])
        else
            equip(sets.midcast.RA[rangedModes.value])
        end
            -- if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
            --     equip(sets.TripleShotCritical)
            --     if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
            --         equip(sets.TrueShot)
            --     end
            -- end
        -- elseif buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
        --     equip(sets.midcast.RA.Critical)
        --     if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
        --         equip(sets.TrueShot)
        --     end
        -- end

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
        end

    -- Enfeebling
    elseif spell.skill == 'Enfeebling Magic' then
        equip(sets.midcast.casting)

    -- Nuking
    elseif spell.type == 'BlackMagic' then
        equip(sets.midcast.casting)
    
    elseif spell.type == 'Trust' then
        equip(sets.precast.casting)


    elseif (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
        if sets.precast.PhantomRoll[spell.name] then
            equip(sets.precast.PhantomRoll[spell.name])
        else
            equip(sets.precast.PhantomRoll)
        end
        if luzafMode.value == 'ON' then
            equip(sets.precast.LuzafRing)
        end

    elseif spell.type == 'JobAbility' then
        equip(sets.me.idle.dt)

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

    ----------------------------------------------------------------------------------------
    -- Weapon skills
    -- sets.me["Insert Weaponskill"] are basically how I define any non-magic spells sets, aka, WS, JA, Idles, etc.
    ----------------------------------------------------------------------------------------


    if sets.me[spell.name] then
        equip(sets.me[spell.name])

        if elemental_ws:contains(spell.name) then
            SashLogic(spell)
        end
    end

    -- Th Mode: See Function
    if thMode.value == 'ON' then
        autoTH(spell)
    end      

end

function aftercast(spell)

    -- Then initiate idle function to check which set should be equipped
    if meleeing.value == "AUTO" then
        -- if player.tp >= lockWeaponTP or meleeModes.value == 'zeroTP' then
        if player.tp >= lockWeaponTP then
            lock:set('ON')
        else
            lock:set('OFF')
        end
        COR_weaponLock(lock.value)
    end

    update_active_ja()
    updateDualWield()
    updateTimers(spell)
    idle()

end

-- NEW-- Remove chat confirms at a later date
function idle()
    -- This function is called after every action, and handles which set to equip depending on what we're doing
    -- We check if we're meleeing because we don't want to idle in melee gear when we're only engaged for trusts
    if player.status=='Engaged' then
        if subWeapon.current:match('Shield') or subWeapon.current:match('Bulwark') or subWeapon.current:match('Buckler') or subWeapon.current:match('Grip') or subWeapon.current:match('Strap') then
            equip(sets.me.melee[meleeModes.value..'sw'])
        else
          if dualwield.value == 'AUTO' then
            if currentHaste == 30 then
              equip(sets.me.melee[meleeModes.value..'dw'])
            elseif currentHaste == 47 then
              equip(sets.me.melee[meleeModes.value..'dw11'])
            end
          else
            if dualwield.value == "11" then
                equip(sets.me.melee[meleeModes.value..'dw11'])
            else
                equip(sets.me.melee[meleeModes.value..'dw'])
            end
          end
        end
    else
        equip(sets.me.idle[idleModes.value])
    end
    equip({main = mainWeapon.current, sub = subWeapon.current, ranged = rangedWeapon.current})
end
 
function status_change(new,old)
    if new == 'Engaged' then  
        -- If we engage check our meleeing status
        idle()
         
        if thMode.value == 'ON' then
            equip(sets.Utility.TH)
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
                COR_weaponLock(meleeing.value)
                if announceState then
                    add_to_chat(322, 'Lock: '..meleeing.value..'')
                end

            elseif commandArgs[2] == 'runspeed' then
                runspeed:cycle()
                updateRunspeedGear(runspeed.value, runspeedslot) 

            elseif commandArgs[2] == 'idlemode' then
                flipforce = true
                idleModes:cycle()
                idle()
                if announceState then
                    add_to_chat(322, 'Idle: '..idleModes.value..'')
                end

            elseif commandArgs[2] == 'meleemode' then
                flipforce = true
                meleeModes:cycle()
                idle()
                if announceState then
                    add_to_chat(322, 'Engage: '..meleeModes.value..'')
                end

            elseif commandArgs[2] == 'dualwield' then
                dualwield:cycle()
                idle()
                if announceState then
                    add_to_chat(322, 'DW: '..dualwield.value..'')
                end

            elseif commandArgs[2] == 'snapshot' then
                snapshot:cycle()
                idle()
                if announceState then
                    add_to_chat(322, 'SS: '..snapshot.value..'')
                end

            elseif commandArgs[2] == 'quickdraw' then
                quickdrawModes:cycle()
                idle()
                if announceState then
                    add_to_chat(322, 'Quickdraw: '..quickdrawModes.value..'')
                end

            elseif commandArgs[2] == 'luzaf' then
                luzafMode:cycle()
                idle()
                if announceState then
                    add_to_chat(322, 'Luzaf: '..luzafMode.value..'')
                end

            elseif commandArgs[2] == 'forcedt' then
                forceDT()
                idle()
                if announceState then
                    add_to_chat(322, 'Idle: '..idleModes.value..'')
                    add_to_chat(322, 'Engage: '..meleeModes.value..'')
                end

            elseif commandArgs[2] == 'thmode' then
                thMode:cycle()
                if player.status=='Engaged' and thMode.value == 'ON' then
                    equip(sets.Utility.TH)
                else
                    idle()
                end
                if announceState then
                    add_to_chat(322, 'TH: '..thMode.value..'')
                end

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

            elseif commandArgs[2] == 'rangedweapon' then
                if commandArgs[3] then
                    rangedWeapon:set(commandArgs[3])
                else
                    rangedWeapon:cycle()
                end

                idle()
                if announceState then
                    add_to_chat(322, 'Ranged: '..rangedWeapon.value..'')
                end

            elseif commandArgs[2] == 'weapons' then
                if commandArgs[3] == 'NaeTP' then
                    mainWeapon:set('Naegling')
                    subWeapon:set(TpBonus)
                elseif commandArgs[3] == 'MaxTP' then
                    mainWeapon:set('Maxentius')
                    subWeapon:set(TpBonus)
                elseif commandArgs[3] == 'TauTP' then
                    mainWeapon:set('Tauret')
                    subWeapon:set(TpBonus)
                elseif commandArgs[3] == 'CroTau' then
                    mainWeapon:set('Crocea Mors')
                    subWeapon:set('Tauret')
                elseif commandArgs[3] == 'CroDay' then
                    mainWeapon:set('Crocea Mors')
                    subWeapon:set('Daybreak')
                end
                
                idle()
                if announceState then
                    add_to_chat(322, 'Main: '..mainWeapon.value..'')
                    add_to_chat(322, 'Sub: '..subWeapon.value..'')
                    add_to_chat(322, 'Ranged: '..rangedWeapon.value..'')
                end

            elseif commandArgs[2] == 'rangedModes' then
                rangedModes:cycle()
                if announceState then
                    add_to_chat(322, 'Ranged: '..rangedModes.value..'')
                end

            elseif commandArgs[2] == 'matchsc' then
                matchsc:cycle()
                add_to_chat(322, 'Match SC: '..matchsc.value..'')
            end
            validateTextInformation()
        end

        if commandArgs[1] == 'ws' then
            if commandArgs[2] == 'auto' then
                if S{'Naegling'}:contains(player.equipment.main) then
                    send_command('@input /ws "Savage Blade" <t>')
                elseif S{'Tauret'}:contains(player.equipment.main) then
                    send_command('@input /ws "Evisceration" <t>')
                end
            end
        end
        
        if commandArgs[1]:lower() == 'quickdraw' then
            if not commandArgs[2] then
                windower.add_to_chat(123,'No element type given.')windower.add_to_chat(123,'No element type given.')
                return
            end
            
            local quickdraw = commandArgs[2]:lower()
            
            if (quickdraw == 'cycle' or quickdraw == 'cycledown') then
                if quickdraw == 'cycle' then
                    elements:cycle()
                    nextElement:cycle()
                    oldElement = elements.current
                elseif quickdraw == 'cycledown' then 
                    elements:cycleback() 
                    nextElement:cycleback()
                    oldElement = elements.current
                end               
                validateTextInformation()
                if announceState then
                    add_to_chat(322, 'Quickdraw: '..elements.current..' -> '..nextElement.current)
                end

            elseif (quickdraw == 'air' or quickdraw == 'ice' or quickdraw == 'fire' or quickdraw == 'water' or quickdraw == 'lightning' or quickdraw == 'earth') then
                local newType = commandArgs[2]
                elements:set(newType)
                oldElement = elements.current
                validateTextInformation()
                send_command('@input /ja "'..nukes['quickdraw'][elements.current]..'"')

            elseif (quickdraw == 'light' or quickdraw == 'dark') then
                local newType = commandArgs[2]
                elements:set(newType)
                validateTextInformation()
                send_command('@input /ja "'..nukes['quickdraw'][elements.current]..'"')
                
            elseif not nukes[quickdraw] then
                windower.add_to_chat(123,'Unknown element type: '..tostring(commandArgs[2]))
                return              
            else        
                -- Leave out target; let Shortcuts auto-determine it.
                --recast = windower.ffxi.get_spell_recasts(nukes[nuke][elements.current])
                --if recast > 0 
                send_command('@input /ja "'..nukes[quickdraw][elements.current]..'"')
            end
        end
    end
end

function autoDT(name,gain)
    local name2
    name2 = string.lower(name)
    if S{"terror","petrification","sleep","stun"}:contains(name2) then
        if gain then
        add_to_chat(322, 'AutoDT: ON')
        equip(sets.Utility.AutoDT)
      else
        idle()
      end
    elseif name2 == "doom" then
        if gain then
            equip(sets.Utility.Doom)
            send_command('@input /p Doomed')
            disable('ring1','ring2','waist','neck')
        else
          send_command('@input /p Doom is off')
          enable('ring1','ring2','waist','neck')
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
        send_command('gs c -cd Mighty Guard Lost!')
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
        if S{"dispelga","diaga","circle blade","poisonga","aeolian edge"}:contains(spellname) then
            equip(sets.Utility.TH)
        end
    end
end

function updateTimers(spell)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('timers create "Sleep II" 90 down')
        elseif spell.english == "Sleep" then
            send_command('timers create "Sleep" 60 down')
        elseif spell.english == "Break" then
            send_command('timers create "Break" 30 down')
        elseif spell.english == "Bind" then
            send_command('timers create "Bind" 60 down')
        elseif spell.english =="Light Shot" then
            send_command('timers create "Light Shot" 60 down')
        end
    end
end

-- Offload to HelperFunctions?
-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1

    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.english == 'Wildfire' or spell.english == 'Leaden Salute' then
                -- magical weaponskills
                bullet_name = MAbullet
            else
                -- physical weaponskills
                bullet_name = WSbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end

    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]

    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            -- add_to_chat(104, 'No ammo ('..bullet_name..') available for that action.')
            -- add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            -- cancel_spell()
            -- eventArgs.cancel = true
            return
        end
    end

    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        cancel_spell()
        -- eventArgs.cancel = true
        return
    end

    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        -- local border = ""
        -- for i = 1, #msg do
        --     border = border .. "*"
        -- end

        -- add_to_chat(104, border)
        add_to_chat(104, msg)
        -- add_to_chat(104, border)

        warned:set()
    elseif available_bullets.count > ammo_warning_limit and warned then
        warned:reset()
    end
end

-- Offload to HelperFunctions
function special_ammo_check()
    -- Stop if Animikii/Hauksbok equipped
    if no_shoot_ammo:contains(player.equipment.ammo) then
        cancel_spell()
        add_to_chat(123, '** Action Canceled: [ '.. player.equipment.ammo .. ' equipped!! ] **')
        return
    end
end

-- Hide this away somewhere better?
-- Flurry helper
windower.register_event('action',function(act)
    --check if you are a target of spell
    local actionTargets = act.targets
    playerId = windower.ffxi.get_player().id
    isTarget = false
    for _, target in ipairs(actionTargets) do
        if playerId == target.id then
            isTarget = true
        end
    end
    if isTarget == true then
        if act.category == 4 then
            local param = act.param
            if snapshot.value == 'AUTO' then
                if param == 845 and flurry ~= 2 then
                    -- add_to_chat(122, 'Flurry Status: Flurry I')
                    flurry = 1
                elseif param == 846 then
                    -- add_to_chat(122, 'Flurry Status: Flurry II')
                    flurry = 2
              end
            end
        end
    end
end)

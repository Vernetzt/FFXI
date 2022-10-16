version = "3.0"
pName = player.name

-- Saying hello
windower.add_to_chat(8,'----- Welcome back to your SCH.lua, '..pName..' -----')

runspeedslot = 'feet'

--------------------------------------------------------------------------------------------------------------
-- HUD STUFF
--------------------------------------------------------------------------------------------------------------
wantedSc = tier1sc[elements.current]
scTier2 = M(true)
-- meleeing = M('OFF', 'ON', 'AUTO')
meleeing = M('OFF', 'ON')
lock = M('OFF', 'ON')
mBurst = M(false)
runspeed = M('OFF', 'ON')
oldElement = elements.current
mBurstOldValue = mBurst.value
matchsc = M('AUTO', 'OFF', 'ON')
MB_Window = 0   
time_start = 0

lastIdle = ""
lastMelee = ""
flipforce = true
thMode = M('OFF', 'ON')

ammoLock = M('OFF', 'ON')
rangeLock = M('OFF', 'ON')

setupTextWindow()

Buff = 
    {
        ['Ebullience'] = false, 
        ['Rapture'] = false, 
        ['Perpetuance'] = false,
        ['Immanence'] = false,
        ['Penury'] = false,
        ['Parsimony'] = false,
        ['Celerity'] = false,
        ['Alacrity'] = false,
        ['Klimaform'] = false,
        ['Sublimation: Activated'] = false
    }
    
-- Reset the state vars tracking strategems.
function update_active_strategems(name, gain)
    Buff['Ebullience'] = buffactive['Ebullience'] or false
    Buff['Rapture'] = buffactive['Rapture'] or false
    Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    Buff['Immanence'] = buffactive['Immanence'] or false
    Buff['Penury'] = buffactive['Penury'] or false
    Buff['Parsimony'] = buffactive['Parsimony'] or false
    Buff['Celerity'] = buffactive['Celerity'] or false
    Buff['Alacrity'] = buffactive['Alacrity'] or false
    Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    if Buff['Sublimation: Activated'] then
        refreshType = "sublimation"
    else
        refreshType = "refresh"
    end
    if midaction() then
        return
    else
        idle()
    end
end

function buff_refresh(name,buff_details)
    -- Update SCH statagems when a buff refreshes.
    update_active_strategems()
    update_sublimation()
    validateTextInformation()
end

function buff_change(name,gain,buff_details)
    -- Update SCH statagems when a buff is gained or lost.
    update_active_strategems()
    update_sublimation()
    validateTextInformation()
    autoDT(name,gain)
end

function SCH_lockMainHand( value )
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

    local spell_recasts = windower.ffxi.get_spell_recasts()

    -- Auto use Echo Drops if you are trying to cast while silenced --    
    if spell.action_type == 'Magic' and buffactive['Silence'] then 
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')     
        add_to_chat(8, '****** ['..spell.name..' CANCELED - Using Echo Drops] ******')
        return        
    end       

    if spell.action_type  == 'Magic' and spell_recasts[spell.recast_id] > 0 then
        cancel_spell()
        downgradenuke(spell)
        add_to_chat(8, '****** ['..spell.name..' CANCELED - Spell on Cooldown, Downgrading spell] ******')
        return
    end

    if meleeing.value == "AUTO" then
        -- if player.tp >= lockWeaponTP or meleeModes.current == 'zeroTP' then
        if player.tp >= lockWeaponTP then
            lock:set('ON')
        else
            lock:set('OFF')
        end
        SCH_lockMainHand(lock.value)
    end

    -- Moving on to other types of magic
    if spell.type == 'WhiteMagic' or spell.type == 'BlackMagic' or spell.type == 'Trust' then
     
        -- Stoneskin Precast
        if spell.name == 'Stoneskin' then
         
            windower.ffxi.cancel_buff(37)--[[Cancels stoneskin, not delayed incase you get a Quick Cast]]
            equip(sets.precast.stoneskin)
             
        -- Cure Precast
        elseif spell.name:match('Cure') or spell.name:match('Cura') then
         
            equip(sets.precast.cure)         
        -- Enhancing Magic
        elseif spell.skill == 'Magic' then
         
            equip(sets.precast.enhancing)            
            if spell.name == 'Sneak' then
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
    -- extends Fast cast set with Grimoire recast aligned 
    if buffactive['addendum: black'] or buffactive['dark arts'] then
        if spell.type == 'BlackMagic' then
            equip(sets.precast.grimoire)            
        end
    elseif buffactive['addendum: white'] or buffactive['light arts'] then
        if spell.type == 'WhiteMagic' then
            equip(sets.precast.grimoire)            
        end
    end

end
 
function midcast(spell)
    -- Get the spell mapping, since we'll be passing it to various functions and checks.
    local spellMap = get_spell_map(spell)    
    -- No need to annotate all this, it's fairly logical. Just equips the relevant sets for the relevant magic
    if spell.name:match('Cure') or spell.name:match('Cura') then
        if spell.element == world.weather_element or spell.element == world.day_element then
            equip(sets.midcast.cure.weather)
        else
            equip(sets.midcast.cure.normal)
        end
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.enhancing)
        if spellMap == 'Storm' then
            equip(sets.midcast.storm)
        elseif spell.name:match('Protect') or spell.name:match('Shell') then
            equip({rring="Sheltered Ring"})
        elseif spell.name:match('Refresh') then
            equip(sets.midcast.refresh)
        elseif spell.name:match('Regen') then
            equip(sets.midcast.regen[regenModes.current])
        elseif spell.name:match('Aquaveil') then
            equip(sets.midcast.aquaveil)
        elseif spell.name:match('Stoneskin') then
            equip(sets.midcast.stoneskin)
        end
    elseif spell.skill == 'Enfeebling Magic' and spell.type == 'BlackMagic' then -- to do: better rule for this.
        equip(sets.midcast.IntEnfeebling)
    elseif spell.skill == 'Enfeebling Magic' and spell.type == 'WhiteMagic' then -- to do: better rule for this.
        equip(sets.midcast.MndEnfeebling)
    elseif spell.type == 'BlackMagic' then
        if mBurst.value == true then
            equip(sets.midcast.MB[nukeModes.current])
        else
            equip(sets.midcast.nuking[nukeModes.current])
        end
    elseif spell.type == 'Trust' then
        equip(sets.precast.casting)
    elseif spell.type == 'JobAbility' then
        equip(sets.me.idle.dt)
    elseif spell.type == 'Magic' then 
        equip(sets.midcast.casting)
    else
        equip(sets.me.idle.dt)
    end

    -- And our catch all, if a set exists for this spell name, use it
    if sets.midcast[spell.name] then
        equip(sets.midcast[spell.name])
    -- Catch all for tiered spells (use mapping), basically if no set for spell name, check set for spell mapping. AKA Drain works for all Drain tiers.
    elseif sets.midcast[spellMap] then
        equip(sets.midcast[spellMap])
    -- Remember those WS Sets we defined? :) sets.me["Insert Weaponskill"] are basically how I define any non-magic spells sets, aka, WS, JA, Idles, etc.
    elseif sets.me[spell.name] then
        equip(sets.me[spell.name])
    end
    
    -- Put the JSE in place.
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap)
    end

    -- Obi / Orph Logic
    if spell.skill ~= 'Enhancing Magic' and spellMap ~= 'Helix' then
        SashLogic(spell)
    end

    -- Dark based Helix gets "pixie hairpin +1"
    if spellMap == 'DarkHelix'then
        equip(sets.midcast.DarkHelix)
    end
    if spellMap == 'Helix' then
        equip(sets.midcast.Helix)
    end

    -- Th Mode: See Function
    if thMode.value == 'ON' then
        autoTH(spell)
    end

end
 
function aftercast(spell) 
    -- Then initiate idle function to check which set should be equipped
    if meleeing.value == "AUTO" then
        -- if player.tp >= lockWeaponTP or meleeModes.current == 'zeroTP' then
        if player.tp >= lockWeaponTP then
            lock:set('ON')
        else
            lock:set('OFF')
        end
        SCH_lockMainHand(lock.value)
    end

    update_active_strategems()
    update_sublimation()
    idle()
    updateTimers(spell)
end

function idle()
    -- This function is called after every action, and handles which set to equip depending on what we're doing
    -- We check if we're meleeing because we don't want to idle in melee gear when we're only engaged for trusts
    if (meleeing.value == 'ON' and player.status=='Engaged') then   
        -- We're engaged and meleeing
        equip(sets.me.melee)               
    else
        -- If we are building sublimation, then we swap refresh to sublimation style idle.
        if buffactive['Sublimation: Activated'] then
            if idleModes.value == 'refresh' then
                equip(sets.me.idle.sublimation)    
            else
                equip(sets.me.idle[idleModes.value])               
            end
        -- We don't have sublimation ticking.
        else
            equip(sets.me.idle[idleModes.value])             
        end
    end

    equip({main = mainWeapon.current, sub = subWeapon.current})

    -- Checks MP for Fucho-no-Obi
    if player.mpp < 51 then
        equip(sets.me.latent_refresh)          
    end
    
end
 
function status_change(new,old)
    if new == 'Engaged' then  
        -- If we engage check our meleeing status
        idle()
         
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
                -- //gs c toggle melee will toggle melee mode on and off.
                -- This basically locks the slots that will cause you to lose TP if changing them,
                -- As well as equip your melee set if you're engaged
                meleeing:cycle()
                SCH_lockMainHand(meleeing.value)
            elseif commandArgs[2] == 'mb' then
                -- //gs c toggle mb will toggle mb mode on and off.
                -- You need to toggle prioritisation yourself
                mBurst:toggle()
                updateMB(mBurst.value)
            elseif commandArgs[2] == 'runspeed' then
                runspeed:cycle()
                updateRunspeedGear(runspeed.value, runspeedslot)
            elseif commandArgs[2] == 'forcedt' then
                forceDT()
                idle()  
            elseif commandArgs[2] == 'idlemode' then
                flipforce = true
                idleModes:cycle()
                idle()
                if buffactive['Sublimation: Activated'] then                 
                    update_sublimation()
                    validateTextInformation()
                -- We don't have sublimation ticking.
                else
                    validateTextInformation()
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

            elseif commandArgs[2] == 'regenmode' then
                regenModes:cycle()                 
                validateTextInformation()   
            elseif commandArgs[2] == 'nukemode' then
                nukeModes:cycle()                               
                validateTextInformation() 
            elseif commandArgs[2] == 'matchsc' then
                matchsc:cycle()                               
                validateTextInformation()

            elseif commandArgs[2] == 'thmode' then
                thMode:cycle()
                if player.status=='Engaged' and thMode.value == 'ON' then
                    equip(sets.Utility.TH)
                else
                    idle()
                end

            end
        end
        
        if commandArgs[1]:lower() == 'scholar' then
            handle_strategems(commandArgs)

        elseif commandArgs[1]:lower() == 'nuke' then
            if not commandArgs[2] then
                windower.add_to_chat(123,'No element type given.')
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
                updateSC(elements.current, scTier2.value)                    
                validateTextInformation()

            elseif (nuke == 'air' or nuke == 'ice' or nuke == 'fire' or nuke == 'water' or nuke == 'lightning' or nuke == 'earth' or nuke == 'light' or nuke == 'dark') then
                local newType = commandArgs[2]
                elements:set(newType)
                updateSC(elements.current, scTier2.value)                
                validateTextInformation()
            elseif not nukes[nuke] then
                windower.add_to_chat(123,'Unknown element type: '..tostring(commandArgs[2]))
                return              
            elseif nuke == 'storm2' then
                send_command('@input /ma "'..nukes[nuke][elements.current]..'" stpc')
            else
                -- Leave out target; let Shortcuts auto-determine it.
                send_command('@input /ma "'..nukes[nuke][elements.current]..'"')     
            end
        elseif commandArgs[1]:lower() == 'sc' then
            if not commandArgs[2] then
                windower.add_to_chat(123,'No element type given.')
                return
            end
            
            local arg = commandArgs[2]:lower()
            
            if arg == 'tier' then
                scTier2:toggle()
                updateSC(elements.current, scTier2.value )   
            end

            if arg == 'castsc' then
                if wantedSc == 'Scission' then
                    send_command('input /p Opening SC: Scission  MB: Stone; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Fire" <t>; wait 4.0; input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Scission  MB: Stone; input /ma "Geohelix" <t>')          
                elseif wantedSc == 'Reverberation' then
                    send_command('input /p Opening SC: Reverberation  MB: Water; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Stone" <t>; wait 4.0; input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Reverberation  MB: Water; input /ma "Hydrohelix" <t>')       
                elseif wantedSc == 'Detonation' then
                    send_command('input /p Opening SC: Detonation  MB: Air; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Thunder" <t>; wait 4.0; input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Detonation  MB: Air; input /ma "Anemohelix" <t>')    
                elseif wantedSc == 'Liquefaction' then
                    send_command('input /p Opening SC: Liquefaction  MB: Fire; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Thunder" <t>; wait 4.0; input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Liquefaction  MB: Fire; input /ma "Pyrohelix" <t>')                  
                elseif wantedSc == 'Induration' then
                    send_command('input /p Opening SC: Induration  MB: Ice; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Water" <t>; wait 4.0; input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Induration  MB: Ice; input /ma "Cryohelix" <t>')                  
                elseif wantedSc == 'Impaction' then
                    send_command('input /p Opening SC: Impaction  MB: Lightning; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Blizzard" <t>; wait 4.0; input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Impaction  MB: Lightning; input /ma "Ionohelix" <t>')                  
                elseif wantedSc == 'Compression' then
                    send_command('input /p Opening SC: Compression  MB: Dark; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Blizzard" <t>; wait 4.0; input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Compression  MB: Dark; input /ma "Noctohelix" <t>')                 
                elseif wantedSc == 'Distortion' then
                    send_command('input /p Opening SC: Distortion  MB: Water / Ice; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Luminohelix" <t>; wait 6.0; input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Distortion  MB: Water / Ice; input /ma "Geohelix" <t>')                   
                elseif wantedSc == 'Fragmentation' then
                    send_command('input /p Opening SC: Fragmentation  MB: Lightning / Wind; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Blizzard" <t>; wait 4.0; input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Fragmentation  MB: Wind / Lightning; input /ma "Hydrohelix" <t>')                  
                elseif wantedSc == 'Fusion' then
                    send_command('input /p Opening SC: Fusion  MB: Light / Fire; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Fire" <t>; wait 4.0; input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Fusion  MB: Light / Fire; input /ma "Ionohelix" <t>')                  
                elseif wantedSc == 'Gravitation' then
                    send_command('input /p Opening SC: Gravitation  MB: Dark / Stone; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Aero" <t>; wait 4.0; input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Gravitation  MB: Dark / Stone; input /ma "Noctohelix" <t>')                 
                elseif wantedSc == 'Transfixion' then
                    send_command('input /p Opening SC: Transfixion  MB: Light; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Noctohelix" <t>; wait 4.0; input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Transfixion  MB: Light; input /ma "Luminohelix" <t>')
                end
            end
        end
    end
end


-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if Buff['Perpetuance'] and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if Buff['Rapture'] and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if Buff['Ebullience'] and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if Buff['Immanence'] then
            equip(sets.buff['Immanence'])
        end
        if Buff['Klimaform'] and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end

    if Buff['Penury'] then equip(sets.buff['Penury']) end
    if Buff['Parsimony'] then equip(sets.buff['Parsimony']) end
    if Buff['Celerity'] then equip(sets.buff['Celerity']) end
    if Buff['Alacrity'] then equip(sets.buff['Alacrity']) end
end


function autoDT(name,gain)
    local name2
    name2 = string.lower(name)
    if S{"terror","petrification","sleep","stun"}:contains(name2) then
      if gain then
        add_to_chat(322, 'AutoDT is on')
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
        send_command('gs c -cd Mighty Guard Lost!')
      end
    end
end

-- Rewrite
function forceDT()
    if flipforce == true then
        lastIdle = idleModes.value
        -- lastMelee = meleeModes.value
        idleModes:set('flee')
        -- meleeModes:set('dt')
        flipforce = false
    -- elseif testforce == true then
    --     testforce = false
    else
        idleModes:set(lastIdle)
        -- meleeModes:set(lastMelee)
        flipforce = true
    end  
end

function updateTimers(spell)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
        --   send_command('wait 35;gs c -cd '..spell.name..': [Off In 10~55 Seconds!];wait 10;gs c -cd '..spell.name..': [Off In 0~45 Seconds!]')
          send_command('timers create "Sleep II" 90 down')
        elseif spell.english == "Sleep" then
            --   send_command('wait 20;gs c -cd '..spell.name..': [Off In 10~40 Seconds!];wait 10;gs c -cd '..spell.name..': [Off In 0~30 Seconds!]')
            send_command('timers create "Sleep" 60 down')
        elseif spell.english == "Break" then
        --   send_command('wait 20;gs c -cd '..spell.name..': [Off In 10 Seconds!]')
          send_command('timers create "Break" 30 down')
        elseif spell.english == "Bind" then
        -- send_command('wait 20;gs c -cd '..spell.name..': [Off In 10~40 Seconds!];wait 10;gs c -cd '..spell.name..': [Off In 0~30 Seconds!]')
          send_command('timers create "Bind" 60 down')
        end
    end
end

function autoTH(spell)
    if thMode.value == 'ON' then
        spellname = string.lower(spell.name)
        -- Add "spells" you wish TH gear to equip on
        if S{"dispelga","diaga","poisonga"}:contains(spellname) then
            equip(sets.Utility.TH)
        end
    end
end
version = "3.0"

-- Saying hello
pName = player.name
windower.add_to_chat(8,'----- Welcome back to your RDM.lua, '..pName..' -----')

-- We're RDM so we're using Carm legs.
runspeedslot = 'legs'

--------------------------------------------------------------------------------------------------------------
-- HUD STUFF -- TO BE EXTERNALIZED
--------------------------------------------------------------------------------------------------------------
meleeing = M('AUTO', 'OFF', 'ON')
lock = M('OFF', 'ON')
mBurst = M(false)
runspeed = M('OFF', 'ON')
oldElement = elements.current
mBurstOldValue = mBurst.value
matchsc = M('AUTO', 'OFF', 'ON')
MB_Window = 0
dualwield = M('AUTO', '31', '11')
bow = M('OFF', 'ON')
thMode = M('OFF', 'ON')
currentHaste = 30

lastIdle = ""
lastMelee = ""
flipforce = true

-- Combine?
ammoLock = M('OFF', 'ON')
rangeLock = M('OFF', 'ON')

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

setupTextWindow()

Buff = 
    {
        ['Composure'] = false, 
        ['Stymie'] = false, 
        ['Saboteur'] = false, 
        ['En-Weather'] = false,
        ['En-Day'] = false,
		['En-BadDay'] = false,
        ['Enspell'] = false,
    }
    
-- Reset the state vars tracking strategems.
function update_active_ja(name, gain)
    Buff['Composure'] = buffactive['Composure'] or false
    Buff['Stymie'] = buffactive['Stymie'] or false
    Buff['Saboteur'] = buffactive['Saboteur'] or false
    Buff['En-Weather'] = buffactive[nukes.enspell[world.weather_element]] or false
    Buff['En-Day'] = buffactive[nukes.enspell[world.day_element]] or false
	Buff['En-BadDay'] = buffactive[nukes.enspell[element.strong_to[world.day_element]]] or false
    Buff['Enspell'] =   buffactive[nukes.enspell['Earth']] or 
                        buffactive[nukes.enspell['Water']] or 
                        buffactive[nukes.enspell['Air']] or 
                        buffactive[nukes.enspell['Fire']] or 
                        buffactive[nukes.enspell['Ice']] or 
                        buffactive[nukes.enspell['Lightning']] or 
                        buffactive[nukes.enspell['Light']] or 
                        buffactive[nukes.enspell['Dark']] or false
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
    autoDT(name,gain)
end

function RDM_lockMainHand( value )
    -- We want to force lock weapons
    if value == 'ON' then
      -- We force lock only main and sub if in zeroTP mode (since we care abot lock, but not TP so Ullr and Ammo still swapping)
        if meleeModes.current == 'zeroTP' then
              disable('main','sub')
              ammoLock:set('OFF')
              rangeLock:set('OFF')
              -- If not in zeroTP mode, lock everything
        elseif bow.value == 'ON' then
              disable('main','sub','ammo')
              ammoLock:set('ON')
              rangeLock:set('OFF')
        elseif bow.value == 'OFF' then
              disable('main','sub','ranged')
              enable ('ammo')
              ammoLock:set('OFF')
              rangeLock:set('ON')
        end
    -- If we are in auto or off mode, but not in zeroTP, we unlock everything
    elseif value == 'OFF' or 'AUTO' then
        if bow.value == 'ON' then
            enable('main','sub')
            disable('ammo')
            ammoLock:set('ON')
            rangeLock:set('OFF')
        else
            enable('main','sub','ranged','ammo')
            ammoLock:set('OFF')
            rangeLock:set('OFF')
        end
    end
    validateTextInformation()
end

function precast(spell)
    -- Get the spell mapping, since we'll be passing it to various functions and checks.
    local spellMap = get_spell_map(spell)
    local enfeebMap = get_enfeeb_map(spell)
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
        if spell.type == 'BlackMagic' then
            downgradenuke(spell)
            add_to_chat(322, '['..spell.name..' CANCELED - Spell on Cooldown, Downgrading]')
        else
            add_to_chat(322, '['..spell.name..' CANCELED - Spell on Cooldown]')
        end
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
        RDM_lockMainHand(lock.value)
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
        else       
            -- For everything else we go with max fastcast
            equip(sets.precast.casting)                
        end
    end
    -- Job Abilities
    -- We use a cat
    -- catch all here, if the set exists for an ability, use it
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
    
    elseif spell.action_type == 'Ranged Attack' then
        equip(sets.midcast.RA)

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
        elseif spell.name:match('Temper') or spellMap == "Enspell" or spellMap == "Gain" then
            equip(sets.midcast.enhancing.potency)
        else
            equip(sets.midcast.enhancing.duration) -- fall back to duration if not specified above 
        end

        -- Casting on others, then we use composure bonus set
        if Buff['Composure'] then 
            -- if  spell.target.type ~= 'SELF' and spell.target.type == 'PLAYER' then
            if  spell.target.type ~= 'SELF' then
                equip(sets.midcast.enhancing.composure)
            end
        end

    -- Enfeebling
    elseif spell.skill == 'Enfeebling Magic' then

        if enfeebMap == 'macc' and rangeLock.value == 'OFF' then
            equip(sets.midcast.Enfeebling[enfeebMap].bow)
        elseif enfeebMap == 'intmacc' and rangeLock.value == 'OFF' then
            equip(sets.midcast.Enfeebling[enfeebMap].bow)
        else
            equip(sets.midcast.Enfeebling[enfeebMap])
        end

        if Buff['Saboteur'] then
            -- equip({hands=EMPY.Hands})
            equip({hands="Regal Cuffs",})
        end

		-- If Stymie is up AND we're casting silence, we swap to 5/5 EMPY
		if Buff['Stymie'] and spell.name =='Silence' then
			equip(sets.midcast.Enfeebling.composure)
		end

    -- Nuking
    elseif spell.type == 'BlackMagic' then
    
        if player.sub_job == ('NIN' or 'DNC') then
            --   add_to_chat(322, 'RDM/NIN')
            if mBurst.value == true then
                equip(sets.midcast.MB[nukeModes.current].DW)
            else
                equip(sets.midcast.nuking[nukeModes.current].DW)
            end
        else
            --   add_to_chat(322, 'NOT DW SJ')
            if mBurst.value == true then
                equip(sets.midcast.MB[nukeModes.current])
            else
                equip(sets.midcast.nuking[nukeModes.current])
            end
        end

        -- Obi / Orph Logic
        if spell.skill ~= 'Enhancing Magic' and spellMap ~= 'Helix' then
            SashLogic(spell)
        end

        if enfeebMap then
            equip(sets.midcast.Enfeebling[enfeebMap])
        end
    
    elseif spell.type == 'Trust' then
        equip(sets.precast.casting)

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
    -- Weapon skills
    -- sets.me["Insert Weaponskill"] are basically how I define any non-magic spells sets, aka, WS, JA, Idles, etc.
    if sets.me[spell.name] then
        equip(sets.me[spell.name])

        -- Sanguine BBlade belt optim
        if spell.name == 'Sanguine Blade' then
            -- Obi / Orph Logic
            SashLogic(spell)
        end

        if spell.name == 'Seraph Blade' then
            -- Obi / Orph Logic
            SashLogic(spell)
        end

    end
    
    -- Prevent Obi by swapping helix stuff last
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
        -- if player.tp >= lockWeaponTP or meleeModes.value == 'zeroTP' then
        if player.tp >= lockWeaponTP then
            lock:set('ON')
        else
            lock:set('OFF')
        end
        RDM_lockMainHand(lock.value)
    end

    update_active_ja()
    updateDualWield()
    updateTimers(spell)
    idle()

end

-- NEW
-- Remove chat confirms at a later date
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
		-- Optimizes Belt for when we want enspell to matter
        if mainWeapon.value == "Crocea Mors" then
            EnspellCheck()
        end

        if meleeModes.current == 'zeroTP' then
            EnspellCheck()
        end
        
    else
        equip(sets.me.idle[idleModes.value])
        -- Checks MP for Fucho-no-Obi
        if player.mpp < 51 then
            equip(sets.me.latent_refresh)          
        end       
    end
    equip({main = mainWeapon.current, sub = subWeapon.current})

    if bow.value == 'ON' then
        equip({ranged = ambuBow,
    ammo=rangedArrows,})
    end
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
                RDM_lockMainHand(meleeing.value)
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

            elseif commandArgs[2] == 'bow' then
                bow:cycle()
                RDM_lockMainHand(meleeing.value)
                idle()
                if bow.value == 'ON' then
                    enable('ranged','ammo')
                    equip({ranged=ambuBow})
                    disable('ranged','ammo')
                end
                if announceState then
                    add_to_chat(322, 'Bow: '..bow.value..'')
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

            elseif commandArgs[2] == 'weapons' then
                if commandArgs[3] == 'NaeTP' then
                    mainWeapon:set('Naegling')
                    subWeapon:set(TpBonus)
                elseif commandArgs[3] == 'MaxTP' then
                    mainWeapon:set('Maxentius')
                    subWeapon:set(TpBonus)
                elseif commandArgs[3] == 'ZeroTP' then
                    mainWeapon:set('Aern Dagger')
                    subWeapon:set('Qutrub Knife')
                    -- meleeModes:set('zeroTP')
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
                end

            elseif commandArgs[2] == 'nukemode' then
                nukeModes:cycle()
                if announceState then
                    add_to_chat(322, 'Nukes: '..nukeModes.value..'')
                end

            elseif commandArgs[2] == 'matchsc' then
                matchsc:cycle()
                add_to_chat(322, 'Match SC: '..matchsc.value..'')
            end
            validateTextInformation()
        end

        if commandArgs[1] == 'ws' then
            if commandArgs[2] == 'auto' then
                if S{'Crocea Mors','Naegling'}:contains(player.equipment.main) then
                    send_command('@input /ws "Savage Blade" <t>')
                elseif S{'Maxentius'}:contains(player.equipment.main) then
                    send_command('@input /ws "Black Halo" <t>')
                elseif S{'Tauret'}:contains(player.equipment.main) then
                    send_command('@input /ws "Evisceration" <t>')
                end
            end
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
                if announceState then
                    add_to_chat(322, 'Nuking: '..elements.current..'')
                end

            elseif (nuke == 'enspellup' or nuke == 'enspelldown') then
                if nuke == 'enspellup' then
                    enspellElements:cycle()
                elseif nuke == 'enspelldown' then 
                    enspellElements:cycleback()
                end     
                validateTextInformation()
                if announceState then
                    add_to_chat(322, 'Enspell: '..enspellElements.value..'')
                end

            elseif (nuke == 'air' or nuke == 'ice' or nuke == 'fire' or nuke == 'water' or nuke == 'lightning' or nuke == 'earth' or nuke == 'light' or nuke == 'dark') then
                local newType = commandArgs[2]
                elements:set(newType)              
                oldElement = elements.current    
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
        end
    end
end
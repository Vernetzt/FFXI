-- midaction() check for runspeed
-- also only swap in mov.speed instead of idle?
-- increase decrease if moving check frame interval?

version = "3.0"

tickdelay = os.clock() + 5

--------------------------------------------------------------------------------------------------------------
local geo_maths = require 'Liz-Maths' -- Vectors and Maths
--------------------------------------------------------------------------------------------------------------

function updateSC( element , scTier )   
    if scTier then
        wantedSc = tier2sc[element]
    else
        wantedSc = tier1sc[element]
    end
    scColor = Colors[element]               
    validateTextInformation()
end

function updateMB( mBurst )   
    validateTextInformation()
end


function updateRunspeedGear( value , slot , pet )
    if value == 'OFF' or value == 'AUTO' then
        validateTextInformation()
        enable(slot)
    else
        validateTextInformation()
        equip(sets.me.movespeed)
        disable(slot)
    end
    if player.main_job == "GEO" or player.main_jon == "SMN" or player.main_jon == "BST" then
        idle(pet)
    else
        -- if not midaction() then
            idle()
        -- end
    end
    validateTextInformation()
end

function lockMainHand( value , pet )   
    if value == 'ON' then
        disable('main','sub','ranged')
        validateTextInformation()
        if player.main_job == "GEO" or player.main_jon == "SMN" or player.main_jon == "BST" then
            idle(pet)
        else
            idle()
        end
    elseif value == 'OFF' or 'AUTO' then
        enable('main','sub','ranged')
        validateTextInformation()
        if player.main_job == "GEO" or player.main_jon == "SMN" or player.main_jon == "BST" then
            idle(pet)
        else
            idle()
        end
    end
end

function handleChant()
    target = windower.ffxi.get_mob_by_target('t')
    if target ~= nil and target.name ~= player.name then
        pPos = geo_maths.vector(windower.ffxi.get_mob_by_target('me').x, windower.ffxi.get_mob_by_target('me').y, windower.ffxi.get_mob_by_target('me').z)
        tPos = geo_maths.vector(windower.ffxi.get_mob_by_target('t').x, windower.ffxi.get_mob_by_target('t').y, windower.ffxi.get_mob_by_target('t').z)

        temp = pPos:sub(tPos)
        temp = temp:normalize(temp)

        if temp.y > 0 then
            colorY = geo_maths.vector(0,255,0)
        else
            colorY = geo_maths.vector(0,0,255)
        end

        if temp.x > 0 then
            colorX = geo_maths.vector(255,255,0)
        else
            colorX = geo_maths.vector(255,0,0)
        end
        color = colorX*temp.x*temp.x + colorY*temp.y*temp.y

        if color.z > 128 then
            cChant = "Magic Crit"
        elseif color.y > 128 and color.x < 128 then
            cChant = "Magic ACC"
        elseif color.x > 128 and color.y < 128 then   
            cChant = "Magic Atk"
        elseif color.x > 128 and color.y > 128 then  
            cChant = "M.Burst Bonus"
        end

        ccColor = "\\cs("..math.floor(color.x)..", "..math.floor(color.y)..", "..math.floor(color.z)..")  "

    else
        cChant = "No Target"
        ccColor = "\\cs(255,255,255)"
    end
end

-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>

function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end

if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
    windower.raw_register_event('action', function(act)
        for _, target in pairs(act.targets) do
            local battle_target = windower.ffxi.get_mob_by_target("t")
            if battle_target ~= nil and target.id == battle_target.id then
                for _, action in pairs(target.actions) do
                    if action.add_effect_message > 287 and action.add_effect_message < 302 then
                        last_skillchain = skillchains[action.add_effect_message]
                        mBurstOldValue = mBurst.value
                        MB_Window = 11
                        MB_Time = os.time()
                        validateTextInformation()
                    elseif action.add_effect_message > 766 and action.add_effect_message < 769 then
                        last_skillchain = skillchains[action.add_effect_message]
                        mBurstOldValue = mBurst.value
                        MB_Window = 11
                        MB_Time = os.time()
                        validateTextInformation()
                    end
                end
            end
        end
    end)
    
if autorunspeed then
    mov = {counter=0}
    if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
        mov.x = windower.ffxi.get_mob_by_index(player.index).x
        mov.y = windower.ffxi.get_mob_by_index(player.index).y
        mov.z = windower.ffxi.get_mob_by_index(player.index).z
    end
    moving = false

    windower.raw_register_event('prerender',function()
        mov.counter = mov.counter + 1;
        if mov.counter>10 then
            local pl = windower.ffxi.get_mob_by_index(player.index)
            if pl and pl.x and mov.x then
                local movement = math.sqrt( (pl.x-mov.x)^2 + (pl.y-mov.y)^2 + (pl.z-mov.z)^2 ) > 0.1


                if not midaction() then
                    if movement and not moving then
                        send_command('gs c toggle runspeed')
                        moving = true
                    elseif not movement and moving then
                        send_command('gs c toggle runspeed')
                        moving = false
                    end
                end

            end

            if pl and pl.x then
                mov.x = pl.x
                mov.y = pl.y
                mov.z = pl.z
            end
            mov.counter = 0
        end
    end)
end

windower.raw_register_event('prerender', function()
    -- if not (os.clock() > tickdelay) then return end
    if os.clock() > tickdelay then
        tickdelay = os.clock() + 1
        if auto_CP_Cape then
            auto_cp()
        end
    end

    if MB_Window > 0 then
        MB_Window = 14 - (os.time() - MB_Time)
        if matchsc.value == 'ON' or matchsc.value == 'AUTO' then
            selectSCElement()
            mBurst:set(true)
        end
    else
        elements:set(oldElement)
        if matchsc.value == 'ON' then
            mBurst:set(true)
        else
            mBurst:set(false)
        end
    end
    validateTextInformation()
end)

function auto_cp()
    --Now we check if we need to lock our back for CP
        if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
            jobpoints = windower.ffxi.get_player().job_points[player.main_job:lower()].jp_spent -- check if we are master
        end
        if jobpoints ~= 2100 and jobpoints ~= nil then -- Basically if not master
            monsterToCheck = windower.ffxi.get_mob_by_target('t')
            if windower.ffxi.get_mob_by_target('t') then -- Sanity Check 
                if #monsterToCheck.name:split(' ') >= 2 then
                    monsterName = T(monsterToCheck.name:split(' '))
                    if monsterName[1] == "Locus" then
                        if monsterToCheck.hpp < 20 then --Check mobs HP Percentage if below 15 then equip CP cape
                            equip({ back = CP_CAPE }) 
                            disable("back") --Lock back
                        else
                            enable("back") --Else make sure the back is enabled
                        end 
                    end
                end
            else
                enable("back") --Else make sure the back is enabled
            end
        else
            enable("back") --Else make sure the back is enabled
        end
    end
end

function selectSCElement()
    -- Tier 3 SC we favor element already chosen, then day (our weather likely match our set element as a sch) then swap for bad day. 
    if last_skillchain.english == "Light" or last_skillchain.english == "Radiance" then
        -- First we always prefer the selected element if that element can burst, if not we move on.
        if elements.current == "Fire" or elements.current == "Lightning" or elements.current == "Air" then
            return
        -- Favor Fire if its Fire's Day or Earth's day (thunder weak on E-Day)
        elseif world.day_element == "Fire" or world.day_element == "Earth" then
            selectedElement = "Fire"
            elements:set(selectedElement)
        -- Favor Wind if its Wind's Day or Earth's day (thunder weak on E-Day)
        elseif world.day_element == "Air" or world.day_element == "Earth" then
            selectedElement = "Air"
            elements:set(selectedElement)
        else
            selectedElement = "Lightning"
            elements:set(selectedElement)
        end
    elseif last_skillchain.english == "Darkness" or last_skillchain.english == "Umbra" then
        -- First we always prefer the selected element if that element can burst, if not we move on.
        if elements.current == "Earth" or elements.current == "Water" or elements.current == "Ice" then
            return
        -- Favor Water if its Water's Day or Fire's day (Ice weak on F-Day)
        elseif world.day_element == "Water" or world.day_element == "Fire" then
            selectedElement = "Water"
            elements:set(selectedElement)
        -- Favor Earth if its Earth's Day or Fire's day (Ice weak on F-Day)
        elseif world.day_element == "Earth" or world.day_element == "Fire" then
            selectedElement = "Earth"
            elements:set(selectedElement)        
        else
            selectedElement = "Ice"
            elements:set(selectedElement)
        end
    -- Tier 2 SC we favor element already chosen, then day (our weather likely match our set element as a sch) then swap for bad day. 
    -- In case of Fusion and Grav, we avoid light / dark cause outside of helix, no good nukes,
    -- Also, we more than likely premeditated the helix we stuck on a mob, so unlikely we want to randomly burst a random helix.
    elseif last_skillchain.english == "Gravitation" then
        selectedElement = "Earth"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Fusion" then
        selectedElement = "Fire"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Fragmentation" then
        if elements.current == "Lightning" or elements.current == "Air" then
            return
        -- Favor Wind if its Wind's Day or Earth's day (thunder weak on E-Day)
        elseif world.day_element == "Air" or world.day_element == "Earth" then
            selectedElement = "Air"
            elements:set(selectedElement)
        else
            selectedElement = "Lightning"
            elements:set(selectedElement)
        end
    elseif last_skillchain.english == "Distortion" then
        if elements.current == "Ice" or elements.current == "Water" then
            return
        -- Favor Water is its Water's Day or Earth's day (Ice weak on F-Day)
        elseif world.day_element == "Water" or world.day_element == "Fire" then
            selectedElement = "Water"
            elements:set(selectedElement)
        else
            selectedElement = "Ice"
            elements:set(selectedElement)
        end
    -- Tier 1 SC we go straight to Busrt Element
    elseif last_skillchain.english == "Compression" then
        selectedElement = "Dark"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Liquefaction" then
        selectedElement = "Fire"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Induration" then
        selectedElement = "Ice"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Reverberation" then
        selectedElement = "Water"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Transfixion" then
        selectedElement = "Light"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Scission" then
        selectedElement = "Earth"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Detonation" then
        selectedElement = "Air"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Impaction" then
        selectedElement = "Lightning"
        elements:set(selectedElement)
    end
end

-- Function to get the current weather intensity: 0 for none, 1 for single weather, 2 for double weather.
-- Unneeded?
function get_weather_intensity()
    return gearswap.res.weather[world.weather_id].intensity
end

function SashLogic(spell)
    -- Match double weather (non-bad day)
    if spell.element == world.weather_element and world.weather_intensity == 2 then
        -- If bad day but double weather check distance
        if spell.element == "Fire" and world.day_element == "Water" then
            if spell.target.distance < (1.7 + spell.target.model_size) then
                equip(sets.midcast.Orpheus)
            else
                equip(sets.midcast.Obi)
            end
        elseif spell.element == "Ice" and world.day_element == "Fire" then
            if spell.target.distance < (1.7 + spell.target.model_size) then
                equip(sets.midcast.Orpheus)
            else
                equip(sets.midcast.Obi)
            end
        elseif spell.element == "Wind" and world.day_element == "Ice" then
            if spell.target.distance < (1.7 + spell.target.model_size) then
                equip(sets.midcast.Orpheus)
            else
                equip(sets.midcast.Obi)
            end
        elseif spell.element == "Earth" and world.day_element == "Wind" then
            if spell.target.distance < (1.7 + spell.target.model_size) then
                equip(sets.midcast.Orpheus)
            else
                equip(sets.midcast.Obi)
            end
        elseif spell.element == "Lightning" and world.day_element == "Earth" then
            if spell.target.distance < (1.7 + spell.target.model_size) then
                equip(sets.midcast.Orpheus)
            else
                equip(sets.midcast.Obi)
            end
        elseif spell.element == "Water" and world.day_element == "Lightning" then
            if spell.target.distance < (1.7 + spell.target.model_size) then
                equip(sets.midcast.Orpheus)
            else
                equip(sets.midcast.Obi)
            end
        else
            equip(sets.midcast.Obi)
        end
    -- Match day and weather
    elseif spell.element == world.day_element and spell.element == world.weather_element then
        equip(sets.midcast.Obi)
    -- Distance under 1.7 yalms
    elseif spell.target.distance < (1.7 + spell.target.model_size) then
        equip(sets.midcast.Orpheus)
    -- Distance under 8 yalms(fallback, for BLU rule later)
    elseif spell.target.distance < (8 + spell.target.model_size) then
        equip(sets.midcast.Orpheus)
    -- Match day or weather
    elseif spell.element == world.day_element or spell.element == world.weather_element then
        equip(sets.midcast.Obi)
    end
end

function downgradenuke( spell )

    if spell.name:match(nukes.t1[elements.current]) then   
        if spell.name == nukes.t5[elements.current] then
            newspell = nukes.t4[elements.current]
        elseif spell.name == nukes.t4[elements.current] then
            newspell = nukes.t3[elements.current]
        elseif spell.name == nukes.t3[elements.current] then
            newspell = nukes.t2[elements.current]
        elseif spell.name == nukes.t2[elements.current] then
            newspell = nukes.t1[elements.current]
        end
        send_command('input /ma "'..newspell..'"')
    end

end

function EnspellCheck()
	-- This only gets checked when wielding Crocea or Vitiation Sword.
	-- Enspell matches double weather but bad day
	if Buff['En-Weather'] and world.weather_intensity == 2 and not Buff['En-BadDay'] then
        equip(sets.midcast.Orpheus)
        equip(sets.midcast.AyanmoHands)
        -- add_to_chat (60, 'Enspell = Double weather but bad day')
	-- Enspell matches double weather and irrelevent day
	elseif Buff['En-Weather'] and world.weather_intensity == 2 then
        equip(sets.midcast.Obi)
        equip(sets.midcast.AyanmoHands)
        -- add_to_chat (60, 'Enspell = Double weather and irrelevent day')
    -- Enspell matches day AND weather
    elseif Buff['En-Weather'] and Buff['En-Day'] then
        equip(sets.midcast.Obi)
        equip(sets.midcast.AyanmoHands)
        -- add_to_chat (60, 'Enspell = Day and weather')
    -- Enspell is there but doesnt match anything of note (single weather no day, day but no weather etc.)
    elseif Buff['Enspell'] then
        equip(sets.midcast.Orpheus)
        equip(sets.midcast.AyanmoHands)
        -- add_to_chat (60, 'Enspell = No match')
    end
end

-- Get a spell mapping for the spell.
function get_spell_map(spell)
    return spell_maps[spell.name]
end
-- Get a spell mapping for the enfeeble.
function get_enfeeb_map(spell)
    return enfeeb_maps[spell.name]
end

function get_blu_map(spell)
    return blu_maps[spell.name]
end

-- Set Macros
function set_macros(sheet,book)
    if book then 
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
end

-- Set Style
function set_style(sheet)
    send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
    add_to_chat (21, 'Your Lockstyle Looks like shit, and you should feel bad')
    add_to_chat (60, 'Be Best')
end

-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = math.floor(player.main_job_level + 10) / 20
    -- assuming level 90+ and if not 550JP replace 5*33 by 5*45 below
    local fullRechargeTime = 5*33

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end

function updateDualWield()
    if dualwield.value == 'AUTO' then
        currentHaste = get_haste_value()
    else
        -- Defaulting for next use.
        currentHaste = 30
    end
end

function updateSnapshot()
    if snapshot.value == 'AUTO' then
    else
        -- Defaulting for next use.
        currentFlurry = 0
    end
end

function get_haste_value()
    if ( (buffactive[33] and not (buffactive.march or buffactive[580] or buffactive[604] or buffactive[228])) or --30% Haste and nothing else pretty much.
        (buffactive[13] and (buffactive.march or buffactive[604]) and (buffactive[580] or buffactive[604] or buffactive[228])) or --Honor March/MG alone very roughly negates slow, leaving you just needing a second.
        (buffactive[565] and buffactive.march == 2 and buffactive[580] and (buffactive[604] or buffactive[228])) ) then
        -- 30% haste
        HasteValue = 30
        return HasteValue
    elseif ( (buffactive[33] and (buffactive[580] or buffactive.march or buffactive[604] or buffactive[228])) or -- Flutter and Geo or march or MG or embrava
            (buffactive[580] and (buffactive.march or buffactive[604] or buffactive[228])) or -- Geo and march or MG or embrava
            (buffactive.march == 2 and (buffactive[604] or buffactive[228])) or -- March x2 and MG or Embrava
            (buffactive[13] and (buffactive.march == 2 or buffactive[580]) and (buffactive[604] or buffactive[228])) ) then -- Slow, but likez the mad buffs 'n shiz, yo.
        -- Capped Haste
        HasteValue = 47
        return HasteValue
    else
        HasteValue = 30
        return HasteValue
    end
end

function get_flury_value(name,gain)
    local name2
    name2 = string.lower(name)

    if S{"flurry",}:contains(name2) then
        if gain then
            -- add_to_chat(122, "Flurry status gained.")
        else
            flurry = 0
            -- add_to_chat(122, "Flurry status cleared.")
        end
    end
end

-- Hides Default/Battlemod Roll Messages
windower.register_event('incoming text', function(old, new, color)
    --Hides Battlemod
    if old:match("Roll.* The total.*") or old:match('.*Roll.*' .. string.char(0x81, 0xA8)) or old:match('.*uses Double.*The total') and color ~= 123 then
        return true
    end
  
    --Hides Vanilla
    if old:match('.* receives the effect of .* Roll.') ~= nil then
        return true
    end
  
    return new, color
  end)
  
  -- COR Roll Info
  windower.raw_register_event('action', function(act)
    if act.category == 6 and table.containskey(rolls, act.param) then
        local playerID = windower.ffxi.get_player().id
        local rollActor = act.actor_id
        local rollerInParty = windower.ffxi.get_mob_by_id(rollActor).in_party
        
        
        -- if rollActor == playerID or rollerInParty then
        -- end
        
        -- Clean unneeded vars
        local rollerName = windower.ffxi.get_mob_by_id(rollActor).name
        local rollID = act.param
        local rollNum = act.targets[1].actions[1].param
        local rollName = rolls[rollID].en
        -- local rollsize = (luzafMode.value and string.char(129,157)) or ''
        local rollInfo = rolls[rollID]
        local party = windower.ffxi.get_party()
  
        rollMembers = {}
        for partyMem in pairs(party) do
            for effectedTarget = 1, #act.targets do
                --if mob is nil then the party member is not in zone, will fire an error.
                if type(party[partyMem]) == 'table' and party[partyMem].mob and act.targets[effectedTarget].id == party[partyMem].mob.id then
                    rollMembers[effectedTarget] = party[partyMem].name
                end
            end
        end
        local membersHit = table.concat(rollMembers, ', ')
        
        -- I rolled -> someone else
        if rollActor == playerID then
            if rollNum == 12 then
                add_to_chat(167,  'Bust! '..string.char(31,210)..rollName..string.char(31,001)..' ['..membersHit..']')
            elseif rollNum == rollInfo.lucky or rollNum == 11 then
                add_to_chat(001,  ''..string.char(31,204).. tostring(rollNum)..string.char(31,001)..' '..string.char(31,210)..rollName..string.char(31,001)..' ['..membersHit..'] '..string.char(31,204).. tostring(rollInfo.lucky)..string.char(31,001)..':'..string.char(31,167).. tostring(rollInfo.unlucky)..string.char(31,001)..'')
            elseif rollNum == rollInfo.unlucky then
                add_to_chat(001,  ''..string.char(31,167).. tostring(rollNum)..string.char(31,001)..' '..string.char(31,210)..rollName..string.char(31,001)..' ['..membersHit..'] '..string.char(31,204).. tostring(rollInfo.lucky)..string.char(31,001)..':'..string.char(31,167).. tostring(rollInfo.unlucky)..string.char(31,001)..'')
            else
                add_to_chat(001,  ''..rollNum..' '..string.char(31,210)..rollName..string.char(31,001)..' ['..membersHit..'] '..string.char(31,204).. tostring(rollInfo.lucky)..string.char(31,001)..':'..string.char(31,167).. tostring(rollInfo.unlucky)..string.char(31,001)..'')
            end
        elseif rollerInParty then
            if rollNum == 12 then
                add_to_chat(167,  '['..rollerName..'] Bust! '..string.char(31,210)..rollName..string.char(31,001)..' ['..membersHit..']')
            elseif rollNum == rollInfo.lucky or rollNum == 11 then
                add_to_chat(001,  '['..rollerName..'] '..string.char(31,204).. tostring(rollNum)..string.char(31,001)..' '..string.char(31,210)..rollName..string.char(31,001)..' ['..membersHit..'] '..string.char(31,204).. tostring(rollInfo.lucky)..string.char(31,001)..':'..string.char(31,167).. tostring(rollInfo.unlucky)..string.char(31,001)..'')
            elseif rollNum == rollInfo.unlucky then
                add_to_chat(001,  '['..rollerName..'] '..string.char(31,167).. tostring(rollNum)..string.char(31,001)..' '..string.char(31,210)..rollName..string.char(31,001)..' ['..membersHit..'] '..string.char(31,204).. tostring(rollInfo.lucky)..string.char(31,001)..':'..string.char(31,167).. tostring(rollInfo.unlucky)..string.char(31,001)..'')
            else
                add_to_chat(001,  '['..rollerName..'] '..rollNum..' '..string.char(31,210)..rollName..string.char(31,001)..' ['..membersHit..'] '..string.char(31,204).. tostring(rollInfo.lucky)..string.char(31,001)..':'..string.char(31,167).. tostring(rollInfo.unlucky)..string.char(31,001)..'')
            end
        end
  
    end
  end)
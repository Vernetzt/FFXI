version = "3.0"

keybinds_off = {}
keybinds_off['key_bind_idle'] = ''
keybinds_off['key_bind_melee'] = ''
keybinds_off['key_bind_casting'] = ''
keybinds_off['key_bind_mainweapon'] = ''
keybinds_off['key_bind_subweapon'] = ''

keybinds_off['key_bind_dualwield'] = ''
keybinds_off['key_bind_bow'] = ''
keybinds_off['key_bind_thMode'] = ''

keybinds_off['key_bind_element_cycle'] = ''
keybinds_off['key_bind_sc_level'] = ''
keybinds_off['key_bind_lock_weapon'] = ''
keybinds_off['key_bind_matchsc'] = ''
keybinds_off['key_bind_enspell_cycle'] = ''
keybinds_off['key_bind_geo_cycle'] = ''
keybinds_off['key_bind_indi_cycle'] = ''
keybinds_off['key_bind_entrust_cycle'] = ''


textHideMode = M(false)
textHideOptions = M(false)
textHideJob = M(false)
textHideBattle = M(false)
textHideHUD = M(false)
useLightMode = M(false)
keybinds = M(false)

hud_padding = 10

hud_x_pos_og = hud_x_pos
hud_y_pos_og = hud_y_pos
hud_font_size_og = hud_font_size
hud_padding_og = hud_padding
hud_transparency_og = hud_transparency

-- mode for generi colors
sectionsColors = M('red', 'blue', 'green', 'white', 'yellow', 'cyan', 'magenta', 'black', 'orange')
keybindsColors = M('red', 'blue', 'green', 'white', 'yellow', 'cyan', 'magenta', 'black', 'orange')
optionsColors = M('red', 'blue', 'green', 'white', 'yellow', 'cyan', 'magenta', 'black', 'orange')
selectionColors = M('red', 'blue', 'green', 'white', 'yellow', 'cyan', 'magenta', 'black', 'orange')

-- Generic Colors
hudColors = {
    ["red"] = "\\cs(255, 32, 32)", 
    ["blue"] = "\\cs(96, 96, 255)", 
    ["green"] = "\\cs(32, 255, 32)",
		["orange"] = "\\cs(255, 128, 32)",     
    ["white"] = "\\cs(225, 225, 225)", 
    ["yellow"] = "\\cs(255, 255, 64)", 
    ["cyan"] = "\\cs(0, 204, 204)", 
    ["magenta"] = "\\cs(255, 0, 255)",
    ['black']="\\cs(92, 92, 92)"
}

cChant = "No Target"
ccColor = hudColors["red"]

scColor = "\\cs(0, 204, 204)"

const_on = "\\cs(32, 255, 32)ON\\cr"
const_off = "\\cs(255, 32, 32)OFF\\cr"
const_autoOff = "\\cs(255, 32, 32)AUTO\\cr"
const_autoOn = "\\cs(32, 255, 32)AUTO\\cr"

hud_endofline = [[\cr
]]
hud_idleMode = ''
hud_meleeMode = ''
hud_nukingMode = ''
hud_mainWeapon = ''
hud_subWeapon = ''
hud_nukingElement = ''
hud_makingSC = ''
hud_regenMode = ''

hud_dualwield = ''
hud_bow = ''
hud_thMode = ''

hud_Enspell = ''
hud_handleSkillchains = ''
hud_lockWeapons = ''
hud_lockMovespeed = ''
hud_lastSC = ''
hud_burstWindow = ''
hud_magicBurst = ''

--------------------------------------------------------------------------------------------------------------
-- HUD LISTINGS --
--------------------------------------------------------------------------------------------------------------
function construct_HUD_Categories( useLightMode )
	if useLightMode then
		hud_endofline = ''
		hud_idleMode = [[    ${keybinds_color}${key_bind_idle}${options_color}Idle:\cr ${selection_color}${player_current_idle|Unset}]]
		if meleeModes ~= nil then
			hud_meleeMode = [[    ${keybinds_color}${key_bind_melee}${options_color}Melee:\cr ${selection_color}${player_current_melee|Unset}]]
		else
			hud_meleeMode = ''
		end

		if dualwield ~= nil then
			hud_dualwield = [[    ${keybinds_color}${key_bind_dualwield}${options_color}DW:\cr ${selection_color}${player_current_dualwield|Unset}]]
		else
			hud_dualwield = ''
		end

		if bow ~= nil then
			hud_bow = [[    ${keybinds_color}${key_bind_bow}${options_color}Bow:\cr ${selection_color}${player_current_bow|Unset}]]
		else
			hud_bow = ''
		end
		
		if thMode ~= nil then
			hud_thMode = [[    ${keybinds_color}${key_bind_thMode}${options_color}TH:\cr ${selection_color}${player_current_thMode|Unset}]]
		else
			hud_thMode = ''
		end

		if nukeModes ~= nil then
			hud_nukingMode = [[    ${keybinds_color}${key_bind_casting}${options_color}Nuke:\cr ${selection_color}${player_current_casting|Unset}]]
		else
			hud_nukingMode = ''
		end
		if mainWeapon ~= nil then
			hud_mainWeapon = [[    ${keybinds_color}${key_bind_mainweapon}${options_color}Main:\cr ${selection_color}${player_current_mainweapon|Unset}]]
		else
			hud_mainWeapon = ''
		end
		if subWeapon ~= nil then
			hud_subWeapon = [[    ${keybinds_color}${key_bind_subweapon}${options_color}Sub:\cr ${selection_color}${player_current_subweapon|Unset}]]
		else
			hud_subWeapon = ''
		end
		if player.main_job == "BLM" or player.main_job == "SCH" or player.main_job == "RDM" or player.main_job == "NIN" or player.main_job == "WHM" or player.main_job == "SMN" or player.main_job == "GEO" then
			hud_nukingElement = [[    ${keybinds_color}${key_bind_element_cycle}${options_color}Nuke:\cr ${element_color}${toggle_element_cycle|Unset}]]
		else
			hud_nukingElement = ''
		end
		if player.main_job == 'SCH' then
			hud_makingSC = [[    ${keybinds_color}${key_bind_sc_level}${options_color}SC:\cr ${sc_element_color}${toggle_sc_level|Unset}]]		
		else
			hud_makingSC = ''
		end
		if player.main_job == 'SCH' then
			hud_regenMode = [[    ${keybinds_color}${key_bind_regen}${options_color}Regen:\cr ${selection_color}${player_current_regen|Unset}]]		
		else
			hud_regenMode = ''
		end
		if player.main_job == 'RDM' then
			hud_Enspell = [[    ${keybinds_color}${key_bind_enspell_cycle}${options_color}Enspell:\cr ${enspell_color}${toggle_enspell_cycle|Unset}]]
		else
			hud_Enspell = ''
		end
		hud_handleSkillchains = [[    ${keybinds_color}${key_bind_matchsc}${options_color}Handle SC:\cr ${player_match_sc}]]
		hud_lockWeapons = [[    ${keybinds_color}${key_bind_lock_weapon}${options_color}Lock:\cr ${toggle_lock_weapon}]]
		hud_lockMovespeed = [[    ${keybinds_color}${key_bind_movespeed_lock}${options_color}Speed:\cr ${toggle_movespeed_lock}]]
		hud_lastSC = [[    ${options_color}Last SC:${last_sc_element_color}${last_sc|No SC yet}]]
		hud_burstWindow = [[    ${options_color}MB Window:${last_sc_element_color}${burst_window|0}]]
		hud_magicBurst = [[    ${options_color}MB:${player_current_mb}]]
		if player.main_job == 'GEO' then
			hud_geoCycle = [[    ${keybinds_color}${key_bind_geo_cycle}${options_color}Geo-Spell:\cr ${selection_color}${toggle_geo_cycle|Unset}]]
			hud_indiCycle = [[    ${keybinds_color}${key_bind_indi_cycle}${options_color}Indi-Spell:\cr ${selection_color}${toggle_indi_cycle|Unset}]]
			hud_entrustCycle = [[    ${keybinds_color}${key_bind_entrust_cycle}${options_color}Entrust-Spell:\cr ${selection_color}${toggle_entrust_cycle|Unset}]]
			hud_cardinalChant = [[    ${options_color}Cardinal Chant:\cr ${card_chant_color}${card_chant|No Target}]]
		else
			hud_geoCycle = ''
			hud_indiCycle = ''
			hud_entrustCycle = ''
			hud_cardinalChant = ''
		end
	else
		hud_endofline = [[\cr
		]]
		hud_idleMode = [[\cr 
		${keybinds_color}${key_bind_idle}${options_color}Idle:\cr ${selection_color}${player_current_idle|Unset}]]
		if meleeModes ~= nil then
			hud_meleeMode = [[\cr 
			${keybinds_color}${key_bind_melee}${options_color}Melee:\cr ${selection_color}${player_current_melee|Unset}]]
		else
			hud_meleeMode = ''
		end

		if dualwield ~= nil then
			hud_dualwield = [[\cr 
			${keybinds_color}${key_bind_dualwield}${options_color}DW:\cr ${selection_color}${player_current_dualwield|Unset}]]
		else
			hud_dualwield = ''
		end

		if bow ~= nil then
			hud_bow = [[\cr 
			${keybinds_color}${key_bind_bow}${options_color}Bow:\cr ${selection_color}${player_current_bow|Unset}]]
		else
			hud_bow = ''
		end
		
		if thMode ~= nil then
			hud_thMode = [[\cr 
			${keybinds_color}${key_bind_thMode}${options_color}TH:\cr ${selection_color}${player_current_thMode|Unset}]]
		else
			hud_thMode = ''
		end

		hud_nukingMode = [[\cr 
		${keybinds_color}${key_bind_casting}${options_color}Nuking:\cr ${selection_color}${player_current_casting|Unset}]]
		if mainWeapon ~= nil then
			hud_mainWeapon = [[\cr 
			${keybinds_color}${key_bind_mainweapon}${options_color}Main:\cr ${selection_color}${player_current_mainweapon|Unset}]]
		else
			hud_mainWeapon = ''
		end
		if subWeapon ~= nil then
			hud_subWeapon = [[\cr 
			${keybinds_color}${key_bind_subweapon}${options_color}Sub:\cr ${selection_color}${player_current_subweapon|Unset}]]
		else
			hud_mainWeapon = ''
		end
		if player.main_job == "BLM" or player.main_job == "SCH" or player.main_job == "RDM" or player.main_job == "NIN" or player.main_job == "WHM" or player.main_job == "SMN" or player.main_job == "GEO" then
			hud_nukingElement = [[\cr 
			${keybinds_color}${key_bind_element_cycle}${options_color}Nuking:\cr ${element_color}${toggle_element_cycle|Unset}]]
		else
			hud_nukingElement = ''
		end
		if player.main_job == 'SCH' then
			hud_makingSC = [[\cr 
			${keybinds_color}${key_bind_sc_level}${options_color}SC:\cr ${sc_element_color}${toggle_sc_level|Unset}]]		
		else
			hud_makingSC = ''
		end
		if player.main_job == 'SCH' then
			hud_regenMode = [[\cr 
			${keybinds_color}${key_bind_regen}${options_color}Regen:\cr ${selection_color}${player_current_regen|Unset}]]		
		else
			hud_regenMode = ''
		end
		if player.main_job == 'RDM' then
			hud_Enspell = [[\cr 
			${keybinds_color}${key_bind_enspell_cycle}${options_color}Enspell:\cr ${enspell_color}${toggle_enspell_cycle|Unset}]]
		else
			hud_Enspell = ''
		end
		hud_handleSkillchains = [[\cr
		${keybinds_color}${key_bind_matchsc}${options_color}Handle SC:\cr ${player_match_sc}]]
		hud_lockWeapons = [[\cr
		${keybinds_color}${key_bind_lock_weapon}${options_color}Lock:\cr ${toggle_lock_weapon}]]
		hud_lockMovespeed = [[\cr
		${keybinds_color}${key_bind_movespeed_lock}${options_color}Speed:\cr ${toggle_movespeed_lock}]]
		hud_lastSC = [[\cr
		${options_color}Last SC:${last_sc_element_color}${last_sc|No SC yet}]]
		hud_burstWindow = [[\cr
		${options_color}Burst Window:${last_sc_element_color}${burst_window|0}]]
		hud_magicBurst = [[\cr
		${options_color}MB:${player_current_mb}]]
		if player.main_job == 'GEO' then
			hud_geoCycle = [[\cr
		  ${keybinds_color}${key_bind_geo_cycle}${options_color}Geo-Spell:\cr ${selection_color}${toggle_geo_cycle|Unset}]]
			hud_indiCycle = [[\cr
		  ${keybinds_color}${key_bind_indi_cycle}${options_color}Indi-Spell:\cr ${selection_color}${toggle_indi_cycle|Unset}]]
			hud_entrustCycle = [[\cr
		  ${keybinds_color}${key_bind_entrust_cycle}${options_color}Entrust-Spell:\cr ${selection_color}${toggle_entrust_cycle|Unset}]]
			hud_cardinalChant = [[\cr
		  ${options_color}Cardinal Chant:\cr ${card_chant_color}${card_chant|No Target}]]
		else
			hud_geoCycle = ''
			hud_indiCycle = ''
			hud_entrustCycle = ''
			hud_cardinalChant = ''
		end
	end
end

function buildHUD( useLightMode )
	if useLightMode then
		hud_mode = hud_idleMode..hud_meleeMode..hud_dualwield..hud_nukingMode..hud_endofline
		hud_options = hud_handleSkillchains..hud_lockWeapons..hud_dualwield..hud_thMode..hud_lockMovespeed..hud_endofline
		hud_job = hud_geoCycle..hud_indiCycle..hud_entrustCycle..hud_mainWeapon..hud_subWeapon..hud_bow..hud_regenMode..hud_nukingElement..hud_makingSC..hud_Enspell..hud_endofline        
		hud_battle = hud_lastSC..hud_burstWindow..hud_magicBurst..hud_cardinalChant..hud_endofline
	else
		hud_mode = [[${sections_color}Modes:]]..hud_idleMode..hud_meleeMode..hud_nukingMode..hud_endofline
		hud_options = [[${sections_color}Options:]]..hud_handleSkillchains..hud_lockWeapons..hud_dualwield..hud_thMode..hud_lockMovespeed..hud_endofline
		hud_job = [[${sections_color}${player_job}:]]..hud_geoCycle..hud_indiCycle..hud_entrustCycle..hud_mainWeapon..hud_subWeapon..hud_bow..hud_regenMode..hud_nukingElement..hud_makingSC..hud_Enspell..hud_endofline        
		hud_battle = [[${sections_color}Battle Info:]]..hud_lastSC..hud_burstWindow..hud_magicBurst..hud_cardinalChant..hud_endofline 
	end

	-- if useLightMode then
	-- 	hud_mode = [[        ${sections_color}Modes:]]..hud_idleMode..hud_meleeMode..hud_dualwield..hud_nukingMode..hud_endofline
	-- else
	-- 	hud_mode = [[${sections_color}Modes:]]..hud_idleMode..hud_meleeMode..hud_nukingMode..hud_endofline
	-- end
	-- hud_options = [[${sections_color}Options:]]..hud_handleSkillchains..hud_lockWeapons..hud_dualwield..hud_thMode..hud_lockMovespeed..hud_endofline
	-- hud_job = [[${sections_color}${player_job}:]]..hud_geoCycle..hud_indiCycle..hud_entrustCycle..hud_mainWeapon..hud_subWeapon..hud_bow..hud_regenMode..hud_nukingElement..hud_makingSC..hud_Enspell..hud_endofline        
	-- hud_battle = [[${sections_color}Battle Info:]]..hud_lastSC..hud_burstWindow..hud_magicBurst..hud_cardinalChant..hud_endofline 

end
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

function validateTextInformation()

    -- Assign Colors
    main_text_hud.sections_color = hudColors[sectionsColors .current]
    main_text_hud.keybinds_color = hudColors[keybindsColors.current]
    main_text_hud.options_color = hudColors[optionsColors.current]
    main_text_hud.selection_color = hudColors[selectionColors.current]

    if regenModes ~= nil then 
    	main_text_hud.player_current_regen = regenModes.current
    end
    if wantedSc ~= nil then
    	main_text_hud.toggle_sc_level = wantedSc
	end
    if idleModes ~= nil then
	    if refreshType ~= nil then
		    if refreshType == "sublimation" then
		        main_text_hud.player_current_idle = tostring(idleModes.current..' + \\cs(32, 255, 32)Sublimation\\cr')
		    else
		        main_text_hud.player_current_idle = idleModes.current
		    end
    	elseif luopanMode ~= nil then
    		if luopanMode == 'pan' then
        		main_text_hud.player_current_idle = tostring(idleModes.current..' + \\cs(32, 255, 32)luopan\\cr')
    		else
        		main_text_hud.player_current_idle = idleModes.current
    		end
    	else
	    	main_text_hud.player_current_idle = idleModes.current
	    end
    end
    if meleeModes ~= nil then
    	main_text_hud.player_current_melee = meleeModes.current
		end

		if dualwield ~= nil then
    	main_text_hud.player_current_dualwield = dualwield.current
		end
		if bow ~= nil then
			main_text_hud.player_current_bow = bow.current
		end
		if thMode ~= nil then
			main_text_hud.player_current_thMode = thMode.current
		end


    if mainWeapon ~= nil then
    	main_text_hud.player_current_mainweapon = mainWeapon.current
    end
    if subWeapon ~= nil then
    	main_text_hud.player_current_subweapon = subWeapon.current
	end
    if nukeModes ~= nil then
    	main_text_hud.player_current_casting = nukeModes.current
  	end
  	if elements ~= nil then
    	main_text_hud.toggle_element_cycle = elements.current
	end
    if enspellElements ~= nil then 
    	main_text_hud.toggle_enspell_cycle = enspellElements.current
    end
    if player.main_job == "GEO" then
	    main_text_hud.toggle_geo_cycle = geomancy.current
	    main_text_hud.toggle_indi_cycle = indicolure.current
	    main_text_hud.toggle_entrust_cycle = entrustindi.current
	    main_text_hud.card_chant = cChant
	    main_text_hud.card_chant_color = ccColor
	end
    main_text_hud.player_job = player.job


    if last_skillchain ~= nil then
        main_text_hud.last_sc = last_skillchain.english
        main_text_hud.burst_window = tostring(MB_Window)
        main_text_hud.last_sc_element_color = Colors[last_skillchain.elements[1]]
    end

	if mBurst ~= nil and matchsc ~= nil then
	    if mBurst.value then
	        main_text_hud.player_current_mb = const_on
	    else
	        main_text_hud.player_current_mb = const_off
	    end
	    if matchsc.value == 'OFF' then
	        main_text_hud.player_match_sc = const_off
	    elseif matchsc.value == 'ON' then
	        main_text_hud.player_match_sc = const_on
		else
	        if mBurst.value then
	            main_text_hud.player_match_sc = const_autoOn
	        else
	            main_text_hud.player_match_sc = const_autoOff
	        end
	    end
	end

	if meleeing ~= nil then
	    if meleeing.value == "OFF" then
	        main_text_hud.toggle_lock_weapon = const_off
	    elseif meleeing.value == "ON" then
	        main_text_hud.toggle_lock_weapon = const_on
	    else
	    	if lockWeaponTP ~= nil then
		        if player.tp >= lockWeaponTP then 
		            main_text_hud.toggle_lock_weapon = const_autoOn
		        elseif meleeModes ~= nil then
		        	if meleeModes.value == 'zeroTP' then
		        		main_text_hud.toggle_lock_weapon = const_autoOn
		        	else
		           		main_text_hud.toggle_lock_weapon = const_autoOff
		        	end
		        else
		           	main_text_hud.toggle_lock_weapon = const_autoOff
		        end
		    else
		        main_text_hud.toggle_lock_weapon = const_autoOff
		    end
	    end
	end

	if runspeed ~= nil then
	    if runspeed.value == 'ON' then
			if autorunspeed then
				main_text_hud.toggle_movespeed_lock =  const_autoOn
			else
				main_text_hud.toggle_movespeed_lock =  const_on
			end
	    elseif runspeed.value == 'OFF' then
			if autorunspeed then
				main_text_hud.toggle_movespeed_lock =  const_autoOff
			else
				main_text_hud.toggle_movespeed_lock =  const_off
			end
	    end
	end

    if keybinds.value then
        texts.update(main_text_hud, keybinds_on)
    else 
        texts.update(main_text_hud, keybinds_off)
    end
    main_text_hud.element_color = Colors[elements.current]
    main_text_hud.enspell_color = Colors[enspellElements.current]
    main_text_hud.sc_element_color = scColor
end

--Default To Set Up the Text Window
function setupTextWindow()

    local default_settings = {}
    default_settings.pos = {}
    default_settings.pos.x = hud_x_pos
    default_settings.pos.y = hud_y_pos
    default_settings.bg = {}

    default_settings.bg.alpha = hud_transparency
    default_settings.bg.red = 40
    default_settings.bg.green = 40
    default_settings.bg.blue = 55
    default_settings.bg.visible = true
    default_settings.flags = {}
    default_settings.flags.right = false
    default_settings.flags.bottom = false
    default_settings.flags.bold = true
    default_settings.flags.draggable = hud_draggable
    default_settings.flags.italic = false
    default_settings.padding = hud_padding
    default_settings.text = {}
    default_settings.text.size = hud_font_size
    default_settings.text.font = hud_font
    default_settings.text.fonts = {}
    default_settings.text.alpha = 255
    default_settings.text.red = 147
    default_settings.text.green = 161
    default_settings.text.blue = 161
    default_settings.text.stroke = {}
    default_settings.text.stroke.width = 1
    default_settings.text.stroke.alpha = 255
    default_settings.text.stroke.red = 0
    default_settings.text.stroke.green = 0
    default_settings.text.stroke.blue = 0

    --Creates the initial Text Object will use to create the different sections in
    if not (main_text_hud == nil) then
        texts.destroy(main_text_hud)
    end
    main_text_hud = texts.new('', default_settings, default_settings)
	--Builds the 4 categories.
	construct_HUD_Categories(useLightMode.value)
	buildHUD(useLightMode.value)
    --Appends the different sections to the main_text_hud
    texts.append(main_text_hud, hud_mode)
    texts.append(main_text_hud, hud_options)
    texts.append(main_text_hud, hud_job)
    texts.append(main_text_hud, hud_battle)
    --We then do a quick validation
    validateTextInformation()

    --Finally we show this to the user
    toggleHudStyle(useLightMode.value)
    main_text_hud:show()    
end
--[[
    This handles hiding the different sections
]]
function hideTextSections()

    --For now when hiding a section its easier to recreate the entire window
    texts.clear(main_text_hud)
    
    --Below we check to make sure this is true by default these are false
    if not textHideMode.value then
        texts.append(main_text_hud, hud_mode)
    end
    if not textHideOptions.value then
        texts.append(main_text_hud, hud_options)
    end
    if not textHideJob.value then
        texts.append(main_text_hud, hud_job)
    end
    if not textHideBattle.value then
        texts.append(main_text_hud, hud_battle)
    end
    validateTextInformation()

end


function toggleHudStyle( useLightMode )
    texts.clear(main_text_hud)
    if useLightMode then
				-- Bottom Center
        -- hud_x_pos = 300
				-- hud_y_pos = 1180

				-- Top Center
				hud_x_pos = 300
        hud_y_pos = -1

        hud_font_size = 10
        hud_padding = 1
        hud_transparency = 0
        hud_strokewidth = 1
    else
        hud_x_pos = hud_x_pos_og
        hud_y_pos = hud_y_pos_og
        hud_font_size = hud_font_size_og
        hud_padding = hud_padding_og
        hud_transparency = hud_transparency_og
        hud_strokewidth = 1
    end
    texts.pos(main_text_hud, hud_x_pos, hud_y_pos)
    texts.size(main_text_hud, hud_font_size)
    texts.pad(main_text_hud, hud_padding)
    texts.bg_alpha(main_text_hud, hud_transparency)
    texts.stroke_width(main_text_hud, hud_strokewidth)
    construct_HUD_Categories(useLightMode)  
    buildHUD(useLightMode)
    hideTextSections()
end

function hud_command(command)
 
    local commandArgs = command
    
    if #commandArgs:split(' ') >= 2 then
        commandArgs = T(commandArgs:split(' '))
        
        if commandArgs[1]:lower() == "hud" then --First variable is hide lets find out what

            if commandArgs[2]:lower() == "hide" then -- Hides/Shows the HUd
                textHideHUD:toggle()

                if textHideHUD.value == true then
                    texts.hide(main_text_hud)
                else 
                    texts.show(main_text_hud)
                end

                hideTextSections()
            elseif commandArgs[2]:lower() == "keybinds" then --Hides/Show Keybinds
                keybinds:toggle()

                if keybinds.value then
                    texts.update(main_text_hud, keybinds_on) --If ON then we pass in Table for keybinds to update the variables
                else 
                    texts.update(main_text_hud, keybinds_off) --Otherwise we set them to blank
                end

                hideTextSections()
            elseif commandArgs[2]:lower() == "hidemodes" then --Hides the Mode
                textHideMode:toggle()
                hideTextSections()
            elseif commandArgs[2]:lower() == "hideoptions" then --Hides/Show Scholar sectio
                textHideOptions:toggle()
                hideTextSections()
            elseif commandArgs[2]:lower() == "hidejob" then --Hides/Show Battle section
                textHideJob:toggle()
                hideTextSections()
            elseif commandArgs[2]:lower() == "hidebattle" then --Hides/Show Battle section
                textHideBattle:toggle()
                hideTextSections()
            elseif commandArgs[2]:lower() == "lite" then --Hides/Show Options
                useLightMode:toggle()
                toggleHudStyle(useLightMode.value)
            elseif commandArgs[2]:lower() == "setcolor" then

            	if commandArgs[3]:lower() == "sections" then
            		if commandArgs[4] ~= nil then
            			if sectionsColors:contains(commandArgs[4]:lower()) then
            				sectionsColors:set(commandArgs[4]:lower())
            			else
							windower.add_to_chat(123,'Unknown hud color: '..tostring(commandArgs[4]))
						end
					else
						sectionsColors:cycle()
            		end
            	
            	elseif commandArgs[3]:lower() == "keybinds" then
            		if commandArgs[4] ~= nil and keybindsColors:contains(commandArgs[4]:lower()) then
            			if keybindsColors:contains(commandArgs[4]:lower()) then
            				keybindsColors:set(commandArgs[4]:lower())
            			else
							windower.add_to_chat(123,'Unknown hud color: '..tostring(commandArgs[4]))
						end
					else
						keybindsColors:cycle()
            		end
            		
            	elseif commandArgs[3]:lower() == "options" then
            		if commandArgs[4] ~= nil and optionsColors:contains(commandArgs[4]:lower()) then
            			if optionsColors:contains(commandArgs[4]:lower()) then
            				optionsColors:set(commandArgs[4]:lower())
            			else
							windower.add_to_chat(123,'Unknown hud color: '..tostring(commandArgs[4]))
						end
					else
						optionsColors:cycle()
            		end
            		
            	elseif commandArgs[3]:lower() == "selection" then
            		if commandArgs[4] ~= nil and selectionColors:contains(commandArgs[4]:lower()) then
            			if selectionColors:contains(commandArgs[4]:lower()) then
            				selectionColors:set(commandArgs[4]:lower())
            			else
							windower.add_to_chat(123,'Unknown hud color: '..tostring(commandArgs[4]))
						end
					else
						selectionColors:cycle()
            		end
            	end
            	validateTextInformation()
            end
        end
    end
end

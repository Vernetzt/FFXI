version = "3.0"
--[[
        Custom commands:
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode auto / on / off and locking of weapons
        gs c toggle idlemode            Toggles between Refresh and DT idle mode.
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)

        -- NEW
        gs c toggle bow
        gs c toggle dualwield	

        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob				Toggles the Job section of the HUD on or off
        gs c hud lite					Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file. Also on CTRL-END
        gs c hud setcolor sections      Cycles colors for sections
        gs c hud setcolor options       Cycles colors for options
        gs c hud setcolor keybinds      Cycles colors for keybinds
        gs c hud setcolor selection     Cycles colors for selection
--]]
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--              ______                   _                  
--             / _____)        _     _  (_)                 
--            ( (____  _____ _| |_ _| |_ _ ____   ____  ___ 
--             \____ \| ___ (_   _|_   _) |  _ \ / _  |/___)
--             _____) ) ____| | |_  | |_| | | | ( (_| |___ |
--            (______/|_____)  \__)  \__)_|_| |_|\___ (___/ 
--                                              (_____|    
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Set this to true and as soon as you move you swap into movespeed set, and revert when stationary
-- Set it to false and the movespeed toggle is manual. 
autorunspeed = true
auto_CP_Cape = false
announceState = true
-- TP treshold where weapons gets locked. 
lockWeaponTP = 300
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- HUD Initial setup and Positioning
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
hud_x_pos = 1985    --important to update these if you have a smaller screen
hud_y_pos = 430     --important to update these if you have a smaller screen
hud_draggable = false
hud_font_size = 10
hud_transparency = 0 -- a value of 0 (invisible) to 255 (no transparency at all)
-- hud_font = 'Impact'
hud_font = 'Calibri'
hud_padding = 10
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
include('Liz-Includes.lua')
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Customize HUD looks and content
-- Colors: ('red', 'blue', 'green', 'white', 'yellow', 'cyan', 'magenta', 'black', 'orange')

sectionsColors:set('orange')
keybindsColors:set('yellow')
optionsColors:set('white')
selectionColors:set('blue')
textHideMode:set(false)
textHideOptions:set(false)
textHideJob:set(false)
textHideBattle:set(false)
textHideHUD:set(false)
useLightMode:set(false)
keybinds:set(false)

--------------------------------------------------------------------------------------------------------------
-- NEW
--------------------------------------------------------------------------------------------------------------
-- Optional. Swap to your BLU macro sheet / book
set_macros(1,3) -- Sheet, Book

-- Set Stylelock
set_style(84)

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('refresh', 'dt', 'eva')
meleeModes = M('normal', 'acc', 'dt', 'eva')

-- To add a new mode to nuking, you need to define both sets: sets.midcast.nuking.mynewmode as well as sets.midcast.MB.mynewmode
nukeModes = M('normal', 'acc')

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Important to read!
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- This will be used later down for weapon combos, here's mine for example, you can add your REMA+offhand of choice in there
-- Add your weapons in the Main list and/or sub list.
-- Don't put any weapons / sub in your IDLE and ENGAGED sets'
-- You can put specific weapons in the midcasts and precast sets for spells, but after a spell is 
-- cast and we revert to idle or engaged sets, we'll be checking the following for weapon selection. 
-- Defaults are the first in each list
mainWeapon = M('Tizona','Maxentius')
subWeapon = M('Machaera +2', 'Naegling', 'Kaja Rod')
TpBonus = "Machaera +2"

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- Setup your Key Bindings here:
-- windower.send_command('bind insert gs c nuke cycle')            -- Insert Cycles Nuke element
-- windower.send_command('bind !insert gs c nuke cycledown')       -- ALT+Insert Cycles Nuke element in reverse order 

-- windower.send_command('bind f9 gs c toggle idlemode')           -- F9 to change Idle Mode    
-- windower.send_command('bind f8 gs c toggle meleemode')          -- F8 to change Melee Mode  
-- windower.send_command('bind !f9 gs c toggle melee')             -- Alt-F9 Toggle Melee mode on / off, locking of weapons
-- windower.send_command('bind home gs c toggle mainweapon')       -- Home Toggle Main Weapon
-- windower.send_command('bind !home gs c toggle subweapon')       -- ALT-Home Toggle sub Weapon.
-- windower.send_command('bind !` input /ma Stun <t>')             -- Alt-` Quick Stun Shortcut.
-- windower.send_command('bind delete gs c nuke enspellup')        -- delete Cycle Enspell Up
-- windower.send_command('bind !delete gs c nuke enspelldown')     -- Alt-delete Cycle Enspell Down
-- windower.send_command('bind !f10 gs c toggle nukemode')         -- Alt-F10 to change Nuking Mode
-- windower.send_command('bind f10 gs c toggle matchsc')           -- F10 to change Match SC Mode         
-- windower.send_command('bind !end gs c hud lite')                -- Alt-End to toggle light hud version       
-- windower.send_command('bind ^end gs c hud keybinds')            -- CTRL-End to toggle Keybinds  

--[[
    This gets passed in when the Keybinds is turned on.
    IF YOU CHANGED ANY OF THE KEYBINDS ABOVE, edit the ones below so it can be reflected in the hud using the "//gs c hud keybinds" command
]]
keybinds_on = {}
-- keybinds_on['key_bind_idle'] = '(F9)'
-- keybinds_on['key_bind_melee'] = '(F8)'
-- keybinds_on['key_bind_casting'] = '(ALT-F10)'
-- keybinds_on['key_bind_mainweapon'] = '(HOME)'
-- keybinds_on['key_bind_subweapon'] = '(Alt-HOME)'
-- keybinds_on['key_bind_element_cycle'] = '(INS)'
-- keybinds_on['key_bind_enspell_cycle'] = '(DEL)'
-- keybinds_on['key_bind_lock_weapon'] = '(ALT-F9)'
-- keybinds_on['key_bind_matchsc'] = '(F10)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    -- windower.send_command('unbind insert')            -- Insert Cycles Nuke element
    -- windower.send_command('unbind !insert')       -- ALT+Insert Cycles Nuke element in reverse order 

    -- windower.send_command('unbind f9')           -- F9 to change Idle Mode    
    -- windower.send_command('unbind f8')          -- F8 to change Melee Mode  
    -- windower.send_command('unbind !f9')             -- Alt-F9 Toggle Melee mode on / off, locking of weapons
    -- windower.send_command('unbind home')          -- Home Toggle Main Weapon
    -- windower.send_command('unbind !home')       -- ALT-Home Toggle sub Weapon.
    -- windower.send_command('unbind !`')             -- Alt-` Quick Stun Shortcut.
    -- windower.send_command('unbind delete')        -- delete Cycle Enspell Up
    -- windower.send_command('unbind !delete')     -- Alt-delete Cycle Enspell Down
    -- windower.send_command('unbind !f10')         -- Alt-F10 to change Nuking Mode
    -- windower.send_command('unbind f10')           -- F10 to change Match SC Mode         
    -- windower.send_command('unbind !end')                -- Alt-End to toggle light hud version       
    -- windower.send_command('unbind ^end')            -- CTRL-End to toggle Keybinds    
end

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
include('BLU_Lib.lua')      -- leave this as is 
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
                --  _____                  __      __        _       _     _
                -- / ____|                 \ \    / /       (_)     | |   | |
                --| |  __  ___  __ _ _ __   \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___
                --| | |_ |/ _ \/ _` | '__|   \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
                --| |__| |  __/ (_| | |       \  / (_| | |  | | (_| | |_) | |  __/\__ \
                -- \_____|\___|\__,_|_|        \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- Setup your Gear Sets below:
function get_sets()
    ----------------------------------------------------------
    -- Auto CP Cape: Will put on CP cape automatically when
    -- fighting Apex mobs and job is not mastered
	-- It will equip the cape and lock it when the apex mob is under 15% hp.
    ----------------------------------------------------------
    CP_CAPE = "Mecisto. Mantle" -- Put your CP cape here
    ----------------------------------------------------------

    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


	-- Fill this with your own JSE. 
    --Atrophy
    AF.Head		=	""
    AF.Body		=	""
    AF.Hands	=	""
    AF.Legs		=	""
    AF.Feet		=	""

    --Vitiation
    RELIC.Head		=	""
    RELIC.Body		=	""
    RELIC.Hands 	=	""
    RELIC.Legs		=	""
    RELIC.Feet		=	""

    --Lethargy
    EMPY.Head		=	""
    EMPY.Body		=	""
    EMPY.Hands		=	""
    EMPY.Legs		=	""
    EMPY.Feet		=	""

    -- Capes:
	Rosmerta = {}
    Rosmerta.DA = { name = "Rosmerta's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dbl.Atk."+10', 'Damage Taken -5%' } }
    Rosmerta.Nuke = { name = "Rosmerta's Cape", augments = { 'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10', } }
    Rosmerta.Crit = { name = "Rosmerta's Cape", augments = { 'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10', } }
    Rosmerta.WSD = { name = "Rosmerta's Cape", augments = { 'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%', } }
    Rosmerta.STP = { name = "Rosmerta's Cape", augments = { 'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%' } }
    Rosmerta.FC = { name="Rosmerta's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Fast Cast"+10','Evasion+15', } }

    -- SETS
     
    sets.me = {}        		-- leave this empty
    sets.buff = {} 				-- leave this empty
    sets.me.idle = {}			-- leave this empty
    sets.me.melee = {}          -- leave this empty
    sets.weapons = {}			-- leave this empty
    sets.me.dualwield = {}
	
    -- Optional 
	include('AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 

	-- Leave weapons out of the idles and melee sets. You can/should add weapons to the casting sets though
    -- Your idle set
    -- Movespeedset
    sets.me.movespeed = { 
        Legs = "Carmine Cuisses +1",
    }

    sets.me.idle.refresh = {

    }

    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle.refresh,{

    })  
    sets.me.idle.mdt = set_combine(sets.me.idle.dt,{

    })  

    sets.me.idle.eva = set_combine(sets.me.idle.dt,{

    })  
	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    sets.me.latent_refresh = {waist="Fucho-no-obi"}     
    
    -- Combat Related Sets

	------------------------------------------------------------------------------------------------------
    -- Dual Wield sets
	------------------------------------------------------------------------------------------------------

    sets.me.melee.normaldw = set_combine(sets.me.idle.refresh,{   

    })

    sets.me.melee.accdw = set_combine(sets.me.melee.normaldw,{

    })

    sets.me.melee.dtdw = set_combine(sets.me.melee.normaldw,{

    })

    sets.me.melee.mdtdw = set_combine(sets.me.melee.dtdw,{

    })

    sets.me.melee.evadw = set_combine(sets.me.idle.eva,{

    })

    ------------------------------------------------------------------------------------------------------
    -- +31 and +11 Dual Wield sets for toggle
 	------------------------------------------------------------------------------------------------------ 

    sets.me.melee.normaldw11 = set_combine(sets.me.melee.normaldw,{   

    })

    sets.me.melee.accdw11 = set_combine(sets.me.melee.accdw,{  

    })

    sets.me.melee.dtdw11 = set_combine(sets.me.melee.dtdw,{   
 
    })

    sets.me.melee.mdtdw11 = set_combine(sets.me.melee.mdtdw,{   
 
    })

    sets.me.melee.evadw11 = set_combine(sets.me.melee.evadw,{

    })


    ------------------------------------------------------------------------------------------------------
    -- AM3 31 Set
    ------------------------------------------------------------------------------------------------------
    sets.me.melee.normaldw.TizAM3 = set_combine(sets.me.melee.normaldw,{   

    })
    sets.me.melee.accdw.TizAM3 = set_combine(sets.me.melee.normaldw.TizAM3,{

    })
    sets.me.melee.dtdw.TizAM3 = set_combine(sets.me.melee.normaldw.TizAM3,{

    })
    sets.me.melee.mdtdw.TizAM3 = set_combine(sets.me.melee.dtdw.TizAM3,{

    })
    sets.me.melee.evadw.TizAM3 = set_combine(sets.me.melee.evadw,{

    })

    ------------------------------------------------------------------------------------------------------
        -- AM3 11 Set
    ------------------------------------------------------------------------------------------------------
    sets.me.melee.normaldw11.TizAM3 = set_combine(sets.me.melee.normaldw.TizAM3,{   

    })
    sets.me.melee.accdw11.TizAM3 = set_combine(sets.me.melee.normaldw11.TizAM3,{  

    })
    sets.me.melee.dtdw11.TizAM3 = set_combine(sets.me.melee.dtdw.TizAM3,{   

    })
    sets.me.melee.mdtdw11.TizAM3 = set_combine(sets.me.melee.dtdw11.TizAM3,{   
         
    })
    sets.me.melee.evadw11.TizAM3 = set_combine(sets.me.melee.evadw,{

    })

    ------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
    ------------------------------------------------------------------------------------------------------
    
    sets.me["Expiacion"] = {

    }
    sets.me["Savage Blade"] = set_combine(sets.me["Expiacion"],{

    })
    sets.me["Black Halo"] = set_combine(sets.me["Expiacion"],{

    })
    sets.me["Chant du Cygne"] = {

    }
    sets.me["Requiescat"] = {

    }
    sets.me["Sanguine Blade"] = {

    }
    sets.me["Red Lotus Blade"] = {

    }
    sets.me["Seraph Blade"] = {

    }

    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though 
	
	
    ---------------
    -- Casting Sets
    ---------------
    sets.precast = {}   		-- Leave this empty  
    sets.midcast = {}    		-- Leave this empty  
    sets.aftercast = {}  		-- Leave this empty  
	sets.midcast.nuking = {}	-- leave this empty
	sets.midcast.MB	= {}		-- leave this empty   
    sets.midcast.enhancing = {} -- leave this empty   
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast BLU
    sets.precast.casting = {

    }
    

    -- Special -Recast sets
    -- sets.me["Utsusemi: Ichi"] = {
    --     ammo = "Sapience Orb",
    --     head = Herc.Head.FC,
    --     neck = "Voltsurge Torque",
    --     left_ear = "Etiolation Earring",
    --     right_ear = "Loquac. Earring",
    --     body = Taeon.Body.FC,
    --     hands = "Leyline Gloves",
    --     -- ring1 = "Kishar Ring",
    --     ring1 = "Lebeche Ring",
    --     ring2 = "Rahab Ring",
    --     back = Rosmerta.FC,
    --     waist = "Witful Belt",
    --     legs = "Psycloth lappas",
    --     feet = "Carmine Greaves +1"
    -- }
    -- sets.me["Utsusemi: Ni"] = {
    --     ammo = "Sapience Orb",
    --     head = Herc.Head.FC,
    --     neck = "Voltsurge Torque",
    --     left_ear = "Etiolation Earring",
    --     right_ear = "Loquac. Earring",
    --     body = Taeon.Body.FC,
    --     hands = "Leyline Gloves",
    --     -- ring1 = "Kishar Ring",
    --     ring1 = "Lebeche Ring",
    --     ring2 = "Rahab Ring",
    --     back = Rosmerta.FC,
    --     waist = "Witful Belt",
    --     legs = "Psycloth lappas",
    --     feet = "Carmine Greaves +1"
    -- }


    sets.precast.enhancing = set_combine(sets.precast.casting,{
		-- don't really need this anymore with capped FC.
    })
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{
		--Legacy. 
    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{

    })

      
    ---------------------
    -- Ability Precasting
    ---------------------

    -- sets.precast["Chainspell"] = {body = RELIC.Body}
	 

	
	----------
    -- Midcast
    ----------
	
    -- Just go make it, inventory will thank you and making rules for each is meh.
    sets.midcast.Obi = {
    	waist="Hachirin-no-Obi",
    }
    sets.midcast.Orpheus = {
        waist="Orpheus's Sash",
    }

        
    -- Utsu SIRD and DT here
    sets.midcast.utsu = set_combine(sets.me.idle.dt, {

    })

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {

    }

    sets.midcast.nuking.normal = set_combine(sets.midcast.casting,{
    })

    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {

    })

    sets.midcast.nuking.acc = set_combine(sets.midcast.nuking.normal, {

    })
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.acc, {

    })	

    -- Blue Magic

    sets.midcast.BluDark = set_combine(sets.midcast.nuking.normal,{

    })
    sets.midcast.BluLight = set_combine(sets.midcast.nuking.normal,{

    })

    -- EVA SET TEST WIP (UPDATE)
    sets.midcast.BluEVA = set_combine(sets.me.idle.eva,{

    })


    sets.midcast.BluSTR = {

    }

    sets.midcast.BluDEX = set_combine(sets.midcast.BluSTR, {})

    sets.midcast.BluVIT = set_combine(sets.midcast.BluSTR, {})

    sets.midcast.BluMND = set_combine(sets.midcast.BluSTR, {})

    sets.midcast.BluAGI = set_combine(sets.midcast.BluSTR, {})

    --Conserve MP Gear, 55%, FC, 17%--
    sets.midcast.BluBuff = {

    }

    --Just for landing things like sleep--
    sets.midcast.BluMACC = {

    }

    sets.midcast.BluStun = {

    }

    --Occultation is every 50 skill, magic barrier equals skill, anything that isn't /50 doesn't matter.
    ---For example diamondhide caps at 500
	---Mastered Skill w/ merits is 472
	
    sets.midcast.BluSkill = {

    }
    
    --Aim for empy hands and FC+ with skill /50
	---Capped magic haste 1200JPs with flutter FC, only 23% FC is needed to cap.
	sets.midcast.Occultation = set_combine(sets.midcast.BluSkill, {

    })

	--Reaving Wind, Feather Tickle, Osmosis, etc
	sets.midcast.BluFastRecast = {

	}

    sets.midcast.Enmity = {

    }

	
    -- Enhancing yourself 
    sets.midcast.enhancing = {

    }


    -- Phalanx
    sets.midcast.phalanx =  set_combine(sets.midcast.enhancing, {

    })

    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{

    })
    sets.midcast.refresh = set_combine(sets.midcast.enhancing,{

    })

    sets.midcast.aquaveil = set_combine(sets.midcast.refresh,{

    })
	
 	
 	sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{

    })
    
    -- Add to RDM_Lib.lua
    sets.midcast.cure.self = set_combine(sets.midcast.cure.normal,{

    })

    sets.midcast.cure.wind = set_combine(sets.midcast.cure.normal,{

    })    

    ------------
    -- Regen
    ------------	
	sets.midcast.regen = set_combine(sets.midcast.enhancing, {

    })


    ----------------
    --Utility Sets--
    ----------------
    sets.Utility = {}
    
    sets.Utility.TH = {

    }
    
	--Comes on when slept, terrored, stunned, and petrified--
    sets.Utility.AutoDT = {

    }
    
    sets.Utility.Doom = {

    }

	--Meditate, TP Wings, Volte Harness all increase TP rewarded based on your STP--
	sets.Utility.Volte = {

    }
	
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
	
end

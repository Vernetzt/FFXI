version = "3.0"
--[[
        Custom commands:

        Toggle Function: 
        gs c toggle melee               Toggle Melee mode auto / on / off and locking of weapons
        gs c toggle idlemode            Toggles between Refresh and DT idle mode.
        gs c toggle rangedmode          Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)
        gs c toggle dualwield           Toggles between Dualwield modes
        gs c toggle quickdraw           Toggle between Quickdraw modes
        
        Casting functions:
        these are to set fewer macros (1 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c quickdraw cycle            Cycles element type for Quickdraw
        gs c quickdraw cycledown        Cycles element type for Quickdraw

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

        Alternatively you can also add the color after those command like: //gs c hud setcolor options blue

        // OPTIONAL IF YOU WANT / NEED to skip the cycles...  
        gs c quickdraw Ice                   Set Element Type to Ice DO NOTE the Element needs a Capital letter. 
        gs c quickdraw Air                   Set Element Type to Air DO NOTE the Element needs a Capital letter. 
        gs c quickdraw Dark                  Set Element Type to Dark DO NOTE the Element needs a Capital letter. 
        gs c quickdraw Light                 Set Element Type to Light DO NOTE the Element needs a Capital letter. 
        gs c quickdraw Earth                 Set Element Type to Earth DO NOTE the Element needs a Capital letter. 
        gs c quickdraw Lightning             Set Element Type to Lightning DO NOTE the Element needs a Capital letter. 
        gs c quickdraw Water                 Set Element Type to Water DO NOTE the Element needs a Capital letter. 
        gs c quickdraw Fire                  Set Element Type to Fire DO NOTE the Element needs a Capital letter. 
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
-- TP treshold where weapons gets locked. 
lockWeaponTP = 300
announceState = true

--------------------------------------------------------------------------------------------------------------
-- HUD Initial setup and Positioning
--------------------------------------------------------------------------------------------------------------

hud_x_pos = 1860    --important to update these if you have a smaller screen
hud_y_pos = 275     --important to update these if you have a smaller screen
hud_draggable = false
hud_font_size = 10
hud_transparency = 0 -- a value of 0 (invisible) to 255 (no transparency at all)
-- hud_font = 'Impact'
hud_font = 'Calibri'
hud_padding = 10

--------------------------------------------------------------------------------------------------------------
include('Liz-Includes.lua')
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

-- Optional. Swap to your RDM macro sheet / book
set_macros(1,7) -- Sheet, Book

-- Set Stylelock
set_style(102)

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('refresh', 'dt')
meleeModes = M('normal', 'acc', 'dt')
rangedModes = M('normal', 'acc')
quickdrawModes = M('Potency','STP')
luzafMode = M('OFF','ON')

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
-- 'Sakpata\'s Sword' example
mainWeapon = M('Naegling', 'Tauret')
subWeapon = M('Tauret', 'Naegling')
rangedWeapon = M('Fomalhaut')
TpBonus = "Machaera +2"

RAbullet = "Chrono Bullet"
RAccbullet = "Chrono Bullet"
WSbullet = "Chrono Bullet"
MAbullet = "Chrono Bullet"
QDbullet = "Chrono Bullet"
no_shoot_ammo = S{"Animikii Bullet", "Hauksbok Bullet"}
elemental_ws = S{"Aeolian Edge", "Leaden Salute", "Wildfire", "Hot Shot"}


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
include('COR_Lib.lua')      -- leave this as is 
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
    JSE = {}

	-- Fill this with your own JSE. 
    -- Laksamana's
    AF.Head		    =	""
    AF.Body		    =	""
    AF.Hands	    =	""
    AF.Legs		    =	""
    AF.Feet		    =	""

    -- Lanun
    RELIC.Head		=	""
    RELIC.Body		=	""
    RELIC.Hands 	=	"Lanun Gants +3"
    RELIC.Legs		=	""
    RELIC.Feet		=	""

    -- Chasseur's
    EMPY.Head		=	"Chass. Tricorne +1"
    EMPY.Body		=	"Chasseur's Frac +1"
    EMPY.Hands		=	"Chasseur's Gants +1"
    EMPY.Legs		=	"Chas. Culottes +1"
    EMPY.Feet		=	"Chass. Bottes +1"

    --Sortie
    JSE.Ear         =   "Chas. Earring +1"

    -- Capes:
    CORCape = {}
    CORCape.TPDW	=	{ }
    CORCape.TPDA	=	{ }
    CORCape.RASS	=	{ }
    CORCape.RASTP	=	{ }
    CORCape.STR 	=	{ }
    CORCape.CRIT 	=	{ }
    CORCape.MATT 	=	{ }

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

    sets.me.idle.regen = {
    }

    sets.me.idle.regain = {
    }

    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle.refresh,{
        head = "Malignance Chapeau",
        -- neck = "Loricate Torque +1",
        neck = "Warder's Charm +1",
        left_ear= "Etiolation Earring",
        -- right_ear = "Eabani Earring",
        right_ear = "Odnowa Earring +1",
        -- body = EMPY.Body,
        body="Malignance Tabard",
        hands = "Malignance Gloves",
        -- left_ring = "Gelatinous Ring +1",
        left_ring = "Shadow Ring",
        right_ring = "Defending ring",
        -- back = Rosmerta.DA,
        back = "Shadow Mantle",
        waist = "Flume belt +1",
        legs = "Malignance Tights",
        feet = "Malignance Boots"

    }) 

    sets.me.idle.mdt = set_combine(sets.me.idle.dt,{

    })  

	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    -- Combat Related Sets

	------------------------------------------------------------------------------------------------------
    -- Dual Wield sets
	------------------------------------------------------------------------------------------------------

    sets.me.melee.normaldw = set_combine(sets.me.idle.refresh,{   
        head = "Dampening Tam",
        neck = "Mirage Stole +1",
        left_ear = "Suppanomimi",
        right_ear = "Eabani Earring",
        body = "Adhemar jacket +1",
        hands = "Adhemar wristbands +1",
        left_ring = "Epona's ring",
        right_ring = "Ilabrat Ring",
        -- back = Rosmerta.DA,
        waist = "Reiki Yotai",
        legs = "Samnuha Tights",
        feet = Herc.Feet.TP,

    })

    sets.me.melee.accdw = set_combine(sets.me.melee.normaldw,{

    })

    sets.me.melee.dtdw = set_combine(sets.me.melee.normaldw,{
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Loricate Torque +1",
        waist="Reiki Yotai",
        right_ear="Eabani Earring",
        left_ear="Suppanomimi",
        right_ring="Defending Ring",
        left_ring = "Epona's ring",
        -- back = Rosmerta.DA,

    })

    sets.me.melee.mdtdw = set_combine(sets.me.melee.dtdw,{

    })


    ------------------------------------------------------------------------------------------------------
    -- +31 and +11 Dual Wield sets for toggle
 	------------------------------------------------------------------------------------------------------ 

    sets.me.melee.normaldw11 = set_combine(sets.me.melee.normaldw,{
        left_ear="Suppanomimi",
        right_ear="Cessance Earring",
        -- waist="Windbuffet belt +1",
        waist="Sailfi Belt +1",
    })

    sets.me.melee.accdw11 = set_combine(sets.me.melee.accdw,{  

    })

    sets.me.melee.dtdw11 = set_combine(sets.me.melee.dtdw,{
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Loricate Torque +1",
        waist="Reiki Yotai",
        right_ear="Eabani Earring",
        left_ear="Suppanomimi",
        right_ring="Defending Ring",
        left_ring = "Epona's ring",
        -- back = Rosmerta.DA,
    })

    sets.me.melee.mdtdw11 = set_combine(sets.me.melee.mdtdw,{   
         
    })


    ------------------------------------------------------------------------------------------------------
	-- Single Wield sets. -- combines from DW sets
	-- So can just put what will be changing when off hand is a shield
    ------------------------------------------------------------------------------------------------------   
    
    sets.me.melee.normalsw = set_combine(sets.me.melee.normaldw,{   

    })
    sets.me.melee.accsw = set_combine(sets.me.melee.accdw,{

    })
    sets.me.melee.dtsw = set_combine(sets.me.melee.dtdw,{

    })
    sets.me.melee.mdtsw = set_combine(sets.me.melee.mdtdw,{

    })

	
    ------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
    ------------------------------------------------------------------------------------------------------
    
    sets.me["Savage Blade"] = {

    }
    sets.me["Requiescat"] = {

    }
    -- sets.me["Sanguine Blade"] {

    -- }
    
    sets.me["Evisceration"] = {

    }
    sets.me["Aeolian Edge"] = {

    }

    sets.me["Leaden Salute"] = {

    }
    sets.me["Last Stand"] = {

    }
    sets.me["Hot Shot"] = {

    }

    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though 
	
	
    ---------------
    -- Sets
    ---------------
    -- Precast
    sets.precast = {}   		-- Leave this empty  
    sets.precast.RA = {}        -- Leave this empty
    -- Midcast
    sets.midcast = {}    		-- Leave this empty  
    sets.midcast.cure = {}      -- Leave This Empty
    sets.midcast.enhancing = {} -- leave this empty
    sets.midcast.RA = {}        -- leave this empty   
    sets.midcast.RA.triple = {} -- leave this empty
    sets.midcast.Quickdraw = {} -- leave this empty
    -- Aftercast                -- Leave this empty
    sets.aftercast = {}  		-- Leave this empty  

    ----------
    -- Precast
    ----------
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast
    sets.precast.casting = {

    }

    sets.precast.utsu = set_combine(sets.precast.casting, {
        body="Passion Jacket",
    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{

    })


    ----------
    -- Preshot
    ----------
    sets.precast.RA = {
    }

    sets.precast.RA.Flurry1 = set_combine(sets.precast.RA,{
    })

    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA,{
    })


    ---------------------
    -- Ability Precasting
    ---------------------

    -- sets.precast["Chainspell"] = {body = RELIC.Body}

    sets.precast.PhantomRoll = {
    }

    sets.precast.PhantomRoll["Caster's Roll"] = set_combine(sets.precast.PhantomRoll, {legs=EMPY.Legs})
    sets.precast.PhantomRoll["Courser's Roll"] = set_combine(sets.precast.PhantomRoll, {feet=EMPY.Feet})
    sets.precast.PhantomRoll["Blitzer's Roll"] = set_combine(sets.precast.PhantomRoll, {head=EMPY.Head})
    sets.precast.PhantomRoll["Tactician's Roll"] = set_combine(sets.precast.PhantomRoll, {body=EMPY.Body})
    sets.precast.PhantomRoll["Allies' Roll"] = set_combine(sets.precast.PhantomRoll, {hands=EMPY.Hands})
    sets.precast.LuzafRing = {ring1="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands=RELIC.Hands}
    sets.precast.WildCard = {}
    sets.precast.SnakeEye = {}
    sets.precast.RandomDeal = {}


    sets.precast.Waltz = {
        body="Passion Jacket",
        ring1="Asklepian Ring",
        waist="Gishdubar Sash",
    }

    -- sets.precast.PhantomRoll["Corsair's Roll"] = set_combine(sets.precast.PhantomRoll, {body="Taeon Tabard"})
	
	----------
    -- Midcast
    ----------
	
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
	
    -- Enhancing yourself 
    sets.midcast.enhancing = {

    }

    -- Phalanx
    sets.midcast.phalanx =  set_combine(sets.midcast.enhancing, {
        head=Taeon.Head.Phalanx,
        body=Taeon.Body.Phalanx,
        legs=Herc.Legs.Phalanx,
        feet=Taeon.Feet.Phalanx,
    })

  
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{

    })

    sets.midcast.refresh = set_combine(sets.midcast.enhancing,{

    })

    sets.midcast.aquaveil = set_combine(sets.midcast.refresh,{

    })
	

    ---------------------------
    -- Cure
    ---------------------------
    
    sets.midcast.cure.normal = {

    }
    sets.midcast.cure.self = set_combine(sets.midcast.cure.normal,{

    })
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{

    })
    sets.midcast.cure.weather.self = set_combine(sets.midcast.cure.self,{

    })
    
    -----------------------------
    -- Midshot
    -----------------------------

    sets.midcast.RA.normal = {
        ammo=RAbullet,
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Marked Gorget",
        waist="Yemaya Belt",
        -- left_ear="Crepuscular Earring",
        right_ear="Crepuscular Earring",
        left_ring="Ilabrat Ring",
        right_ring = "Crepuscular Ring",
    }

    sets.midcast.RA.racc = set_combine(sets.midcast.RA.normal,{

    })

    sets.midcast.RA.triple.normal = set_combine(sets.midcast.RA.normal,{
        body="Councilor's Garb",
    })

    sets.midcast.RA.triple.racc = set_combine(sets.midcast.RA.acc,{

    })

    -----------------------------
    -- Quickdraw
    -----------------------------

    sets.midcast.Quickdraw.Potency = {

    }
    sets.midcast.Quickdraw.STP = {

    }
    sets.midcast.Quickdraw['Light Shot'] = {

    }
    sets.midcast.Quickdraw['Dark Shot'] = sets.midcast.Quickdraw['Light Shot']
    sets.midcast.Quickdraw.Enhance = {body="Mirke Wardecors", feet="Chass. Bottes +1"}


    ------------
    -- Utility
    ------------

    sets.Utility = {}

    sets.Utility.AutoDT = set_combine(sets.me.idle.dt,{
    })

    sets.Utility.TH = {
        waist = "Chaac Belt",
        -- head = "White rarab cap +1",
        ammo = "Perfect Lucky Egg",
    }

    sets.Utility.Doom = {
        neck="Nicander's Necklace",
        waist="Gishdubar Sash",
        left_ring="Blenmot's Ring +1",
        right_ring="Purity Ring",
    }
	
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
	
end

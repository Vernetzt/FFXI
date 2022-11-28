version = "3.0"

-------------------------------------------------------------------------------------------------------------------
-- Spell mappings allow defining a general category or description that each of sets of related
-- spells all fall under.
-------------------------------------------------------------------------------------------------------------------


spell_maps = {
    ['Cure']='Cure',['Cure II']='Cure',['Cure III']='Cure',['Cure IV']='Cure',['Cure V']='Cure',['Cure VI']='Cure',
    ['Full Cure']='Cure',
    ['Cura']='Curaga',['Cura II']='Curaga',['Cura III']='Curaga',
    ['Curaga']='Curaga',['Curaga II']='Curaga',['Curaga III']='Curaga',['Curaga IV']='Curaga',['Curaga V']='Curaga',
    -- Status Removal doesn't include Esuna or Sacrifice, since they work differently than the rest
    ['Poisona']='StatusRemoval',['Paralyna']='StatusRemoval',['Silena']='StatusRemoval',['Blindna']='StatusRemoval',['Cursna']='StatusRemoval',
    ['Stona']='StatusRemoval',['Viruna']='StatusRemoval',['Erase']='StatusRemoval',
    ['Barfire']='BarElement',['Barstone']='BarElement',['Barwater']='BarElement',['Baraero']='BarElement',['Barblizzard']='BarElement',['Barthunder']='BarElement',
    ['Barfira']='BarElement',['Barstonra']='BarElement',['Barwatera']='BarElement',['Baraera']='BarElement',['Barblizzara']='BarElement',['Barthundra']='BarElement',
    ['Raise']='Raise',['Raise II']='Raise',['Raise III']='Raise',['Arise']='Raise',
    ['Reraise']='Reraise',['Reraise II']='Reraise',['Reraise III']='Reraise',['Reraise IV']='Reraise',
    ['Protect']='Protect',['Protect II']='Protect',['Protect III']='Protect',['Protect IV']='Protect',['Protect V']='Protect',
    ['Shell']='Shell',['Shell II']='Shell',['Shell III']='Shell',['Shell IV']='Shell',['Shell V']='Shell',
    ['Protectra']='Protectra',['Protectra II']='Protectra',['Protectra III']='Protectra',['Protectra IV']='Protectra',['Protectra V']='Protectra',
    ['Shellra']='Shellra',['Shellra II']='Shellra',['Shellra III']='Shellra',['Shellra IV']='Shellra',['Shellra V']='Shellra',
    ['Regen']='Regen',['Regen II']='Regen',['Regen III']='Regen',['Regen IV']='Regen',['Regen V']='Regen',
    ['Refresh']='Refresh',['Refresh II']='Refresh',['Refresh III']='Refresh',
    ['Teleport-Holla']='Teleport',['Teleport-Dem']='Teleport',['Teleport-Mea']='Teleport',['Teleport-Altep']='Teleport',['Teleport-Yhoat']='Teleport',
    ['Teleport-Vahzl']='Teleport',['Recall-Pashh']='Teleport',['Recall-Meriph']='Teleport',['Recall-Jugner']='Teleport',
    ['Valor Minuet']='Minuet',['Valor Minuet II']='Minuet',['Valor Minuet III']='Minuet',['Valor Minuet IV']='Minuet',['Valor Minuet V']='Minuet',
    ["Knight's Minne"]='Minne',["Knight's Minne II"]='Minne',["Knight's Minne III"]='Minne',["Knight's Minne IV"]='Minne',["Knight's Minne V"]='Minne',
    ['Advancing March']='March',['Victory March']='March',
    ['Sword Madrigal']='Madrigal',['Blade Madrigal']='Madrigal',
    ["Hunter's Prelude"]='Prelude',["Archer's Prelude"]='Prelude',
    ['Sheepfoe Mambo']='Mambo',['Dragonfoe Mambo']='Mambo',
    ['Raptor Mazurka']='Mazurka',['Chocobo Mazurka']='Mazurka',
    ['Sinewy Etude']='Etude',['Dextrous Etude']='Etude',['Vivacious Etude']='Etude',['Quick Etude']='Etude',['Learned Etude']='Etude',['Spirited Etude']='Etude',['Enchanting Etude']='Etude',
    ['Herculean Etude']='Etude',['Uncanny Etude']='Etude',['Vital Etude']='Etude',['Swift Etude']='Etude',['Sage Etude']='Etude',['Logical Etude']='Etude',['Bewitching Etude']='Etude',
    ["Mage's Ballad"]='Ballad',["Mage's Ballad II"]='Ballad',["Mage's Ballad III"]='Ballad',
    ["Army's Paeon"]='Paeon',["Army's Paeon II"]='Paeon',["Army's Paeon III"]='Paeon',["Army's Paeon IV"]='Paeon',["Army's Paeon V"]='Paeon',["Army's Paeon VI"]='Paeon',
    ['Fire Carol']='Carol',['Ice Carol']='Carol',['Wind Carol']='Carol',['Earth Carol']='Carol',['Lightning Carol']='Carol',['Water Carol']='Carol',['Light Carol']='Carol',['Dark Carol']='Carol',
    ['Fire Carol II']='Carol',['Ice Carol II']='Carol',['Wind Carol II']='Carol',['Earth Carol II']='Carol',['Lightning Carol II']='Carol',['Water Carol II']='Carol',['Light Carol II']='Carol',['Dark Carol II']='Carol',
    ['Foe Lullaby']='Lullaby',['Foe Lullaby II']='Lullaby',['Horde Lullaby']='Lullaby',['Horde Lullaby II']='Lullaby',
    ['Fire Threnody']='Threnody',['Ice Threnody']='Threnody',['Wind Threnody']='Threnody',['Earth Threnody']='Threnody',['Lightning Threnody']='Threnody',['Water Threnody']='Threnody',['Light Threnody']='Threnody',['Dark Threnody']='Threnody',
    ['Fire Threnody II']='Threnody',['Ice Threnody II']='Threnody',['Wind Threnody II']='Threnody',['Earth Threnody II']='Threnody',['Lightning Threnody II']='Threnody',['Water Threnody II']='Threnody',['Light Threnody II']='Threnody',['Dark Threnody II']='Threnody',
    ['Battlefield Elegy']='Elegy',['Carnage Elegy']='Elegy',
    ['Foe Requiem']='Requiem',['Foe Requiem II']='Requiem',['Foe Requiem III']='Requiem',['Foe Requiem IV']='Requiem',['Foe Requiem V']='Requiem',['Foe Requiem VI']='Requiem',['Foe Requiem VII']='Requiem',
    ['Utsusemi: Ichi']='Utsusemi',['Utsusemi: Ni']='Utsusemi',['Utsusemi: San']='Utsusemi',
    ['Katon: Ichi'] = 'ElementalNinjutsu',['Suiton: Ichi'] = 'ElementalNinjutsu',['Raiton: Ichi'] = 'ElementalNinjutsu',
    ['Doton: Ichi'] = 'ElementalNinjutsu',['Huton: Ichi'] = 'ElementalNinjutsu',['Hyoton: Ichi'] = 'ElementalNinjutsu',
    ['Katon: Ni'] = 'ElementalNinjutsu',['Suiton: Ni'] = 'ElementalNinjutsu',['Raiton: Ni'] = 'ElementalNinjutsu',
    ['Doton: Ni'] = 'ElementalNinjutsu',['Huton: Ni'] = 'ElementalNinjutsu',['Hyoton: Ni'] = 'ElementalNinjutsu',
    ['Katon: San'] = 'ElementalNinjutsu',['Suiton: San'] = 'ElementalNinjutsu',['Raiton: San'] = 'ElementalNinjutsu',
    ['Doton: San'] = 'ElementalNinjutsu',['Huton: San'] = 'ElementalNinjutsu',['Hyoton: San'] = 'ElementalNinjutsu',
    ['Banish']='Banish',['Banish II']='Banish',['Banish III']='Banish',['Banishga']='Banish',['Banishga II']='Banish',
    ['Holy']='Holy',['Holy II']='Holy',['Drain']='Drain',['Drain II']='Drain',['Drain III']='Drain',['Aspir']='Aspir',['Aspir II']='Aspir',
    ['Absorb-Str']='Absorb',['Absorb-Dex']='Absorb',['Absorb-Vit']='Absorb',['Absorb-Agi']='Absorb',['Absorb-Int']='Absorb',['Absorb-Mnd']='Absorb',['Absorb-Chr']='Absorb',
    ['Absorb-Acc']='Absorb',['Absorb-TP']='Absorb',['Absorb-Attri']='Absorb',
    ['Enlight']='Enlight',['Enlight II']='Enlight',['Endark']='Endark',['Endark II']='Endark',
    ['Burn']='ElementalEnfeeble',['Frost']='ElementalEnfeeble',['Choke']='ElementalEnfeeble',['Rasp']='ElementalEnfeeble',['Shock']='ElementalEnfeeble',['Drown']='ElementalEnfeeble',
    ['Pyrohelix']='Helix',['Cryohelix']='Helix',['Anemohelix']='Helix',['Geohelix']='Helix',['Ionohelix']='Helix',['Hydrohelix']='Helix',['Luminohelix']='Helix',['Noctohelix']='DarkHelix',
    ['Pyrohelix II']='Helix',['Cryohelix II']='Helix',['Anemohelix II']='Helix',['Geohelix II']='Helix',['Ionohelix II']='Helix',['Hydrohelix II']='Helix',['Luminohelix II']='Helix',['Noctohelix II']='DarkHelix',
    ['Firestorm']='Storm',['Hailstorm']='Storm',['Windstorm']='Storm',['Sandstorm']='Storm',['Thunderstorm']='Storm',['Rainstorm']='Storm',['Aurorastorm']='Storm',['Voidstorm']='Storm',
    ['Firestorm II']='Storm',['Hailstorm II']='Storm',['Windstorm II']='Storm',['Sandstorm II']='Storm',['Thunderstorm II']='Storm',['Rainstorm II']='Storm',['Aurorastorm II']='Storm',['Voidstorm II']='Storm',
    ['Fire Maneuver']='Maneuver',['Ice Maneuver']='Maneuver',['Wind Maneuver']='Maneuver',['Earth Maneuver']='Maneuver',['Thunder Maneuver']='Maneuver',['Water Maneuver']='Maneuver',['Light Maneuver']='Maneuver',['Dark Maneuver']='Maneuver',
    ['Enstone']='Enspell',['Enwater']='Enspell',['Enaero']='Enspell',['Enfire']='Enspell',['Enblizzard']='Enspell',['Enthunder']='Enspell',
    ['Gain-AGI']='Gain',['Gain-CHR']='Gain',['Gain-DEX']='Gain',['Gain-INT']='Gain',['Gain-MND']='Gain',['Gain-STR']='Gain',['Gain-VIT']='Gain',
}

enfeeb_maps = {
    ['Dia']='potency', ['Dia II']='potency', ['Dia III']='potency',
    ['Bio']='potency', ['Bio II']='potency', ['Bio III']='potency',
    ['Paralyze']='mndpot', ['Paralyze II']='mndpot', 
    ['Slow']='mndpot', ['Slow II']='mndpot', 
    ['Addle']='mndpot', ['Addle II']='mndpot',
    ['Sleep']='intmacc', ['Sleep II']='intmacc', ['Sleepga']='intmacc', 
    ['Silence']='macc', 
    ['Inundation']='macc', 
    ['Dispel']='macc', ['Dispelga']='macc',
    ['Break']='macc', 
    ['Bind']='intmacc', 
    ['Blind']='intpot', ['Blind II']='intpot', 
    ['Gravity']='potency', ['Gravity II']='potency',
    -- We leave Fazzle and FrazzleII as pure macc to help land it in cases its a high resist. 
    -- This lets us follow up with a high potency Frazzle3 
    ['Frazzle']='macc', ['Frazzle II']='macc', ['Frazzle III']='skillmndpot', 
    ['Distract']='skillmndpot', ['Distract II']='skillmndpot', ['Distract III']='skillmndpot', 
    ['Poison']='skillpot', ['Poison II']='skillpot', ['Poisonga']='skillpot',
}

blu_maps = {
    ['Asuran Claws']='BluSTR', ['Bilgestorm']='BluSTR', ['Battle Dance']='BluSTR', ['Bludgeon']='BluSTR', ['Bloodrake']='BluSTR', ['Death Scissors']='BluSTR', ['Dimensional Death']='BluSTR', ['Empty Thrash']='BluSTR', ['Quadrastrike']='BluSTR', ['Uppercut']='BluSTR', ['Tourbillion']='BluSTR', ['Sinker Drill']='BluSTR', ['Thrashing Assault']='BluSTR', ['Vertical Cleave']='BluSTR', ['Whirl of Rage']='BluSTR', ['Saurian Slide']='BluSTR', ['Sinal Cleave']='BluSTR', ['Paralyzing Triad']='BluSTR', 
    ['Amorphic Spikes']='BluDEX', ['Barbed Crescent']='BluDEX', ['Claw Cyclone']='BluDEX', ['Disseverment']='BluDEX', ['Foot Kick']='BluDEX', ['Frenetic Rip']='BluDEX', ['Goblin Rush']='BluDEX', ['Hysteric Barrage']='BluDEX', ['Seedspray']='BluDEX', ['Vanity Dive']='BluDEX', 
    ['Cannonball']='BluVIT', ['Delta Thrust']='BluVIT', ['Glutinous Dart']='BluVIT', ['Grand Slam']='BluVIT', ['Quad. Continuum']='BluVIT', ['Sprout Smack']='BluVIT', 
    ['Benthic Typhoon']='BluAGI', ['Helldive']='BluAGI', ['Hydro Shot']='BluAGI', ['Jet Stream']='BluAGI', ['Pinecone Bomb']='BluAGI', ['Wild Oats']='BluAGI', ['Spiral Spin']='BluAGI', 
    ['Acrid Stream']='BluINT', ['Anvil Lightning']='BluINT', ['Crashing Thunder']='BluINT', ['Charged Whisker']='BluINT', ['Droning Whirlwind']='BluINT', ['Firespit']='BluINT', ['Foul Waters']='BluINT', ['Gates of Hades']='BluINT', ['Leafstorm']='BluINT', ['Molting Plumage']='BluINT', ['Nectarous Deluge']='BluINT', ['Polar Roar']='BluINT', ['Regurgitation']='BluINT', ['Rending Deluge']='BluINT', ['Scouring Spate']='BluINT', ['Searing Tempest']='BluINT', ['Silent Storm']='BluINT', ['Spectral Floe']='BluINT', ['Subduction']='BluINT', ['Tem. Upheaval']='BluINT', ['Thermal Pulse']='BluINT', ['Thunderbolt']='BluINT', ['Uproot']='BluINT', ['Water Bomb']='BluINT', ['Embalming Earth']='BluINT', ['Entomb']='BluINT', ['Sandspin']='BluINT', 
    ['Blood Saber']='BluDark', ['Dark Orb']='BluDark', ['Death Ray']='BluDark', ['Eyes On Me']='BluDark', ['Evryone. Grudge']='BluDark', ['Palling Salvo']='BluDark', ['Tenebral Crush']='BluDark', 
    ['Blinding Fulgor']='BluLight', ['Diffusion Ray']='BluLight', ['Magic Hammer']='BluLight', ['Rail Cannon']='BluLight', ['Retinal Glare']='BluLight', 
    ['1000 Needles']='BluMACC', ['Absolute Terror']='BluMACC', ['Auroral Drape']='BluMACC', ['Awful Eye']='BluMACC', ['Blastbomb']='BluMACC', ['Blank Gaze']='BluMACC', ['Blistering Roar']='BluMACC', ['Blitzstrahl']='BluMACC', ['Blood Drain']='BluMACC', ['Blood Saber']='BluMACC', ['Chaotic Eye']='BluMACC', ['Cimicine Discharge']='BluMACC', ['Cold Wave']='BluMACC', ['Digest']='BluMACC', ['Corrosive Ooze']='BluMACC', ['Demoralizing Roar']='BluMACC', ['Dream Flower']='BluMACC', ['Cruel Joke']='BluMACC',['Enervation']='BluMACC', ['Filamented Hold']='BluMACC', ['Frightful Roar']='BluMACC', ['Geist Wall']='BluMACC', ['Hecatomb Wave']='BluMACC', ['Infrasonics']='BluMACC', ['Light of Penance']='BluMACC', ['Lowing']='BluMACC', ['Mind Blast']='BluMACC', ['Mortal Ray']='BluMACC', ['MP Drainkiss']='BluMACC', ['Sheep Song']='BluMACC', ['Soporific']='BluMACC', ['Sound Blast']='BluMACC', ['Sprout Smack']='BluMACC', ['Stinking Gas']='BluMACC', ['Venom Shell']='BluMACC', ['Voracious Trunk']='BluMACC', ['Yawn']='BluMACC', 
    ['Bad Breath']='BluBreath', ['Flying Hip Press']='BluBreath', ['Final Sting']='BluBreath', ['Frost Breath']='BluBreath', ['Heat Breath']='BluBreath', ['Magnetite Cloud']='BluBreath', ['Poison Breath']='BluBreath', ['Radiant Breath']='BluBreath', ['Self Destruct']='BluBreath', ['Thunder Breath']='BluBreath', ['Vapor Spray']='BluBreath', ['Wind Breath']='BluBreath', 
    ['Barrier Tusk']='BluBuff', ['Cocoon']='BluBuff', ['Carcharian Verve']='BluBuff', ['Erratic Flutter']='BluBuff', ['Harden Shell']='BluBuff', ['Orcish Counterstance']='BluBuff', ['Plasma Charge']='BluBuff', ['Pyric Bulwark']='BluBuff', ['Memento Mori']='BluBuff', ['Mighty Guard']='BluBuff', ['Nat. Meditation']='BluBuff', ['Reactor Cool']='BluBuff', ['Saline Coat']='BluBuff', ['Feather Barrier']='BluBuff', ['Refueling']='BluBuff', ['Warm-Up']='BluBuff', ['Zephyr Mantle']='BluBuff', ['Reactor Cool']='BluBuff', ['Plasma Charge']='BluBuff', ['Amplification']='BluBuff', 
    ['Diamondhide']='BluSkill', ['Metallic Body']='BluSkill', ['Magic Barrier']='BluSkill', ['Atra. Libations']='BluSkill', ['Occultation']='BluSkill', 
    ['Healing Breeze']='BluHealing', ['Magic Fruit']='BluHealing', ['Plenilune Embrace']='BluHealing', ['Pollen']='BluHealing', ['Restoral']='BluHealing', ['Wild Carrot']='BluHealing', 
    ['Frypan']='BluStun', ['Head Butt']='BluStun', ['Sudden Lunge']='BluStun', ['Tail slap']='BluStun', ['Sub-zero Smash']='BluStun', ['Sweeping Gouge']='BluStun', 
    ['Actinic Burst']='BluEnmity', ['Exuviation']='BluEnmity', ['Fantod']='BluEnmity', ['Jettatura']='BluEnmity', ['Temporal Shift']='BluEnmity', 
    ['Osmosis']='BluFastRecast', ['Feather Tickle']='BluFastRecast', ['Reaving Wind']='BluFastRecast', 
}

elements =  M('Ice', 'Air', 'Dark', 'Light', 'Earth', 'Lightning', 'Water', 'Fire')

element = {}
element.weak_to = {['Light']='Dark', ['Dark']='Light', ['Fire']='Ice', ['Ice']='Wind', ['Wind']='Earth', ['Earth']='Lightning',
        ['Lightning']='Water', ['Water']='Fire'}

element.strong_to = {['Light']='Dark', ['Dark']='Light', ['Fire']='Water', ['Ice']='Fire', ['Wind']='Ice', ['Earth']='Wind',
        ['Lightning']='Earth', ['Water']='Lightning'}

enspellElements =  M('Ice', 'Air', 'Earth', 'Lightning', 'Water', 'Fire')

quickdrawElements =  M('Ice', 'Air', 'Dark', 'Light', 'Earth', 'Lightning', 'Water', 'Fire')

nextElement =  M('Air', 'Dark', 'Light', 'Earth', 'Lightning', 'Water', 'Fire','Ice')
-- nextElement =  M('Ice', 'Air', 'Earth', 'Lightning', 'Water', 'Fire', 'Dark', 'Light')

nukes = {}
nukes.t1 = {['Earth']="Stone",      ['Water']="Water",      ['Air']="Aero",     ['Fire']="Fire",    ['Ice']="Blizzard",     ['Lightning']="Thunder", ['Light']="Thunder", ['Dark']="Blizzard"}
nukes.t2 = {['Earth']="Stone II",   ['Water']="Water II",   ['Air']="Aero II",  ['Fire']="Fire II", ['Ice']="Blizzard II",  ['Lightning']="Thunder II", ['Light']="Thunder II", ['Dark']="Blizzard II"}
nukes.t3 = {['Earth']="Stone III",  ['Water']="Water III",  ['Air']="Aero III", ['Fire']="Fire III",['Ice']="Blizzard III", ['Lightning']="Thunder III", ['Light']="Thunder III", ['Dark']="Blizzard III"}
nukes.t4 = {['Earth']="Stone IV",   ['Water']="Water IV",   ['Air']="Aero IV",  ['Fire']="Fire IV", ['Ice']="Blizzard IV",  ['Lightning']="Thunder IV", ['Light']="Thunder IV", ['Dark']="Blizzard IV"}
nukes.t5 = {['Earth']="Stone V",    ['Water']="Water V",    ['Air']="Aero V",   ['Fire']="Fire V",  ['Ice']="Blizzard V",   ['Lightning']="Thunder V", ['Light']="Thunder V", ['Dark']="Blizzard V"}
nukes.helix2 = {['Earth']="Geohelix II",  ['Water']="Hydrohelix II", ['Air']="Anemohelix II",['Fire']="Pyrohelix II", ['Ice']="Cryohelix II", ['Lightning']="Ionohelix II",    ['Light']="Luminohelix II", ['Dark']="Noctohelix II"}
nukes.helix = {['Earth']="Geohelix",  ['Water']="Hydrohelix", ['Air']="Anemohelix",['Fire']="Pyrohelix", ['Ice']="Cryohelix", ['Lightning']="Ionohelix",    ['Light']="Luminohelix", ['Dark']="Noctohelix"}
nukes.storm = {['Earth']="Sandstorm", ['Water']="Rainstorm",  ['Air']="Windstorm", ['Fire']="Firestorm", ['Ice']="Hailstorm", ['Lightning']="Thunderstorm", ['Light']="Aurorastorm", ['Dark']="Voidstorm"}
nukes.storm2 = {['Earth']="Sandstorm II", ['Water']="Rainstorm II",  ['Air']="Windstorm II", ['Fire']="Firestorm II", ['Ice']="Hailstorm II", ['Lightning']="Thunderstorm II", ['Light']="Aurorastorm II", ['Dark']="Voidstorm II"}
nukes.enspell = {['Earth']="Enstone", ['Water']="Enwater",  ['Air']="Enaero", ['Fire']="Enfire", ['Ice']="Enblizzard", ['Lightning']="Enthunder", ['Light']="Enthunder", ['Dark']="Enblizzard"}
nukes.ra1 = {['Earth']="Stonera",    ['Water']="Watera",    ['Air']="Aera",    ['Fire']="Fira",    ['Ice']="Blizzara",    ['Lightning']="Thundara",    ['Light']="Thundara",    ['Dark']="Blizzara"}
nukes.ra2 = {['Earth']="Stonera II", ['Water']="Watera II", ['Air']="Aera II", ['Fire']="Fira II", ['Ice']="Blizzara II", ['Lightning']="Thundara II", ['Light']="Thundara II", ['Dark']="Blizzara II"}
nukes.ra3 = {['Earth']="Stonera III",['Water']="Watera III",['Air']="Aera III",['Fire']="Fira III",['Ice']="Blizzara III",['Lightning']="Thundara III",['Light']="Thundara III",['Dark']="Blizzara III"}
nukes.quickdraw = {['Earth']="Earth Shot",      ['Water']="Water Shot",      ['Air']="Wind Shot",     ['Fire']="Fire Shot",    ['Ice']="Ice Shot",     ['Lightning']="Thunder Shot", ['Light']="Light Shot", ['Dark']="Dark Shot"}

geomancy = M('Geo-Acumen', 'Geo-Attunement', 'Geo-Barrier', 'Geo-STR', 'Geo-DEX', 'Geo-VIT', 'Geo-AGI', 'Geo-INT', 'Geo-MND', 'Geo-CHR', 'Geo-Fade',
             'Geo-Fend', 'Geo-Focus', 'Geo-Frailty', 'Geo-Fury', 'Geo-Gravity', 'Geo-Haste', 'Geo-Languor', 'Geo-Malaise', 'Geo-Paralysis', 
             'Geo-Poison', 'Geo-Precision', 'Geo-Refresh', 'Geo-Regen', 'Geo-Slip', 'Geo-Slow', 'Geo-Torpor', 'Geo-Vex', 'Geo-Voidance', 'Geo-Wilt')
indicolure = M('Indi-Acumen', 'Indi-Attunement', 'Indi-Barrier', 'Indi-STR', 'Indi-DEX', 'Indi-VIT', 'Indi-AGI', 'Indi-INT', 'Indi-MND', 'Indi-CHR', 'Indi-Fade',
             'Indi-Fend', 'Indi-Focus', 'Indi-Frailty', 'Indi-Fury', 'Indi-Gravity', 'Indi-Haste', 'Indi-Languor', 'Indi-Malaise', 'Indi-Paralysis', 
             'Indi-Poison', 'Indi-Precision', 'Indi-Refresh', 'Indi-Regen', 'Indi-Slip', 'Indi-Slow', 'Indi-Torpor', 'Indi-Vex', 'Indi-Voidance', 'Indi-Wilt')
entrustindi = M('Indi-Acumen', 'Indi-Attunement', 'Indi-Barrier', 'Indi-STR', 'Indi-DEX', 'Indi-VIT', 'Indi-AGI', 'Indi-INT', 'Indi-MND', 'Indi-CHR', 'Indi-Fade',
             'Indi-Fend', 'Indi-Focus', 'Indi-Frailty', 'Indi-Fury', 'Indi-Gravity', 'Indi-Haste', 'Indi-Languor', 'Indi-Malaise', 'Indi-Paralysis', 
             'Indi-Poison', 'Indi-Precision', 'Indi-Refresh', 'Indi-Regen', 'Indi-Slip', 'Indi-Slow', 'Indi-Torpor', 'Indi-Vex', 'Indi-Voidance', 'Indi-Wilt')

-- Colors for elements
Colors = {
    ["Fire"] = "\\cs(204, 0, 0)", 
    ["Water"] = "\\cs(0, 102, 204)", 
    ["Air"] = "\\cs(51, 102, 0)", 
    ["Light"] = "\\cs(255, 255, 255)", 
    ["Earth"] = "\\cs(139, 139, 19)", 
    ["Ice"] = "\\cs(0, 204, 204)", 
    ["Lightning"] = "\\cs(102, 0, 204)",
    ['Dark']="\\cs(92, 92, 92)"
}

skillchains = {
    [288] = {id=288,english='Light',elements={'Light','Fire','Lightning','Wind'}, color=Colors[4]},
    [289] = {id=289,english='Darkness',elements={'Dark','Earth','Water','Ice'}, color=Colors[8]},
    [290] = {id=290,english='Gravitation',elements={'Earth', 'Dark'}, color=Colors[5]},
    [291] = {id=291,english='Fragmentation',elements={'Lightning','Wind'}, color=Colors[7]},
    [292] = {id=292,english='Distortion',elements={'Ice', 'Water'}, color=Colors[6]},
    [293] = {id=293,english='Fusion',elements={'Fire', 'Light'}, color=Colors[1]},
    [294] = {id=294,english='Compression',elements={'Dark'}, color=Colors[8]},
    [295] = {id=295,english='Liquefaction',elements={'Fire'}, color=Colors[1]},
    [296] = {id=296,english='Induration',elements={'Ice'}, color=Colors[6]},
    [297] = {id=297,english='Reverberation',elements={'Water'}, color=Colors[2]},
    [298] = {id=298,english='Transfixion', elements={'Light'}, color=Colors[4]},
    [299] = {id=299,english='Scission',elements={'Earth'}, color=Colors[5]},
    [300] = {id=300,english='Detonation',elements={'Wind'}, color=Colors[3]},
    [301] = {id=301,english='Impaction',elements={'Lightning'}, color=Colors[7]},
    [767] = {id=767,english='Radiance',elements={'Light','Fire','Lightning','Wind'}, color=Colors[4]},
    [768] = {id=768,english='Umbra',elements={'Dark','Earth','Water','Ice'}, color=Colors[8]},
}

tier1sc =   {}
tier1sc['Ice'] = 'Induration'
tier1sc['Air'] ='Detonation'
tier1sc['Dark'] = 'Compression' 
tier1sc['Light'] = 'Transfixion'
tier1sc['Earth'] = 'Scission'
tier1sc['Lightning'] = 'Impaction'
tier1sc['Water'] = 'Reverberation'
tier1sc['Fire'] = 'Liquefaction'

tier2sc =   {}
tier2sc['Ice'] = 'Distortion'
tier2sc['Air'] ='Fragmentation'
tier2sc['Dark'] = 'Gravitation' 
tier2sc['Light'] = 'Fusion'
tier2sc['Earth'] = 'Gravitation'
tier2sc['Lightning'] = 'Fragmentation'
tier2sc['Water'] = 'Distortion'
tier2sc['Fire'] = 'Fusion'

rolls = {
    [97]  = {id=97,en="Phantom Roll"},
    [98]  = {id=98,en="Fighter's Roll",     lucky=5, unlucky=9, bonus="DA"},
    [99]  = {id=99,en="Monk's Roll",        lucky=3, unlucky=7, bonus="SB"},
    [100] = {id=100,en="Healer's Roll",     lucky=3, unlucky=7, bonus="CPR"},
    [101] = {id=101,en="Wizard's Roll",     lucky=5, unlucky=9, bonus="MATT"},
    [102] = {id=102,en="Warlock's Roll",    lucky=4, unlucky=8, bonus="MACC"},
    [103] = {id=103,en="Rogue's Roll",      lucky=5, unlucky=9, bonus="CRIT"},
    [104] = {id=104,en="Gallant's Roll",    lucky=3, unlucky=7, bonus="DEF"},
    [105] = {id=105,en="Chaos Roll",        lucky=4, unlucky=8, bonus="ATT/RATT"},
    [106] = {id=106,en="Beast Roll",        lucky=4, unlucky=8, bonus="P.ATT/RATT"},
    [107] = {id=107,en="Choral Roll",       lucky=2, unlucky=6, bonus="SIRD"},
    [108] = {id=108,en="Hunter's Roll",     lucky=4, unlucky=8, bonus="ACC/RACC"},
    [109] = {id=109,en="Samurai Roll",      lucky=2, unlucky=6, bonus="STP"},
    [110] = {id=110,en="Ninja Roll",        lucky=4, unlucky=8, bonus="EVA"},
    [111] = {id=111,en="Drachen Roll",      lucky=4, unlucky=8, bonus="P.ACC/RACC"},
    [112] = {id=112,en="Evoker's Roll",     lucky=5, unlucky=9, bonus="Refresh"},
    [113] = {id=113,en="Magus's Roll",      lucky=2, unlucky=6, bonus="MDEF"},
    [114] = {id=114,en="Corsair's Roll",    lucky=5, unlucky=9, bonus="XP"},
    [115] = {id=115,en="Puppet Roll",       lucky=3, unlucky=7, bonus="P.MATT/MACC"},
    [116] = {id=116,en="Dancer's Roll",     lucky=3, unlucky=7, bonus="Regen"},
    [117] = {id=117,en="Scholar's Roll",    lucky=2, unlucky=6, bonus="Conserve MP"},
    [118] = {id=118,en="Bolter's Roll",     lucky=3, unlucky=9, bonus="Movement+"},
    [119] = {id=119,en="Caster's Roll",     lucky=2, unlucky=7, bonus="FC"},
    [120] = {id=120,en="Courser's Roll",    lucky=3, unlucky=9, bonus="SS"},
    [121] = {id=121,en="Blitzer's Roll",    lucky=4, unlucky=9, bonus="-Delay"},
    [122] = {id=122,en="Tactician's Roll",  lucky=5, unlucky=8, bonus="Regain"},
    [302] = {id=302,en="Allies' Roll",      lucky=3, unlucky=10, bonus="Skillchain+"},
    [303] = {id=303,en="Miser's Roll",      lucky=5, unlucky=7, bonus="Save TP"},
    [390] = {id=390,en="Naturalist's Roll", lucky=3, unlucky=7, bonus="Enh. Duration"},
    [391] = {id=391,en="Runeist's Roll",    lucky=4, unlucky=8, bonus="MEVA"},
  }


--   before edits
--   rolls = {
--     [97]  = {id=97,en="Phantom Roll"},
--     [98]  = {id=98,en="Fighter's Roll",     lucky=5, unlucky=9, bonus="Double Attack Rate"},
--     [99]  = {id=99,en="Monk's Roll",        lucky=3, unlucky=7, bonus="Subtle Blow"},
--     [100] = {id=100,en="Healer's Roll",     lucky=3, unlucky=7, bonus="Cure Potency Received"},
--     [101] = {id=101,en="Wizard's Roll",     lucky=5, unlucky=9, bonus="Magic Attack"},
--     [102] = {id=102,en="Warlock's Roll",    lucky=4, unlucky=8, bonus="Magic Accuracy"},
--     [103] = {id=103,en="Rogue's Roll",      lucky=5, unlucky=9, bonus="Critical Hit Rate"},
--     [104] = {id=104,en="Gallant's Roll",    lucky=3, unlucky=7, bonus="Defense"},
--     [105] = {id=105,en="Chaos Roll",        lucky=4, unlucky=8, bonus="Attack"},
--     [106] = {id=106,en="Beast Roll",        lucky=4, unlucky=8, bonus="Pet Attack"},
--     [107] = {id=107,en="Choral Roll",       lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
--     [108] = {id=108,en="Hunter's Roll",     lucky=4, unlucky=8, bonus="Accuracy"},
--     [109] = {id=109,en="Samurai Roll",      lucky=2, unlucky=6, bonus="Store TP"},
--     [110] = {id=110,en="Ninja Roll",        lucky=4, unlucky=8, bonus="Evasion"},
--     [111] = {id=111,en="Drachen Roll",      lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
--     [112] = {id=112,en="Evoker's Roll",     lucky=5, unlucky=9, bonus="Refresh"},
--     [113] = {id=113,en="Magus's Roll",      lucky=2, unlucky=6, bonus="Magic Defense"},
--     [114] = {id=114,en="Corsair's Roll",    lucky=5, unlucky=9, bonus="Experience Points"},
--     [115] = {id=115,en="Puppet Roll",       lucky=3, unlucky=7, bonus="Pet Magic Attack/Accuracy"},
--     [116] = {id=116,en="Dancer's Roll",     lucky=3, unlucky=7, bonus="Regen"},
--     [117] = {id=117,en="Scholar's Roll",    lucky=2, unlucky=6, bonus="Conserve MP"},
--     [118] = {id=118,en="Bolter's Roll",     lucky=3, unlucky=9, bonus="Movement Speed"},
--     [119] = {id=119,en="Caster's Roll",     lucky=2, unlucky=7, bonus="Fast Cast"},
--     [120] = {id=120,en="Courser's Roll",    lucky=3, unlucky=9, bonus="Snapshot"},
--     [121] = {id=121,en="Blitzer's Roll",    lucky=4, unlucky=9, bonus="Attack Delay"},
--     [122] = {id=122,en="Tactician's Roll",  lucky=5, unlucky=8, bonus="Regain"},
--     [302] = {id=302,en="Allies' Roll",      lucky=3, unlucky=10, bonus="Skillchain Damage"},
--     [303] = {id=303,en="Miser's Roll",      lucky=5, unlucky=7, bonus="Save TP"},
--     [390] = {id=390,en="Naturalist's Roll", lucky=3, unlucky=7, bonus="Enh. Magic Duration"},
--     [391] = {id=391,en="Runeist's Roll",    lucky=4, unlucky=8, bonus="Magic Evasion"},
--   }
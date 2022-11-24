--------------------------------------------------
--Generic Declaration
--------------------------------------------------
Amal = {}
Amal.Head = {}
Amal.Body = {}
Amal.Hands = {}
Amal.Legs = {}
Amal.Feet = {}
Merl = {}
Merl.Head = {}
Merl.Body = {}
Merl.Hands = {}
Merl.Legs = {}
Merl.Feet = {}
Adhe = {}
Adhe.Head = {}
Adhe.Body = {}
Adhe.Hands = {}
Adhe.Legs = {}
Adhe.Feet = {}
Herc = {}
Herc.Head = {}
Herc.Body = {}
Herc.Hands = {}
Herc.Legs = {}
Herc.Feet = {}
Carm = {}
Carm.Head = {}
Carm.Body = {}
Carm.Hands = {}
Carm.Legs = {}
Carm.Feet = {}
Kayk = {}
Kayk.Head = {}
Kayk.Body = {}
Kayk.Hands = {}
Kayk.Legs = {}
Kayk.Feet = {}
Taeon = {}
Taeon.Head = {}
Taeon.Body = {}
Taeon.Hands = {}
Taeon.Legs = {}
Taeon.Feet = {}
Telch = {}
Telch.Head = {}
Telch.Body = {}
Telch.Hands = {}
Telch.Legs = {}
Telch.Feet = {}
Chiro = {}
Chiro.Head = {}
Chiro.Hands = {}
Chiro.Body = {}
Chiro.Legs = {}
Chiro.Feet = {}
Gada = {}
Grio = {}

--------------------------------------------------
--------------------------------------------------    

-- This helps when your augment changes to only have 1 place to update. 


if  ( player.main_job == "RDM" or 
      player.main_job == "BLU" or 
      player.main_job == "SCH" ) then 
   
  -- Amal.Head.A			=	{ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}} 
  Amal.Body.A	=	{ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
  Amal.Hands.D =	{ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
  Amal.Legs.A	 =	{ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
  Amal.Feet.D =	{ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}}
end

if  ( player.main_job == "RDM" or 
      player.main_job == "SCH" ) then 
   
  Kayk.Hands.A =	{ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}}
end

if  ( player.main_job == "RDM" or 
      player.main_job == "SCH" ) then

  Merl.Head.FC =	{ name="Merlinic Hood", augments={'Pet: "Subtle Blow"+3','Pet: AGI+6','"Fast Cast"+8','Accuracy+17 Attack+17','Mag. Acc.+7 "Mag.Atk.Bns."+7',}}
  Merl.Head.MB = { name="Merlinic Hood", augments={'Mag. Acc.+29','Magic burst dmg.+11%','MND+9','"Mag.Atk.Bns."+14',}}
  Merl.Head.DT = { name="Merlinic Hood", augments={'"Mag.Atk.Bns."+1','Phys. dmg. taken -4%',}}
  Merl.Body.FC = { name="Merlinic Jubbah", augments={'Mag. Acc.+16','"Fast Cast"+4','CHR+6',}}
  Merl.Hands.Phalanx = { name="Merlinic Dastanas", augments={'Mag. Acc.+30','"Dual Wield"+2','Phalanx +3',}}
  Merl.Legs.Phalanx = { name="Merlinic Shalwar", augments={'Crit.hit rate+2','MND+5','Phalanx +3','Accuracy+12 Attack+12','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
  Merl.Legs.MATT = { name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Fast Cast"+5','INT+8','Mag. Acc.+15','"Mag.Atk.Bns."+10',}}
  Merl.Legs.MB = { name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+4%','INT+10','Mag. Acc.+6','"Mag.Atk.Bns."+4',}}
  Merl.Feet.FC = { name="Merlinic Crackows", augments={'Mag. Acc.+9 "Mag.Atk.Bns."+9','"Fast Cast"+6','CHR+10','Mag. Acc.+2',}}
  Merl.Feet.Drain = { name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Drain" and "Aspir" potency +4','Mag. Acc.+12','"Mag.Atk.Bns."+12',}}
  Merl.Feet.MB = { name="Merlinic Crackows", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Magic burst dmg.+10%','MND+7','"Mag.Atk.Bns."+11',}}
  Merl.Feet.Idle = { name="Merlinic Crackows", augments={'Blood Pact Dmg.+3','Accuracy+9','"Refresh"+1','Accuracy+12 Attack+12','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
end

if  ( player.main_job == "RDM" or 
      player.main_job == "SCH" or
      player.main_job == "BLU" ) then

  Telch.Head = { name="Telchine Cap", augments={'Potency of "Cure" effect received+7%','Enh. Mag. eff. dur. +10',}}
  Telch.Body = { name="Telchine Chas.", augments={'Potency of "Cure" effect received+7%','Enh. Mag. eff. dur. +9',}}
  Telch.Hands = { name="Telchine Gloves", augments={'Potency of "Cure" effect received+7%','Enh. Mag. eff. dur. +9',}}
  Telch.Legs = { name="Telchine Braconi", augments={'Potency of "Cure" effect received+6%','Enh. Mag. eff. dur. +8',}}
  Telch.Feet = { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}}
end

if  ( player.main_job == "RDM" or 
      player.main_job == "SCH" ) then 
  
  -- Chiro.Hands.Phalanx = { }

  Chiro.Hands.TH = { name="Chironic Gloves", augments={'AGI+9','Pet: "Dbl. Atk."+2','"Treasure Hunter"+2','Accuracy+16 Attack+16','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}
  Chiro.Hands.Idle = { name="Chironic Gloves", augments={'Rng.Atk.+8','"Drain" and "Aspir" potency +2','"Refresh"+1','Accuracy+16 Attack+16','Mag. Acc.+9 "Mag.Atk.Bns."+9',}}
  Chiro.Legs.MACC = { name="Chironic Hose", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Conserve MP"+3','VIT+7','Mag. Acc.+14','"Mag.Atk.Bns."+6',}}
  Chiro.Legs.Idle = { name="Chironic Hose", augments={'Pet: "Mag.Atk.Bns."+17','Crit.hit rate+3','"Refresh"+2','Accuracy+15 Attack+15','Mag. Acc.+9 "Mag.Atk.Bns."+9',}}
end

if  ( player.main_job == "BLU" or
      player.main_job == "COR" ) then 

  Herc.Head.FC = { name="Herculean Helm", augments={'"Mag.Atk.Bns."+3','"Fast Cast"+5','STR+5',} }
  Herc.Hands.Idle = { name="Herculean Gloves", augments={'Pet: DEX+15','DEX+10','"Refresh"+2','Accuracy+1 Attack+1','Mag. Acc.+5 "Mag.Atk.Bns."+5',} }
  Herc.Hands.WSD = { name="Herculean Gloves", augments={'Mag. Acc.+1','Crit. hit damage +2%','Weapon skill damage +7%','Accuracy+6 Attack+6','Mag. Acc.+12 "Mag.Atk.Bns."+12',} }
  Herc.Legs.Idle = { name="Herculean Trousers", augments={'MND+13','Mag. Acc.+21','"Refresh"+1','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
  Herc.Legs.Phalanx = { name="Herculean Trousers", augments={'Pet: "Dbl. Atk."+1','MND+8','Phalanx +3','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}
  Herc.Feet.Idle = { name="Herculean Boots", augments={'MND+3','"Rapid Shot"+4','"Refresh"+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',} }
  Herc.Feet.TP = { name="Herculean Boots", augments={'"Triple Atk."+3','Accuracy+11','Attack+14',} }
  Herc.Feet.TH = { name="Herculean Boots", augments={'STR+3','Mag. Acc.+24','"Treasure Hunter"+2','Accuracy+4 Attack+4',}}
end

if  ( player.main_job == "BLU" or
      player.main_job == "COR" ) then 

  Adhe.Head.B =	{ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}
  -- Adhe.Head.B = { name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}
  Adhe.Body.B = { name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}}
  Adhe.Hands.A =	{ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
end

if  ( player.main_job == "RDM" or
      player.main_job == "BLU" ) then 

  -- Carm.Head.D =	{ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}
  Carm.Legs.D	=	{ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}}
  Carm.Feet.B	=	{ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4%',}}
  -- Carm.Feet.B = { name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}}
end

if  ( player.main_job == "RDM" or
      player.main_job == "BLU" or
      player.main_job == "COR" ) then

  Taeon.Head.Phalanx = { name="Taeon Chapeau", augments={'Phalanx +3',} }
  Taeon.Body.Phalanx = { name="Taeon Tabard", augments = {'"Fast Cast"+4',} }
  -- Taeon.Hands.Phalanx = {  }
  -- Taeon.Legs.Phalanx = {  }
  Taeon.Feet.Phalanx = { name="Taeon Boots", augments={'Attack+24','"Dual Wield"+3','Phalanx +2',} }
  Taeon.Feet.DW = { name="Taeon Boots", augments={'Accuracy+25','"Dual Wield"+4',} }
end

if ( player.main_job == "RDM" or
     player.main_job == "SCH" ) then

  Gada.Enfeeb = { name="Gada", augments={'Attack+13','VIT+6','Mag. Acc.+24','"Mag.Atk.Bns."+15',}}
  Gada.Enhancing = { name="Gada", augments={'Enh. Mag. eff. dur. +5','VIT+6','Mag. Acc.+18','"Mag.Atk.Bns."+13',}}
  Gada.Healing = {}
end

if ( player.main_job == "RDM" or
     player.main_job == "SCH" ) then
      
  Grio.Enfeeb = { name="Grioavolr", augments={'Enfb.mag. skill +15','Mag. Acc.+13','"Mag.Atk.Bns."+18',}}
  Grio.Nuking = {}
end

local cfg = {}

-- (see vRP.EXT.Inventory:defineItem)
-- map of id => {name, description, menu_builder, weight}
--- name: display name, value or genfunction(args)
--- description: value or genfunction(args) (html)
--- menu_builder: (optional) genfunction(args, menu)
--- weight: (optional) value or genfunction(args)
--
-- genfunction are functions returning a correct value as: function(args, ...)
-- where args is a list of {base_idname,args...}
cfg.items = {
  ["gold_ore"] = {"Gold ore","",nil,1},
  ["gold_processed"] = {"Gold processed","",nil,1.2},
  ["gold_ingot"] = {"Gold ingot","",nil,12},
  ["gold_catalyst"] = {"Gold catalyst","Used to transform processed gold into gold ingot.",nil,0.1},
  ["demineralized_water"] = {"Demineralized water (1L)","",nil,1},

  --==================--
  --====Base Items====--
  --==================--
  ["bank_money"] = {"Money from a Bank","Marked bills from a bank.",nil,0.0},
  ["groceries"] = {"Groceries","All the things you need for cooking at home.",nil,5.0},
  --====================--
  --====Casino Items====--
  --====================--
  ["casino_chip"] = {"Diamond Casino Chips","",nil,0.0},
  --=====================--
  --====Illegal Items====--
  --=====================--
  ["dirty_money"] = {"Dirty money","Illegally earned money.",nil,0.0},
  ["stolen_credit"] = {"Credit Card Info","handwritten credit card information.",nil,0.01},
  ["weed"] = {"Fresh Weed", "", nil, 0.02},
  ["weed_processed"] = {"Weed", "Bagged and ready for selling.", nil, 0.01},
  ["upperR"] = {"Upper Receiver", "An upper receiver.",nil, 1.0},
  ["lowerR"] = {"Lower Receiver", "A lower receiver.",nil, 1.0},
  ["methpipe"] = {"Methpipe", "A methpipe.", nil, 0.1},
  --========================--
  --====Burgetshot Items====--
  --========================--
  ["burger_products"] = {"Burgershot products","For company use only.",nil,1.0},
  --===================--
  --====pizza Items====--
  --===================--
  ["pizza_products"] = {"Pizza by the Slice products","For company use only.",nil,1.0},
  --======================--
  --====GoPostal Items====--
  --======================--
  ["package"] = {"Package","A Package for delivery.",nil,5.0},
  --=============================--
  --====Drug Processing Items====--
  --=============================--
  ["demineralized_water"] = {"Demineralized water (1L)","",nil,1},
  ["hydrochloric_acid"] = {"Hydrochloric acid (1L)","",nil,1},
  ["cocaleaf"] = {"Coca Leaf", "Leaf of the infamous coca plant",nil, 0.02},
  ["diesel"] = {"Diesel", "A jerry can of diesel (1L)",nil, 1},
  ["baggies"] = {"Small baggies","Small Ziplock Baggies.",nil,0.1},
  ["methlab"] = {"Portable Methlab","Propane bottle, pipes, trays, tools...everything you need except the kitchen sink.",nil,10.0},
  ["acetone"] = {"Nail Polish Remover","A bottle of acetone based nail polish remover.",nil,0.1},
  ["lithium"] = {"Lithium Batteries","A pack of lithium batteries,..this is for your flashlight right?.",nil,0.1},
  --=================================--
  --====Hunting and Fishing Items====--
  --=================================--
  ["meat"] = {"Venison", "Raw venison",nil, 1},
  ["leather"] = {"Leather", "Deer hide",nil, 1},
  --=============================--
  --====Weapon Crafting Items====--
  --=============================--
  ["gbarrel"] = {"Gun Barrel", "A gun barrel.",nil, 0.75},
  ["stock"] = {"Gun Stock", "A wooden gun stock.",nil, 1.0},
  ["pistol_parts"] = {"Pistol Parts", "Use these parts to craft a pistol.", nil, 1.0},
  ["shotgun_parts"] = {"Shotgun Parts", "Use these parts to craft a shotgun.", nil, 1.0},
  ["smg_parts"] = {"SMG Parts", "Use these parts to craft an SMG.", nil, 1.0},
  ["rifle_parts"] = {"Rifle Parts", "Use these parts to craft a rifle.", nil, 1.0},
  ["screws"] = {"Screws", "Standard Stainless Steel Machine Screws.",nil, 0.25},
  ["wood"] = {"Wood", "Some nice, hard wood.",nil, 1},
  ["bolts"] = {"Bolts", "Standard Stainless Steel Bolts.",nil, 0.25},
  ["gunp"] = {"Gun Powder", "",nil, 0.5},
  ["pvc"] = {"PVC", "PVC pipes.",nil, 0.5},
  ["casing"] = {"Bullet Casing", "",nil,0.1},
  ["sniper_parts"] = {"Sniper Parts","",nil,1.0},
  ["autorp"] = {"Automatic Reviever Parts","",nil,1.0},
  ["gunbpt"] = {"Black Powder Trigger","",nil,0.5},
  ["lgbarrel"] = {"Long Gunbarrel","",nil,1.0},
  ["gunbpb"] = {"Black Powder Gunbarrel","",nil,1.0},
  ["mg_parts"] = {"LMG Parts","",nil,5.0},
  ["elect_parts"] = {"Electric Parts","",nil,1.5},
  --==================--
  --====Farm Items====--
  --==================--
  ["seed"] = {"Seed", "Some seeds for farming",nil, 0.5},
  ["fertilizer"] = {"Fertilizer", "A bag of fertilizer", nil, 2.5},
  ["bottle"] = {"Bottle", "glass bottle", nil, 0.1},
  ["crate"] = {"Crate", "A wooden crate for shipping", nil, 0.5},
  ["barrel"] = {"Barrel", "An empty barrel.", nil, 5.0},
  ["harvest"] = {"Farm Fresh Harvest", "A crate of freshly harvested crops", nil, 10.0},
  --============================--
  --====Other Items====--
  --============================--
  ["lighter"] = {"A Lighter","used to lighting things on fire.",nil,0.2},
  ["coffee"] = {"Coffee", "", nil, 0.2},
  ["boom_box"] = {"Boom Box", "An old style boom box.", nil, 2.0},
  ["sour"] = {"Sour Mix", "",nil, 0.5},
}

return cfg

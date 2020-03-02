
local cfg = {}
-- define garage types with their associated vehicles
-- (vehicle list: https://wiki.fivem.net/wiki/Vehicles)

cfg.rent_factor = 0.1 -- 10% of the original price if a rent
cfg.sell_factor = 0.75 -- sell for 75% of the original price

cfg.force_out_fee = 8000 -- amount of money (fee) to force re-spawn an already out vehicle

-- default chest weight for vehicle trunks
cfg.default_vehicle_chest_weight = 150

cfg.vehicle_update_interval = 15 -- seconds
cfg.vehicle_check_interval = 15 -- seconds, re-own/respawn task
cfg.vehicle_respawn_radius = 150 -- radius for the out vehicle respawn feature

-- define vehicle chest weight by model in lower case
cfg.vehicle_chest_weights = {
  ["benson"] = 120,
  ["trailersmall"] = 100,
  ["trailers"] = 500,
  ["tanker"] = 5000
}

-- each garage type is a map of veh_name => {title, price, description}
-- _config: map_entity, permissions (optional, only users with the permissions will have access to the shop)
--- map_entity: {ent,cfg} will fill cfg.title, cfg.pos
cfg.garage_types = {

  ["Blackmarket Cars"] = {
    _config = {map_entity = {"PoI", {marker_id = 27}}},
    ["kuruma2"] = {"Armored Kuruma", 1750000, "<img src='gui/images/cars/ArmouredKaruma.jpg' /><br/><br/>Storage: 50 KG<br/>"},
    ["dukes2"] = {"Armored Dukes", 1500000, "<img src='gui/images/cars/ArmouredDukes.jpg' /><br/><br/>Storage: 50 KG<br/>"},
  },

  ["Bus Rental Teir One"] = {
    _config = {map_entity = {"PoI", {marker_id = 27}}, permissions = {"!aptitude.job.bus.<10"}},
    ["RENTALBUS"] = {"Rental Bus", 0, ""},
  },

  ["Bus Rental Teir Two"] = {
    _config = {map_entity = {"PoI", {marker_id = 27}}, permissions = {"!aptitude.job.bus.>9", "!aptitude.job.bus.<20"}},
    ["RENTALBUS"] = {"Rental Bus", 0, ""},
    ["BUS"] = {"City Bus", 0, ""},
  },

  ["Bus Rental Teir Three"] = {
    _config = {map_entity = {"PoI", {marker_id = 27}}, permissions = {"!aptitude.job.bus.>19"}},
    ["RENTALBUS"] = {"Rental Bus", 0, ""},
    ["BUS"] = {"City Bus", 0, ""},
    ["COACH"] = {"Coach Bus", 0, ""},
  },

  ["Luxury Autos"] = { -- sells Buckingham, Pfister, Grotti, Enus and Pegassi-manufactured vehicles
    _config = {map_entity = {"PoI", {blip_id = 523, blip_color = 1, marker_id = 27}}},
    ["pfister811"] = {"Pfister 811", 845000, "<img src='images/cars/Pfister811.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["comet2"] = {"Pfister Comet",179800, "<img src='images/cars/Pfistercomet.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["comet3"] = {"Pfister Comet Retro Custom",177720, "<img src='images/cars/PfisterCometRetroCustom.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["comet4"] = {"Pfister Comet Safari",166150, ""},
    ["comet5"] = {"Pfister Comet SR",245000, "<img src='images/cars/PfisterCometSR.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["neon"] = {"Pfister Neon", 75000, "<img src='images/cars/PfisterNeon.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["cheetah"] = {"Grotti Cheetah", 670000, "<img src='images/cars/GrottiCheetah.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["turismor"] = {"Grotti Turismo R", 1000000, "<img src='images/cars/GrottiTurismoR.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["visione"] = {"Grotti Visione", 1500000, "<img src='images/cars/GrottiVisione.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["prototipo"] = {"Grotti X80 Proto", 5000000, "<img src='images/cars/GrottiX80Proto.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["bestiagts"] = {"Grotti Bestia GTS",295000, "<img src='images/cars/GrottiBestiaGTS.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["carbonizzare"] = {"Grotti Carbonizzare",522700, "<img src='images/cars/GrottiCarbonizzare.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["cheetah2"] = {"Grotti Cheetah Classic", 181000, "<img src='images/cars/GrottiCheetahClassic.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["gt500"] = {"Grotti GT500", 650000, "<img src='images/cars/GrottiGT500.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["stinger"] = {"Grotti Stinger", 13600, "<img src='images/cars/GrottiStinger.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["stingergt"] = {"Grotti Stinger GT", 15000, "<img src='images/cars/GrottiStingerGT.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["turismo2"] = {"Grotti Turismo Classic", 300000, "<img src='images/cars/GrottiTurismoClassic.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["brioso"] = {"Grotti Brioso R/A", 6000, "<img src='images/cars/GrottiBriosoRA.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["cog55"] = {"Enus Cognoscenti 55", 209000, "<img src='images/cars/EnusCognoscenti55.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["cognoscenti"] = {"Enus Cognoscenti", 175000, "<img src='images/cars/EnusCognoscenti.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["stafford"] = {"Enus Stafford", 35700, "<img src='images/cars/EnusStafford.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["superd"] = {"Enus Super Diamond", 417000, "<img src='images/cars/EnusSuperDiamond.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["cogcabrio"] = {"Enus Cognoscenti Cabrio", 151000, "<img src='images/cars/EnusCognoscentiCabrio.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["huntley"] = {"Enus Huntley S", 140000, "<img src='images/cars/EnusHuntleyS.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["windsor"] = {"Enus Windsor", 176000, "<img src='images/cars/EnusWindsor.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["windsor2"] = {"Enus Windsor Drop", 230000, "<img src='images/cars/EnusWindsorDrop.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["infernus"] = {"Pegassi Infernus", 354000, "<img src='images/cars/PegassiInfernus.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["osiris"] = {"Pegassi Osiris", 1400000, "<img src='images/cars/PegassiOsiris.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["reaper"] = {"Pegassi Reaper", 3400000, "<img src='images/cars/PegassiReaper.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["tempesta"] = {"Pegassi Tempesta", 200000, "<img src='images/cars/PegassiTempesta.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["tezeract"] = {"Pegassi Tezeract", 500000, "<img src='images/cars/PegassiTezeract.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["zentorno"] = {"Pegassi Zentorno", 2200000, "<img src='images/cars/PegassiZentorno.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["infernus2"] = {"Pegassi Infernus Classic", 222000, "<img src='images/cars/PegassiInfernusClassic.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["monroe"] = {"Pegassi Monroe", 500000, "<img src='images/cars/PegassiMonroe.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["vacca"] = {"Pegassi Vacca", 260000, "<img src='images/cars/PegassiVacca.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["torero"] = {"Pegassi Torero", 102500, "<img src='images/cars/PegassiTorero.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["toros"] = {"Pegassi Toros", 200000, "<img src='images/cars/PegassiToros.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["autarch"] = {"Överflöd Autarch", 2000000, "<img src='images/cars/ÖverflödAutarch.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["entityxf"] = {"Överflöd Entity XF", 4800000, "<img src='images/cars/ÖverflödEntityXF.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["entity2"] = {"Överflöd Entity XXR", 2100000, "<img src='images/cars/ÖverflödEntityXXR.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["tyrant"] = {"Överflöd Tyrant", 750000, "<img src='images/cars/ÖverflödTyrant.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["adder"] = {"Truffade Adder", 2400000, "<img src='images/cars/TruffadeAdder.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["nero"] = {"Truffade Nero", 3000000, "<img src='images/cars/TruffadeNero.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["nero2"] = {"Truffade Nero Custom", 3500000, "<img src='images/cars/TruffadeNeroCustom.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["ztype"] = {"Truffade Z-Type", 40000000, "<img src='images/cars/TruffadeZ-Type.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["cyclone"] = {"Coil Cyclone", 1000000, "<img src='images/cars/CoilCyclone.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["raiden"] = {"Coil Raiden", 78000, "<img src='images/cars/CoilRaiden.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["voltic"] = {"Coil Voltic",55000, "<img src='images/cars/CoilVoltic.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["brawler"] = {"Coil Brawler", 99000, "<img src='images/cars/CoilBrawler.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["gp1"] = {"Progen GP1", 312500, "<img src='images/cars/ProgenGP1.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["t20"] = {"Progen T20", 1350000, "<img src='images/cars/ProgenT20.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["tyrus"] = {"Progen Tyrus", 1200000, "<img src='images/cars/ProgenTyrus.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["italigto"] = {"Progen Itali GTO",335300, "<img src='images/cars/ProgenItaliGTO.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["italigtb"] = {"Progen Itali GTB", 234000, "<img src='images/cars/ProgenItaliGTB.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["italigtb2"] = {"Progen Itali GTB Custom", 250000, "<img src='images/cars/ProgenItaliGTBCustom.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["jester"] = {"Dinka Jester",157500, "<img src='images/cars/DinkaJester.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["jester3"] = {"Dinka Jester Classic",80000, "<img src='images/cars/DinkaJesterClassic.jpg' /><br/><br/>Storage: 50 KG<br/>"},
    ["fusilade"] = {"Schyster Fusilade",34100, "<img src='images/cars/SchysterFusilade.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["deveste"] = {"Principe Deveste Eight", 1600000, "<img src='images/cars/PrincipeDevesteEight.jpg' /><br/><br/>Storage: 150 KG<br/>"},
  },

  ["Mosley Auto Service"] = { -- sells Albany-manufactured vehicles
    _config = {map_entity = {"PoI", {blip_id = 523, blip_color = 2, marker_id = 27}}},
    ["alpha"] = {"Albany Alpha",47000, "<img src='images/cars/Albany_Alpha.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["btype2"] = {"Albany Fränken Stange", 20000, "<img src='images/cars/Albany_Fränken_Stange.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["btype"] = {"Albany Roosevelt", 115000, "<img src='images/cars/Albany_Roosevelt.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["btype3"] = {"Albany Roosevelt Valor", 120000, "<img src='images/cars/Albany_Roosevelt_Valor.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["manana"] = {"Albany Manana", 6600, "<img src='images/cars/Albany_Manana.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["emperor"] = {"Albany Emperor Restored", 13000, "<img src='images/cars/Albany_Emperor_Restored.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["emperor2"] = {"Albany Emperor", 7000, "<img src='images/cars/Albany_Emperor.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["primo"] = {"Albany Primo", 5000, "<img src='images/cars/Albany_Primo.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["primo2"] = {"Albany Primo Custom", 10000, "<img src='images/cars/Albany_Primo_Custom.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["washington"] = {"Albany Washington", 4000, "<img src='images/cars/Albany_Washington.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["stretch"] = {"Albany Washington Limousine", 25000, "<img src='images/cars/Albany_Washington_Limousine.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["buccaneer"] = {"Albany Buccaneer", 4000, "<img src='images/cars/Albany_Buccaneer.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["buccaneer2"] = {"Albany Buccaneer Custom", 8000, "<img src='images/cars/Albany_Buccaneer_Custom.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["hermes"] = {"Albany Hermes", 78000, "<img src='images/cars/Albany_Hermes.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["virgo"] = {"Albany Virgo", 5000, "<img src='images/cars/Albany_Virgo.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["cavalcade"] = {"Albany Cavalcade", 53000, "<img src='images/cars/Albany_Cavalcade.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["cavalcade2"] = {"Albany Cavalcade SE", 57000, "<img src='images/cars/Albany_Cavalcade_SE.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["ninef"] = {"Obey 9F",138700, "<img src='images/cars/Obey_9F.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["ninef2"] = {"Obey 9F Cabrio",177100, "<img src='images/cars/Obey_9F_Cabrio.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["rocoto"] = {"Obey Rocoto", 59000, "<img src='images/cars/Obey_Rocoto.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["coquette"] = {"Invetero Coquette",119000, "<img src='images/cars/Invetero_Coquette.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["coquette2"] = {"Invetero Coquette Classic", 22900, "<img src='images/cars/Invetero_Coquette_Classic.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["coquette3"] = {"Invetero Coquette BlackFin", 46700, "<img src='images/cars/Invetero_Coquette_BlackFin.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["elegy2"] = {"Annis Elegy RH8",120000, "<img src='images/cars/Annis_Elegy_RH8.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["elegy"] = {"Annis Elegy Retro Custom",100000, "<img src='images/cars/Annis_Elegy_Retro_Custom.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["faction"] = {"Willard Faction", 15000, "<img src='images/cars/Willard_Faction.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["faction2"] = {"Willard Faction Custom", 26000, "<img src='images/cars/Willard_Faction_Custom.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["faction3"] = {"Willard Faction Custom Donk", 44000, "<img src='images/cars/Willard_Faction_Custom_Donk.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["dukes"] = {"Imponte Dukes", 16500, "<img src='images/cars/Imponte_Dukes.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["nightshade"] = {"Imponte Nightshade", 23000, "<img src='images/cars/Imponte_Nightshade.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["phoenix"] = {"Imponte Phoenix", 16000, "<img src='images/cars/Imponte_Phoenix.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["ruiner"] = {"Imponte Ruiner", 10000, "<img src='images/cars/Imponte_Ruiner.jpg' /><br/><br/>Storage: 150 KG<br/>"},
  },

  ["Premium Deluxe Motorsport"] = { -- sells all OTHER vehicles
    _config = {map_entity = {"PoI", {blip_id = 523, blip_color = 3, marker_id = 27}}},
    ["banshee2"] = {"Bravado Banshee 900R", 92500, "<img src='images/cars/Bravado_Banshee_900R.jpg' /><br/><br/>Storage: 105 KG<br/>"},
    ["banshee"] = {"Bravado Banshee",142700, "<img src='images/cars/Bravado_Banshee.jpg' /><br/><br/>Storage: 115 KG<br/>"},
    ["buffalo"] = {"Bravado Buffalo",24835, "<img src='images/cars/Bravado_Buffalo.jpg' /><br/><br/>Storage: 135 KG<br/>"},
    ["buffalo2"] = {"Bravado Buffalo S",29220, "<img src='images/cars/Bravado_Buffalo_S.jpg' /><br/><br/>Storage: 135 KG<br/>"},
    ["verlierer2"] = {"Bravado Verlierer",65700,"<img src='images/cars/Bravado_Verlierer.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["gauntlet"] = {"Bravado Gauntlet", 26000, "<img src='images/cars/Bravado_Gauntlet.jpg' /><br/><br/>Storage: 125 KG<br/>"}, 
    ["ratloader2"] = {"Bravado Rat Truck Restored", 10000, "<img src='images/cars/Rat_Loader_Restored.jpg' /><br/><br/>Storage: 150 KG<br/>"}, 
    ["gresley"] = {"Bravado Gresley", 30000, "<img src='images/cars/Bravado_Gresley.jpg' /><br/><br/>Storage: 150 KG<br/>"}, 
    ["dloader"] = {"Bravado Duneloader", 10000, "<img src='images/cars/Bravado_Duneloader.jpg' /><br/><br/>Storage: 200 KG<br/>"},
    ["youga"] = {"Bravado Youga", 20000, "<img src='images/cars/Bravado_Youga.jpg' /><br/><br/>Storage: 500 KG<br/>"},
    ["youga2"] = {"Bravado Youga Classic", 24000, "<img src='images/cars/Bravado_Youga_Classic.jpg' /><br/><br/>Storage: 500 KG<br/>"},
    ["rumpo"] = {"Bravado Rumpo", 20000, "<img src='images/cars/Bravado_Rumpo.jpg' /><br/><br/>Storage: 500 KG<br/>"},
    ["rumpo3"] = {"Bravado Rumpo Custom", 24000, "<img src='images/cars/Bravado_Rumpo_Custom.jpg' /><br/><br/>Storage: 500 KG<br/>"},
    ["bison"] = {"Bravado Bison", 15000, "<img src='images/cars/Bravado_Bison.jpg' /><br/><br/>Storage: 200 KG<br/>"},
    ["penetrator"] = {"Ocelot Penetrator", 616000, "<img src='images/cars/Ocelot_Penetrator.jpg' /><br/><br/>Storage: 115 KG<br/>"},
    ["xa21"] = {"Ocelot XA-21", 1150000, "<img src='images/cars/Ocelot_XA-21.jpg' /><br/><br/>Storage: 115 KG<br/>"},
    ["lynx"] = {"Ocelot Lynx",60750, "<img src='images/cars/Ocelot_Lynx.jpg' /><br/><br/>Storage: 115 KG<br/>"},
    ["pariah"] = {"Ocelot Pariah", 300000, "<img src='images/cars/Ocelot_Pariah.jpg' /><br/><br/>Storage: 125 KG<br/>"},
    ["ardent"] = {"Ocelot Ardent", 35200, ""},
    ["swinger"] = {"Ocelot Swinger", 68000, "<img src='images/cars/Ocelot_Swinger.jpg' /><br/><br/>Storage: 110 KG<br/>"},
    ["jackal"] = {"Ocelot Jackal", 71000, "<img src='images/cars/Ocelot_Jackal.jpg' /><br/><br/>Storage: 135 KG<br/>"},
    ["f620"] = {"Ocelot F620", 132000, "<img src='images/cars/Ocelot_F620.jpg' /><br/><br/>Storage: 115 KG<br/>"},
    ["sc1"] = {"Übermacht SC1", 300000, "<img src='images/cars/Ubermacht_SC1.jpg' /><br/><br/>Storage: 105 KG<br/>"},
    ["revolter"] = {"Übermacht Revolter", 50500, "<img src='images/cars/Ubermacht_Revolter.jpg' /><br/><br/>Storage: 135 KG<br/>"},
    ["sentinel3"] = {"Übermacht Sentinel Classic", 55000, "<img src='images/cars/Ubermacht_Sentinel_Classic.jpg' /><br/><br/>Storage: 125 KG<br/>"},
    ["oracle"] = {"Übermacht Oracle", 66000, "<img src='images/cars/Ubermacht_Oracle.jpg' /><br/><br/>Storage: 135 KG<br/>"},
    ["oracle2"] = {"Übermacht Oracle XS", 79000, "<img src='images/cars/Ubermacht_Oracle_XS.jpg' /><br/><br/>Storage: 135 KG<br/>"},
    ["sentinel2"] = {"Übermacht Sentinel", 43000, "<img src='images/cars/Ubermacht_Sentinel.jpg' /><br/><br/>Storage: 135 KG<br/>"},
    ["sentinel"] = {"Übermacht Sentinel XS", 45000, "<img src='images/cars/Ubermacht_Sentinel_XS.jpg' /><br/><br/>Storage: 125 KG<br/>"},
    ["zion"] = {"Übermacht Zion", 78000, "<img src='images/cars/Ubermacht_Zion.jpg' /><br/><br/>Storage: 125 KG<br/>"},
    ["zion2"] = {"Übermacht Zion Cabrio", 80000, "<img src='images/cars/Ubermacht_Zion_Cabrio.jpg' /><br/><br/>Storage: 115 KG<br/>"},
    ["taipan"] = {"Cheval Taipan", 1600000, "<img src='images/cars/Cheval_Taipan.jpg' /><br/><br/>Storage: 105 KG<br/>"},
    ["surge"] = {"Cheval Surge", 30000, "<img src='images/cars/Cheval_Surge.jpg' /><br/><br/>Storage: 135 KG<br/>"},
    ["picador"] = {"Cheval Picador", 10000, "<img src='images/cars/Cheval_Picador.jpg' /><br/><br/>Storage: 200 KG<br/>"},
    ["vagner"] = {"Dewbauchee Vagner", 3200000, "<img src='images/cars/Dewbauchee_Vagner.jpg' /><br/><br/>Storage: 105 KG<br/>"},
    ["massacro"] = {"Dewbauchee Massacro",294950, "<img src='images/cars/Dewbauchee_Massacro.jpg' /><br/><br/>Storage: 125 KG<br/>"},
    ["rapidgt"] = {"Dewbauchee Rapid GT",200000, "<img src='images/cars/Dewbauchee_Rapid_GT.jpg' /><br/><br/>Storage: 115 KG<br/>"},
    ["rapidgt2"] = {"Dewbauchee Rapid GT Convertible",210000, "<img src='images/cars/Dewbauchee_Rapid_GT_Convertible.jpg' /><br/><br/>Storage: 105 KG<br/>"},
    ["seven70"] = {"Dewbauchee Seven-70", 1870000, "<img src='images/cars/Dewbauchee_Seven-70.jpg' /><br/><br/>Storage: 110 KG<br/>"},
    ["specter"] = {"Dewbauchee Specter", 250000, "<img src='images/cars/Dewbauchee_Specter.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["specter2"] = {"Dewbauchee Specter Custom", 275000, "<img src='images/cars/Dewbauchee_Specter_Custom.jpg' /><br/><br/>Storage: 150 KG<br/>"},
    ["rapidgt3"] = {"Dewbauchee Rapid GT Classic", 288000, "<img src='images/cars/Dewbauchee_Rapid_GT_Classic.jpg' /><br/><br/>Storage: 115 KG<br/>"},
    ["exemplar"] = {"Dewbauchee Exemplar", 206000, "<img src='images/cars/Dewbauchee_Exemplar.jpg' /><br/><br/>Storage: 125 KG<br/>"},
  },

  ["Sanders Motorcycles"] = { 
    _config = {map_entity = {"PoI", {blip_id = 522, blip_color = 1, marker_id = 27}}},
    ["blazer"] = {"Nagasaki Blazer", 1000, "ATV (NOT STREET LEGAL)"},
    ["blazer3"] = {"Nagasaki Hot Rod Blazer", 2000, "ATV (NOT STREET LEGAL)"},
    ["blazer4"] = {"Nagasaki Street Blazer", 5000, "ATV (NOT STREET LEGAL)"},
    ["raptor"] = {"BF Raptor", 57000, "Roadster"},
    ["akuma"] = {"Dinka Akuma", 9000, "Sports bike (NOT STREET LEGAL)"},
    ["avarus"] = {"Liberty City Cycles Avarus", 16000, "Chopper-style"},
    ["bagger"] = {"Western Motorcycle Company Bagger", 16000, "Roadcruiser"},
    ["bati"] = {"Pegassi Bati 801", 15000, "Sports bike"},
    ["bati2"] = {"Pegassi Bati Custom", 20000, "Sports bike (NOT STREET LEGAL)"},
    ["bf400"] = {"Nagasaki BF400", 14000, "Dirt Bike (NOT STREET LEGAL)"},
    ["carbonrs"] = {"Nagasaki Carbon RS", 40000, "Sports bike"},
    ["chimera"] = {"Nagasaki Chimera", 50000, "Chopper-style tricycle"},
    ["cliffhanger"] = {"Western Motorcycle Company Cliffhanger", 25000, "Rally motorcycle (NOT STREET LEGAL)"},
    ["daemon2"] = {"Western Motorcycle Company Daemon", 45000, "Chopper-style"},
    ["defiler"] = {"Shitzu Defiler", 22000, "Sports bike"},
    ["diablous"] = {"Principe Diabolus", 49000, "Sports bike"},
    ["diablous2"] = {"Principe Diabolus Custom", 69000, "Sports bike (NOT STREET LEGAL)"},
    ["double"] = {"Dinka Double T", 12000, "Sports bike (NOT STREET LEGAL)"},
    ["enduro"] = {"Dinka Enduro", 48000, "Dirt bike (NOT STREET LEGAL)"},
    ["esskey"] = {"Pegassi Esskey", 46000, "Scrambler motorcycle"},
    ["faggio2"] = {"Pegassi Faggio", 5000, "Scooter"},
    ["faggio3"] = {"Pegassi Faggio Mod", 6000, "Scooter"},
    ["faggio"] = {"Pegassi Faggio Sport", 8000, "Scooter"},
    ["fcr"] = {"Pegassi FCR 1000", 35000, "Sports bike"},
    ["fcr2"] = {"Pegassi FCR 1000 Custom", 69000, "Sports bike (NOT STREET LEGAL)"},
    ["gargoyle"] = {"Western Motorcycle Company Gargoyle", 20000, "Rally-converted motorcycle (NOT STREET LEGAL)"},
    ["hakuchou"] = {"Shitzu Hakuchou", 82000, "Sports bike"},
    ["hakuchou2"] = {"Shitzu Hakuchou Drag", 176000, "Drag bike (NOT STREET LEGAL)"},
    ["hexer"] = {"Liberty City Cycles Hexer", 15000, "Chopper-style"},
    ["innovation"] = {"Liberty City Cycles Innovation", 25000, "Chopper-style (NOT STREET LEGAL)"},
    ["lectro"] = {"Principe Lectro", 50000, "Sports bike"},
    ["manchez"] = {"Maibatsu Manchez", 67000, "Dirt bike (NOT STREET LEGAL)"},
    ["nemesis"] = {"Principe Nemesis", 12000, "Sports bike"},
    ["nightblade"] = {"Western Motorcycle Company Nightblade", 30000, "Chopper-style Cruiser"},
    ["pcj"] = {"Shitzu PCJ-600", 9000, "Sports bike"},
    ["ratbike"] = {"Western Motorcycle Company Wolfsbane", 2000, "ratbike (NOT STREET LEGAL)"},
    ["wolfsbane"] = {"Western Motorcycle Company Wolfsbane Restored", 22000, "Chopper-style Cruiser (NOT STREET LEGAL)"},
    ["ruffian"] = {"Pegassi Ruffian", 10000, "Sports bike"},
    ["sanchez2"] = {"Maibatsu Sanchez", 18000, "Dirt bike (NOT STREET LEGAL)"},
    ["sanctus"] = {"Liberty City Cycles Sanctus", 95000, "Custom Chopper-style"},
    ["sovereign"] = {"Western Motorcycle Company Sovereign", 20000, "Roadcruiser"},
    ["thrust"] = {"Dinka Thrust", 75000, "Sports bike"},
    ["vader"] = {"Shitzu Vader", 9000, "Sports bike (NOT STREET LEGAL)"},
    ["vindicator"] = {"Dinka Vindicator", 30000, "Sports bike"},
    ["vortex"] = {"Pegassi Vortex", 56000, "Sports bike"},
    ["zombiea"] = {"Western Motorcycle Company Zombie Bobber", 9000, "Chopper-style (NOT STREET LEGAL)"},
    ["zombieb"] = {"Western Motorcycle Company Zombie Chopper", 19000, "Chopper-style (NOT STREET LEGAL)"},
  },

  ["Rental Cars"] = { 
    _config = {map_entity = {"PoI", {blip_id = 523, blip_color = 4, marker_id = 27}}},
    ["ratloader"] = {"Bravado Rat Truck", 700, ""},
    ["fugitive"] = {"Cheval Fugitive", 5000, ""},
    ["tailgater"] = {"Obey Tailgater", 5000, ""},
    ["savestra"] = {"Annis Savestra", 3600, ""},
    ["panto"] = {"Benefactor Panto", 7000, ""},
    ["michelli"] = {"Lampadati Michelli GT", 4000, ""},
    ["deviant"] = {"Schyster Deviant", 3000, ""},
    ["z190"] = {"Karin 190z", 7200, ""},
    ["intruder"] = {"Karin Intruder", 6300, ""},
    ["dilettante"] = {"Karin Dilettante", 7500, ""},
    ["rebel2"] = {"Karin Rebel Restored", 8000, ""}, 
    ["rebel"] = {"Karin Rebel", 5000, ""},
    ["blista"] = {"Dinka Blista", 3000, ""},
    ["cheburek"] = {"RUNE Cheburek", 5000, ""},
    ["fagaloa"] = {"Vulcar Fagaloa", 3000, ""},
    ["ingot"] = {"Vulcar Ingot", 4700, ""},
    ["regina"] = {"Dundreary Regina", 4000, ""},
    ["virgo3"] = {"Dundreary Virgo Classic", 4000, ""},
    ["virgo2"] = {"Dundreary Virgo Classic Custom", 7000, ""},
    ["stratum"] = {"Zirconium Stratum", 5000, ""},
    ["tornado3"] = {"Declasse Tornado", 2500, ""},
    ["tornado4"] = {"Declasse Convertible Tornado", 4600, ""},
    ["tornado6"] = {"Declasse Tornado Hotrod", 8000, ""},
    ["premier"] = {"Declasse Premier", 4300, ""},
    ["rhapsody"] = {"Declasse Rhapsody", 5000, ""},
    ["vamos"] = {"Declasse Vamos", 8000, ""},
    ["moonbeam"] = {"Declasse Moonbeam", 2000, ""},
    ["moonbeam2"] = {"Declasse Moonbeam Custom", 3000, ""},
    ["bifta"] = {"BF Bifta", 2000, "dune buggy"},
    ["dune"] = {"BF Dune Buggy", 2500, ""},
    ["bfinjection"] = {"BF Injection", 1500, ""},
    ["kalahari"] = {"Canis Kalahari", 2000, ""},
    ["bodhi2"] = {"Canis Bodhi", 6000, ""},
    ["issi3"] = {"Weeny Issi Classic", 5000, ""},
    ["issi2"] = {"Weeny Issi", 2500, ""},
    ["prairie"] = {"Bollokan Prairie", 3000, ""},
  },

  ["Larrys RV Sales"] = { 
    _config = {map_entity = {"PoI", {blip_id = 85, blip_color = 5, marker_id = 27}}},
    ["furoregt"] = {"Lampadati Furore GT",100000, ""},
    ["tropos"] = {"Lampadati Tropos Rallye",310000, ""},
    ["casco"] = {"Lampadati Casco", 11400, ""},
    ["pigalle"] = {"Lampadati Pigalle", 11700, ""},
    ["viseris"] = {"Lampadati Viseris", 41000, ""},
    ["felon"] = {"Lampadati Felon", 75000, ""},
    ["felon2"] = {"Lampadati Felon", 80000, ""},
    ["futo"] = {"Karin Futo",13800, ""},
    ["kuruma"] = {"Karin Kuruma",37995, ""},
    ["sultan"] = {"Karin Sultan",38500, ""},
    ["asterope"] = {"Karin Asterope", 11500, ""},
    ["sultanrs"] = {"Karin Sultan RS", 40000, ""},
    ["bjxl"] = {"Karin BeeJay XL", 29000, ""},
    ["khamelion"] = {"Hijak Khamelion", 67600, ""},
    ["ruston"] = {"Hijak Ruston", 79200, ""},
    ["penumbra"] = {"Maibatsu Penumbra",23600, ""},
    ["warrener"] = {"Vulcar Warrener", 24000, ""},
    ["mesa"] = {"Canis Mesa", 23000, ""},
    ["mesa3"] = {"Canis Mesa Grande", 40000, ""},
    ["seminole"] = {"Canis Seminole", 31000, ""},
    ["freecrawler"] = {"Canis Freecrawler", 178000, ""},
    ["kamacho"] = {"Canis Kamacho", 48000, ""},
  },

  ["Vapid Dealership"] = { 
    _config = {map_entity = {"PoI", {blip_id = 523, blip_color = 6, marker_id = 27}}},
    ["bullet"] = {"Vapid Bullet", 450000, ""},
    ["fmj"] = {"Vapid FMJ", 400000, ""},
    ["gb200"] = {"Vapid GB200",250000, ""},
    ["peyote"] = {"Vapid Peyote", 38000, ""},
    ["retinue"] = {"Vapid Retinue", 11000, ""},
    ["stanier"] = {"Vapid Stanier", 4000, ""},
    ["blade"] = {"Vapid Blade", 5000, ""},
    ["chino"] = {"Vapid Chino", 6000, ""},
    ["chino2"] = {"Vapid Chino Custom", 10000, ""},
    ["clique"] = {"Vapid Clique", 2000, ""},
    ["dominator"] = {"Vapid Dominator", 26000, ""},
    ["dominator3"] = {"Vapid Dominator GTX", 30000, ""},
    ["ellie"] = {"Vapid Ellie", 109000, ""},
    ["hotknife"] = {"Vapid Hotknife", 60000, ""},
    ["hustler"] = {"Vapid Hustler", 52000, ""},
    ["slamvan"] = {"Vapid Slamvan", 7000, ""},
    ["slamvan3"] = {"Vapid Slamvan Custom", 14000, ""},
    ["contender"] = {"Vapid Contender", 27000, ""},
    ["radi"] = {"Vapid Radius", 10000, ""},
    ["sadler"] = {"Vapid Sadler", 43000, ""},
    ["speedo4"] = {"Vapid Speedo Custom", 31000, ""},
    ["minivan"] = {"Vapid Minivan", 23000, ""},
    ["minivan2"] = {"Vapid Minivan Custom", 27000, ""},
    ["bobcatxl"] = {"Vapid Bobcat XL", 6500, ""},
    ["sandking2"] = {"Vapid Sandking SWB", 56000, ""},
    ["sandking"] = {"Vapid Sandking XL", 58000, ""},
    ["riata"] = {"Vapid Riata", 30000, ""},
    ["mamba"] = {"Declasse Mamba", 105000, ""},
    ["tornado"] = {"Declasse Tornado Restored", 10800, ""},
    ["tornado2"] = {"Declasse Convertible Tornado Restored", 22500, ""},
    ["tornado5"] = {"Declasse Tornado Custom Restored", 15000, ""},
    ["asea"] = {"Declasse Asea", 12700, ""},
    ["Impaler"] = {"Declasse Impaler Restored", 63000, ""},
    ["tulip"] = {"Declasse Tulip", 15000, ""},
    ["tampa"] = {"Declasse Tampa", 10000, ""},
    ["stalion"] = {"Declasse Stallion", 12000, ""},
    ["sabregt"] = {"Declasse Sabre Turbo", 12000, ""},
    ["sabregt2"] = {"Declasse Sabre Turbo Custom", 18000, ""},
    ["yosemite"] = {"Declasse Yosemite", 10000, ""},
    ["voodoo2"] = {"Declasse VooDoo", 11000, ""},
    ["voodoo"] = {"Declasse VooDoo Restored", 21000, ""},
    ["vigero"] = {"Declasse Vigero", 13000, ""},
    ["granger"] = {"Declasse Granger", 50000, ""},
    ["rancherxl"] = {"Declasse Rancher XL", 16000, ""},
    ["burrito3"] = {"Declasse Burrito", 28000, ""},
    ["gburrito2"] = {"Declasse Burrito Custom", 32000, ""},
  },

  ["Benefactor Dealership"] = {
    _config = {map_entity = {"PoI", {blip_id = 523, blip_color = 7, marker_id = 27}}},
    ["feltzer2"] = {"Benefactor Feltzer",222000, ""},
    ["schafter4"] = {"Benefactor Schafter LWB", 195000, ""},
    ["schafter3"] = {"Benefactor Schafter V12",192000, ""},
    ["schwarzer"] = {"Benefactor Schwartzer", 58900, ""},
    ["schlagen"] = {"Benefactor Schlagen GT", 158000, ""},
    ["surano"] = {"Benefactor Surano",69000, ""},
    ["streiter"] = {"Benefactor Streiter", 53500, ""},
    ["feltzer3"] = {"Benefactor Stirling GT", 965000, ""},
    ["glendale"] = {"Benefactor Glendale", 32000, ""},
    ["schafter2"] = {"Benefactor Schafter", 51000, ""},
    ["dubsta"] = {"Benefactor Dubsta", 64000, ""},
    ["dubsta2"] = {"Benefactor Dubsta SE", 75000, ""},
    ["dubsta3"] = {"Benefactor Dubsta 6x6", 82000, ""},
    ["serrano"] = {"Benefactor Serrano", 55000, ""},
    ["xls"] = {"Benefactor XLS", 70000, ""},
    ["patriot"] = {"Mammoth Patriot", 53000, ""},
    ["patriot2"] = {"Mammoth Patriot Limo", 78000, ""},
    ["baller"] = {"Gallivanter Baller", 50000, ""},
    ["baller2"] = {"Gallivanter Baller SE", 55000, ""},
    ["baller3"] = {"Gallivanter Baller LE", 58000, ""},
    ["baller4"] = {"Gallivanter Baller LE LWB", 60000, ""},
    ["habanero"] = {"Emperor Habanero", 37000, ""},
    ["fq2"] = {"Fathom FQ 2", 21000, ""},
    ["surfer2"] = {"BF Surfer", 14000, ""},
    ["surfer"] = {"BF Surfer Restored", 32000, ""},
    ["landstalker"] = {"Dundreary Landstalker", 47000, ""},
  },

  ["Civilian Trailers"] = {
    _config = {map_entity = {"PoI", {blip_id = 479, blip_color = 4, marker_id = 27}}},
    ["boattrailer"] = {"Boat Trailer", 5000, ""},
    ["trailersmall"] = {"Utility Trailer", 2500, ""},
  },

  ["taxi"] = {
    _config = {map_entity = {"PoI", {blip_id = 56, blip_color = 5, marker_id = 27}}, permissions = {"taxi.vehicle"} },
    ["taxi"] = {"Taxi",100,""}
  },

  ["Attack-A-Taco"] = {
    _config = {map_entity = {"PoI", {marker_id = 27}}, permissions = {"taco.vehicle"} },
    ["taco"] = {"Attack-A-Taco Food Truck",100,""}
  },

  ["Union Depository"] = {
    _config = {map_entity = {"PoI", {marker_id = 27}}, permissions = {"bank.vehicle"} },
    ["stockade"] = {"Armored Bank Truck",100,""}
  },

  ["LSPD"] = {
    _config = {map_entity = {"PoI", {marker_id = 27}}, permissions = {"LSPD.vehicle"} },
    -- WIP
  },

  ["BCSO"] = {
    _config = {map_entity = {"PoI", {marker_id = 27}}, permissions = {"BCSO.vehicle"} },
    -- WIP
  },

  ["SASP"] = {
    _config = {map_entity = {"PoI", {marker_id = 27}}, permissions = {"SASP.vehicle"} },
    -- WIP
  },

  ["Helipad"] = {
    _config = {map_entity = {"PoI", {marker_id = 27}}, permissions = {"police.heli"} },
    ["polmav"] = {"Maverick Helicopter",250000, ""},  
  },

  ["Fire Department"] = {
    _config = {map_entity = {"PoI", {marker_id = 27}}, permissions = {"emergency.vehicle"} },
    -- WIP
  },

  ["Emergency boats"] = {
    _config = {map_entity = {"PoI", {blip_id = 427, blip_color = 4, marker_id = 27}}, permissions = {"police.vehicle"} },
    ["predator"] = {"Predator",0, "police"},
	  ["seashark2"] = {"Lifeguard Seashark",0, "EMS"},
  },

  ["bicycles"] = {
    _config = {map_entity = {"PoI", {blip_id = 226, blip_color = 4, marker_id = 27}}},
    ["bmx"] = {"BMX", 150, ""},
    ["cruiser"] = {"Beach Cruiser", 100, ""},
    ["tribike2"] = {"Endurex Race Bike", 250, ""},
    ["fixter"] = {"Fixter", 200, ""},
    ["scorcher"] = {"Scorcher Mountain Bike", 300, ""},
    ["tribike3"] = {"Tri-Cycles Race Bike", 275, ""},
    ["tribike"] = {"Whippet Race Bike", 300, ""},
  },

  ["boats"] = {
    _config = {map_entity = {"PoI", {marker_id = 27}}},
    ["dinghy"] = {"Dinghy", 50000, "A zodiac."},
    ["dinghy2"] = {"Dinghy II", 50000, "A zodiac."},
    ["dinghy3"] = {"Dinghy III", 50000, "A zodiac."},
    ["dinghy4"] = {"Dinghy IV", 50000, "A zodiac."},
    ["marquis"] = {"Marquis", 250000, "A yacht."},
    ["seashark"] = {"Seashark", 9000, "A jet ski."},
    ["seashark3"] = {"Seashark III", 9000, "A jet ski."},
    ["speeder"] = {"Speeder", 600000, "A fast boat."},
    ["speeder2"] = {"Speeder II", 600000, "A fast boat."},
    ["squalo"] = {"Squalo", 600000, "A fast boat."},
    ["jetmax"] = {"JetMax", 600000, "A fast boat."},
    ["toro"] = {"Toro", 600000, "A fast boat."},
    ["toro2"] = {"Toro II", 600000, "A fast boat."},
    ["tropic"] = {"Tropic", 600000, "A fast boat."},
    ["tropic2"] = {"Tropic II", 600000, "A fast boat."},
    ["suntrap"] = {"Suntrap", 250000, "Pleasure boat."},
    ["submersible"] = {"Submersible",1000000, "Sub"},
    ["submersible2"] = {"Kraken",1500000, "sub"},
  },

  ["planes"] = {
    _config = {map_entity = {"PoI", {blip_id = 307, blip_color = 4, marker_id = 27}}, permissions = {"pilot.whitelisted"} },
    ["velum"] = {"Velum", 500000, "Propeller plane."},
    ["velum2"] = {"Velum II", 500000, "Propeller plane."},
    ["stunt"] = {"Stunt", 250000, "Small propeller plane."},
    ["mammatus"] = {"Mammatus", 250000, "Small propeller plane."},
    ["dodo"] = {"Dodo", 250000, "Small propeller plane."},
    ["duster"] = {"Duster", 105000, "Old propeller plane."},
    ["cuban800"] = {"Cuban 800", 250000, "Small propeller plane."},
    ["luxor"] = {"Luxor", 3500000, "Private jet."},
    ["luxor2"] = {"Luxor II", 5000000, "Private jet."}
  },

  ["helicopters"] = {
    _config = {map_entity = {"PoI", {blip_id = 43, blip_color = 4, marker_id = 27}}, permissions = {"pilot.whitelisted"} },
    ["maverick"] = {"Maverick", 150000, "Basic chopper."},
    ["swift"] = {"Swift", 550000, "Fast chopper."},
    ["swift2"] = {"Swift II", 550000, "Fast chopper."},
    ["supervolito"] = {"Super Volito", 850000, "Fast chopper."},
    ["supervolito2"] = {"Super Volito II", 850000, "Fast chopper."},
    ["volatus"] = {"Volatus", 3500000, "Top of the line chopper."}
  },

  ["transport"] = {
    _config = {map_entity = {"PoI", {marker_id = 27}}},
    ["mule2"] = {"Maibatsu Mule", 50000, ""},
    ["benson"] = {"Vapid Benson", 70000, ""},
    ["pounder"] = {"MTL Pounder", 90000, ""},
    ["hauler"] = {"Jobuilt Hauler", 100000, ""},
    ["packer"] = {"MTL Packer", 125000, ""},
    ["phantom"] = {"Jobuilt Phantom", 150000, ""},
    ["phantom3"] = {"Jobuilt Phantom Custom", 175000, ""},
  },

  ["containers"] = {
    _config = {map_entity = {"PoI", {marker_id = 27}}},
    ["trailers"] = {"Basic", 30000, "Medium container."},
    ["tanker"] = {"Tanker", 300000, "Big container."},
    ["tr2"] = {"Car Hauler", 20000, "Car Trailer."}
  },

  ["tow"] = {
    _config = {map_entity = {"PoI", {marker_id = 27}}, permissions={"tow.vehicle"} },
    ["flatbed"] = {"Basic Flatbed", 1000, "tow"},
  },

  ["GoPostal"] = {
    _config = {map_entity = {"PoI", {marker_id = 27}}, permissions = {"postal.vehicle"} },
    ["boxville2"] = {"GoPostal Van",150,""}
  },

  ["PostOps"] = {
    _config = {map_entity = {"PoI", {marker_id = 27}}, permissions = {"postops.vehicle"} },
    ["boxville4"] = {"PostOps Van",150,""}
  },
}

-- {garage_type,x,y,z}
cfg.garages = {
  {"PostOps",-425.00814819336,6129.6879882813,31.47833442688},
  {"GoPostal",65.810043334961,119.59355163574,79.106971740723},
  {"Luxury Autos",-765.53240966797,-244.70407104492,37.247955322266},
  {"Mosley Auto Service",-48.168132781982,-1685.6123046875,29.464202880859},
  {"Sanders Motorcycles",260.38748168945,-1156.0574951172,29.275060653687},
  {"Premium Deluxe Motorsport",-52.560230255127,-1112.8394775391,26.449216842651},
  {"Larrys RV Sales",1224.8697509766,2709.771484375,38.005779266357},
  {"Vapid Dealership",-222.83110046387,-1163.7462158203,23.015302658081},
  {"Benefactor Dealership",-97.15771484375,91.175216674805,71.785308837891},

  {"taxi",908.72912597656,-176.1830291748,74.182678222656},

  {"LSPD",449.82241821289,-1013.9649658203,28.488388061523},
  {"BCSO",-468.97213745117,6038.6674804688,31.340539932251},
  {"SASP",860.04498291016,-1350.3395996094,26.066228866577},

  {"Helipad",449.09732055664,-981.26141357422,43.691661834717}, -- Mission Row
  {"Helipad",-466.79919433594,5981.0209960938,33.205085754395}, -- paleto SO
  {"Helipad",313.45788574219,-1465.4332275391,46.509490966797}, -- Crusade Medical

  {"Emergency boats",-849.89434814453,-1367.5648193359,1.6051679849625}, -- LS

  {"Fire Department",1200.7218017578,-1494.0347900391,34.692577362061}, -- El Burro Hieghts FD

  {"bicycles",-352.038482666016,-109.240043640137,38.6970825195313},
  {"boats",-849.89434814453,-1367.5648193359,1.6051679849625}, -- LS
  {"planes",-971.09014892578,-2999.0270996094,13.945075035095}, --LSIA
  {"planes",1741.4787597656,3278.1618652344,41.102363586426}, --Sandy
  {"helicopters",-745.34118652344,-1468.5938720703,5.0005254745483}, --heli tours
  {"helicopters",1770.1314697266,3239.7880859375,42.123035430908},
  {"containers",818.30346679688,-3219.6208496094,5.8987922668457},
  {"transport",844.35461425781,-3220.556640625,5.898561000824},
  {"tow",-192.27067565918,-1385.7940673828,31.133335113525},

  {"Rental Cars",-972.4208984375,-2703.8754882813,13.865050315857},

  {"bicycles",-1000.6048583984,-2750.6235351563,13.756634712219},
  {"bicycles",217.78094482422,-868.26208496094,30.492092132568},
  {"bicycles",761.19653320313,-1222.9936523438,25.029844284058},
  {"bicycles",-891.54754638672,-804.41003417969,15.921191215515},

  {"Union Depository",-33.919010162354,-672.04534912109,32.338108062744},
  {"Attack-A-Taco",458.88845825195,-1229.7338867188,30.037857055664},

  {"Civilian Trailers",395.1852722168,-1158.3721923828,29.291767120361},
  {"Blackmarket Cars",936.64514160156,-1515.1156005859,30.94871711731},

  {"Bus Rental Teir One",466.67367553711,-589.13763427734,28.450071334839},
  {"Bus Rental Teir Two",466.67367553711,-589.13763427734,28.450071334839},
  {"Bus Rental Teir Three",466.67367553711,-589.13763427734,28.450071334839},
  {"Bus Rental Teir One",-195.24685668945,6216.7421875,31.489255905151},
  {"Bus Rental Teir Two",-195.24685668945,6216.7421875,31.489255905151},
  {"Bus Rental Teir Three",-195.24685668945,6216.7421875,31.489255905151},
  {"Bus Rental Teir One",1624.685546875,3571.0495605469,35.146278381348},
  {"Bus Rental Teir Two",1624.685546875,3571.0495605469,35.146278381348},
  {"Bus Rental Teir Three",1624.685546875,3571.0495605469,35.146278381348},
}

return cfg

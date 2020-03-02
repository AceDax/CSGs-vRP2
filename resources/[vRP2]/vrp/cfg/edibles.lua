
local cfg = {}

cfg.action_delay = 2 -- seconds, delay between two edible consume actions

cfg.solid_sound = "sounds/eating.ogg"
cfg.liquid_sound = "sounds/drinking.ogg"

-- (see vRP.EXT.Edible:defineEdible)
-- map of id => {type, effects, name, description, weight}
--- type
---- default types: liquid, solid, drug
--- effects: map of effect => value
---- default effects: water (0-1), food (0-1), health (0-100)
--- name, description, weight: same as item
cfg.edibles = {
  --=====|======|=====--
  --=====|Drinks|=====--
  --=====|======|=====--
  water = {"liquid", {water = 0.30}, "Water bottle","", 0.5},
  milk = {"liquid", {water = 0.10}, "Milk","", 0.5},
  tea = {"liquid", {water = 0.08}, "Tea","", 0.2},
  icetea = {"liquid", {water = 0.08}, "ice-Tea","", 0.5},
  orangejuice = {"liquid", {water = 0.10}, "Orange Juice.","", 0.5},
  ecola = {"liquid", {water = 0.05}, "E-Cola","", 0.3},
  sprunk = {"liquid", {water = 0.05}, "Sprunk","", 0.3},
  redgull = {"liquid", {water = 0.03}, "RedGull","", 0.3},
  lemonlimonad = {"liquid", {water = 0.10}, "Lemon limonad","", 0.3},
  --=====|===|=====--
  --=====|Food|=====--
  --=====|===|=====--
  bread = {"solid", {food = 0.1}, "Bread","", 0.5},
  donut = {"solid", {food = 0.15}, "Donut","", 0.2},
  tacos = {"solid", {food = 0.2}, "Tacos","", 0.2},
  tacos2 = {"solid", {food = 0.01}, "Attack-A-Tacos","", 0.2},
  sandwich = {"solid", {food = 0.25}, "Sandwich","A tasty snack.", 0.5},
  kebab = {"solid", {food = 0.45}, "Kebab","", 0.85},
  prison = {"solid", {food = 0.01, water = 0.01}, "Prison Food","Its what you would expect,...barely edible.", 1.0},
  --=====|=======|=====--
  --=====|Alcohol|=====--
  --=====|=======|=====--
  vodka = {"alcohol", {health = 0.0}, "Vodka","", 0.5},
  screwdriver = {"alcohol", {health = 0.0}, "Screwdriver","", 0.5},
  bloodymary = {"alcohol", {health = 0.0}, "Bloody Mary","", 0.5},
  wrussian = {"alcohol", {health = 0.0}, "White Russian","", 0.5},
  mmartini = {"alcohol", {health = 0.0}, "Mexican Martini","", 0.5},
  mqueen = {"alcohol", {health = 0.0}, "Marble Queen","", 0.5},
  tsunrise = {"alcohol", {health = 0.0}, "Tequila Sunrise","", 0.5},
  mcoffee = {"alcohol", {health = 0.0}, "Mexican Coffee","", 0.5},
  pcolada = {"alcohol", {health = 0.0}, "Piña Colada","", 0.5},
  afizz = {"alcohol", {health = 0.0}, "Autumn Fizz","", 0.5},
  rum = {"alcohol", {health = 0.0}, "Rum", "", 0.5},
  crum = {"alcohol", {health = 0.0}, "E-Cola and Rum", "", 0.5},
  gin = {"alcohol", {health = 0.0}, "Gin", "", 0.5},
  tequila = {"alcohol", {health = 0.0}, "Tequila", "", 0.5},
  Tsec = {"alcohol", {health = 0.0}, "Triple Sec", "", 0.5},
  longtea = {"alcohol", {health = 0.0}, "Long Island Ice Tea", "", 0.5},
  margarita = {"alcohol", {health = 0.0}, "Margarita", "", 0.5},
  sake = {"alcohol", {health = 0.0}, "Saké", "", 0.5},
  forty = {"alcohol", {health = 0.0}, "Forty", "", 0.5},
  b151 = {"alcohol", {health = 0.0}, "Barcardi 151", "", 0.5},
  whiskey = {"alcohol", {health = 0.0}, "Whiskey", "", 0.5},
  scotch = {"alcohol", {health = 0.0}, "Scotch", "", 0.5},
  bourbon = {"alcohol", {health = 0.0}, "Bourbon", "", 0.5},
  coffee = {"coffee", {water = 0.3}, "Coffee", "", 0.2},
  --=====|=====|=====--
  --=====|Fruit|=====--
  --=====|=====|=====--
  peach = {"solid", {food = 0.1, water = 0.1}, "Peach","A peach.", 0.15},
  --=====|============|=====--
  --=====|Home Kitchen|=====--
  --=====|============|=====--
  breakfast1 = {"solid", {food = 0.01, water = -0.5}, "Breakfast","This meal is completely burt up! You are lucky you didn't set your house on fire.", 0.2},
  breakfast2 = {"solid", {food = 0.1, water = -0.2}, "Breakfast","This meal has some charring around the edges and doen't taste the best but at least you didn't set your smoke alarm off this time.", 0.2},
  breakfast3 = {"solid", {food = 0.3}, "Breakfast","Nothing is burnt this time but the flavor is still lacking something you just don't know what.", 0.2},
  breakfast4 = {"solid", {food = 0.5}, "Breakfast","A well balanced meal that tastes great.", 0.2},
  breakfast5 = {"solid", {food = 0.9, water = 0.3}, "Breakfast","A meal fit for royalty, only an amazing chef could pull something like this off.", 0.2},
  lunch1 = {"solid", {food = 0.01, water = -0.5}, "Lunch","This meal is completely burt up! You are lucky you didn't set your house on fire.", 0.2},
  lunch2 = {"solid", {food = 0.1, water = -0.2}, "Lunch","This meal has some charring around the edges and doen't taste the best but at least you didn't set your smoke alarm off this time.", 0.2},
  lunch3 = {"solid", {food = 0.3}, "Lunch","Nothing is burnt this time but the flavor is still lacking something you just don't know what.", 0.2},
  lunch4 = {"solid", {food = 0.5}, "Lunch","A well balanced meal that tastes great.", 0.2},
  lunch5 = {"solid", {food = 0.9, water = 0.3}, "Lunch","A meal fit for royalty, only an amazing chef could pull something like this off.", 0.2},
  dinner1 = {"solid", {food = 0.01, water = -0.5}, "Dinner","This meal is completely burt up! You are lucky you didn't set your house on fire.", 0.2},
  dinner2 = {"solid", {food = 0.1, water = -0.2}, "Dinner","This meal has some charring around the edges and doen't taste the best but at least you didn't set your smoke alarm off this time.", 0.2},
  dinner3 = {"solid", {food = 0.3}, "Dinner","Nothing is burnt this time but the flavor is still lacking something you just don't know what.", 0.2},
  dinner4 = {"solid", {food = 0.5}, "Dinner","A well balanced meal that tastes great.", 0.2},
  dinner5 = {"solid", {food = 0.9, water = 0.3}, "Dinner","A meal fit for royalty, only an amazing chef could pull something like this off.", 0.2},
  pancake = {"solid", {food = 0.2}, "Pancake","A pancake.", 0.1},
  eggs = {"solid", {food = 0.2}, "Eggs","Scrambled or Sunnyside up?", 0.1},
  bacon = {"solid", {food = 0.2}, "Bacon","", 0.1},
  waffle = {"solid", {food = 0.2}, "Waffle","A waffle.", 0.1},
  cereal = {"solid", {food = 0.2, water = 0.1}, "Cereal","Milk and cereal when all else fails.", 0.1},
  tuna = {"solid", {food = 0.2}, "Tuna Sandwich",".", 0.1},
  pbj = {"solid", {food = 0.2}, "PB&J Sandwich","", 0.1},
  hamcheese = {"solid", {food = 0.2}, "Ham & Cheese Sandwich","", 0.1},
  grillcheese = {"solid", {food = 0.2}, "Grilled Cheese Sandwich","", 0.1},
  blt = {"solid", {food = 0.2}, "BLT Sandwich","", 0.1},
  bbqchicken = {"solid", {food = 0.2}, "BBQ Chicken","", 0.1},
  steak = {"solid", {food = 0.2}, "Homecooked Steak","", 0.1},
  lasagna = {"solid", {food = 0.3, water = 0.0}, "Lasagna","", 0.2},
  tv = {"solid", {food = 0.2}, "TV Dinner","When all else fails.", 0.1},
  spaghetti = {"solid", {food = 0.2}, "Spaghetti","", 0.1},
  meatstew = {"liquid", {food = 0.5, water = 0.5}, "Venison Stew","Hunted and Home cooked.", 0.2},
  shark = {"solid", {food = 0.6}, "Shark Steak","Hand caught and Home cooked.", 0.2},
  turtle = {"liquid", {food = 0.5, water = 0.5}, "Turtle Stew","Hand caught and Home cooked.", 0.2},
  --=====|=======|=====--
  --=====|Drugs|=====--
  --=====|=======|=====--
  pills = {"drug", {health = 25}, "Pills","A simple medication.", 0.1},
  bandage = {"bandage", {health = 5}, "Bandage","A simple bandage.", 0.01},
  cigarette = {"cig", {health = 0.0}, "Cigarette","", 0.01},
  rolly = {"weed", {health = 0.0}, "Rolling Paper","", 0.01},
  meth = {"meth", {health = 0.0}, "Crystal Meth","", 0.01},
  cocaine = {"cocaine", {health = 0.0}, "Cocaine","", 0.01},
}

return cfg

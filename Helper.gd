extends Node

func format_number(number):
    var string = str(number)
    var mod = string.length() % 3
    var res = ""

    for i in range(0, string.length()):
        if i != 0 && i % 3 == mod:
            res += " "
        res += string[i]

    return res

var recipes = {
  "wood-saw": {
    "consumes": ["logs"],
    "produces": ["planks"],
    "input_rate": 1,
    "output_rate": 2
   },
 "blueberry-club": {
    "consumes": ["blueberries"],
    "produces": ["blueberry-smoothie"],
    "input_rate": 1,
    "output_rate": 1
   },
  "basic-axe": {
    "consumes": ["sticks", "stones"],
    "produces": ["basic-axe"],
    "input_rate": 1,
    "output_rate": 1
   },
  "basic-pickaxe": {
    "consumes": ["logs", "stones"],
    "produces": ["basic-pickaxe"],
    "input_rate": 1,
    "output_rate": 1
   },
  "forester": {
    "consumes": ["basic-axe"],
    "produces": ["logs"],
    "input_rate": 1,
    "output_rate": 2
   },
  "farmer": {
    "consumes": ["water"],
    "produces": ["corn", "potatoes"],
    "input_rate": 1,
    "output_rate": 1
   },
  "bakery": {
    "consumes": ["potatoes"],
    "produces": ["bread"],
    "input_rate": 2,
    "output_rate": 1
   },
  "basic-miner": {
    "consumes": ["basic-pickaxe"],
    "produces": ["iron"],
    "input_rate": 1,
    "output_rate": 1
   },
  "hammer": {
    "consumes": ["logs", "iron"],
    "produces": ["hammer"],
    "input_rate": 1,
    "output_rate": 1
   },
  "sword-production": {
    "consumes": ["logs", "iron"],
    "produces": ["sword"],
    "input_rate": 2,
    "output_rate": 1
   },
  "shovel": {
    "consumes": ["logs", "iron"],
    "produces": ["shovel"],
    "input_rate": 2,
    "output_rate": 1
   },
  "pickaxe": {
    "consumes": ["logs", "iron"],
    "produces": ["pickaxe"],
    "input_rate": 2,
    "output_rate": 1
   },
  "rake": {
    "consumes": ["logs", "iron"],
    "produces": ["rake"],
    "input_rate": 2,
    "output_rate": 1
   },
  "miner": {
    "consumes": ["pickaxe"],
    "produces": ["coal"],
    "input_rate": 1,
    "output_rate": 1
   },
  "dynamite-factory": {
    "consumes": ["coal", "stones", "raspberries", "potatoes", "water"],
    "produces": ["dynamite"],
    "input_rate": 2,
    "output_rate": 1
   },
  "advanced-miner": {
    "consumes": ["dynamite"],
    "produces": ["gold"],
    "input_rate": 2,
    "output_rate": 1
   },
  "golden-sword-production": {
    "consumes": ["gold", "sword"],
    "produces": ["golden-sword"],
    "input_rate": 3,
    "output_rate": 1
   }
 }

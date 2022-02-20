extends Node

onready var inventory_item = preload("res://Inventory/InventoryItem.tscn")

var inventory_list_control : Control

var stone_auto_crafter_throughput = 1
var stick_auto_crafter_throughput = 1

var inventory = {
  "coins": {
    "count": 0,
    "visible": false,
    "short": "C",
    "type": "",
    "name": "Coins",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "stones": {
    "visible": false,
    "name": "Stones",
    "image": "stone.png",
    "count": 0,
    "worth": 1,
    "short": "Sto",
    "type": "Raw",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
  },
  "sticks": {
    "visible": false,
    "name": "Sticks",
    "image": "stick.png",
    "count": 0,
    "worth": 1,
    "short": "Sti",
    "type": "Raw",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "logs": {
    "visible": false,
    "name": "Logs",
    "image": "logs.png",
    "count": 0,
    "worth": 3,
    "short": "Logs",
    "type": "Goods",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "blueberries": {
    "visible": false,
    "name": "Blueberries",
    "image": "blueberry.png",
    "count": 0,
    "worth": 2,
    "short": "BlueB",
    "type": "Raw",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "strawberries": {
    "visible": false,
    "name": "Strawberries",
    "image": "strawberry.png",
    "count": 0,
    "worth": 2,
    "short": "StrawB",
    "type": "Raw",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "cherries": {
    "visible": false,
    "name": "Cherries",
    "image": "cherry.png",
    "count": 0,
    "worth": 2,
    "short": "Cherr",
    "type": "Raw",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "blackberries": {
    "visible": false,
    "name": "Blackberries",
    "image": "blackberry.png",
    "count": 0,
    "worth": 2,
    "short": "Blackberry",
    "type": "Raw",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "raspberries": {
    "visible": false,
    "name": "Raspberries",
    "image": "raspberry.png",
    "count": 0,
    "worth": 2,
    "short": "Raspberry",
    "type": "Raw",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "blueberry-smoothie": {
    "visible": false,
    "name": "Blueberry Smoothie",
    "image": "blueberry_smoothie.png",
    "count": 0,
    "worth": 2,
    "short": "BBS",
    "type": "Goods",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "basic-axe": {
    "visible": false,
    "name": "Basic Axe",
    "image": "axe.png",
    "count": 0,
    "worth": 5,
    "short": "BA",
    "type": "Tools",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "planks": {
    "visible": false,
    "name": "Planks",
    "image": "plank.png",
    "count": 0,
    "worth": 5,
    "short": "Plank",
    "type": "Goods",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "water": {
    "visible": false,
    "name": "Water",
    "image": "water.png",
    "count": 0,
    "worth": 0,
    "short": "Water",
    "type": "Raw",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "potatoes": {
    "visible": false,
    "name": "Potatoes",
    "image": "potato.png",
    "count": 0,
    "worth": 1,
    "short": "Potatoes",
    "type": "Raw",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "corn": {
    "visible": false,
    "name": "Corn",
    "image": "corn.png",
    "count": 0,
    "worth": 1,
    "short": "Corn",
    "type": "Raw",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "bread": {
    "visible": false,
    "name": "Potatoe Bread",
    "image": "bread.png",
    "count": 0,
    "worth": 4,
    "short": "Bread",
    "type": "Goods",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "basic-pickaxe": {
    "visible": false,
    "name": "Basic Pickaxe",
    "image": "basic_pickaxe.png",
    "count": 0,
    "worth": 2,
    "short": "Basic Pickaxe",
    "type": "Tools",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "iron": {
    "visible": false,
    "name": "Iron",
    "image": "iron.png",
    "count": 0,
    "worth": 1,
    "short": "Iron",
    "type": "Raw",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "hammer": {
    "visible": false,
    "name": "Hammer",
    "image": "hammer.png",
    "count": 0,
    "worth": 5,
    "short": "Hammer",
    "type": "Tools",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "sword": {
    "visible": false,
    "name": "Sword",
    "image": "sword.png",
    "count": 0,
    "worth": 5,
    "short": "Sword",
    "type": "Tools",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "shovel": {
    "visible": false,
    "name": "Shovel",
    "image": "shovel.png",
    "count": 0,
    "worth": 5,
    "short": "Shovel",
    "type": "Tools",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "rake": {
    "visible": false,
    "name": "Rake",
    "image": "rake.png",
    "count": 0,
    "worth": 5,
    "short": "Rake",
    "type": "Tools",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "pickaxe": {
    "visible": false,
    "name": "Pickaxe",
    "image": "pickaxe.png",
    "count": 0,
    "worth": 5,
    "short": "Pickaxe",
    "type": "Tools",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "coal": {
    "visible": false,
    "name": "Coal",
    "image": "coal.png",
    "count": 0,
    "worth": 1,
    "short": "Coal",
    "type": "Raw",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "dynamite": {
    "visible": false,
    "name": "Dynamite",
    "image": "dynamite.png",
    "count": 0,
    "worth": 5,
    "short": "Dynamite",
    "type": "Goods",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
    "gold": {
    "visible": false,
    "name": "Gold",
    "image": "gold.png",
    "count": 0,
    "worth": 5,
    "short": "Gold",
    "type": "Raw",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   },
  "golden-sword": {
    "visible": false,
    "name": "Golden Sword",
    "image": "kings_sword.png",
    "count": 0,
    "worth": 10,
    "short": "Golden Sword",
    "type": "Tools",
    "in": 0,
    "out": 0,
    "in_buff": 0,
    "out_buff": 0
   }
}

func get(type):
  return inventory[type]["count"]
  
func get_worth(type):
  return inventory[type]["worth"]
  
func visible(type):
  return inventory[type]["visible"]
  
func short(type):
  return inventory[type]["short"]

func name(type):
  return inventory[type]["name"]

func type(type):
  return inventory[type]["type"]
  
func in_buff(type):
  return inventory[type]["in_buff"]

func out_buff(type):
  return inventory[type]["out_buff"]

func increase(type, amount = 1):
  inventory[type]["in"] += amount

  if type != "coins" && (amount <= 0 || (inventory_count() + amount) > Targets.max_inventory_worth):
    return
    
  if !inventory[type]["visible"]:
    inventory[type]["visible"] = true
    
    if type != "coins":
      add_item(type, inventory[type]["name"], inventory[type]["image"], inventory[type]["type"])
    
  inventory[type]["count"] += amount

func decrease(type, amount = 1):
  inventory[type]["out"] += amount
  if get(type) >= amount:
    inventory[type]["count"] -= amount
    return true
  else:
    return false

func craft_stone_auto_crafter():
  decrease("stones", Targets.stone_auto_crafter_price)

  
func craft_stick_auto_crafter():
  decrease("stones", Targets.stick_auto_crafter_price)

func inventory_count():
  var temp_count = 0
  
  for item in inventory.keys():
    if item != "coins":
      temp_count += get(item)
    
  return temp_count
  
func render_throughput():
  for item in inventory.keys():
    inventory[item]["in_buff"] = inventory[item]["in"]
    inventory[item]["out_buff"] = inventory[item]["out"]
    inventory[item]["in"] = 0
    inventory[item]["out"] = 0

func add_item(identifier, item_name, image, type):
  var temp_item = inventory_item.instance()
  temp_item.name = identifier
  temp_item.item_name = item_name
  temp_item.identifier = identifier
  temp_item.item_image = load("res://Sprites/Resources/" + image)
  
  var target = inventory_list_control.get_node(type).get_child(0).get_child(0)
  target.add_child(temp_item)
  inventory_list_control.current_tab = inventory_list_control.get_node(type).get_index()

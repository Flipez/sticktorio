extends Node

signal new_target_log_message

var interaction_player : AudioStreamPlayer

var money_visible = false

var max_employment = 4
var cur_employment = 0

var employment_stage = 1
var max_inventory_worth = 1200
var inventory_stage = 1
var inventory_upgrade_offered = false
var cave_upgrade_offered = false

var stone_auto_crafter = false
var stone_auto_crafter_price = 20

var stick_auto_crafter = false
var stick_auto_crafter_price = 100

var kings_count = 0

var kings_cup = false
var kings_medal = false
var kings_sword = false
var kings_crown = false

var wood_saw = false
var blueberry_club = false
var basic_axe = false
var forester = false
var farmer = false
var bakery = false
var basic_pickaxe = false
var basic_mining = false
var hammer = false
var blacksmith_knowledge = false
var miner = false
var advanced_mining = false
var dynamite_factory = false
var golden_sword = false

var inventory_visible = false
var trading_visible = false
var main_control : Control
var production_control : Control
var employment_control : Control
var trade_control : Control
var trade_control_item_list : VBoxContainer

var reset_offered = false

var employee_tab_hidden = true
var production_tab_hidden = true

var smoothie_booster_visible = false
var smoothie_booster_enabled = false

onready var trade_item = preload("res://Trading/TradeItem.tscn")
onready var activate_sound = preload("res://Sounds/switch.wav")

func play_sound(stream, volume = -5):
  interaction_player.volume_db = volume
  interaction_player.stream = stream
  interaction_player.play()
  
func play_ui_sound():
  interaction_player.stream = activate_sound
  interaction_player.play()

func validate_targets():
  if !stone_auto_crafter && Inventory.get("stones") >= 20:
    emit_signal("new_target_log_message", "Looks like people are willing to help you for some stones!")
    stone_auto_crafter = true
    employee_tab_hidden = false
    employment_control.add_item("stones", "Stones", "stone.png", "stones", 1, 20, "stones")

  if !stick_auto_crafter && Inventory.get("stones") >= 100:
    emit_signal("new_target_log_message", "Looks like more people are willing to help you for some stones!")
    stick_auto_crafter = true
    employment_control.add_item("sticks", "Sticks", "stick.png", "sticks", 1, 100, "stones")
    
  if !blueberry_club && Inventory.get("blueberries") > 50:
    blueberry_club = true
    add_trade_item("blueberry-club", "Blueberry Club", "club.png", 350, "coins")
    
  if !smoothie_booster_visible && Inventory.get("blueberry-smoothie") > 50:
    smoothie_booster_visible = true

  if !trading_visible && Inventory.get("stones") > 200:
    trading_visible = true
    emit_signal("new_target_log_message", "The trading guy appeared, he probably has interesting stuff!")
    
  if !money_visible && Inventory.get("coins") > 0:
    money_visible = true
    
  if Inventory.inventory_count() >= max_inventory_worth * 0.95 && !inventory_upgrade_offered:
    add_trade_item("inventory-upgrade", "Inventory Upgrade", "inventory_upgrade.png", max_inventory_worth * 2, "coins")
    inventory_upgrade_offered = true
    
  if cur_employment == max_employment && cave_upgrade_offered == false:
    cave_upgrade_offered = true
    add_trade_item("cave-upgrade", "Cave Upgrade", "cave_upgrade.png", max_employment * 1000, "coins")
    
  if max_employment >= 16 && employment_stage == 1:
    employment_stage += 1
    emit_signal("new_target_log_message", "Some villages will collect random berries from the forest!")
    employment_control.add_item("berries", "Berries", "blueberry.png", ["blueberries", "raspberries", "blackberries"], 1, 250, "coins")

  if !basic_axe && Inventory.get("sticks") > 50:
    basic_axe = true
    add_trade_item("basic-axe", "Basic Axe Production", "axe.png", 500, "coins")

  if !forester && Inventory.get("basic-axe") > 20:
    forester = true
    add_trade_item("forester", "Forester", "logs.png", 500, "coins")
    
  if !basic_pickaxe && Inventory.get("logs") > 10:
    basic_pickaxe = true
    add_trade_item("basic-pickaxe", "Basic Pickaxe", "basic_pickaxe.png", 200, "coins")
    
  if !farmer && Inventory.get("blueberry-smoothie") >= 50:
    farmer = true
    employment_control.add_item("water-mill", "Water Mill", "water.png", ["water"], 1, 250, "coins")
    add_trade_item("farmer", "Basic Farmer", "farmer.png", 500, "coins")
    
  if !bakery && Inventory.get("potatoes") > 30:
    bakery = true
    add_trade_item("bakery", "Bakery", "bread.png", 500, "coins")
    
  if !basic_mining && Inventory.get("basic-pickaxe") > 40:
    basic_mining = true
    add_trade_item("basic-miner", "Basic Miner", "basic_pickaxe.png", 500, "coins")
    
  if !kings_cup && Inventory.get("iron") > 200:
    kings_cup = true
    add_trade_item("kings-cup", "Kings Cup", "kings_cup.png", 5000, "coins")
    add_trade_item("hammer", "Hammer Production", "hammer.png", 500, "coins")
    add_trade_item("wood-saw", "Wood Saw", "saw.png", 700, "coins")
    emit_signal("new_target_log_message", "You've found the Kings Cup while mining.")
    
  if !blacksmith_knowledge && Inventory.get("planks") > 200 && Inventory.get("hammer") > 100:
    blacksmith_knowledge = true
    add_trade_item("blacksmith-knowledge", "Blacksmith Knowledge", "knowledge.png", 2000, "hammer")
    emit_signal("new_target_log_message", "If a better blacksmith can build you more tools?")

  if !kings_medal && Inventory.get("rake") > 100:
    kings_medal = true
    add_trade_item("kings-medal", "Kings Medal", "kings_medal.png", 10000, "coins")
    emit_signal("new_target_log_message", "The Kings Medal! In the middle of you potatoe field!")
    
  if !miner && Inventory.get("pickaxe") > 200:
    miner = true
    add_trade_item("miner", "Miner", "pickaxe.png", 5000, "coins")
    
  if !dynamite_factory && Inventory.get("coal") > 200:
    dynamite_factory = true
    add_trade_item("dynamite-factory", "Dynamite Factory", "dynamite.png", 10000, "coins")
    
  if !advanced_mining && Inventory.get("dynamite") > 200:
    advanced_mining = true
    add_trade_item("advanced-miner", "Advanced \"Miner\"", "advanced_mining.png", 10000, "coins")
    add_trade_item("kings-crown", "Kings Crown", "kings_crown.png", 10000, "gold")
    emit_signal("new_target_log_message", "You've found the Kings Cup deep in the mines, how likely was that?")

  if !golden_sword && Inventory.get("gold") > 200:
    golden_sword = true
    add_trade_item("golden-sword-production", "Golden Sword Production", "kings_sword.png", 7000, "coins")

  if !kings_sword && Inventory.get("golden-sword") > 200:
    kings_sword = true
    add_trade_item("kings-sword", "Kings Sword", "kings_sword.png", 100000, "coins")
    emit_signal("new_target_log_message", "While building golden swords, you blacksmith accidentially has build the Kings Sword!")
    
  if !reset_offered && kings_count >= 2:
    reset_offered = true
    main_control.offer_reset()

func add_trade_item(identifier, item_name, image, price, currency):
  var temp_item = trade_item.instance()
  temp_item.identifier = identifier
  temp_item.item_name = item_name
  temp_item.price = price
  temp_item.currency = currency
  temp_item.item_image = load("res://Sprites/Resources/" + image)
  trade_control_item_list.add_child(temp_item)
  temp_item.connect("item_bought", production_control, "item_bought")

func reset_game():
  for item in Inventory.inventory.keys():
    Inventory.inventory[item]["count"] = 0
  employment_control.reset()
  production_control.reset()
  cur_employment = 0

  if randi() % 2:
    return
    
  main_control.increase_timer()

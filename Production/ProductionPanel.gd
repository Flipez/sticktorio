extends Tabs

onready var production_item = preload("res://Production/ProductionItem.tscn")
onready var recipe_preload = preload("res://Production/Recipe.gd")

func _process(_delta):
  if get_parent().get_tab_hidden(1) != Targets.production_tab_hidden:
    get_parent().set_tab_hidden(1, Targets.production_tab_hidden)
    if !Targets.production_tab_hidden:
      get_parent().current_tab = 1


func item_bought(item):
  if item.identifier == "inventory-upgrade":
    Targets.inventory_upgrade_offered = false
    Targets.inventory_stage += 1
    Targets.max_inventory_worth *= 2
  elif item.identifier == "cave-upgrade":
    Targets.max_employment = (item.price / 1000) * 4
    Targets.cave_upgrade_offered = false
  elif item.identifier == "kings-cup":
    Targets.kings_count += 1
  elif item.identifier == "kings-medal":
    Targets.kings_count += 1
  elif item.identifier == "kings-crown":
    Targets.kings_count += 1
  elif item.identifier == "kings-sword":
    Targets.kings_count += 1
  elif item.identifier == "blacksmith-knowledge":
    Targets.add_trade_item("sword-production", "Sword Production", "sword.png", 2000, "coins")
    Targets.add_trade_item("shovel", "Shovel Production", "shovel.png", 3000, "coins")
    Targets.add_trade_item("pickaxe", "Pickaxe Production", "pickaxe.png", 1000, "coins")
    Targets.add_trade_item("rake", "Rake Production", "rake.png", 500, "coins")
  else:
    Targets.production_tab_hidden = false
    add_item(item.identifier, item.item_name, item.item_image, recipe_preload.new().use(item.identifier), false, item.currency, item.price)
    Targets.cur_employment += 1
    Targets.max_employment += 1
    get_parent().current_tab = 1

func tick():
   for item in $ScrollContainer/VBoxContainer.get_children():
     item.tick()
    
func reset():
  for item in $ScrollContainer/VBoxContainer.get_children():
    item.production_count = 0

func add_item(identifier, item_name, image, recipe, active, currency, price):
  var temp_item = production_item.instance()
  temp_item.name = identifier
  temp_item.item_name = item_name
  temp_item.identifier = identifier
  temp_item.item_image = image
  temp_item.recipe = recipe
  temp_item.active = active
  temp_item.currency = currency
  temp_item.price = price
  $ScrollContainer/VBoxContainer.add_child(temp_item)

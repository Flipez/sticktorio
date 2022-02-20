extends Panel

onready var tab_sound = preload("res://Sounds/tab_click.wav")


func _process(_delta):
  $ScoreLabel.text = "%s / %s" % [Helper.format_number(Inventory.inventory_count()), Helper.format_number(Targets.max_inventory_worth)]
  $ProgressBar.max_value = Targets.max_inventory_worth
  $ProgressBar.value = Inventory.inventory_count()

  if Inventory.inventory_count() > Targets.max_inventory_worth * 0.95:
    $ScoreLabel.set("custom_colors/font_color", Color(255,0,0,1))
  else:
    $ScoreLabel.set("custom_colors/font_color", Color(1,1,1,1))

func tick():
  for item in $TabContainer/Goods/ScrollContainer/VBoxContainer.get_children():
    item.tick()
  for item in $TabContainer/Raw/ScrollContainer/VBoxContainer.get_children():
    item.tick()
  for item in $TabContainer/Tools/ScrollContainer/VBoxContainer.get_children():
    item.tick()

func _on_TabContainer_tab_selected(_tab):
  Targets.play_sound(tab_sound)

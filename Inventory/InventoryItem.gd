extends HBoxContainer

export var identifier : String
export var item_name : String
export var item_image : Texture

func _ready():
  $NameLabel.text = item_name
  $TextureRect.texture = item_image
  
  for i in range(50):
    var new = $Control.get_child(0).duplicate(8)
    new.rect_position.x = i
    $Control.add_child(new)

func _process(_delta):
  var count = count()
  $CountLabel.text = Helper.format_number(count)
  $Button.hint_tooltip = "Sell all %s %s for %s coins" % [Helper.format_number(count), item_name, Helper.format_number(count * Inventory.get_worth(identifier))]
  $Button.visible = Targets.trading_visible

func tick():
  $ThroughputLabel.text = "(%s in / %s out)  " % [Inventory.in_buff(identifier), Inventory.out_buff(identifier)]
  set_graph()

func set_graph():
  var pgs = $Control.get_children()
  var max_value = Inventory.in_buff(identifier)
  
  for i in pgs:
    if i.value > max_value:
      max_value = i.value

  for pg in pgs:
    if max_value > 0:
      pg.max_value = max_value
    var cur_index = pg.get_index()
    if cur_index + 1 < pgs.size():
      pg.value = pgs[cur_index + 1].value
    elif cur_index + 1 == pgs.size():
      pg.value = Inventory.out_buff(identifier)

func worth():
  return count() * Inventory.get_worth(identifier)

func count():
  return Inventory.get(identifier)

func _on_Button_pressed():
  Inventory.increase("coins", worth())
  Inventory.decrease(identifier, count())
  Targets.play_ui_sound()

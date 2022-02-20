extends HBoxContainer

export var identifier : String
export var item_name : String
export var item_image : Texture
export var price : int
export var currency : String
export var produces = []
export var output_rate : int
export var employment_count : int
var output_modifier = 1

func _ready():
  $TextureRect.texture = item_image
  employment_count = 0
  render_label()
  var disp_name = Inventory.name(currency)
  $HireButton.text = "Hire! (%s %s)" % [price, disp_name]
  $HireButton.hint_tooltip = "Hire one %s Collector for %s %s" % [item_name, price, disp_name]
  $FireButton.hint_tooltip = "Fire one %s Collector. You will not get you resources back." % item_name

func _process(_delta):
  $HireButton.disabled = (Targets.cur_employment >= Targets.max_employment) || Inventory.get(currency) < price
  $FireButton.disabled = employment_count == 0

func tick():
  render_label()
  if Targets.smoothie_booster_enabled:
    output_modifier = 2
    Inventory.decrease("blueberry-smoothie", 1)
  else:
    output_modifier = 1
  for _i in range(employment_count):
    if typeof(produces) == TYPE_ARRAY:
      randomize()
      Inventory.increase(produces[randi() % produces.size()], output_rate * output_modifier)
    else:
      Inventory.increase(produces, output_rate * output_modifier)

func render_label():
  $Label.text = "%s Collector: %s" % [item_name, employment_count]
  $ThroughputLabel.text = "(%s out)" % (output_rate * employment_count * output_modifier)

func _on_HireButton_pressed():
  Inventory.decrease(currency, price)
  employment_count += 1
  Targets.cur_employment += 1
  render_label()
  Targets.play_ui_sound()


func _on_FireButton_pressed():
  employment_count -= 1
  Targets.cur_employment -= 1
  render_label()
  Targets.play_ui_sound()

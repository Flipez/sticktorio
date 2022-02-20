extends HBoxContainer

export var item_name : String
export var identifier : String
export var currency : String
export var price : int
export var item_image : Texture
var recipe : Node
export var active : bool
export var production_count = 1

func _ready():
  $TextureRect.texture = item_image
  $Label.text = item_name
  hint_tooltip = "Converts %s to %s on a %s:%s ratio per second" % [recipe.consumes, recipe.produces, recipe.input_rate, recipe.output_rate]
  
  var disp_name = Inventory.name(currency)
  $HireButton.text = "Hire! (%s %s)" % [price, disp_name]
  $HireButton.hint_tooltip = "Hire one %s for %s %s" % [item_name, price, disp_name]
  $FireButton.hint_tooltip = "Fire one %s. You will not get you resources back." % item_name

func render_label():
  $Label.text = "%s: %s" % [item_name, production_count]
  $ThroughputLabel.text = "(%s in / %s out)" % [recipe.input_rate * production_count ,recipe.output_rate * production_count]

func _process(_delta):
  $CheckBox.pressed = active
  $HireButton.disabled = (Targets.cur_employment >= Targets.max_employment) || Inventory.get(currency) < price
  $FireButton.disabled = production_count <= 1

func tick():
  render_label()
  var all_available = true
  if active:
    for _i in range(production_count):
      for item in recipe.consumes:
        if !Inventory.decrease(item, recipe.input_rate):
          all_available = false
      if all_available:
        $Label.set("custom_colors/font_color", Color(1,1,1,1))
        for item in recipe.produces:
          Inventory.increase(item, recipe.output_rate)
      else:
        $Label.set("custom_colors/font_color", Color(200,0,0,1))


func _on_HireButton_pressed():
  Inventory.decrease(currency, price)
  Targets.cur_employment += 1
  production_count += 1
  Targets.play_ui_sound()

func _on_FireButton_pressed():
  production_count -= 1
  Targets.cur_employment -= 1
  Targets.play_ui_sound()

func _on_CheckBox_pressed():
  active = !active
  Targets.play_ui_sound()

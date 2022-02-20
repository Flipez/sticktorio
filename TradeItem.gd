extends HBoxContainer

export var identifier : String
export var item_name : String
export var price : int
export var currency : String
export var item_image : Texture

signal item_bought

func _ready():
  $Label.text = "%s (%s %s)" % [item_name, Helper.format_number(price), Inventory.short(currency)]
  $TextureRect.texture = item_image

func _process(_delta):
  $Button.disabled = (Inventory.get(currency) < price)

func _on_Button_button_up():
  if Inventory.get(currency) >= price:
    Inventory.decrease(currency, price)
    emit_signal("item_bought", self)
    Targets.play_ui_sound()
    queue_free()

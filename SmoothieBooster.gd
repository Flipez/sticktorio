extends HBoxContainer

func _process(_delta):
  visible = Targets.smoothie_booster_visible
  $CheckButton.pressed = Targets.smoothie_booster_enabled


func _on_CheckButton_pressed():
  Targets.smoothie_booster_enabled = !Targets.smoothie_booster_enabled

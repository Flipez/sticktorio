extends Control


func _on_Timer_timeout():
  var _return = get_tree().change_scene("res://MainControl.tscn")

func _process(_delta):
  if Input.is_action_just_pressed("mouse_click"):
    _on_Timer_timeout()

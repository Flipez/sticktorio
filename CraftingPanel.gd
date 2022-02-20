extends Panel

onready var tab_sound = preload("res://Sounds/tab_click.wav")

func _process(_delta):
  $ScoreLabel.text = "%s / %s" % [Targets.cur_employment, Targets.max_employment]
  $ProgressBar.max_value = Targets.max_employment
  $ProgressBar.value = Targets.cur_employment
  
  if Targets.max_employment == Targets.cur_employment:
    $ScoreLabel.set("custom_colors/font_color", Color(255,0,0,1))
  else:
    $ScoreLabel.set("custom_colors/font_color", Color(1,1,1,1))
  
func _on_TabContainer_tab_selected(_tab):
  Targets.play_sound(tab_sound)

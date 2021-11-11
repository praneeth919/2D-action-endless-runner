extends Button

export var next_scene = ""

func _on_Button_button_up():
	if next_scene != null:
		get_tree().change_scene(next_scene)

func _on_Button_button_down():
	$Sfx.play()

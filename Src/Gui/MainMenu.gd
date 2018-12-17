extends Control

func _ready():
	get_tree().paused = false
	# Update High Score
	$ScoreLabel2.text = str(Global.game_data.Player.high_score)

func _on_Quit_button_up():
	get_tree().quit()


func _on_Store_button_up():
	$Store.show()
	$VBoxContainer.hide()
	$ScoreLabel.hide()
	$ScoreLabel2.hide()
	$BackButton.show()


func _on_BackButton_button_up():
	if $Store.visible:
		$VBoxContainer.show()
		$BackButton.hide()
		$Store.hide()
		$ScoreLabel.show()
		$ScoreLabel2.show()

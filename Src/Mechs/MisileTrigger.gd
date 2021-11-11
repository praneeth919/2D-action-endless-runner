extends Node2D

var misile = preload("res://Src/Enemies/Misile.tscn")

func _ready():
	randomize()
	
func _on_VisibilityNotifier2D_screen_entered():
	var m = misile.instance()
	m.position.x = self.position.x + 2000
	m.position.y = self.position.y
	get_parent().add_child(m)
	

extends Node2D

func _ready():
	$AudioStreamPlayer.play()
	$ExpParti.emitting = true
	set_as_toplevel(true)

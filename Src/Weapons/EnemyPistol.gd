extends Node2D

var can_fire = true
var Projectile = preload("res://Src/Weapons/Projectile.tscn")

func _process(delta):
	if get_parent().get_parent().dead: # Grabd parent is the enemy observe scenre tree
		$Timer.stop()
		self.hide()
		
func shoot():
	if visible:
		# Start shoot timer and animation. Both have been synced. Check timeout function for shooting code
		if can_fire:
			can_fire = false
			$AnimationPlayer.play("shoot")
			$Timer.start()

func _on_Timer_timeout():
	can_fire = true
	$Sfx.play()
	var p = Projectile.instance()
	p.position = $Position2D.global_position #Spawn projectile at position node's position
	p.rotation = $Position2D.global_rotation# Rotate projectile via position 2d rotation which makes it moves backward
	get_parent().add_child(p) #Add projectile to the game world


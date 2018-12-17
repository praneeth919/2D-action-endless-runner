extends Node2D

var can_fire = true
var Projectile = preload("res://Src/Weapons/Projectile.tscn")

func _process(delta):
	if visible:
		if Input.is_action_pressed("shoot") and can_fire:
			can_fire = false
			$AnimationPlayer.play("shoot")
			var p = Projectile.instance()
			$Position2D.position.y = rand_range(-7,7) #lesser accuracy
			p.position = $Position2D.global_position
			owner.add_child(p) #Add projectile to the game world
			Global.player.screen_shake() #Cause Screen shake, Autoload
			$Sfx.play()
			
func _on_AnimationPlayer_animation_finished(_anim_name):
	can_fire = true
	
	

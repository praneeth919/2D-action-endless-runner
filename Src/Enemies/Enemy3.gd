extends KinematicBody2D

export var move_speed = 10
export var gravity = 500
var velocity = Vector2.ZERO
var dead = false
var rpg_dead = false
var can_run = 1
var explosion = preload("res://Src/Mechs/Explosion.tscn")
var coin = preload("res://Src/Mechs/Coins.tscn")
var hp = 3

func _physics_process(delta):
	# Gravity
	velocity.y += gravity * delta
	# limit velocity.y
	if velocity.y > gravity:
		velocity.y = gravity
	# To the left
	velocity.x -= move_speed * delta
	# limit velocity.x
	if velocity.x > move_speed:
		velocity.x = move_speed
	# Enable movement
	velocity = move_and_slide(velocity)

func on_hit():
	hp -= 1
	if hp <= 0:
		on_death()
func on_death():
	# Play death animation and delete fire particles and cause expvosion and screen shake
	dead = true
	Global.player.screen_shake() # Autoload
	$AnimatedSprite.play("death")
	$FireParti.queue_free()
	$CollisionShape2D.set_deferred("disabled", true)
	$PlayerDetector/CollisionShape2D.set_deferred("disabled", true)
	var e = explosion.instance()
	e.position = self.global_position
	get_parent() .add_child(e)
	set_physics_process(false)
	# Spawn coin
	var c = coin.instance()
	c.position =  self.position
	get_parent().call_deferred("add_child", c)

func _on_AnimatedSprite_animation_finished():
	# When animation is done turn dark
	if $AnimatedSprite.animation == "death":
		self.modulate = Color("474545")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_PlayerDetector_body_entered(body):
	# delete self from scene, cause player damage, spawn explosion and screen_shake
	if body.is_in_group("Player"):
		queue_free()
		body.on_hit()
		Global.player.screen_shake() # Autoload
		var e = explosion.instance()
		e.position = self.global_position
		get_parent() .add_child(e)
		

extends KinematicBody2D

var coin = preload("res://Src/Mechs/Coins.tscn")

export var move_speed = 100
export var gravity = 100
var velocity = Vector2.ZERO
var dead = false
var rpg_dead = false
var can_run = 1
var weapon_choice = 0

func _ready():
	randomize()
	# Chose weapon
	weapon_choice = int(rand_range(1,3))
	if weapon_choice == 1:
		$Weapons/EnemyPistol.show()
	else:
		$Weapons/EnemyAk47.show()
	can_run = int(rand_range(1,3))
	# Randomly chose to run or stand
	if can_run == 1:
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("idle")
		

func _physics_process(delta):
	# Gravity
	velocity.y += gravity * delta
	if velocity.y > gravity:
		velocity.y = gravity
	velocity = move_and_slide(velocity)

func on_hit():
	# Play death animation and delete weapon
	dead = true
	$AnimatedSprite.play("death")
	remove_from_group("Enemies") # Projectiles won't collide when dead
	# Spawn coin
	var c = coin.instance()
	c.position =  self.position
	get_parent().call_deferred("add_child", c)

func _on_AnimatedSprite_animation_finished():
	# When animation is done turn dark
	if $AnimatedSprite.animation == "death":
		self.modulate = Color("474545")


func _on_VisibilityNotifier2D_screen_entered():
	$Weapons/EnemyPistol.shoot()
	$Weapons/EnemyAk47.shoot()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

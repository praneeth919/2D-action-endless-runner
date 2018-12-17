extends KinematicBody2D

var coin = preload("res://Src/Mechs/Coins.tscn")
# Check animation player node. Float animation plays on ready

export var move_speed = 100
export var gravity = 80
var velocity = Vector2.ZERO
var dead = false
var knock_force = 10000
var dir = 0
var weapon_choice = 0


func _ready():
	randomize()
	# Chose weapon
	weapon_choice = int(rand_range(1,3))
	if weapon_choice == 1:
		$Weapons/EnemyPistol.show()
	else:
		$Weapons/EnemyAk47.show()
	# Decide to go up or down on ready
	dir = int(rand_range(1,3))
	if dir == 1:
		velocity.y += gravity 
	else:
		velocity.y -= gravity
	
func _physics_process(delta):
	# if not dead
	if !dead:
		# Move up and down 
		if is_on_ceiling():
			velocity.y *= -gravity * delta
		elif is_on_floor():
			velocity.y *= -gravity * delta
		# limit velocity.y else he'll phase off :)
		velocity.y  = clamp(velocity.y, -gravity, gravity)
	# if dead
	else:
		velocity.y = 0
		velocity.x += knock_force * delta # pushes enemy away with speed
	velocity.x = move_and_slide(velocity, Vector2.UP).x

func on_hit():
	# Play death animation and delete weapon
	dead = true
	$AnimatedSprite.play("death")
	$CollisionShape2D.set_deferred("disabled", true)
	# Spawn coin
	var c = coin.instance()
	c.position =  self.position
	get_parent().call_deferred("add_child", c)
	
func _on_AnimatedSprite_animation_finished():
	# When animation is done turn dark
	if $AnimatedSprite.animation == "death":
		self.modulate = Color("474545")


func _on_VisibilityNotifier2D_screen_entered():
	$Weapons/EnemyAk47.shoot()
	$Weapons/EnemyPistol.shoot()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

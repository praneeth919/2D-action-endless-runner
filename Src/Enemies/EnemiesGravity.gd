extends KinematicBody2D
class_name  EnemyGrav

var gravity = 1000
var velocity = Vector2.ZERO

func _physics_process(delta):
	# Gravity
	velocity.y += gravity * delta
	if velocity.y > gravity:
		velocity.y = gravity
	velocity = move_and_slide(velocity)

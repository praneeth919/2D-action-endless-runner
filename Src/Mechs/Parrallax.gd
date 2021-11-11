extends ParallaxLayer

export var move_speed = 10

func _process(delta):
	if get_parent().can_process:
		motion_offset.x -= move_speed * delta

extends ParallaxLayer

export var move_speed = 10

func _process(delta):
	# if parent can move then move. helps for stop and start of the bg scrolling
	if get_parent().can_process:
		motion_offset.x -= move_speed * delta

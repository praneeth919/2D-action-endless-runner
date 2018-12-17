extends StaticBody2D

func _process(delta):
	$CollisionShape2D.scale.x += 10

extends EnemyGrav

var explosion = preload("res://Src/Mechs/Explosion.tscn")


func _on_PlayerDetector_body_entered(body):
	# If collides with player: Player plays bomb_death animation, Tnt deletes itself and add explosion
	if body.is_in_group("Player"):
		self.queue_free()
		body.on_hit()
		body.bomb = true
		var e = explosion.instance()
		e.position = self.global_position
		get_parent().add_child(e)

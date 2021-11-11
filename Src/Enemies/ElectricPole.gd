extends EnemyGrav


func _on_PlayerDetector_body_entered(body):
	# If collides with player: Player plays bomb_death animation, Tnt deletes itself and add explosion
	if body.is_in_group("Player"):
		body.electricuted = true
		body.on_hit()

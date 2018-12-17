extends EnemyGrav


func _on_PlayerDetector_body_entered(body):
<<<<<<< HEAD
<<<<<<< HEAD
	# If collides with player: Player plays bomb_death animation, Tnt deletes itself and add explosion
=======
	# If collides with player: Player plays bomb_death animation. Tnt deletes itself and add explosion
>>>>>>> 2040d10 (added)
=======
	# If collides with player: Player plays bomb_death animation, Tnt deletes itself and add explosion
>>>>>>> cf47154 (added)
	if body.is_in_group("Player"):
		body.electricuted = true
		body.on_hit()

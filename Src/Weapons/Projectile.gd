extends Area2D

onready var anims = $AnimatedSprite
var speed = 500
var damage = 2
var explosion = preload("res://Src/Mechs/Explosion.tscn")
var can_exp = 0

func _ready():
	randomize()
	can_exp = rand_range(1,5)
	# Makes bullet not to be affected by parents transform
	self.set_as_toplevel(true)
	anims.play("ready")

func _process(delta):
  position += transform.x * speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Projectile_body_entered(body):
	if body.is_in_group("Player"):
		body.on_hit()
		body.bomb = true
		set_physics_process(false)
		$HitSfx.play()
		if can_exp <= 2:
			var e = explosion.instance()
			e.position = self.position
			get_parent().add_child(e)
	if body.is_in_group("Enemies"):
		body.on_hit()
		$HitSfx.play()
		set_physics_process(false)
		queue_free()
		if can_exp <= 2:
			var e = explosion.instance()
			e.position = self.position
			get_parent().add_child(e)

func _on_HitSfx_finished():
	queue_free()


func _on_Projectile_area_entered(area):
	if area.is_in_group("Projectiles"):
		area.queue_free()
		var e = explosion.instance()
		e.position = self.position
		get_parent().add_child(e)

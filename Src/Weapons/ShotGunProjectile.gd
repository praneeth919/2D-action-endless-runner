extends Area2D

onready var anims = $AnimatedSprite
var speed = 500
var damage = 2
var explosion = preload("res://Src/Mechs/Explosion.tscn")

func _ready():
	# Makes bullet not to be affected by parents transform
	self.set_as_toplevel(true)
	anims.play("ready")

func _process(delta):
  position += transform.x * speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_ShotGunProjectile_body_entered(body):
	if body.is_in_group("Player"):
		body.on_hit()
		body.bomb = true
		var e = explosion.instance()
		e.position = self.position
		get_parent().add_child(e)
	if body.is_in_group("Enemies"):
		body.on_death()
		var e = explosion.instance()
		e.position = self.position
		get_parent().add_child(e)


func _on_ShotGunProjectile_area_entered(area):
	if area.is_in_group("Projectiles"):
		area.queue_free()
		var e = explosion.instance()
		e.position = self.position
		get_parent().add_child(e)

extends Area2D

export var speed = 20
export var damage = 2
var explosion = preload("res://src/Mechs/Explosion.tscn")

var reflect = false

func _ready():
	# Makes bullet not to be affected by parents transform
	self.set_as_toplevel(true)
	
func _physics_process(delta):
	position -= transform.x * speed * delta
		
func on_death():
	queue_free()
	var e = explosion.instance()
	e.position = self.position
	get_parent().add_child(e)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_VisibilityNotifier2D_screen_entered():
	$Sprite2.hide()
	$Sfx.play()


func _on_Misile_body_entered(body):
	if body.is_in_group("Player"):
		on_death()
		body.on_hit()
		body.bomb = true
		set_physics_process(false)


func _on_Misile_area_entered(area):
	if area.is_in_group("Projectiles"):
		on_death()
		set_physics_process(false)

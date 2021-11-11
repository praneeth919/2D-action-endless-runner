extends KinematicBody2D

export var move_speed = 100
export var gravity = 100
export var jump_force = 100
var velocity = Vector2.ZERO
var dead = false
var e_dead = false
var gliding = false
var jump_no = 1
var hp = 3
var hit = false
var electricuted = false
var bomb = false
var coin = 0
var score = 0

func _ready():
	Global.player = self
	# Weapon equip. Check store code
	if Global.game_data.Player.weapon_equiped == 1:
		$Weapons/Pistol.show()
	if Global.game_data.Player.weapon_equiped == 2:
		$Weapons/Ak47.show()
	if Global.game_data.Player.weapon_equiped == 3:
		$Weapons/ShotGun.show()
	
func _physics_process(delta):
	velocity.y += gravity * delta
	if velocity.y > gravity:
		velocity.y = gravity
	get_input(delta)

		
func get_input(delta):
	if !dead:
		velocity.x += move_speed * delta
		velocity.x = clamp(velocity.x, -move_speed, move_speed)
	else:
		if !e_dead:
			velocity.x -= 1000 * delta
			$Camera2D.current = false
	
	if Input.is_action_just_pressed("jump") and is_on_floor() and jump_no < 2:
		velocity.y -= jump_force
		jump_no = 1
		$JumpSfx.play()
	elif Input.is_action_just_pressed("jump") and !is_on_floor() and jump_no < 2:
		jump_no = 2
		velocity.y -= jump_force
		$JumpSfx.play()
	# Controls jump and fall animations
	if !hit:
		if velocity.y < 0 and !is_on_floor():
			$AnimatedSprite.play("jump")
		elif velocity.y > 0 and !is_on_floor():
			$AnimatedSprite.play("fall")
		
	
	velocity = move_and_slide(velocity, Vector2.UP)

func on_hit():
	$AnimatedSprite.play("hit")
	hp -= 1
	hit = true
	$HitSfx.play()
	if hp == 2:
		$HudLayer/HpBar3.modulate = Color("580909")
	if hp == 1:
		$HudLayer/HpBar2.modulate = Color("580909")
	if hp <= 0:
		$HudLayer/HpBar.modulate = Color("580909")
		save_game_data()
		get_parent().get_node("HudLayer/Anchor/GameOver").show()
		get_parent().get_node("HudLayer/Anchor/PauseButton").hide()
		if bomb:
			on_death()
		elif electricuted:
			on_electric_death()
			
func on_death():
	dead = true
	get_parent().get_node("ParallaxBackground").can_process = false #Stop background movement
	$AnimatedSprite.play("bomb_death")

func on_electric_death():
	dead = true
	e_dead = true
	$Weapons.hide()
	$AnimatedSprite.play("electric_death")
	get_parent().get_node("ParallaxBackground").can_process = false #Stop background movement
	
func screen_shake():
	$Camera2D/ScreenShake.start()

func reset_stuff():
	score = 0
	coin = 0


func save_game_data():
	Global.game_data.Player.coins += int(coin)
	# High score mechanic
	if  score > Global.game_data.Player.high_score:
		get_parent().get_node("HudLayer/Anchor/GameOver/Score").text = "High Score :"
		Global.game_data.Player.high_score = score
	else:
		get_parent().get_node("HudLayer/Anchor/GameOver/Score").text = "Score :"

func _on_AnimatedSprite_animation_finished():
	# Fixes stuck on ground bug
	if $AnimatedSprite.animation == "run" and is_on_floor():
		jump_no = 1
	# if the player reaches the ground play run animation
	if $AnimatedSprite.animation == "fall" and is_on_floor():
		$AnimatedSprite.play("run")
		jump_no = 1
	if $AnimatedSprite.animation == "hit" and is_on_floor():
		$AnimatedSprite.play("run")
		hit = false
	elif $AnimatedSprite.animation == "hit" and !is_on_floor():
		hit = false
		if velocity.y < 0 :
			$AnimatedSprite.play("jump")
		elif velocity.y > 0:
			$AnimatedSprite.play("fall")
	
	# When animation is done stop player's movement
	if $AnimatedSprite.animation == "electric_death" and hp <= 0:
		velocity.x = 0
		get_tree().paused = true
	else:
		$AnimatedSprite.play("run")


func _on_VisibilityNotifier2D_screen_exited():
	get_tree().paused = true

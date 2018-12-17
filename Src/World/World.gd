extends Node2D

# loads scenes for instancing
var enemy1 = preload("res://Src/Enemies/Enemy1.tscn")
var enemy2 = preload("res://Src/Enemies/Enemy2.tscn")
var enemy3 = preload("res://Src/Enemies/Enemy3.tscn")
var tnt = preload("res://Src/Enemies/Tnt.tscn")
var e_pole = preload("res://Src/Enemies/ElectricPole.tscn")
var missile_trigger = preload("res://Src/Mechs/MisileTrigger.tscn")
var coin = preload("res://Src/Mechs/Coins.tscn")
var can_e2 = false # Can spawn enemy2
var can_e3 = false # Can spawn enemy3
var can_mt = false # Can spawn missile_trigger

var spawn_stuffs = 1
var dif_score = 0

func _ready():
	start()
	$SpawnTimer.wait_time = rand_range(1,5)
	$CoinSpawnTimer.wait_time = rand_range(1,5)
	
func _process(delta):
	update_stuff()
	
func start():
	$SpawnTimer.start()
	$CoinSpawnTimer.start()
	$ScoreTimer.start()

func spawner(): #Code for spawning enemies
	if spawn_stuffs == 1:
		var e1 = enemy1.instance()
		e1.position =  $Player/Position2D.global_position
		get_parent().add_child(e1)
	elif spawn_stuffs == 2:
		var t = tnt.instance()
		t.position = $Player/Position2D.global_position
		get_parent().add_child(t)
	elif spawn_stuffs == 3:
		var ep = e_pole.instance()
		ep.position =  $Player/Position2D.global_position
		get_parent().add_child(ep)
	elif spawn_stuffs == 4 and can_e2 == true:
		var e2 = enemy3.instance()
		e2.position =  $Player/Position2D.global_position
		get_parent().add_child(e2)
	elif spawn_stuffs == 5 and can_e3 == true:
		var e3 = enemy2.instance()
		e3.position =  $Player/Position2D.global_position
		get_parent().add_child(e3)
	elif spawn_stuffs == 6 and can_mt == true:
		var mt = missile_trigger.instance()
		mt.position.x =  $Player/Position2D.global_position.x
		mt.position.y =  rand_range(20, 120)
		get_parent().add_child(mt)
	else: # Just incase of a gap
		var e1 = enemy1.instance()
		e1.position =  $Player/Position2D.global_position
		get_parent().add_child(e1)
		
		
func update_stuff():
	$HudLayer/Anchor/ScoreLabel.text = str($Player.score)
	$HudLayer/Anchor/CoinLabel.text = str(int($Player.coin))
	$HudLayer/Anchor/GameOver/Coins2.text = str(int($Player.coin))
	$HudLayer/Anchor/GameOver/Score2.text = str($Player.score)
	
func _on_SpawnTimer_timeout():
	randomize()
	$SpawnTimer.wait_time = rand_range(1,6)
	spawner()
	# Base on score spawn enemies
	if $Player.score >= 0:
		spawn_stuffs = int(rand_range(1,4))
	if $Player.score >= 200:
		can_e2 = true
		spawn_stuffs = int(rand_range(1,5))
	if $Player.score >= 600:
		can_mt = true
		spawn_stuffs = int(rand_range(1,6))
	if $Player.score >= 1000:
		can_e3 = true
		spawn_stuffs = int(rand_range(1,7))
	
func _on_CoinSpawnTimer_timeout():
	randomize()
	$CoinSpawnTimer.wait_time = rand_range(1,5)
	var c = coin.instance()
	c.position.x =  $Player/Position2D.global_position.x
	c.position.y =  rand_range(20, 120)
	get_parent().add_child(c)


func _on_ScoreTimer_timeout():
	$Player.score += 1
	# Difficulty is base on enemies spawned the higher the score the more enemies get spawned and speed
	if $Player.score >= 100:
		$Player.move_speed = 110
		$SpawnTimer.wait_time = rand_range(1,5)
	if $Player.score >= 200:
		$SpawnTimer.wait_time = rand_range(1,4)
		$Player.move_speed = 120
	if $Player.score >= 400:
		can_e2 = true
		$Player.move_speed = 140
		$Player.gravity = 500
		$Player.jump_force = 200
		$SpawnTimer.wait_time = rand_range(1,3)
	if $Player.score >= 600:
		$Player.move_speed = 160
		$Player.gravity = 600
		$Player.jump_force = 260
		$SpawnTimer.wait_time = rand_range(1,2)
	if $Player.score >= 800:
		can_mt = true
		$Player.move_speed = 180
		$Player.gravity = 800
		$Player.jump_force = 280
	if $Player.score >= 1000:
		$Player.move_speed = 200
		$Player.gravity = 1000
		$Player.jump_force = 300
		can_e3 = true


func _on_RetryButton_button_up():
	get_tree().paused = false
	get_tree().reload_current_scene()
	Global.save_game()


func _on_ResumeButton_button_up():
	$HudLayer/Anchor/PauseMenu.hide()
	$HudLayer/Anchor/PauseButton.show()
	get_tree().paused = false

func _on_Quit_button_up():
	get_tree().quit()

func _on_PauseButton_button_up():
	$HudLayer/Anchor/PauseButton.hide()
	$HudLayer/Anchor/PauseMenu.show()
	get_tree().paused = true


func _on_MainMenu_button_up():
	get_tree().paused = false

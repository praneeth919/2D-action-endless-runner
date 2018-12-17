extends Area2D

var speed = 200
var target = null
var amount = 0
var up_speed = 10
export var magnet = true
export var min_amnt = 1
export var max_amnt = 3

func _ready():
	amount = int(rand_range(min_amnt,max_amnt))
	randomize()
		
func _on_Coins_body_entered(body):
	if body.is_in_group("Player"):
		body.coin += amount
		self.hide()
		$CoinSfx.play()


func _on_CoinSfx_finished():
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

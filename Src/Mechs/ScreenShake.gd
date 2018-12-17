extends Node2D

# High amp = smooth shake and vice versa

onready var tween = $Tween
onready var camera = get_parent()
onready var frequency = $FrequencyTimer

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

export var amplitude = 0
var duration: float = 0
var piority = 0

func _ready():
	$DurationTimer.wait_time = duration
	$FrequencyTimer.wait_time = duration
	
func start(duration = 0.2, frequency = 16, amplitude = 3, piority = 0):
	if piority == self.piority:
		amplitude = self.amplitude
		$DurationTimer.wait_time = duration
		self.frequency.wait_time = 1 / float(frequency)
		
		$DurationTimer.start()
		$FrequencyTimer.start()
		new_shake()
func stop():
	if tween.is_active():
		tween.set_active(false)
	
func new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	
	tween.interpolate_property(camera, "offset", camera.offset, rand, frequency.wait_time, TRANS, EASE)
	tween.start()

func reset():
	tween.interpolate_property(camera, "offset", camera.offset, Vector2(), frequency.wait_time, TRANS, EASE)
	tween.start()
	piority = 0


func _on_FrequencyTimer_timeout():
	new_shake()


func _on_DurationTimer_timeout():
	reset()
	frequency.stop()

extends ParallaxBackground

# Madefall animation 3s to avoid repetive animations
export var can_process = false

func _ready():
	if can_process:
		can_process = true
	

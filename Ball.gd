extends RigidBody2D

enum STATE {BASE, BOUNCE}
var holding = false
var ball_state = STATE.BASE
var initial_mouse
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if ball_state == STATE.BASE:
		if holding = true:
			$Arrow.show()
		else:
			$Arrow.hide()
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed == true:
				initial_mouse = get_global_mouse_position()
				holding = true
			elif event.pressed == false:
				holding = false

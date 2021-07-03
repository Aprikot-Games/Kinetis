extends RigidBody2D

enum STATE {BASE, BOUNCE}
var holding = false
var ball_state = STATE.BASE
var initial_mouse
var diff_vec = 0
var clamped_len = 0

func release():
	apply_central_impulse(diff_vec.normalized() * clamped_len)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if ball_state == STATE.BASE:
		if holding == true:
			$Arrow.show()
			diff_vec = -(get_global_mouse_position() - position)
			$Arrow.rotation = diff_vec.angle() + PI/2
			clamped_len = clamp(diff_vec.length(), 30, 300)
			$Arrow/ArrowBody.scale.y = clamped_len/5
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
				release()

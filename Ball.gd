extends RigidBody2D

enum STATE {RESIZE, LAUNCH, BOUNCE}
var holding = false
var ball_state = STATE.RESIZE
var initial_mouse
var diff_vec = 0
var clamped_len = 0

func release():
	if ball_state == STATE.LAUNCH:
		apply_central_impulse(diff_vec.normalized() * clamped_len * 5)
	if ball_state == STATE.RESIZE:
		ball_state = STATE.LAUNCH

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if ball_state == STATE.LAUNCH:
		if holding == true:
			$Arrow.show()
			diff_vec = -(get_global_mouse_position() - position)
			$Arrow.rotation = diff_vec.angle() + PI/2
			clamped_len = clamp(diff_vec.length(), 30, 300)
			$Arrow/ArrowBody.scale.y = clamped_len/5
		else:
			$Arrow.hide()
	elif ball_state == STATE.RESIZE:
		if holding == true:
			diff_vec = -(get_global_mouse_position() - position)
			var vec_len = clamp(diff_vec.length(), 30, 240)/60
			$Sprite.scale = Vector2(vec_len, vec_len)
			$CollisionShape2D.scale = $Sprite.scale
			$Arrow.offset.y = (vec_len * 18) + 16
			$Arrow/ArrowBody.position.y = vec_len * 18 + 16
			mass = vec_len
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

func _on_Ball_body_entered(body):
	if body.is_in_group("block"):
		body.queue_free()
		pass

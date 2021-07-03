extends RigidBody2D

enum STATE {RESIZE, LAUNCH, BOUNCE}
var holding = false
var ball_state = STATE.RESIZE
var initial_mouse
var diff_vec = 0
var clamped_len = 0
var ball_power = 3
var bounces = 3
const initial_pos = Vector2(255, 443)

signal ball_destroyed

var ball2_tex = preload("res://sprites/ball2.png")
var ball3_tex = preload("res://sprites/ball3.png")
var ball4_tex = preload("res://sprites/ball4.png")
var ball5_tex = preload("res://sprites/ball5.png")
var ball6_tex = preload("res://sprites/ball6.png")

var ball_texs = [ball2_tex, ball3_tex, ball4_tex, ball5_tex, ball6_tex]

func release():
	if ball_state == STATE.LAUNCH:
		apply_central_impulse(diff_vec.normalized() * clamped_len * 5)
		ball_state = STATE.BOUNCE
		$Arrow.hide()
	if ball_state == STATE.RESIZE:
		ball_state = STATE.LAUNCH

# Called when the node enters the scene tree for the first time.
func _ready():
	position = initial_pos

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
			mass = 1
			ball_power = 5 - (floor(vec_len)+1)
			print(ball_power)
	$Sprite.set_texture(ball_texs[ball_power])

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
		body.damage(1)
		pass
	bounces -= 1
	if bounces <= 0:
		ball_power-= 1
		bounces = 3
	if ball_power < 0:
		emit_signal("ball_destroyed")

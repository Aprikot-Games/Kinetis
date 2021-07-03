extends RigidBody2D

var block2_tex = preload("res://sprites/block2.png")
var block3_tex = preload("res://sprites/block3.png")
var block4_tex = preload("res://sprites/block4.png")
var block5_tex = preload("res://sprites/block5.png")
var block6_tex = preload("res://sprites/block6.png")

var block_texs = [block2_tex, block3_tex, block4_tex, block5_tex, block6_tex]

var block_pow = 5

func damage(power):
	block_pow = clamp(block_pow - power, 0, 5)
	if block_pow <= 0:
		queue_free()
	$Sprite.set_texture(block_texs[block_pow - 1])

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.set_texture(block_texs[block_pow - 1])

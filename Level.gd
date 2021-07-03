extends Node2D

export (PackedScene) var Block
export (PackedScene) var Ball

var player_ball

func create_new_ball():
	player_ball = Ball.instance()
	add_child(player_ball)
	player_ball.connect("ball_destroyed", self, "_on_ball_destroyed")

func _ready():
	create_new_ball()

func _on_ball_destroyed():
	player_ball.queue_free()
	create_new_ball()

class_name Coin
extends Area2D

onready var animation_player = $AnimationPlayer

func _on_body_entered(_body):
	animation_player.play("picked")
	_body.emit_signal("collect_coin")

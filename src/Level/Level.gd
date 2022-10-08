extends Node2D

#camara al iniciar el nivel

const LIMIT_LEFT = -315
const LIMIT_TOP = -350
const LIMIT_RIGHT = 955
const LIMIT_BOTTOM = 990

func _ready():
	for child in get_children():
		if child is Player:
			var camera = child.get_node("Camera")
			camera.limit_left = LIMIT_LEFT
			camera.limit_top = LIMIT_TOP
			camera.limit_right = LIMIT_RIGHT
			camera.limit_bottom = LIMIT_BOTTOM

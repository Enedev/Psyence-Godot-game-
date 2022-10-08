extends Control

func _unhandled_input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
		get_tree().set_input_as_handled()

onready var animacion = $AnimationPlayer

func _ready():
	animacion.play("anim")
	yield(animacion,"animation_finished")
	TRANSICION.change_scene_local("res://src/Main/main_menu.tscn")

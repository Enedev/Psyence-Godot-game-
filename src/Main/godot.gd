extends Control

#Animacion de logo de godot
onready var anim = $AnimationPlayer

func _unhandled_input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
		get_tree().set_input_as_handled()

func _ready():
	anim.play("desvanecerse")
	yield(anim,"animation_finished")
	TRANSICION.change_scene_local("res://src/Main/seedg.tscn")

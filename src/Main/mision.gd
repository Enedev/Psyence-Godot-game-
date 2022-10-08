extends Control

onready var animacion = $AnimationPlayer

func _unhandled_input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
		get_tree().set_input_as_handled()

func _physics_process(delta):
	animacion.play("planet")
	
func _on_Button_pressed():
	get_tree().get_nodes_in_group("sounds")[0].get_node("click").play()
	TRANSICION.change_scene_local("res://src/Main/Game.tscn")

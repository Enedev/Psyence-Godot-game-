extends CanvasLayer

#Game over y sus sonidos y botones
onready var Anim_title = $AnimationPlayer

func _unhandled_input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
		get_tree().set_input_as_handled()

func _ready():
	Anim_title.play("gameover")

func _on_RestartButton2_pressed():
	get_tree().get_nodes_in_group("sounds")[0].get_node("click").play()
	TRANSICION.change_scene_local("res://src/Main/Game.tscn")
	

func _on_QuitButton_pressed():
	get_tree().get_nodes_in_group("sounds")[0].get_node("click").play()
	TRANSICION.change_scene_local("res://src/Main/main_menu.tscn")

extends Control

onready var psyence = $VBoxContainer/AnimationPlayer

#reproduce la animacion del titulo
func _ready():
	psyence.play("psyence")

# Funcion que al presionar F11 pone la pantalla completa
func _unhandled_input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
		get_tree().set_input_as_handled()

#Funcion que cierra el juego al presionar salir
func _on_salir_pressed():
	#reproduce  el sonido 
	get_tree().get_nodes_in_group("sounds")[0].get_node("click").play()
	#Cierra el juego
	get_tree().quit()
#Funcion que te lleva al selector de niveles
func _on_empezar_pressed():
	#reproduce  el sonido
	get_tree().get_nodes_in_group("sounds")[0].get_node("click").play()
	#Cambia a la escena del juego 
	TRANSICION.change_scene_local("res://src/Main/mision.tscn")

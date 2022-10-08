extends CanvasLayer

onready var Anim_play : AnimationPlayer = $AnimationPlayer

#Esta funcion es la transiion 
func change_scene_local(path: String) -> void:
	layer = 0
	#fade in 
	Anim_play.play("fade_in")
	yield(Anim_play,"animation_finished")
	#cambio de escena
	get_tree().change_scene(path)
	#fade out
	Anim_play.play("fade_out")
	yield(Anim_play,"animation_finished")
	layer = -2

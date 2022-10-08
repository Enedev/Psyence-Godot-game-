extends Area2D

#portal y su animacion

export (String) var escena
onready var Anim_play : AnimationPlayer = $AnimationPlayer


func _on_portal_body_entered(body):
	if body.name == "Player":
		Anim_play.play("portal")
		yield(Anim_play,"animation_finished")
		TRANSICION.change_scene_local("res://src/Main/"+escena+".tscn")

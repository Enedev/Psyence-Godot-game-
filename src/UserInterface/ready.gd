extends CanvasLayer

#Ready al iniciar los niveles
onready var Anima_play : AnimationPlayer = $AnimationPlayer

#Esta funcion es la animacion 
func ready_local():
	layer = 0
	#animacion 
	Anima_play.play("ready")
	yield(Anima_play,"animation_finished")
	layer = -2

func _ready():
	Anima_play.play("ready")

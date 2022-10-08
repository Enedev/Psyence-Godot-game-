class_name Bullet
extends RigidBody2D

#Bala y su daño hacia los enemigos
onready var animation_player = $AnimationPlayer


func destroy():
	animation_player.play("destroy")


func _on_body_entered(body):
	if body is Enemy:
		body.destroy()
	pass


func _on_Bullet_body_entered(body):
	if body is Castor:
		body.destroy()
	pass # Replace with function body.

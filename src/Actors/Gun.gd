class_name Gun
extends Position2D

#Codigo de la pistola y de la velocidad de la bala
const BULLET_VELOCITY = 500.0
const Bullet = preload("res://src/Objects/Bullet.tscn")

onready var sound_shoot = $Shoot
onready var timer = $Cooldown

func shoot(direction = 1):
	if not timer.is_stopped():
		return false
	var bullet = Bullet.instance()
	bullet.global_position = global_position
	bullet.linear_velocity = Vector2(direction * BULLET_VELOCITY, 0)

	bullet.set_as_toplevel(true)
	add_child(bullet)
	sound_shoot.play()
	return true

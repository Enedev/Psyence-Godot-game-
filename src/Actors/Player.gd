class_name Player
extends Actor

signal collect_coin()

const FLOOR_DETECT_DISTANCE = 20.0

export(String) var action_suffix = ""
#Definicion de variables para la vida, las colisiones, los timers, los sonidos y los sprites.
onready var platform_detector = $PlatformDetector
onready var animation_player = $AnimationPlayer
onready var shoot_timer = $ShootAnimation
export var cooldownShoot = 0.3
onready var sprite = $Sprite
onready var sound_jump = $Jump
onready var gun = sprite.get_node(@"Gun")
onready var get_damage = true
export var cooldown = 1
onready var timer
var damage = false
var health : int = 100

#Control de camara
func _ready():
	var camera: Camera2D = $Camera
	if action_suffix == "_p1":
		camera.custom_viewport = $"../.."
	elif action_suffix == "_p2":
		var viewport: Viewport = $"../../../../ViewportContainer2/Viewport"
		viewport.world_2d = ($"../.." as Viewport).world_2d
		camera.custom_viewport = viewport
	timer = Timer.new()
	add_child(timer)
	timer.set_one_shot(true)
	timer.set_wait_time(cooldown)
	timer.connect("timeout", self, "_cooldown_finish")
	
	#Todo relacionado a las fisicas
func _physics_process(_delta):
	#Sonido del salto
	if Input.is_action_just_pressed("jump" + action_suffix) and is_on_floor():
		sound_jump.play()

	var direction = get_direction()

	var is_jump_interrupted = Input.is_action_just_released("jump" + action_suffix) and _velocity.y < 0.0
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)

	var snap_vector = Vector2.ZERO
	if direction.y == 0.0:
		snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE
	var is_on_platform = platform_detector.is_colliding()
	_velocity = move_and_slide_with_snap(
		_velocity, snap_vector, FLOOR_NORMAL, not is_on_platform, 4, 0.9, false
	)

	if direction.x != 0:
		if direction.x > 0:
			sprite.scale.x = 1
		else:
			sprite.scale.x = -1
	
	var is_shooting = false
	if Input.is_action_just_pressed("shoot" + action_suffix):
		is_shooting = gun.shoot(sprite.scale.x)

	var animation = get_new_animation(is_shooting)
	if animation != animation_player.current_animation and shoot_timer.is_stopped():
		if is_shooting:
			shoot_timer.start()
			
		animation_player.play(animation)

func get_direction():
	return Vector2(
		Input.get_action_strength("move_right" + action_suffix) - Input.get_action_strength("move_left" + action_suffix),
		-1 if is_on_floor() and Input.is_action_just_pressed("jump" + action_suffix) else 0
	)
# Velocidad de fisicas.
func calculate_move_velocity(
		linear_velocity,
		direction,
		speed,
		is_jump_interrupted
	):
	var velocity = linear_velocity
	velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		velocity.y *= 0.6
	return velocity

#Animaciones
func get_new_animation(is_shooting = false):
	var animation_new = ""
	if is_on_floor():
		if abs(_velocity.x) > 0.1:
			animation_new = "run"
		else:
			animation_new = "idle"
	else:
		if _velocity.y > 0:
			animation_new = "falling"
		else:
			animation_new = "jumping"
	if is_shooting:
		animation_new += "_weapon"
	if health <= 0:
		animation_new = "dead"
	if get_damage == false:
		animation_new = "damage"
	
	return animation_new
	
#Funcion para declarar el damage
func damage_player(damage):
	health -= damage 

#Funcion para recibir daño de todo lo que tenga collision en el grupo "enemy", para iniciar el cooldown de recibir daño, para el gameover, la animacion de daño.
func _on_HurtBox_area_entered(area):
	if area.get_parent().is_in_group("enemy") && get_damage:
		timer.start()
		damage_player(area.get_parent().damage)
		animation_player.play("damage")
		get_damage = false
		if health <= 0:
			yield(get_tree().create_timer(0.8), "timeout")
			TRANSICION.change_scene_local("res://src/UserInterface/GameOverScreen.tscn")

#Funcion para finalizar el cooldown de recibir daño
func _cooldown_finish():
	get_damage = true

extends Node2D

class_name Shooter

@onready var shoot_timer: Timer = $ShootTimer


@export var speed := 50.0
@export var life_span := 10.0
@export var bullet_key: ObjectFactory.BULLET_KEY
@export var shoot_delay := 0.7


var _can_shoot := true


func _ready():
	shoot_timer.wait_time = shoot_delay
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)


func shoot(dir: Vector2):
	if !_can_shoot:
		return

	_can_shoot = false
	ObjectFactory.create_bullet(
		dir,
		life_span,
		speed,
		bullet_key,
		global_position
	)

	shoot_timer.start()


func _on_shoot_timer_timeout():
	_can_shoot = true

class_name AttackMelee
extends Area2D


@export var damage := 1
@export var attack_speed := 1.0


@onready var animated_sprite_2d : AnimatedSprite2D = $AnimatedSprite2D


var flip_h : bool


func _ready():
	animated_sprite_2d.flip_h = flip_h


func setup(flip := false):
	flip_h = flip


func attack():
	pass
	
	
func _on_animation_finished():
	queue_free()

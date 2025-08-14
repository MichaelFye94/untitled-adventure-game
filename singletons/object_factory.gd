extends Node


enum BULLET_KEY {
	PLAYER,
	ENEMY
}

enum SCENE_KEY {
	ATTACK_BASE,
	PICKUP
}

const BULLET = {
	BULLET_KEY.PLAYER: preload("res://scenes/bullets/bullet_player/bullet_player.tscn")
	#BULLET_KEY.ENEMY: preload("res://scenes/bullets/bullet_enemy/bullet_enemy.tscn")
}

const SIMPLE_SCENES: = {
	SCENE_KEY.ATTACK_BASE: preload("res://scenes/actors/player/weapons/attack_melee_base.tscn"),
}


func add_child_deferred(child):
	get_tree().root.add_child(child)


func call_add_child(child):
	call_deferred("add_child_deferred", child)


func create_bullet(direction: Vector2, life_span: float ,speed: float, key: BULLET_KEY, start_pos: Vector2):
	var new_bullet = BULLET[key].instantiate() as Bullet
	new_bullet.setup(direction, life_span, speed)
	new_bullet.global_position = start_pos

	call_add_child(new_bullet)
	

func create_weapon_attack(start_pos: Vector2, flip_h := false):
	var new_attack = SIMPLE_SCENES[SCENE_KEY.ATTACK_BASE].instantiate() as AttackMelee
	new_attack.global_position = start_pos
	new_attack.setup(flip_h)
	
	call_add_child(new_attack)
	

func create_explosion(scene: PackedScene, start_pos: Vector2):
	var new_explosion = scene.instantiate() as Node
	new_explosion.global_position = start_pos
	
	call_add_child(new_explosion)
	

func create_simple_scene(scene: SCENE_KEY, start_pos: Vector2, flip_h := false):
	var new_scene = SIMPLE_SCENES[scene].instantiate()
	new_scene.global_position = start_pos

	call_add_child(new_scene)

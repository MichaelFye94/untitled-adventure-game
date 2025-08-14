class_name Bullet
extends Area2D


@onready var sprite_2d : AnimatedSprite2D = $Sprite2D
@onready var collision_shape_2d : CollisionShape2D = $CollisionShape2D


@export var explosion : PackedScene
@export var can_break_blocks := false


var _direction := Vector2.RIGHT
var _life_span := 20.0
var _lifetime := 0.0


func _ready():
	sprite_2d.flip_h = _direction.x < 0
	if _direction.x < 0:
		collision_shape_2d.position.x *= -1


func _process(delta):
	check_expired(delta)
	position += _direction * delta


func setup(dir: Vector2, life_span: float, speed: float):
	_direction = dir.normalized() * speed
	_life_span = life_span


func check_expired(delta: float):
	_life_span += delta
	if _lifetime > _life_span:
		queue_free()


func spawn_explosion():
	ObjectFactory.create_explosion(explosion, collision_shape_2d.global_position)
	
	
func destroy_tile(tileMap: TileMap):
	if not can_break_blocks:
		return
		
	var pos = tileMap.local_to_map(tileMap.to_local(collision_shape_2d.global_position))
	var data = tileMap.get_cell_tile_data(0, pos)
	if data and data.get_custom_data("weapon_open"):
		tileMap.set_cell(0, pos, 0, Vector2i(-1, -1))


func _on_area_entered(_area:Area2D):
	spawn_explosion()
	queue_free()


func _on_body_entered(tileMap: TileMap):
	spawn_explosion()
	destroy_tile(tileMap)
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

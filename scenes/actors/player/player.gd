class_name Player
extends CharacterBody2D


@onready var debug_label : Label = %Label
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var shooting_timer : Timer = $ShootingTimer
@onready var shooter : Shooter = $Shooter


const SPEED = 75.0
const FRICTION = 50.0
const JUMP_VELOCITY = -400.0

enum ANIMATION_KEYS {
	SHOOT,
	RUN_SHOOT,
	RUN,
	JUMP,
	IDLE
}

const ANIMATIONS := {
	ANIMATION_KEYS.SHOOT: "shoot",
	ANIMATION_KEYS.RUN_SHOOT: "run-shoot",
	ANIMATION_KEYS.RUN: "run",
	ANIMATION_KEYS.JUMP: "jump",
	ANIMATION_KEYS.IDLE: "idle"
}


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var shooter_initial_pos : Vector2
var can_shoot := true

# state
# Track if we're past the apex of the jump
# If not, then when airborne do not allow x-axis movement
var is_past_jump_apex := false


func _ready():
	shooter_initial_pos = shooter.position
	
	
func shoot():
	var facing = Vector2.LEFT if sprite.flip_h else Vector2.RIGHT
	shooter.shoot(facing)

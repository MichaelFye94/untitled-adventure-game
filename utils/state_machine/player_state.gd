class_name PlayerState
extends State


var player : Player

enum PLAYER_STATE_KEYS {
	IDLE,
	RUN,
	AIR,
	SHOOT
}

const PLAYER_STATES = {
	PLAYER_STATE_KEYS.IDLE: "Idle",
	PLAYER_STATE_KEYS.RUN: "Run",
	PLAYER_STATE_KEYS.AIR: "Air",
	PLAYER_STATE_KEYS.SHOOT: "Shoot"
}


# Called when the node enters the scene tree for the first time.
func _ready():
	await owner.ready
	
	player = owner as Player
	
	assert(player != null)
	
	
func handle_facing(dir: float):
	match dir:
		dir when dir < 0:
			player.sprite.flip_h = true
			player.shooter.position.x = player.shooter_initial_pos.x * -1
		dir when dir > 0:
			player.sprite.flip_h = false
			player.shooter.position.x = player.shooter_initial_pos.x
		_:
			pass
			

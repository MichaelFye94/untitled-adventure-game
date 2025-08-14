extends PlayerState


func enter(msg := {}):
	player.debug_label.text = "State: Idle"
	player.velocity = Vector2.ZERO
	player.sprite.play(player.ANIMATIONS[player.ANIMATION_KEYS.IDLE])


func physics_update(delta: float):
	if not player.is_on_floor():
		state_machine.transition_to(PLAYER_STATES[PLAYER_STATE_KEYS.AIR])
		return
		
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		state_machine.transition_to(PLAYER_STATES[PLAYER_STATE_KEYS.AIR], { do_jump = true })
	elif Input.get_axis("left", "right") != 0:
		state_machine.transition_to(PLAYER_STATES[PLAYER_STATE_KEYS.RUN])
	elif Input.is_action_just_pressed("attack"):
		player.shoot()
		state_machine.transition_to(PLAYER_STATES[PLAYER_STATE_KEYS.SHOOT])
	elif Input.is_action_just_pressed("melee"):
		var pos = player.shooter.global_position
		ObjectFactory.create_weapon_attack(pos, player.shooter.position.x < 0)

extends PlayerState


# Called when the node enters the scene tree for the first time.
func enter(msg := {}):
	player.debug_label.text = "State: Shoot"
	player.sprite.play(player.ANIMATIONS[player.ANIMATION_KEYS.SHOOT])
	if msg.has("shot"):
		player.sprite.set_frame_and_progress(2, 2)
	else:
		player.shooting_timer.start()
	if not player.shooting_timer.timeout.is_connected(on_shooting_timer_timeout):
		player.shooting_timer.timeout.connect(on_shooting_timer_timeout)


func physics_update(_delta):
	if Input.get_axis("left", "right") != 0:
		state_machine.transition_to(PLAYER_STATES[PLAYER_STATE_KEYS.RUN])
	if Input.is_action_just_pressed("attack"):
		player.shoot()
		player.sprite.play(player.ANIMATIONS[player.ANIMATION_KEYS.SHOOT])
		player.shooting_timer.start()



func on_shooting_timer_timeout():
	player.shooting_timer.timeout.disconnect(on_shooting_timer_timeout)
	if Input.get_axis("left", "right") != 0:
		state_machine.transition_to(PLAYER_STATES[PLAYER_STATE_KEYS.RUN])
	else:
		state_machine.transition_to(PLAYER_STATES[PLAYER_STATE_KEYS.IDLE])

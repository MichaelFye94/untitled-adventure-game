extends PlayerState


func enter(msg := {}):
	player.debug_label.text = "State: Run"
	if player.shooting_timer.is_stopped():
		player.sprite.play("run")
	else:
		player.sprite.play("run-shoot")
	if not player.shooting_timer.timeout.is_connected(switch_to_animation):
		player.shooting_timer.timeout.connect(switch_to_animation)
	
	
func physics_update(delta):
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
	
	var direction : float = (
		Input.get_action_strength("right", true)
		- Input.get_action_strength("left", true)
	)
	
	handle_movement(direction)
	
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.shooting_timer.timeout.disconnect(switch_to_animation)
		state_machine.transition_to(PLAYER_STATES[PLAYER_STATE_KEYS.AIR], { do_jump = true })
	elif Input.is_action_just_pressed("attack"):
		switch_to_animation(player.ANIMATIONS[player.ANIMATION_KEYS.RUN_SHOOT])
		player.shooting_timer.start()
		player.shoot()
	elif is_equal_approx(direction, 0.0):
		player.shooting_timer.timeout.disconnect(switch_to_animation)
		if player.shooting_timer.is_stopped():
			state_machine.transition_to(PLAYER_STATES[PLAYER_STATE_KEYS.IDLE])
		else:
			state_machine.transition_to(PLAYER_STATES[PLAYER_STATE_KEYS.SHOOT], { shot = true })
	

func switch_to_animation(animation: String = "run"):
	var current_anim_frame = player.sprite.frame
	var current_anim_progress = player.sprite.frame_progress
	player.sprite.play(animation)
	player.sprite.set_frame_and_progress(current_anim_frame, current_anim_progress)


func handle_movement(direction: float):
	var run = Input.is_action_pressed("run")
	player.sprite.speed_scale = 1 + int(run)
	
	if !is_equal_approx(direction, 0.0):
		var speed = player.SPEED * 2 if run else player.SPEED
		print("starting velocity x: " + str(player.velocity.x))
		player.velocity.x = move_toward(
			player.velocity.x,
			direction * speed,
			player.SPEED / 6
		)
		print("end velocity x: " + str(player.velocity.x))
	else:
		print("Slowing velocity...")
		player.velocity.x = move_toward(player.velocity.x, 0, player.FRICTION)
	player.move_and_slide()

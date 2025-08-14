extends PlayerState


var is_past_jump_apex := false
var update_ticks := 0


func enter(msg := {}):
	player.debug_label.text = "State: Air"
	if msg.has("do_jump"):
		player.velocity.y = player.JUMP_VELOCITY
		player.sprite.play(player.ANIMATIONS[player.ANIMATION_KEYS.JUMP])
		update_ticks = 0
		print("Reset air state update_ticks")


func physics_update(delta):
	var direction = Input.get_axis("ui_left", "ui_right")

	if not player.is_on_floor():
		player.debug_label.text = "State: Air\nNot on floor"
		player.velocity.y += player.gravity * delta
		is_past_jump_apex = player.velocity.y > 0
		
	if not is_past_jump_apex:
		player.debug_label.text = "State: Air\nnot On Floor and ascending"
		pass
	elif direction:
		player.debug_label.text = "State: Air\nDescending in direction"
		handle_facing(direction)
			
		player.velocity.x = move_toward(player.velocity.x, direction * player.SPEED, player.SPEED / 6)
	else:
		player.debug_label.text = "State: Air\nDescending"
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	
	if is_past_jump_apex and player.is_on_floor() and update_ticks > 0:
		if direction:
			state_machine.transition_to(PLAYER_STATES[PLAYER_STATE_KEYS.RUN])
		state_machine.transition_to(PLAYER_STATES[PLAYER_STATE_KEYS.IDLE])
	
	update_ticks += 1
	player.move_and_slide()

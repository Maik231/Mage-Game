extends PlayerState

var decelaration_factor : int = 0

func enter(old_state_name : String, data := {}) -> void:
	pass

func process(delta : float) -> void:
	pass

func physics_process(delta : float) -> void:
	move(delta)
	player.move_and_slide()
	
	if Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif not player.is_on_floor():
		finished.emit(FALLING)
	elif player.velocity == Vector2.ZERO:
		finished.emit(IDLE)

func move(delta : float) -> void:
	var direction = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = lerpf(player.velocity.x, player.SPEED * direction, minf(4 * delta, 1))
		decelaration_factor = 0
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, (decelaration_factor + player.DECELLERATION) * delta)
		decelaration_factor += 1000 * delta


func handle_input(event : InputEvent):
	pass

func exit() -> void:
	pass

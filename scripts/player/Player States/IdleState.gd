extends PlayerState

func enter(old_state_name : String, data := {}) -> void:
	pass

func process(delta : float) -> void:
	pass

func physics_process(delta : float) -> void:
	if Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif Input.get_axis("left", "right"):
		finished.emit(WALKING)
	elif not player.is_on_floor():
		finished.emit(FALLING)

func handle_input(event : InputEvent):
	pass

func exit() -> void:
	pass

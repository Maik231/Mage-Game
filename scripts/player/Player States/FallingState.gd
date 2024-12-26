extends PlayerState

@onready var walking_state = $"../WalkingState"

func enter(old_state_name : String, data := {}) -> void:
	if player.has_wings:
		finished.emit(WING)

func process(delta : float) -> void:
	pass

func physics_process(delta : float) -> void:
	apply_gravity(delta)
	walking_state.move(delta)
	player.move_and_slide()
	
	if player.is_on_floor():
		finished.emit(WALKING)

func apply_gravity(delta : float, gravity_factor : float = 1):
	player.velocity += player.get_gravity() * delta
	if player.velocity.y > player.TERMINAL_VELOCITY * gravity_factor:
		player.velocity.y = player.TERMINAL_VELOCITY * gravity_factor

func handle_input(event : InputEvent):
	pass

func exit() -> void:
	pass

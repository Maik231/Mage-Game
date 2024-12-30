extends PlayerState

@onready var walking_state = $"../WalkingState"
@onready var falling_state = $"../FallingState"

func enter(old_state_name : String, data := {}) -> void:
	if player.has_wings:
		finished.emit(PlayerStates.WING)
		return
	player.velocity.y = player.JUMP_VELOCITY

func process(delta : float) -> void:
	pass

func physics_process(delta : float) -> void:
	player.velocity += player.get_gravity() * delta / 2
	walking_state.move(delta)
	player.move_and_slide()
	
	if player.velocity.y >= 0 or not Input.is_action_pressed("jump"):
		finished.emit(PlayerStates.FALLING)

func handle_input(event : InputEvent):
	pass

func exit() -> void:
	pass

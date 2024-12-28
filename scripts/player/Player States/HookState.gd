extends PlayerState

var destination : Vector2

func enter(old_state_name : String, data := {}) -> void:
	destination = data["destination"]

func process(delta : float) -> void:
	pass

func physics_process(delta : float) -> void:
	if player.position.distance_to(destination) > 10:
		player.velocity = (destination - player.position).normalized() * player.hook.player_travel_speed
		player.move_and_slide()
	else:
		player.velocity = Vector2.ZERO

func handle_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		player.hook.end()
		finished.emit(FALLING)

func exit() -> void:
	pass

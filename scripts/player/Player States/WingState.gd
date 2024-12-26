extends PlayerState

var wing_time : float
@onready var falling_state = $"../FallingState"

func enter(old_state_name : String, data := {}) -> void:
	wing_time = 0

func process(delta : float) -> void:
	pass

func physics_process(delta : float) -> void:
	if Input.is_action_pressed("jump"):
		if wing_time < player.wing.fly_time:
			player.velocity.y = lerpf(player.velocity.y, player.wing.vertical_speed, minf(4 * delta, 1))
			wing_time += delta
		else:
			falling_state.apply_gravity(delta, 0.3)
	else:
		falling_state.apply_gravity(delta)
	
	var direction = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = lerpf(player.velocity.x, player.wing.horizontal_speed * direction, minf(4 * delta, 1))
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.DECELLERATION * delta)
	player.move_and_slide()
	
	if player.is_on_floor():
		finished.emit(WALKING)

func handle_input(event : InputEvent):
	pass

func exit() -> void:
	pass

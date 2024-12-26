extends Node
class_name StateMachine

@export var current_state : State

func _ready():
	if not current_state:
		current_state = get_child(0)
	
	for state : State in get_children():
		state.finished.connect(change_state)
	
	await owner.ready
	current_state.enter("")

func process(delta : float) -> void:
	current_state.process(delta)

func physics_process(delta : float) -> void:
	current_state.physics_process(delta)

func unhandled_input(event : InputEvent) -> void:
	current_state.handle_input(event)
	
func change_state(new_state : String, data : Dictionary = {}) -> void:
	if not has_node(new_state):
		print_debug("state not found " + new_state)
		return

	current_state.exit()
	var old_state_name = current_state.name
	current_state = get_node(new_state)
	current_state.enter(old_state_name, data)

extends Node
class_name State

signal finished(next_state_path: String, old_state_name : String, data : Dictionary)

func enter(old_state_name : String, data := {}) -> void:
	pass

func process(delta : float) -> void:
	pass

func physics_process(delta : float) -> void:
	pass

func handle_input(event : InputEvent):
	pass

func exit() -> void:
	pass

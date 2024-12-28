extends CharacterBody2D
class_name Player

const SPEED : int = 120
const JUMP_VELOCITY : int = -220
const DECELLERATION : int = SPEED * 3
const TERMINAL_VELOCITY : int = 400
var has_wings : bool = false
var wing : Wing
@export var hook : Hook

@onready var movement_state_machine : StateMachine = $MovementStateMachine

func _ready():
	wing = Wing.new()

func _process(delta : float) -> void:
	movement_state_machine.process(delta)

func _physics_process(delta : float) -> void:
	movement_state_machine.physics_process(delta)

func _unhandled_input(event : InputEvent) -> void:
	movement_state_machine.unhandled_input(event)

func _input(event):
	if event.is_action_pressed("hook"):
		hook.shoot()

class Wing:
	var horizontal_speed : int
	var vertical_speed : int
	var fly_time : float
	func _init():
		horizontal_speed = 240
		vertical_speed = -300
		fly_time = 2

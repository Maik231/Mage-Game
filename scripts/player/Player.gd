extends CharacterBody2D
class_name Player

const SPEED : int = 120 
const JUMP_VELOCITY : int = -220
const DECELLERATION : int = SPEED * 3
const TERMINAL_VELOCITY : int = 400
var has_wings : bool = false
var wing : Wing
@export var hook : Hook
@export var current_spell : SpellBase

@onready var movement_state_machine : StateMachine = $MovementStateMachine

func _ready():
	wing = Wing.new()
	hook.equip(self)

func _process(delta : float) -> void:
	movement_state_machine.process(delta)

func _physics_process(delta : float) -> void:
	if Input.is_action_pressed("use_spell"):
		current_spell.use_spell()
	if is_on_floor() and Input.is_action_pressed("down"):
		for i in get_slide_collision_count():
			var collision := get_slide_collision(i)
			if collision.get_collider().name == "Platforms":
				position.y += 1
				movement_state_machine.change_state(PlayerStates.FALLING)
	movement_state_machine.physics_process(delta)

func _unhandled_input(event : InputEvent) -> void:
	movement_state_machine.unhandled_input(event)

func _input(event : InputEvent):
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

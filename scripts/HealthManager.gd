extends Node

@export var max_hp : int
var current_hp : int
var invincible : bool = false
@export var invincible_time : float = 0.5

@onready var timer = $Timer

func _ready():
	current_hp = max_hp

func take_damage(damage : int):
	if invincible:
		return
	current_hp -= damage
	print("" + get_parent().name + ", " + str(current_hp) + "/" + str(max_hp))
	if current_hp <= 0:
		get_parent().die()
	if invincible_time != 0:
		invincible = true
		timer.start(invincible_time)

func _on_timer_timeout():
	invincible = false

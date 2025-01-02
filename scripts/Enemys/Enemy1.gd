extends CharacterBody2D


var player : Player
@onready var health_manager = $HealthManager

func take_damage(damage : int):
	health_manager.take_damage(damage)

func die():
	queue_free()

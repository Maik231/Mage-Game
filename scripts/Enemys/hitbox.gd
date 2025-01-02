extends Area2D

@export var damage : int

func _process(delta):
	var bodies := get_overlapping_bodies()
	if bodies:
		bodies[0].take_damage(damage, global_position)

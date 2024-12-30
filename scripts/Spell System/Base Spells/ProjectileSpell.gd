extends SpellBase


var cast_cooldown : float
var on_colldown : bool = false
@export var projectile : PackedScene

func _ready():
	$Timer.wait_time = cast_cooldown

func use_spell():
	if on_colldown:
		return

	$Timer.start()
	add_child(projectile.instantiate())
	on_colldown = true


func _on_timer_timeout():
	on_colldown = false

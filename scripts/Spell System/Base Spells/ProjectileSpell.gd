extends SpellBase


@export var cast_cooldown : float
var on_colldown : bool = false
@export var projectile : PackedScene

func _ready():
	$Timer.wait_time = cast_cooldown

func use_spell():
	if on_colldown:
		return

	$Timer.start()
	var new_projectile = projectile.instantiate()
	new_projectile.global_position = global_position
	$Projectiles.add_child(new_projectile)
	on_colldown = true

func _process(delta : float):
	position = (get_global_mouse_position() - owner.global_position).normalized() * 10


func _on_timer_timeout():
	on_colldown = false

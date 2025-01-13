extends CharacterBody2D

@export var speed : float
@export var time_limit : float
@export var inaccuracy_in_radians : float
@export var bounce : bool
@export var damage : int
var direction : Vector2

func _ready():
	if time_limit:
		$Timer.wait_time = time_limit
		$Timer.start()
	direction = (get_global_mouse_position() - global_position).normalized().rotated(randf_range(-inaccuracy_in_radians, inaccuracy_in_radians))


func _physics_process(delta):
	var collision_info := move_and_collide(direction * speed * delta)
	if collision_info:
		if bounce and collision_info.get_collider().name in ["Enviroment", "Platforms"]:
			direction = direction.bounce(collision_info.get_normal())
		elif collision_info.get_collider().has_method("take_damage"):
			collision_info.get_collider().take_damage(damage)
			queue_free()
		else:
			queue_free()

func _on_timer_timeout():
	queue_free()

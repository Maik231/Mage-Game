extends Area2D

@export var speed : float
@export var time_limit : float
@export var bouncing : bool
@export var inaccuracy_in_radians : float
@export var damage : int

var direction : Vector2

var object

func _ready():
	if time_limit:
		$Timer.wait_time = time_limit
		$Timer.start()
	direction = (get_global_mouse_position() - global_position).normalized().rotated(randf_range(-inaccuracy_in_radians, inaccuracy_in_radians))


func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()


func _on_timer_timeout():
	queue_free()

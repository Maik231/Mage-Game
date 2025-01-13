extends Area2D

@export var speed : float
@export var time_limit : float
@export var inaccuracy_in_radians : float
@export var damage : int
@export var detection_range : float
var target : Node2D
var direction : Vector2

func _ready():
	if time_limit:
		$Timer.wait_time = time_limit
		$Timer.start()
	direction = (get_global_mouse_position() - global_position).normalized().rotated(randf_range(-inaccuracy_in_radians, inaccuracy_in_radians))
	$"detection range/CollisionShape2D".scale *= detection_range

func _physics_process(delta):
	if target:
		if target.is_queued_for_deletion():
			target = null
			look_for_new_target()
		else:
			direction = direction.lerp((target.global_position - global_position).normalized(), delta * 10).normalized()
	
	position += direction * speed * delta

func _on_timer_timeout():
	queue_free()


func _on_detection_range_body_entered(body: Node2D) -> void:
	if target:
		return
	target = body


func _on_detection_range_body_exited(body: Node2D) -> void:
	if body == target:
		target == null
		look_for_new_target()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()

func look_for_new_target():
	var bodies = $"detection range".get_overlapping_bodies()
	if bodies:
		target = bodies[0]

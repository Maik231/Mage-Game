extends Area2D

var direction : Vector2
@export var speed : int
@export var damage : int
var mouse_start_position : float


func _ready():
	mouse_start_position = get_global_mouse_position().y
	position.y = get_viewport().get_camera_2d().position.y
	position.x = get_global_mouse_position().x + randf_range(-100, 100)
	direction = (get_global_mouse_position() - global_position).normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body : Node2D):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	if position.y > mouse_start_position:
		var collision := get_overlapping_bodies()
		for col in collision:
			if col.has_method("take_damage"):
				col.take_damage(damage)
		queue_free()

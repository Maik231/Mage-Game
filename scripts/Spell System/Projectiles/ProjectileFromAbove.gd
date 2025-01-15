extends Area2D

var direction : Vector2
@export var speed : int
@export var damage : int
@export var explosion_radius : float
var mouse_start_position : float


func _ready():
	$ShapeCast2D.shape.set_radius(explosion_radius)
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
		queue_free()
		if $ShapeCast2D.is_colliding():
			for i in $ShapeCast2D.get_collision_count():
				$ShapeCast2D.get_collider(i).take_damage(damage / 2)

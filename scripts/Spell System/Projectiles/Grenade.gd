extends CharacterBody2D

@export var speed : float
@export var time_limit : float
@export var damage : int
@export var explosion_radius : float

@onready var shape_cast_2d = $ShapeCast2D
@onready var timer = $Timer

var direction : Vector2

func _ready():
	timer.wait_time = time_limit
	timer.start()
	shape_cast_2d.shape.set_radius(explosion_radius)
	direction = (get_global_mouse_position() - global_position).normalized()
	velocity = direction * speed

func _physics_process(delta):
	velocity += get_gravity() * delta
	var collision_info := move_and_collide(velocity * delta)
	if collision_info:
		if collision_info.get_collider().has_method("take_damage"):
			collision_info.get_collider().take_damage(damage)
			explode()
		else:
			velocity = velocity.bounce(collision_info.get_normal()) * factor()

func factor() -> float:
	var lenght := velocity.length()
	if lenght > 50:
		return 0.4
	return 0

func explode():
	shape_cast_2d.enabled = true
	shape_cast_2d.force_shapecast_update()
	if shape_cast_2d.is_colliding():
		for i in shape_cast_2d.get_collision_count():
			shape_cast_2d.get_collider(i).take_damage(damage / 2)
	queue_free()

func _on_timer_timeout():
	explode()

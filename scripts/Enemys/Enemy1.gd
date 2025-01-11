extends CharacterBody2D

@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight
@onready var player : Player = %Player
@onready var health_manager = $HealthManager
var direction : int
const SPEED : int = 50

func take_damage(damage : int):
	health_manager.take_damage(damage)

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if player.global_position.x - global_position.x < -5:
		direction = -1
	elif player.global_position.x - global_position.x > 5:
		direction = 1
	elif is_on_floor() and jump_under_player():
		velocity.y = -200
	
	if is_on_floor() and (ray_cast_left.is_colliding() or ray_cast_right.is_colliding()):
		velocity.y = -200

	velocity.x = lerpf(velocity.x, direction * SPEED, minf(1, 4 * delta))
	move_and_slide()

func jump_under_player() -> bool:
	return global_position.y > player.global_position.y and player.global_position.distance_to(global_position) < 100

func die():
	queue_free()

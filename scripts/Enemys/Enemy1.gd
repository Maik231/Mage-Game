extends CharacterBody2D


@onready var player : Player = %Player
@onready var health_manager = $HealthManager
var direction : int
const SPEED : int = 50
func take_damage(damage : int):
	health_manager.take_damage(damage)

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if player.global_position.x - global_position.x < -10:
		direction = -1
	elif player.global_position.x - global_position.x > 10:
		direction = 1
	elif is_on_floor() and global_position.y > player.global_position.y and player.global_position.distance_to(global_position) < 100:
		velocity.y = -200
	velocity.x = lerpf(velocity.x, direction * SPEED, minf(1, 4 * delta))
	move_and_slide()

func die():
	queue_free()

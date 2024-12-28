extends Area2D
class_name Hook

var direction : Vector2

var hit_object : bool
var returning : bool
var shooting : bool = false

@export var player : Player

var travel_distance : int = 150
var hook_travel_speed : int = 300
var player_travel_speed : int = 300

func shoot():
	if shooting:
		return
	
	show()
	global_position = player.position
	direction = (get_global_mouse_position() - player.global_position).normalized()
	shooting = true
	hit_object = false
	returning = false

func equip(new_player : Player):
	player = new_player

func _physics_process(delta):
	if not shooting:
		return
	
	if hit_object:
		return

	if not returning:
		position += direction * hook_travel_speed * delta
		if player.global_position.distance_to(global_position) > travel_distance:
			returning = true
	else:
		position += (player.global_position - global_position).normalized() * hook_travel_speed * delta
		if player.global_position.distance_to(global_position) < 5:
			end()

func end():
	shooting = false
	hide()

func _on_body_entered(body : Node2D):
	hit_object = true
	player.movement_state_machine.change_state("HookState", {"destination" : position})

extends Label

@onready var player : Player = $".."

func _process(delta):
	text = str(player.velocity.x).pad_decimals(2)

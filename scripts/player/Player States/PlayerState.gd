extends State
class_name PlayerState

const WALKING : String = "WalkingState"
const JUMPING : String = "JumpingState"
const FALLING : String = "FallingState"
const IDLE : String = "IdleState"
const WING : String = "WingState"
const HOOK : String = "HookState"

@onready var player : Player = owner as Player

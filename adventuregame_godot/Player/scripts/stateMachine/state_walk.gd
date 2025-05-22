class_name State_Walk extends PlayerState

@export var move_speed: float = 100.0

@onready var idle: PlayerState = $"../Idle"
@onready var attack: PlayerState = $"../Attack"

func Enter() -> void:
	player.UpdateAnimation("walk")

func Exit() -> void:
	pass
	
func Process(_delta: float) -> PlayerState:
	if player.direction == Vector2.ZERO:
		return idle
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("walk")	
	
	return null

func Physics( _delta: float) -> PlayerState:
	return null

func HandleInput(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("attack"):
		return attack
	return null
	
	

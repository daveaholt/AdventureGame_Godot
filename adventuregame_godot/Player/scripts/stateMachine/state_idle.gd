class_name State_Idle extends PlayerState

@onready var walk: State_Walk = $"../Walk"

func Enter() -> void:
	player.UpdateAnimation("idle")

func Exit() -> void:
	pass
	
func Process(_delta: float) -> PlayerState:
	if player.direction != Vector2.ZERO:
		return walk
	
	player.velocity = Vector2.ZERO
	return null

func Physics( _delta: float) -> PlayerState:
	return null

func HandleInput(_event: InputEvent) -> PlayerState:
	return null
	

class_name PlayerState extends Node

static var player: Player
static var state_machine: PlayerStateMachine

func init() -> void:
	pass

func _ready() -> void:
	pass

func Enter() -> void:
	pass

func Exit() -> void:
	pass
	
func Process(_delta: float) -> PlayerState:
	return null

func Physics( _delta: float) -> PlayerState:
	return null

func HandleInput(_event: InputEvent) -> PlayerState:
	return null

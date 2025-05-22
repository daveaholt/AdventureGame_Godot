class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: PlayerStateMachine = $StateMachine

signal DirectionChanged(new_direction: Vector2)

func _ready() -> void:
	state_machine.Initialize(self, animation_player)

func _process(delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()

func _physics_process(delta: float) -> void:
	move_and_slide()
	
func SetDirection() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	var direction_id: int = int( round( ( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_4.size() )	)
	var new_dir = DIR_4[direction_id]
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	DirectionChanged.emit(new_dir)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true
	
func UpdateAnimation(_state : String) -> void:
	animation_player.play(_state + "_" + AnimDirection())
		
func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

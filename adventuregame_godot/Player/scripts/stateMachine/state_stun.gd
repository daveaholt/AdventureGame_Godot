class_name State_Stun extends PlayerState

@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0
@export var invulnerable_duration: float = 1.0

@onready var idle: PlayerState = $"../Idle"

var hurt_box: HurtBox
var direction: Vector2
var next_state: PlayerState = null

func init() -> void:
	player.PlayerDamaged.connect(_player_damaged)

func Enter() -> void:
	player.make_invulnerable(invulnerable_duration)
	player.animation_player.animation_finished.connect(_animation_finished)	
	direction = player.global_position.direction_to(hurt_box.global_position)
	player.velocity = direction * -knockback_speed
	player.UpdateAnimation("stun")
	player.effect_animation_player.play("damaged")
	player.SetDirection()

func Exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect(_animation_finished)
	
func Process(_delta: float) -> PlayerState:
	player.velocity -= player.velocity * decelerate_speed * _delta
	return next_state

func Physics( _delta: float) -> PlayerState:
	return null

func HandleInput(_event: InputEvent) -> PlayerState:
	return null

func _player_damaged(_hurt_box: HurtBox) -> void:
	hurt_box = _hurt_box
	state_machine.ChangeState(self)
	
func _animation_finished(_new_animation: String) -> void:
	next_state = idle

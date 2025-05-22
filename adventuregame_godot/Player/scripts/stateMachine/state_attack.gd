class_name State_Attack extends PlayerState

var attacking: bool = false

@export var attack_sound: AudioStream
@export_range(1,20.05) var decelerate_speed: float = 5

@onready var idle: PlayerState = $"../Idle"
@onready var walk: State_Walk = $"../Walk"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_anim_player: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

func Enter() -> void:
	player.UpdateAnimation("attack")
	attack_anim_player.play("attack_" + player.AnimDirection())
	animation_player.animation_finished.connect(EndAttack)
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9,1.1)
	audio.play()
	attacking = true

func Exit() -> void:
	animation_player.animation_finished.disconnect( EndAttack)
	attacking = false
	pass
	
func Process(_delta: float) -> PlayerState:
	player.velocity -= player.velocity * decelerate_speed * _delta
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

func Physics( _delta: float) -> PlayerState:
	return null

func HandleInput(_event: InputEvent) -> PlayerState:
	return null
	
func EndAttack(_newAnimName: String):
	attacking = false;

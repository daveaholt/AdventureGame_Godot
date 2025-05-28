class_name Player extends CharacterBody2D

signal PlayerDamaged(hurt_box: HurtBox)
signal DirectionChanged(new_direction: Vector2)

var invulnerable: bool = false
var HP: int = 6
var max_HP: int = 6
var cardinal_direction : Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]


@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var hit_box: HitBox = $HitBox
@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer


func _ready() -> void:
	PlayerManager.player = self
	state_machine.Initialize(self, animation_player)
	hit_box.Damaged.connect(_take_damage)
	update_hp(99)

func _process(_delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()

func _physics_process(_delta: float) -> void:
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

func _take_damage(_hurt_box: HurtBox) -> void:
	if invulnerable == true:
		return
	update_hp(-_hurt_box.damage)
	if HP > 0:
		PlayerDamaged.emit(_hurt_box)
	else:
		PlayerDamaged.emit(_hurt_box)
		update_hp(99)
	pass
	
func update_hp(delta: int) -> void:
	HP = clampi(HP + delta, 0, max_HP)
	PlayerHud.update_hp(HP, max_HP)
	pass

func make_invulnerable(invulnerable_duration: float = 1.0) -> void:
	invulnerable = true
	hit_box.monitoring = false
	
	await get_tree().create_timer(invulnerable_duration).timeout
	invulnerable = false
	hit_box.monitoring = true

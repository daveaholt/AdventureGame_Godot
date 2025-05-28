class_name EnemyStun extends EnemyState

@export var anim_name: String = "stun"
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0

@export_category("AI")
@export var next_state: EnemyState

var _damage_position: Vector2
var _direction: Vector2
var animation_finished: bool = false

func init() -> void:
	enemy.EnemyDamaged.connect(_on_enemy_damaged)	

func enter() -> void:
	animation_finished = false	
	enemy.invulnerable = true
	
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.set_direction(_direction)
	enemy.velocity = _direction * -knockback_speed
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)

func exit() -> void:
	enemy.invulnerable = false
	enemy.animation_player.animation_finished.disconnect(_on_animation_finished)
	
func process(_delta : float) -> EnemyState:
	if animation_finished == true:
		return next_state
		
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return  null

func physics_process(_delta : float) -> EnemyState:
	return null
	
func _on_enemy_damaged(_hurt_box: HurtBox) -> void:
	_damage_position = _hurt_box.global_position
	state_machine.change_state(self)
	
func _on_animation_finished(_animName: String ) -> void:
	animation_finished = true

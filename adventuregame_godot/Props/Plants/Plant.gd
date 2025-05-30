class_name Plant extends Node2D
@onready var hit_box: HitBox = $HitBox
const PLANT = preload("res://Props/Plants/Plant.tscn")
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D


func _ready() -> void:
	hit_box.Damaged.connect(TakeDamage)

func TakeDamage(_hurt_box: HurtBox)-> void:
	visible = false
	collision_shape_2d.set_deferred("disabled", true)
	await get_tree().create_timer(16.0).timeout
	visible = true
	collision_shape_2d.set_deferred("disabled", false)
	

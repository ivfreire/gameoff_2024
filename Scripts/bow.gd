extends Node2D

@export var arrow_speed: float = 1000.0

@onready var arrow_prefab = preload("res://Prefabs/arrow.tscn")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('fire'):
		var arrow = arrow_prefab.instantiate()
		
		var mouse_position = self.get_global_mouse_position()
		var direction = (mouse_position - self.global_position).normalized()
		
		get_tree().get_root().add_child(arrow)
		arrow.global_position = self.global_position
		arrow.linear_velocity = direction * arrow_speed

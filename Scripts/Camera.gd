extends Camera2D

@export var player: CharacterBody2D
@export var smooth_speed: float = 5.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if player:
		global_position = global_position.lerp(player.global_position, smooth_speed * delta)

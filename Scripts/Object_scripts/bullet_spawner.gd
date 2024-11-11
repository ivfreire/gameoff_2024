extends Area2D

@export var bullet : PackedScene

func shoot():
	var b = bullet.instantiate()
	add_child(b)

func _on_timer_timeout() -> void:
	shoot()

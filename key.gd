extends Area2D

var key_collected = false

func _on_body_entered(body: Node2D) -> void:
	print('entrou')
	if body.is_in_group('player'):
		body.has_key = true
		key_collected = true
		queue_free()

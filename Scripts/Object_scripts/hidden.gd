extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		if body.has_method('able_hide_function'):
			body.able_hide_function(true) 

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group('player'):
		if body.has_method('able_hide_function'):
			body.able_hide_function(false) 

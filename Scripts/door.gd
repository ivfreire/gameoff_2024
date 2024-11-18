extends Area2D

var can_enter = false 

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('player') and body.has_key == true:
		can_enter = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and can_enter:
		print('entrou')

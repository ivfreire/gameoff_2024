extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body:Node) -> void:
	if not body.is_in_group("player"):
		var bow = get_tree().get_first_node_in_group("bow")
		if bow:
			bow.current_arrow = null
		queue_free()

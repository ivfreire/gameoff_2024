class_name Hike extends  Area2D 

@export var endpoint : Hike = null



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.hike = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.hike = false

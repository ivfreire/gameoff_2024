extends PathFollow2D

var speed = 0.05

func _process(delta: float) -> void:
	progress_ratio += delta * speed

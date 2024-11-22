extends PathFollow2D

var speed = 0.05

var progress_count = 1

func _process(delta: float) -> void:
	progress_ratio += delta * speed
	print(progress_ratio)
	
	#TODO implementar código apra virar sprite

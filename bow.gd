extends Node2D

@export var arrow_speed: float = 400.0
@export var max_arrow_distance: float = 200

@onready var arrow_prefab = preload("res://Prefabs/arrow.tscn")
var current_arrow = null

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('fire') and current_arrow == null:
		shoot_arrow()

func shoot_arrow() -> void:
	current_arrow = arrow_prefab.instantiate()
	
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()
	
	get_tree().get_root().add_child(current_arrow)
	current_arrow.global_position = global_position
	
	current_arrow.linear_velocity = direction * arrow_speed
	
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = max_arrow_distance / arrow_speed
	timer.one_shot = true
	timer.timeout.connect(func():remove_arrow())
	timer.start()
	

func remove_arrow() -> void:
	if current_arrow != null:
		current_arrow.queue_free()
		current_arrow = null

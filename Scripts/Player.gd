extends CharacterBody2D


# motion variables
@export var speed = 300.0
@export var jump_velocity = -500.0
var can_move = true 

# stealth_mechanics variables
var able_hide = false
var hide = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if can_move:
		move_and_slide()
	
	### stealth
	if Input.is_action_just_pressed('hide') and able_hide == true:
		if hide:
			hide_function(false)
			$sprite.modulate = Color(1,1,1,1)
		else:
			hide_function(true)
			$sprite.modulate = Color(1,1,1,.5)

		

## stealth function
func able_hide_function(val:bool):
	able_hide = val
	

func hide_function(val:bool):
	if val:
		can_move = false
	else:
		can_move = true
	hide = val

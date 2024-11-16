extends CharacterBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hike_timer: Timer = $hike_timer


# motion variables
@export var speed = 300.0
@export var jump_velocity = -500.0
var can_move = true 
var hike = false

# stealth_mechanics variables
var able_hide = false
var hide = false


func _physics_process(delta: float) -> void:
		

	if not is_on_floor() and not hike:
		velocity += get_gravity() * delta

	#TODO coyote jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		animated_sprite_2d.play("jump")
		await animated_sprite_2d.animation_finished


	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

		
	if hike:
		var hike_direction := Input.get_axis("move_up", "move_down")
		velocity.y = hike_direction*speed

	if can_move:
		move_and_slide()
	
	animate()
	
	### stealth
	if Input.is_action_just_pressed('hide') and able_hide == true:
		if hide:
			animated_sprite_2d.play("reveal")
			await animated_sprite_2d.animation_finished
			hide_function(false)
		else:
			animated_sprite_2d.play("hide")
			hide_function(true)

		

## stealth function
func able_hide_function(val:bool):
	able_hide = val
	

func hide_function(val:bool):
	if val:
		can_move = false
	else:
		can_move = true
	hide = val
	
func animate():
	## TODO colocar todas animações aqui. Não sei como	
	if velocity.x != 0 and hide == false:
		animated_sprite_2d.play("walk")
		if velocity.x < 0:
			animated_sprite_2d.flip_h = true
		elif velocity.x > 0: 
			animated_sprite_2d.flip_h = false	
	
	if velocity.x == 0 and velocity.y == 0 and hike == false and hide == false:
		animated_sprite_2d.play("idle")

	if hike:
		if velocity.y != 0:
			animated_sprite_2d.play("hike")
		else:
			animated_sprite_2d.play("idle_hike")


func _on_hike_timer_timeout() -> void:
	hike = false

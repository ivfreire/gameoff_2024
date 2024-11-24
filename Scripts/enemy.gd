extends CharacterBody2D


@export var speed = 10
@export var range = 100
var spawn_position = 0
var flip = false
var chase = false
var attacking = false
var colliding_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$anim.play("walking")
	spawn_position = position.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	walking()
	chasing()


func walking():
		#print(chase)
#Idle
	#print(chase)
	if chase == false:
		if flip == false:
			#position.x -= speed
			velocity.x = -speed
			if position.x <= spawn_position - range:
				flip = true
				scale.x *= -1
		else:
			velocity.x = speed
			#position.x += speed
			if position.x >= spawn_position + range:
				flip = false
				scale.x *= -1

	else: 
		if flip == false:
			velocity.x = -2 * speed
			#position.x -= 2*speed
		else:
			velocity.x = 2 * speed
			#position.x += 2*speed
	move_and_slide()
	
func chasing():
#Chase
	if $range.is_colliding():
		var collider = $range.get_collider()
		if collider and collider.is_in_group('player'):
			if chase == false:
				speed = 0
				$anim.play('detect')
				await $anim.animation_finished
				chase = true
				speed = 15
				$anim.play('chasing')
				
		if chase and colliding_counter <= 300:
			colliding_counter += 1
			#print(colliding_counter)
			if colliding_counter > 300:
				colliding_counter = 0
				chase = false 
				speed = 10
				$anim.play("walking")

	if $floor_cast.is_colliding() == false:
		chase = false 
		speed = 10
		$anim.play("walking")

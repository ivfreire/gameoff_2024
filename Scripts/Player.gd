extends CharacterBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hike_timer: Timer = $hike_timer

# motion variables
@export var speed = 300
@export var jump_velocity = -300
var can_move = true 
var hike = false

# stealth_mechanics variables
var able_hide = false
var hide = false

# temporary var
var has_key = false 

# coyote time
@export var coyote_time: float = 0.2  # Duração do coyote time em segundos
var time_since_on_floor: float = 0.0  # Tempo desde que o jogador esteve no chão
var can_coyote_jump: bool = false  # Se o jogador pode usar o coyote jump

@export var respawn_location : Vector2 

#func _init() -> void:
func _ready() -> void:
	##melhor passar isso pra ready, a global que ta pegando tá errada
	self.respawn_location = self.global_position
	print('Respawn location set to: ', self.respawn_location)

func _physics_process(delta: float) -> void:
	
	# atualiza o coyote
	if is_on_floor():
		time_since_on_floor = 0.0
		can_coyote_jump = true
	else:
		time_since_on_floor += delta
		if time_since_on_floor > coyote_time:
			can_coyote_jump = false

	if not is_on_floor() and not hike:
		velocity += get_gravity() * delta

	#TODO coyote jump
	if Input.is_action_just_pressed("jump") and (is_on_floor() or can_coyote_jump):
		velocity.y = jump_velocity
		animated_sprite_2d.play("jump")
		await animated_sprite_2d.animation_finished
		can_coyote_jump = false  # Evita saltos extras durante o coyote time


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

func respawn() -> void:
	print('respawn')
	
	self.global_position = self.respawn_location
	self.has_key = false

extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -170.0
const STOMP_VELOCITY = 570.0
const DASH_VELOCITY = 500.0
const DASH_DURATION = 0.2
const DASH_COOLDOWN = 1.0


var DASH_TIMER = 0.0
var COOLDOWN_TIMER = 0.0
var IS_DASHING = false
var DASH_DIRECTION = Vector2.ZERO

@onready var animated_sprite = $AnimatedSprite2D

func _process(delta: float) -> void:
	pass
		
func _physics_process(delta: float) -> void:
	# Handle Input
	var input_direction = Input.get_vector("move_left", "move_right", "jump", "sneak")
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handle stomp
	if Input.is_action_just_pressed("sneak") and not is_on_floor():
		velocity.y = STOMP_VELOCITY
		
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
			if Input.is_action_pressed("sneak"):
				animated_sprite.play("lay_down")
		else:
			animated_sprite.play("walk")
	else:
		animated_sprite.play("jump")


	if Input.is_action_just_pressed("dash"):
		_player_dash(input_direction)
		
	if IS_DASHING:
		velocity = DASH_DIRECTION * DASH_VELOCITY
		DASH_TIMER -= delta
		if DASH_TIMER <= 0:
			_end_dash()
		
	move_and_slide()

func _player_dash(direction: Vector2):
	IS_DASHING = true
	DASH_TIMER = DASH_DURATION
	COOLDOWN_TIMER = DASH_COOLDOWN
	if direction == Vector2.ZERO:
		direction = Vector2.RIGHT if $AnimatedSprite2D.scale.x > 0 else Vector2.LEFT
		
	DASH_DIRECTION = direction.normalized()

func _end_dash():
	IS_DASHING = false

				
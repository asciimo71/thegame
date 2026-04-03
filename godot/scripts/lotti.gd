extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -170.0
const STOMP_VELOCITY = 570.0

@onready var animated_sprite = $AnimatedSprite2D

func _process(delta: float) -> void:
	pass
		
func _physics_process(delta: float) -> void:
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

	move_and_slide()

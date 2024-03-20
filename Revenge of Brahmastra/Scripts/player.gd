extends CharacterBody2D

@onready var playerAnimation = $AnimatedSprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * SPEED 
		if direction == 1:
			playerAnimation.flip_h = false
			playerAnimation.animation = "Right"
		else:
			playerAnimation.animation = "Right"
			playerAnimation.flip_h = true	 
	elif direction == 0:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			playerAnimation.animation = "Idle"
	
	playerAnimation.play()
	position.x = clamp(position.x + direction*SPEED*delta,15,1280 - 30)
	move_and_slide()

extends CharacterBody2D

enum States { IDLE, MOVE, ATTACK, TAKE_HIT }
var state = States.IDLE
var player : Node
var attack_range = 100.0 # Adjust based on your game's scale
var move_speed = 100.0 # Adjust based on your game's needs
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D
var chase = false


func _ready():
	# Assuming you have a method to find the player, you might use a signal or just search in _process
	player = get_parent().get_node("Player")

func _process(delta):
	velocity.y += gravity * delta
	if state != States.ATTACK:  # Block movement logic when attacking
		if chase:
			var direction = (player.position - self.position).normalized()
			if direction.x > 0:
				animated_sprite.play("Run_right")
			else:
				animated_sprite.play("Run_left")
			velocity.x = direction.x * move_speed
		else:
			animated_sprite.play("IdleLeft")
			velocity.x = 0
	
	move_and_slide()

	


func _on_player_detect_body_entered(body):
	if body.name == "Player":
		state = States.ATTACK  # Change state to ATTACK
		var attack_type = "atklght" if randi() % 2 == 0 else "atkhvy"
		animated_sprite.play(attack_type)
		await animated_sprite.animation_finished  # Wait for animation to finish
		state = States.IDLE  # Return to IDLE state


func _on_big_area_body_entered(body):
	if body.name == "Player":
		chase = true
	




func _on_player_detect_body_exited(body):
	if body.name == "Player":
		state = States.MOVE


func _on_big_area_body_exited(body):
	if body.name == "Player":
		chase = false # Replace with function body.

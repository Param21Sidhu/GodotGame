extends CharacterBody2D

enum States { IDLE, MOVE, ATTACK, TAKE_HIT }
var state = States.IDLE
var player : Node
var attack_range = 100.0 # Adjust based on your game's scale
var move_speed = 100.0 # Adjust based on your game's needs
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D
var chase = false
var health = 100
var player_inattack_zone = false

func _ready():
	# Assuming you have a method to find the player, you might use a signal or just search in _process
	player = get_parent().get_node("Player")

func _process(delta):
	velocity.y += gravity * delta
	if state != States.ATTACK:  # Block movement logic when attacking
		if chase:
			var direction = (player.position - self.position).normalized()
			animated_sprite.play("run")
			if direction.x > 0:
				animated_sprite.flip_h = false
			else:
				animated_sprite.flip_h = true
			velocity.x = direction.x * move_speed
		else:
			animated_sprite.play("idle")
			velocity.x = 0
	
	deal_with_damage()
	move_and_slide()

	
func enemy():
	pass

func _on_player_detect_body_entered(body):
	if body.name == "Player":
		chase = true

	
#



func _on_player_detect_body_exited(body):
	if body.name == "Player":
		chase = false 





func _on_attack_area_body_entered(body):
	if body.name == "Player":
		player_inattack_zone = true
		state = States.ATTACK  # Change state to ATTACK
		var attack_type = "attack1" if randi() % 2 == 0 else "attack2"
		animated_sprite.play(attack_type)
		await animated_sprite.animation_finished  # Wait for animation to finish
		state = States.IDLE  # Return to IDLE state # Replace with function body.


func _on_attack_area_body_exited(body):
	if body.name == "Player":
		player_inattack_zone = false
		state = States.MOVE # Replace with function body.

func deal_with_damage():
	if player_inattack_zone and Main3.player_current_attack == true:
		health = health - 20
		print("health = ",health)
		
		if health <= 0:
			queue_free()

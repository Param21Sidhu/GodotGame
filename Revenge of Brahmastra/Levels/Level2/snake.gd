extends CharacterBody2D
var health = 10
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player : Node
var chase = false
var speed = 50 
func _ready():
	get_node("AnimatedSprite2D").play("Idle")
	player = get_parent().get_node("Player")
	
func _physics_process(delta):
	velocity.y += gravity * delta 
	if chase == true :
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Jump")
		
	
			
		var direction = (player.position - self.position).normalized()
		
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true 
			velocity.x = direction.x * speed 
		else:
			get_node("AnimatedSprite2D").flip_h =  false
			velocity.x = direction.x * speed 
	else :
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0
	
	move_and_slide()




func _on_player_death_body_entered(body):
	if body.name == "Player":
		chase = false 
		get_node("AnimatedSprite2D").play("Death")
		await get_node("AnimatedSprite2D").animation_finished
		self.queue_free()


func _on_player_collison_body_entered(body):
	if body.name == "Player":
		body.health -= 3 
		death()
		
		
func death():
	chase = false 
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()


func _on_playerdetection_body_entered(body):
	if body.name == "Player":
		chase = true  # Replace with function body.


func _on_playerdetection_body_exited(body):
	if body.name == "Player":
		chase = false  # Replace with function body.

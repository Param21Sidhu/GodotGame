extends CharacterBody2D

@onready var playerAnimation = $AnimatedSprite2D
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var enemy_inattack_range = false
var enemy_attack_cooldown= true
var health = 160
var player_alive = true

var attack_in_prog = false
var dir

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if health <= 0:
		player_alive = false
		health = 0
		print("PLayer killed")
		queue_free()
		#this is wehere we add lost or win screen
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
			dir = "right"
		else:
			playerAnimation.animation = "Right"
			playerAnimation.flip_h = true	 
			dir = "left"
	elif direction == 0:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0 and  !attack_in_prog:
			playerAnimation.animation = "Idle"
			
		

	
	

	position.x = clamp(position.x + direction * SPEED * delta, 15, 1280 - 30)
	update_health()
	attack()
	enemy_attack()
	move_and_slide()
	playerAnimation.play()


func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 10
		#print("health",health)
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		#print("player took damage")
	
func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true
		 


func _on_player_hitbox_body_exited(body):
		if body.has_method("enemy"):
			enemy_inattack_range = false
		 
func player():
	pass


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true # Replace with function body.


func attack():
	if Input.is_action_just_pressed("lghtAtk"):
		Main3.player_current_attack = true
		attack_in_prog = true
		if dir == "right":
			playerAnimation.flip_h = false
			playerAnimation.animation = "swrdAtk"
			playerAnimation.play()
			$deal_attack_timer.start()
		else:
			
			playerAnimation.flip_h = true
			playerAnimation.animation = "swrdAtk"
			playerAnimation.play()
			$deal_attack_timer.start()
	
	
	if Input.is_action_just_pressed("hvyAtk"):
		Main3.player_current_attack = true
		attack_in_prog = true
		if dir == "right":
			playerAnimation.flip_h = false
			playerAnimation.animation = "swrdAtkHvy"
			playerAnimation.play()
			$deal_attack_timer.start()
		else:
			playerAnimation.flip_h = true
			playerAnimation.animation = "swrdAtkHvy"
			playerAnimation.play()
			$deal_attack_timer.start()
		



func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Main3.player_current_attack = false
	attack_in_prog = false
	
func update_health():
	var healthBar = $HealthBar
	healthBar.value = health
	
	healthBar.visible = true

func _on_regin_timer_timeout():
	if health < 100:
		health = health + 20
		if health > 100:
			health = 100
	print(health)
	if health <= 0:
		health = 0 # Replace with function body.

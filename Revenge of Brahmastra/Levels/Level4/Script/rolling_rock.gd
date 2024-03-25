extends RigidBody2D

var roll_speed = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	apply_central_impulse(Vector2(10,0))
	#apply_torque(roll_speed)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


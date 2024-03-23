extends Node2D

@export var offset = Vector2(100,0)
@export var duration = 3.0

func _ready():
	start_tween()
	
func start_tween():
	var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property($AnimatableBody2D, "position:x", offset.x, duration / 2)
	tween.tween_property($AnimatableBody2D, "position:x", $AnimatableBody2D.position.x, duration / 2)

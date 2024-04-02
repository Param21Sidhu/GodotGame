extends Area2D

@onready var  anim = $AnimatedSprite2D
func _ready():
	anim.play("Idle")
	
func _on_body_entered(body):
	if body.name  =="Player":
		anim.play ("collcted")
#
#
func _on_animated_sprite_2d_animation_finished():
	if anim.animation == "collcted":
		queue_free()

extends CharacterBody2D




func _on_playerdetection_body_entered(body):
	if body.name =='Player':
		print("Player")

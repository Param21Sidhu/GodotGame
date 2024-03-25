extends Node2D

@export var Enemy : PackedScene
var player : CharacterBody2D
var camera : Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("Player")
	camera = get_node("Camera2D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera.position.x = player.position.x


func _on_player_checker_for_ene_body_entered(body):
	if body.name == "Player":
		var ene = Enemy.instantiate()
		ene.position.x =  740
		ene.position.y = 700
		add_child(ene)

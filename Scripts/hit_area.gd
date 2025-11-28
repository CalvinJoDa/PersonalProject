extends Area3D

@export var next_level_path: String = "res://Scenes/GameOver.tscn"
@export var spawn_name: String = "PlayerEnterPoint"

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	# Check if the body is the player
	if body == get_tree().get_current_scene().player:
		print("Player detected by enemy!")
		# Call Main's load_level() to replace the level
		get_tree().get_current_scene().load_level(next_level_path, spawn_name)

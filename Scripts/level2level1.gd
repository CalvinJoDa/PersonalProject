extends Area3D

@export var target_scene: String
@export var spawn_point_name: String = "SpawnPoint"

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		get_tree().root.get_node("Main").load_level(target_scene, spawn_point_name)

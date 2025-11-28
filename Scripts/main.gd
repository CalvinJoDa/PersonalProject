extends Node

@onready var level_holder = $LevelHolder
@onready var player = $Player

func load_level(path: String, _spawn_name: String):
	# Delete existing level
	for c in level_holder.get_children():
		c.queue_free()

	# Load new level
	var packed = load(path)
	var level = packed.instantiate()
	level_holder.add_child(level)

	# Move player to spawn point
	var spawn: Node3D = level.get_node("LevelTransitions/PlayerEnterPoint")
	player.global_transform = spawn.global_transform

func _ready():
	load_level("res://Scenes/level1.tscn", "PlayerEnterPoint")

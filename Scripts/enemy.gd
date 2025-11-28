extends CharacterBody3D

@export var speed: float = 1
@export var aggro_range: float = 5
@export var gravity: float = -9.8
@export var arena_scene: String = "res://level1Arena.tscn"
# Path to the scene to load when player is caught
@export var next_scene_path : String = "res://level1Arena.tscn"
@onready var player = get_tree().root.get_node("Main/Player")

var wander_timer := 0.0
var wander_dir := Vector3.ZERO


func _physics_process(delta):

	var move_dir := Vector3.ZERO

	# -------------------------
	#  AGGRO MOVEMENT
	# -------------------------
	if player:
		var dist := global_transform.origin.distance_to(player.global_transform.origin)

		if dist < aggro_range:
			move_dir = (player.global_transform.origin - global_transform.origin)
			move_dir.y = 0  # ignore vertical
			move_dir = move_dir.normalized()
		else:
			move_dir = wander()
	else:
		move_dir = wander()

	# -------------------------
	#  HORIZONTAL MOVEMENT
	# -------------------------
	var horizontal = move_dir * speed
	velocity.x = horizontal.x
	velocity.z = horizontal.z

	# -------------------------
	#  GRAVITY
	# -------------------------
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	move_and_slide()
	


# -----------------------------------
#  WANDER SYSTEM (constant speed)
# -----------------------------------
func wander() -> Vector3:
	wander_timer -= 1

	if wander_timer <= 0:
		wander_timer = randf_range(30, 120)
		wander_dir = Vector3(
			randf_range(-1, 1),
			0,
			randf_range(-1, 1)
		).normalized()

	return wander_dir

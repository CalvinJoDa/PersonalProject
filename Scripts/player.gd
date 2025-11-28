extends CharacterBody3D

@export var speed: float = 5
@export var gravity: float = -9.8  # negative because Y+ is up

func _physics_process(_delta):
	var input_dir = Vector3.ZERO

	# Left/right (X)
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1
	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1

	# Depth movement (Z)
	if Input.is_action_pressed("move_forward"):
		input_dir.z -= 1
	if Input.is_action_pressed("move_backward"):
		input_dir.z += 1

	# Normalize diagonal movement
	if input_dir.length() > 0:
		input_dir = input_dir.normalized()

	# Apply horizontal movement
	velocity.x = input_dir.x * speed
	velocity.z = input_dir.z * speed

	# Apply gravity (vertical movement)
	if not is_on_floor():
		velocity.y += gravity * _delta
	else:
		velocity.y = 0  # reset vertical velocity when on floor

	# Move the player
	move_and_slide()

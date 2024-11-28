extends CharacterBody3D

@export var max_lean_angle := 30.0
@export var lean_speed := 100.0
@export var speed_multiplier := 0.2

var lean_angle := Vector2.ZERO

func _physics_process(delta: float) -> void:
	handle_input(delta)
	update_movement(delta)
	update_visuals(delta)

	
func handle_input(delta: float) -> void:
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("tilt_right") - Input.get_action_strength("tilt_left")
	input_vector.y = Input.get_action_strength("tilt_backward") - Input.get_action_strength("tilt_forward")
	
	lean_angle += input_vector * lean_speed * delta
	
	
func update_movement(delta: float) -> void:
	var direction := Vector3(
		sin(deg_to_rad(lean_angle.x)),
		0,
		sin(deg_to_rad(lean_angle.y))
	)
	
	var speed = lean_angle.length() * speed_multiplier
	
	velocity = direction.normalized() * speed
	
	move_and_slide()
	
	if lean_angle.length() >= max_lean_angle:
		print("The clown has fallen!")
	
	
	
func update_visuals(delta: float) -> void:
	$Clown.rotation_degrees.y = -lean_angle.y
	$Clown.rotation_degrees.z = lean_angle.x

extends CharacterBody3D

@export var max_lean_angle := 30.0
@export var fall_speed := 50.0
@export var lean_speed := 150.0
@export var entropy_strength := 5.0
@export var speed_multiplier := 0.2

var lean_angle := 0.0

func _physics_process(delta: float) -> void:
	handle_input(delta)
	update_movement(delta)
	update_visuals(delta)

	
func handle_input(delta: float) -> void:
	var input_vector = Vector2.ZERO
	
	input_vector = Input.get_action_strength("tilt_left") - Input.get_action_strength("tilt_right")
	
	lean_angle += input_vector * lean_speed * delta
	
	if abs(lean_angle) > 0:
		lean_angle += sign(lean_angle) * fall_speed * delta
	
	lean_angle += randf_range(-entropy_strength, entropy_strength) * delta

	
func update_movement(delta: float) -> void:
	var direction := Vector3(
		sin(deg_to_rad(lean_angle)),
		0,
		0,
	)
	
	var speed = abs(lean_angle) * speed_multiplier
	
	velocity = direction.normalized() * speed
	
	move_and_slide()
	
	if abs(lean_angle) >= max_lean_angle:
		print("The clown has fallen!")
	
	
	
func update_visuals(delta: float) -> void:
	$Clown.rotation_degrees.z = lean_angle

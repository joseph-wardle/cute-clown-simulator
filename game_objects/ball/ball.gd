extends CharacterBody3D

@export var max_lean_angle := 50.0
@export var gravity_strength := 30.0
@export var input_sensitivity := 100.0
@export var entropy_strength := 0.0
@export var speed_multiplier := 0.2
@export var input_smoothing := 10.0

var lean_angle := 0.0
var smoothed_input := 0.0

func _physics_process(delta: float) -> void:
	process_input(delta)
	update_lean_angle(delta)
	update_velocity()
	move_and_slide()
	check_for_fall()
	update_visuals()

	
func process_input(delta: float) -> void:
	var raw_input := Input.get_action_strength("tilt_left") - Input.get_action_strength("tilt_right")
	smoothed_input = lerp(smoothed_input, raw_input, input_smoothing * delta)


func update_lean_angle(delta: float) -> void:
	var input_effect := smoothed_input * input_sensitivity * delta
	var gravity_effect := sin(deg_to_rad(lean_angle)) * gravity_strength * delta
	var entropy_effect := randf_range(-1, 1) * entropy_strength * delta
	lean_angle += input_effect + gravity_effect + entropy_effect
	lean_angle = clamp(lean_angle, -max_lean_angle, max_lean_angle)

	
func update_velocity() -> void:
	var movement_direction := Vector3(sin(deg_to_rad(lean_angle)), 0, 0)
	var movement_speed : float = abs(lean_angle) * speed_multiplier
	velocity = movement_direction.normalized() * movement_speed
	

func check_for_fall() -> void:
	if abs(lean_angle) >= max_lean_angle - 0.1:
		print("")
	
		
func update_visuals() -> void:
	$Clown.rotation_degrees.z = lean_angle


func _on_projectile_arch_number_of_balls_changes(num_of_balls: int) -> void:
	gravity_strength += 2

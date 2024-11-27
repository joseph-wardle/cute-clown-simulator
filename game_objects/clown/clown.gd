extends CharacterBody3D

@export var tilt_speed := 2.0


var tilt := Vector2.ZERO


func _physics_process(delta: float) -> void:
	var input_tilt := Vector2.ZERO
	if Input.is_action_pressed("tilt_forward"):
		input_tilt.y += 1
	if Input.is_action_pressed("tilt_backward"):
		input_tilt.y -= 1
	if Input.is_action_pressed("tilt_left"):
		input_tilt.x -= 1
	if Input.is_action_pressed("tilt_right"):
		input_tilt.x += 1
	
	tilt += input_tilt * tilt_speed * delta

extends Path3D

var num_of_balls := 1
var current_ball := 1
var timer_keeping_ball_ratio := 1.0
var ball_ratio := 2

signal need_progress_ratio
signal number_of_balls_changes(num_of_balls: int)

func _calculate_pos() -> float:
	if current_ball % 2 != 0:
		# Odd throw
		var fraction := float(current_ball) / float(ball_ratio)
		need_progress_ratio.emit()
		var distance := timer_keeping_ball_ratio - fraction
		if distance < 0.0:
			distance += 1.0
		current_ball += 1
		return distance
	else:
		# Even Throw
		if current_ball == ball_ratio:
			ball_ratio *= 2
			current_ball = 1
			return _calculate_pos()
		current_ball += 1
		return _calculate_pos()


func add_object():
	var follower = PathFollow3D.new()
	var mesh = MeshInstance3D.new()
	
	# setups for the mesh
	mesh.scale = Vector3(0.232, 0.232, 0.232)
	mesh.mesh = SphereMesh.new()
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(1.0, 0.0, 0.0)
	mesh.set_surface_override_material(0, material)
	
	# Attach the path follow script to the follower
	var script = load("res://game_objects/juggling_arch/path_follow_3d.gd")
	follower.add_child(mesh)
	follower.script = script
	follower.this_progress_ratio =_calculate_pos()
	
	add_child(follower)
	num_of_balls += 1
	number_of_balls_changes.emit(num_of_balls)


func _on_time_keeping_ball_send_progress_ratio(curr_progress_ratio: Variant) -> void:
	timer_keeping_ball_ratio = curr_progress_ratio

extends Path3D

var num_of_balls = 1
var current_ball = 1
var timer_keeping_ball_ratio = 1
var ball_ratio = 2

signal need_progress_ratio()
signal number_of_balls_changes(num_of_balls: int)

func calculate_pos() -> float:
	if(current_ball % 2 != 0):
		var fraction : float = float(current_ball)/float(ball_ratio)
		need_progress_ratio.emit()
		var distance = timer_keeping_ball_ratio - fraction
		if(distance < 0):
			distance = 1 - distance
		current_ball +=1
		return distance
	elif(current_ball % 2 == 0):
		if(current_ball == ball_ratio):
			ball_ratio *= 2
			current_ball = 1
			return calculate_pos()
		current_ball += 1
		return calculate_pos()
	return 0.1

func add_object():
	#Ok so the first thing we are going to do is add a new pathFollowInstance
	var follower = PathFollow3D.new()
	
	#After that we are going to add the mesh instance. set it.
	var mesh = MeshInstance3D.new()
	mesh.scale.x = -0.236
	mesh.scale.y = -0.239
	mesh.scale.z = -0.232
	mesh.set_mesh(SphereMesh.new())
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(255, 0, 0, 255)
	mesh.set_surface_override_material(0, material)
	var script = load("res://game_objects/juggling_arch/path_follow_3d.gd")
	follower.add_child(mesh)
	follower.script = script
	var new_progress_ratio = calculate_pos()
	print(new_progress_ratio)
	follower.this_progress_ratio = new_progress_ratio
	add_child(follower)
	num_of_balls += 1
	number_of_balls_changes.emit(num_of_balls)


func _on_time_keeping_ball_send_progress_ratio(curr_progress_ratio: Variant) -> void:
	timer_keeping_ball_ratio = curr_progress_ratio

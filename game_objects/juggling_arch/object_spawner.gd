extends Path3D

var timer = 0
var spawnTime = 3
var current_ball = 1
var ball_ratio = 2
var timer_keeping_ball_ratio = 1
signal need_progress_ratio()

func calculate_pos() -> float:
	if(current_ball % 2 != 0):
		var fraction : float = float(current_ball)/float(ball_ratio)
		need_progress_ratio.emit()
		var distance = timer_keeping_ball_ratio - fraction
		if(distance < 0):
			distance = 1 - distance
		current_ball +=1
		print("Time keeping ball", timer_keeping_ball_ratio, "new ball", distance)
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
	var script = load("res://game_objects/juggling_arch/path_follow_3d.gd")
	follower.add_child(mesh)
	follower.script = script
	var new_progress_ratio = calculate_pos()
	print(new_progress_ratio)
	follower.this_progress_ratio = new_progress_ratio
	print(follower.this_progress_ratio)
	add_child(follower)


func _on_time_keeping_ball_send_progress_ratio(curr_progress_ratio: Variant) -> void:
	timer_keeping_ball_ratio = curr_progress_ratio

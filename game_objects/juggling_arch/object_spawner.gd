extends Path3D

var timer = 0
var spawnTime = 3

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
	add_child(follower)

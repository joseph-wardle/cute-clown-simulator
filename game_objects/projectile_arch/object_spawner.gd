extends Path3D

@export var spawn_time := 3.0
var timer := 0.0

func _process(delta: float) -> void:
	timer += delta
	if timer >= spawn_time:
		timer = 0.0
		add_object()


func add_object():
	var follower = PathFollow3D.new()
	var mesh = MeshInstance3D.new()
	
	mesh.scale = Vector3(0.232, 0.232, 0.232)
	mesh.mesh = SphereMesh.new()
	
	var script = load("res://game_objects/projectile_arch/path_follow_3d.gd")
	follower.add_child(mesh)
	follower.script = script
	add_child(follower)



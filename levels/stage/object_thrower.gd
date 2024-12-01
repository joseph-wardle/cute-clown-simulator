extends Node3D

var timer = 0
var object_thrower = load("res://game_objects/thown_object/thrown_object.tscn")

func create_new_thrower():
	var new_object_thrower = object_thrower.instantiate()
	new_object_thrower.scale.x = 0.31
	new_object_thrower.scale.y = 0.31
	new_object_thrower.scale.z = 0.31
	new_object_thrower.position.y = -2.452
	new_object_thrower.position.z = -14.081
	return new_object_thrower
	
	
func _process(delta):
	timer+=delta
	if timer > 10:
		var new_object_thrower = create_new_thrower()
		add_child(new_object_thrower)
		timer = 0

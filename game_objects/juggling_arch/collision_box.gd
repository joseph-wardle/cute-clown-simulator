extends Area3D

func _on_area_entered(area: Area3D) -> void:
	var parent = get_parent() # Get the parent node
	parent.add_object() # Call the function

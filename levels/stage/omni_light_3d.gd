extends OmniLight3D

func _process(delta):
	var target_node = get_node("../Ball")
	if target_node:
		#global_transform.origin = target_node.global_transform.origin
		global_transform.origin.x = target_node.global_transform.origin.x

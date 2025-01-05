extends Node3D


func _on_crowd_level_changed(crowd_level: float) -> void:
	print(crowd_level)
	for child in get_children():
		child._on_crowd_level_changed(crowd_level)

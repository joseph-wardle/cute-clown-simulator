extends Control

func _on_crowd_meter_crowd_level_changed(crowd_level: Variant) -> void:
	if(crowd_level <= 0):
		get_tree().change_scene_to_file("res://levels/end screen/end_screen.tscn")

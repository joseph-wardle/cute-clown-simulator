extends Area3D

func _on_area_entered(area: Area3D) -> void:
	visible = false
	position.y = -25

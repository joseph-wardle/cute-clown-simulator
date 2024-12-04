extends MeshInstance3D

func _on_clown_intro_changed(intro: Variant) -> void:
	var material = get_surface_override_material(0)
	material.albedo_color = Color(255, 255, 0)
	if !intro:
		material.albedo_color = Color(0, 128, 0)
	set_surface_override_material(0, material)

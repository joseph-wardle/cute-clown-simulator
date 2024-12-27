extends AnimatedSprite2D


func _on_texture_button_mouse_entered() -> void:
	play("default", 1.0, false)


func _on_texture_button_mouse_exited() -> void:
	pause()
	frame = 0

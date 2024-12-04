extends CharacterBody3D

@export var num_of_balls_count = 1

signal level_changed(level: int)
signal intro_changed(intro)

func _on_projectile_arch_number_of_balls_changes(num_of_balls: int) -> void:
	num_of_balls_count = num_of_balls
	levelChange()
	
func levelChange():
	if num_of_balls_count == 4:
		level_changed.emit(2)
	elif num_of_balls_count == 8:
		level_changed.emit(3)
	elif num_of_balls_count == 16:
		level_changed.emit(4)
	elif num_of_balls_count == 32:
		level_changed.emit(5)


func _on_music_controller_is_intro(intro_bool: Variant) -> void:
	intro_changed.emit(intro_bool)


func _on_intro_changed(intro: Variant) -> void:
	pass # Replace with function body.

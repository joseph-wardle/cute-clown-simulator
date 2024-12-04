extends Control

func _ready():
	visible = false

func _on_crowd_meter_crowd_level_changed(crowd_level: Variant) -> void:
	if(crowd_level <= 0):
		visible = true
		get_tree().paused = true


func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()

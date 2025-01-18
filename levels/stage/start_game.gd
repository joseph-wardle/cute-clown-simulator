extends Control

func ready():
	visible = true
	
func _input(event):
	if event.is_action_pressed("beat"):
		get_tree().paused = false
		visible = false

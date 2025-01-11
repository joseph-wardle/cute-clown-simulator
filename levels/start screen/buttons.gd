extends Button

var is_hovered = false
var rotation_speed = 6
var rotation_angle = 10
var time = 0

@export var button_type = ""

func _on_pressed() -> void:
	modulate = "323232"
	match button_type:
		"start": get_tree().change_scene_to_file("res://levels/stage/stage.tscn")
		"quit": get_tree().quit()
	
func _process(delta: float) -> void:
	if(is_hovered):
		time+=delta
		rotation = sin(time*rotation_speed)/rotation_angle

func _on_mouse_entered() -> void:
	is_hovered = true
	scale.y += .1
	scale.x += .1


func _on_mouse_exited() -> void:
	is_hovered = false
	rotation = 0
	time = 0
	scale.y -= .1
	scale.x -= .1

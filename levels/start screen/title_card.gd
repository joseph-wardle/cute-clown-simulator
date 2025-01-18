extends TextureRect

@export var rotation_speed = 1
@export var rotation_angle = 40
var time = 0


func _process(delta: float) -> void:
	time+=delta
	rotation = sin(time*rotation_speed)/rotation_angle

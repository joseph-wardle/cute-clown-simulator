@tool
extends PathFollow3D

@export var process: bool = true
@export var speed: int = 5

func _process(delta):
	if process:
		progress += delta * speed

@tool
extends PathFollow3D

@export var process: bool = false
@export var speed: int = 50

func _process(delta):
	if process:
		progress += delta * speed
		print(progress)

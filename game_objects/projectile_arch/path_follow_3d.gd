@tool
extends PathFollow3D

@export var process := true
@export var speed := 5.0

func _process(delta: float) -> void:
	if process:
		progress += delta * speed

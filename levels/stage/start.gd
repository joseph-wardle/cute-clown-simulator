extends Sprite3D

var increasing := false

func _process(delta: float) -> void:
		#figure out if you need to go up or down in the flash
		if transparency <= 0.5:
			increasing = true
		elif transparency == 1.0:
			increasing = false
			
		#then go up or down
		if increasing:
			transparency += delta * 2
		else:
			transparency -= delta * 2
		print(transparency)

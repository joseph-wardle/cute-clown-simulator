extends Sprite3D

@export var duration = 3000
var increasing = true
var started = false

func flash_start():
	if !started:
		started = true
		transparency = 0.5


func _process(delta):
	if get_parent().get_parent().flash_warning:
		flash_start()
		#if the flash warning is on we are going to modify the transparency
		if duration > 0: #if the timer is still going
			print(transparency)
			#figure out if you need to go up or down in the flash
			if transparency <= 0.5:
				increasing = true
			elif transparency == 1.0:
				increasing = false
			
			#then go up or down
			if increasing:
				transparency += delta
			else:
				transparency -= delta
			
			#then lower the timer
			duration -= 10
		else:
			transparency = 1

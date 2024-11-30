extends PathFollow3D

var speed: float = 4.59

func _process(delta):
	if(get_parent().get_parent().go_down && progress_ratio < 1):
		progress += delta * speed
		if progress_ratio > .99:
			progress_ratio = 1
			visible = false

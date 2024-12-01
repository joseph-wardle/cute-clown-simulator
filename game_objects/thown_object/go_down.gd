extends PathFollow3D

var speed: float = 4.59
var sound_played = false;

func _process(delta):
	if(get_parent().get_parent().go_down && progress_ratio < 1):
		if(progress_ratio < .2 && sound_played == false):
			$AudioStreamPlayer3D.play()
			sound_played == true
		progress += delta * speed
		if progress_ratio > .99:
			progress_ratio = 1
			visible = false

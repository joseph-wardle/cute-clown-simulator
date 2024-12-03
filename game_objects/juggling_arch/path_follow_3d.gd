@tool
extends PathFollow3D

@export var process: bool = true
@onready var timer = get_node("../RhythmCounter")

func _process(delta):
	if process:
		# Calculate the beat duration from the timer's BP0
		var beat_duration = 60 / timer.bpm
		# Increment progress to complete one loop in one beat
		progress_ratio += delta/beat_duration
		# Wrap progress to ensure it stays between 0 and 1 


func _on_rhythm_counter_timeout() -> void:
	progress_ratio = 1 

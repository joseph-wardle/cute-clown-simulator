extends ProgressBar

@export var perfect_effect := 15
@export var good_effect := 8
@export var ok_effect := 5
@export var miss_effect := -2
@export var deterioration_rate := 7.0
@export var crowd_level := 60.0:
	set(num):
		crowd_level = num
		value = crowd_level
		
signal crowd_level_changed(crowd_level)

func _on_rhythm_counter_input_result(input_type: int) -> void:
	match input_type:
		0:
			crowd_level += perfect_effect
		1:
			crowd_level += good_effect
		2:
			crowd_level += ok_effect
		3:
			crowd_level += miss_effect
	crowd_level = clamp(crowd_level, 0, 100)
	crowd_level_changed.emit(crowd_level)
	
	
func _process(delta: float) -> void:
	crowd_level -= deterioration_rate * delta
	crowd_level_changed.emit(crowd_level)
	

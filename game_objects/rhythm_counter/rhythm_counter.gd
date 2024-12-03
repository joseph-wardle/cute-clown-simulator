extends Timer

enum InputType {
	PERFECT,
	GOOD,
	OK,
	MISS
}
	
signal beat
signal input_result(input_type: InputType)

@export var perfect_window := 200.0 
@export var good_window := 300.0
@export var ok_window := 400.0

@export var bpm: float:
	get:
		return 60.0 / wait_time if wait_time > 0 else 0.0
	set(value):
		wait_time = 60.0 / value if value > 0 else 0.0

var last_beat_time: float = 0.0
var perfect_half_window: float
var good_half_window: float
var ok_half_window: float
var delta : float

func _ready() -> void:
	_update_half_windows()
	bpm = 108
	
	
func _update_half_windows() -> void:
	perfect_half_window = perfect_window / 2
	good_half_window = good_window / 2
	ok_half_window = ok_window / 2


func _input(event):
	if event.is_action_pressed("beat"):
		var input_time := Time.get_ticks_msec()
		delta = _calculate_delta(input_time)
		var result := _get_input_result(delta)
		emit_signal("input_result", result)
		print(result)


func _calculate_delta(input_time: float) -> float:
	var beat_interval := wait_time * 1000.0 # convert to ms
	var ms_since_last_beat := input_time - last_beat_time
	delta = fposmod(ms_since_last_beat, beat_interval)
	if delta > beat_interval / 2:
		delta = beat_interval - delta
	return delta
	
	
func _get_input_result(delta: float) -> InputType:
	if delta <= perfect_half_window:
		return InputType.PERFECT
	elif delta <= good_half_window:
		return InputType.GOOD
	elif delta <= ok_half_window:
		return InputType.OK
	else:
		return InputType.MISS

func _on_timeout() -> void:
	emit_signal("beat")
	last_beat_time = Time.get_ticks_msec()
	print("BEAT")

extends Timer

enum InputType {
	PERFECT,
	GOOD,
	OK,
	MISS
}
	
signal beat
signal input_result(input_type: InputType)

@export var perfect_window := 250.0 
@export var good_window := 300.0
@export var ok_window := 400.0

@export var bpm: float:
	get: return _calculate_bpm()
	set(new_bpm): _update_wait_time(new_bpm)

var last_beat_time_ms := 0.0
var perfect_window_half: float
var good_window_half: float
var ok_window_half: float
var current_offset_ms : float
var is_intro := true

func _ready() -> void:
	_refresh_window_halves()
	bpm = 108


func _calculate_bpm() -> float:
	return 60.0 / wait_time if wait_time > 0 else 0.0


func _update_wait_time(new_bpm: float) -> void:
	wait_time = 60.0 / new_bpm if new_bpm > 0 else 0.0


func reset_beat() -> void:
	last_beat_time_ms = Time.get_ticks_msec()
	emit_signal("beat")


func _refresh_window_halves() -> void:
	perfect_window_half = perfect_window * 0.5
	good_window_half = good_window * 0.5
	ok_window_half = ok_window * 0.5


func _input(event):
	if event.is_action_pressed("beat") and not is_intro:
		var input_time_ms := Time.get_ticks_msec()
		current_offset_ms = _calculate_input_offset(input_time_ms)
		var accuracy := _evaluate_input_accuracy(current_offset_ms)
		emit_signal("input_result", accuracy)

func _calculate_input_offset(input_time_ms: float) -> float:
	var beat_duration_ms := wait_time * 1000.0 # convert to ms
	var ms_elapsed_since_last_beat := input_time_ms - last_beat_time_ms
	var offset := fposmod(ms_elapsed_since_last_beat, beat_duration_ms)
	if offset > beat_duration_ms * 0.5:
		offset = beat_duration_ms - offset
	return offset


func _evaluate_input_accuracy(delta: float) -> InputType:
	if delta <= perfect_window_half:
		return InputType.PERFECT
	elif delta <= good_window_half:
		return InputType.GOOD
	elif delta <= ok_window_half:
		return InputType.OK
	else:
		return InputType.MISS


func _on_timeout() -> void:
	emit_signal("beat")
	last_beat_time_ms = Time.get_ticks_msec()


func _on_clown_level_changed(level: int) -> void:
	match level:
		2:
			_apply_difficulty(150.0, 200.0, 225.0, 126.0)
		3:
			_apply_difficulty(125.0, 160.0, 200.0, 141.0)
		4:
			_apply_difficulty(100.0, 130.0, 160.0, 161.0)
		5:
			_apply_difficulty(75.0, 100.0, 130.0, 189.0)


func _apply_difficulty(perfect: float, good: float, ok: float, new_bpm: float) -> void:
	perfect_window = perfect
	good_window = good
	ok_window = ok
	bpm = new_bpm
	_refresh_window_halves()

func _on_music_controller_is_intro(controller_is_intro: bool) -> void:
	is_intro = controller_is_intro
	

	

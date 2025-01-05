@tool
extends PathFollow3D

@export var process := true
@export var this_progress_ratio : float = 0.0

@onready var timer = get_node("../RhythmCounter")

signal send_progress_ratio(curr_progress_ratio)

func _ready() -> void:
	set_progress_ratio(this_progress_ratio)
	
func _process(delta) -> void:
	if not process or not timer:
		return

	var beat_duration : float = 60.0 / timer.bpm
	progress_ratio += delta / beat_duration
	progress_ratio = fposmod(progress_ratio, 1.0)


func _on_rhythm_counter_timeout() -> void:
	progress_ratio = 1.0


func _on_projectile_arch_need_progress_ratio() -> void:
	send_progress_ratio.emit(progress_ratio)

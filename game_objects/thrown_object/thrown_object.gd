extends Node3D

@export var up_speed: float = 4.59
@export var down_speed: float = 4.59
@export var flash_warning_duration: float = 3.0
@export var random_pos_range_x: float = 15.0
@export var reset_position_y: float = -25.0

@export var go_up := false
@export var flash_warning := false
@export var go_down := false
@export var done := false

var rng := RandomNumberGenerator.new()
var timer := 0.0
var flash_time_left := 0.0
var flash_started := false
var flash_increasing := true
var sound_played_down := false

func _ready() -> void:
	rng.randomize()
	position.x = rng.randf_range(-random_pos_range_x, random_pos_range_x)
	flash_time_left = flash_warning_duration
	
	# Connect signals if not already done in the editor:
	#$BallFallArea.connect("area_entered", self, "_on_ball_fall_area_entered")

func _process(delta: float) -> void:
	timer += delta
	
	# 1) Trigger up throw after 1 second (if not already going up).
	if not go_up and timer > 1.0:
		go_up = true
	
	# 2) Handle upward throw along "Up/PathFollow3D"
	if go_up:
		_handle_up_throw(delta)

	# 3) If up throw is done, enable flash warning
	if $Up/PathFollow3D.progress_ratio >= 1.0:
		flash_warning = true

	# 4) Flash warning logic (fade + blink) and countdown
	if flash_warning:
		_handle_flash_warning(delta)
		_handle_warning_blink(delta)
		if flash_time_left <= 0.0:
			go_down = true

	# 5) Handle downward motion along "Down/PathFollow3D"
	if go_down:
		_handle_go_down(delta)

#
# ========== SIGNAL HANDLERS ==========
#
func _on_ball_fall_area_entered(area: Area3D) -> void:
	# Hide and reset position (old ball_falling.gd logic)
	visible = false
	position.y = reset_position_y

#
# ========== INTERNAL METHODS ==========
#
func _handle_up_throw(delta: float) -> void:
	var follow = $Up/PathFollow3D
	if follow.progress_ratio < 1.0:
		follow.progress += up_speed * delta
		if follow.progress_ratio >= 0.99:
			follow.progress_ratio = 1.0
			follow.visible = false

func _handle_flash_warning(delta: float) -> void:
	# Fading alpha in "Down/FlashWarning" sprite (old flash_warning.gd)
	if not flash_started:
		flash_started = true
		$Down/FlashWarning.modulate.a = 0.5
		$Down/FlashWarning/AudioStreamPlayer3D.play()

	if flash_time_left > 0.0:
		var alpha_val = $Down/FlashWarning.modulate.a
		if alpha_val <= 0.5:
			flash_increasing = true
		elif alpha_val >= 1.0:
			flash_increasing = false

		var fade_speed = 2.0 * delta
		alpha_val += fade_speed if flash_increasing else -fade_speed
		$Down/FlashWarning.modulate.a = clamp(alpha_val, 0.0, 1.0)
		flash_time_left -= delta
	else:
		$Down/FlashWarning.modulate.a = 1.0

func _handle_warning_blink(delta: float) -> void:
	# Blinks the "Down/Warning" sprite each frame (old warning.gd logic).
	# If you want a slower blink, you can store a small blink-timer 
	# instead of toggling every single frame.
	if $Down/Warning:
		$Down/Warning.visible = !$Down/Warning.visible

func _handle_go_down(delta: float) -> void:
	var follow = $Down/PathFollow3D
	if follow.progress_ratio < 1.0:
		if follow.progress_ratio < 0.2 and not sound_played_down:
			$Down/PathFollow3D/AudioStreamPlayer3D.play()
			sound_played_down = true
		follow.progress += down_speed * delta
		if follow.progress_ratio >= 0.99:
			follow.progress_ratio = 1.0
			follow.visible = false
			done = true

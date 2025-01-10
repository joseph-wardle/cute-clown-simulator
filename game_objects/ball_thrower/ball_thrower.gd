extends Node3D

enum IndicatorState { FLASHING, HIDDEN }
enum IndicatorFlashDirection { INCREASE, DECREASE }

signal ball_caught()
signal ball_missed()

@export var spawn_range := 5.0
@export var flash_speed := 3.0
@export var ball_speed := 10.0

var thrown_ball: PackedScene =  preload("res://game_objects/thrown_ball/thrown_ball.tscn")
var current_offset           := 0.0
var initial_ball_position    := Vector3(0.0, 0.0, -8.0)

var indicator_state := IndicatorState.HIDDEN
var indicator_alpha := 0.0
var indicator_flash_direction := IndicatorFlashDirection.INCREASE

@onready var indicator : Sprite3D = $Indicator
@onready var warning_sound_player : AudioStreamPlayer = $WarningSoundPlayer


func _ready() -> void:
	indicator.modulate.a = indicator_alpha

	
func _process(delta: float) -> void:
	if indicator_state == IndicatorState.FLASHING:
		_flash_indicator(delta)
		

func _flash_indicator(delta: float) -> void:
	print(indicator_alpha)
	if indicator_flash_direction == IndicatorFlashDirection.INCREASE:
		indicator_alpha += flash_speed * delta
		if indicator_alpha >= 1.0:
			indicator_alpha = 1.0
			indicator_flash_direction = IndicatorFlashDirection.DECREASE
	else:
		indicator_alpha -= flash_speed * delta
		if indicator_alpha <= 0.0:
			indicator_alpha = 0.0
			indicator_flash_direction = IndicatorFlashDirection.INCREASE
	indicator.modulate.a = indicator_alpha
	

func _on_began_decending() -> void:
	indicator_state = IndicatorState.FLASHING
	warning_sound_player.play()
	


func _throw_ball() -> void:
	current_offset = randf_range(-spawn_range, spawn_range)
	indicator.position.x = current_offset
	
	var thrown_ball_instance := thrown_ball.instantiate()
	add_child(thrown_ball_instance)
	thrown_ball_instance.position = initial_ball_position
	thrown_ball_instance.position.x += current_offset
	thrown_ball_instance.speed = ball_speed
	thrown_ball_instance.connect("began_decending", _on_began_decending)
	thrown_ball_instance.connect("collided", _on_ball_area_entered)


func _on_throw_interval_timer_timeout() -> void:
	_throw_ball()
	
	
func _on_ball_area_entered(_area: Area3D, is_caught: bool) -> void:
	if is_caught:
		emit_signal("ball_caught")
	else:
		emit_signal("ball_missed")
	indicator_state = IndicatorState.HIDDEN
	indicator.modulate.a = 0.0
	

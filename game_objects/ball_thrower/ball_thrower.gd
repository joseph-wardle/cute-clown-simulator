extends Node3D

enum IndicatorState { FLASHING, HIDDEN }
enum IndicatorFlashDirection { INCREASE, DECREASE }

signal ball_caught
signal ball_missed

@export var spawn_range := 5.0
@export var flash_speed := 3.0
@export var ball_speed := 10.0

@onready var indicator : Sprite3D = $Indicator
@onready var warning_sound_player : AudioStreamPlayer = $WarningSoundPlayer

var thrown_ball: PackedScene =  preload("res://game_objects/thrown_ball/thrown_ball.tscn")

var indicator_state := IndicatorState.HIDDEN
var indicator_alpha := 0.0
var flash_direction := IndicatorFlashDirection.INCREASE

const INITIAL_BALL_POSITION := Vector3(0.0, 0.0, -8.0)


func _ready() -> void:
	_update_indicator_alpha()

	
func _process(delta: float) -> void:
	if indicator_state == IndicatorState.FLASHING:
		_update_flashing_indicator(delta)
		

func _update_flashing_indicator(delta: float) -> void:
	if flash_direction == IndicatorFlashDirection.INCREASE:
		indicator_alpha += flash_speed * delta
		if indicator_alpha >= 1.0:
			indicator_alpha = 1.0
			flash_direction = IndicatorFlashDirection.DECREASE
	else:
		indicator_alpha -= flash_speed * delta
		if indicator_alpha <= 0.0:
			indicator_alpha = 0.0
			flash_direction = IndicatorFlashDirection.INCREASE
	_update_indicator_alpha()
	

func _update_indicator_alpha() -> void:
	indicator.modulate.a = indicator_alpha


func _on_began_decending() -> void:
	indicator_state = IndicatorState.FLASHING
	warning_sound_player.play()


func _throw_ball() -> void:
	var offset := randf_range(-spawn_range, spawn_range)
	indicator.position.x = offset
	
	var ball_instance := thrown_ball.instantiate()
	add_child(ball_instance)
	ball_instance.position = INITIAL_BALL_POSITION
	ball_instance.position.x += offset
	ball_instance.speed = ball_speed
	ball_instance.connect("began_decending", _on_began_decending)
	ball_instance.connect("collided", _on_ball_area_entered)


func _on_throw_interval_timer_timeout() -> void:
	_throw_ball()


func _on_ball_area_entered(_area: Area3D, is_caught: bool) -> void:
	if is_caught:
		emit_signal("ball_caught")
	else:
		emit_signal("ball_missed")
	_reset_indicator()


func _reset_indicator() -> void:
	indicator_state = IndicatorState.HIDDEN
	indicator_alpha = 0.0
	_update_indicator_alpha()
	

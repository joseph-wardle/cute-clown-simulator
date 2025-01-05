extends Node

var level1_intro := preload("res://assets/audio/music/lv1-intro.wav")
var level1_loop  := preload("res://assets/audio/music/lv1-loop.wav")
var level2_intro := preload("res://assets/audio/music/lv2-intro.wav")
var level2_loop  := preload("res://assets/audio/music/lv2-loop.wav")
var level3_intro := preload("res://assets/audio/music/lv3-intro.wav")
var level3_loop  := preload("res://assets/audio/music/lv3-loop.wav")
var level4_intro := preload("res://assets/audio/music/mus_lv4-intro.wav")
var level4_loop  := preload("res://assets/audio/music/mus_lv4-loop.wav")
var finale_intro := preload("res://assets/audio/music/mus_finale-intro.wav")
var finale_loop  := preload("res://assets/audio/music/mus_finale.wav")

signal is_intro(is_intro: bool)

func _ready():
	$IntroPlayer.stream = level1_intro
	is_intro.emit(true)
	$IntroPlayer.play()
	$IntroPlayer.connect("finished", self._on_intro_finished)
	
	$LoopPlayer.stream = level1_loop
	$LoopPlayer.connect("finished", self._on_loop_finished)
	
func _on_intro_finished():
	$IntroPlayer.stream = null
	is_intro.emit(false)
	$LoopPlayer.play()
	
	
func _on_loop_finished():
	$LoopPlayer.play()


func _on_clown_level_changed(level: int) -> void:
	match level:
		2:
			_play_new_intro_loop(level2_intro, level2_loop)
		3:
			_play_new_intro_loop(level3_intro, level3_loop)
		4:
			_play_new_intro_loop(level4_intro, level4_loop)
		5:
			_play_new_intro_loop(finale_intro, finale_loop)

func _play_new_intro_loop(intro_stream: AudioStream, loop_stream: AudioStream) -> void:
	$IntroPlayer.stream = intro_stream
	$LoopPlayer.stream = loop_stream
	is_intro.emit(true)
	$IntroPlayer.play()
	$IntroPlayer.connect("finished", self._on_intro_finished)
	$LoopPlayer.connect("finished", self._on_loop_finished)
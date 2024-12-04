extends Node

var level1_intro: AudioStream = preload("res://assets/audio/music/lv1-intro.wav")
var level1_loop: AudioStream = preload("res://assets/audio/music/lv1-loop.wav")
var level2_intro: AudioStream = preload("res://assets/audio/music/lv2-intro.wav")
var level2_loop: AudioStream = preload("res://assets/audio/music/lv2-loop.wav")
var level3_intro: AudioStream = preload("res://assets/audio/music/lv3-intro.wav")
var level3_loop: AudioStream = preload("res://assets/audio/music/lv3-loop.wav")
var level4_intro: AudioStream = preload("res://assets/audio/music/mus_lv4-intro.wav")
var level4_loop: AudioStream = preload("res://assets/audio/music/mus_lv4-loop.wav")
var finale_intro: AudioStream = preload("res://assets/audio/music/mus_finale-intro.wav")
var finale_loop: AudioStream = preload("res://assets/audio/music/mus_finale.wav")


func _ready():
	$IntroPlayer.stream = level1_intro
	$IntroPlayer.play()
	$IntroPlayer.connect("finished", self._on_intro_finished)
	
	$LoopPlayer.stream = level1_loop
	$LoopPlayer.connect("finished", self._on_loop_finished)
	
	
func _on_intro_finished():
	$IntroPlayer.stream = null
	$LoopPlayer.play()
	
	
func _on_loop_finished():
	$LoopPlayer.play()


func _on_clown_level_changed(level: int) -> void:
	match level:
		2:
			$IntroPlayer.stream = level2_intro
			$LoopPlayer.stream = level2_loop
		3:
			$IntroPlayer.stream = level3_intro
			$LoopPlayer.stream = level3_loop
		4:
			$IntroPlayer.stream = level4_intro
			$LoopPlayer.stream = level4_loop
		5:
			$IntroPlayer.stream = finale_intro
			$LoopPlayer.stream = finale_loop
	$IntroPlayer.play()
	$IntroPlayer.connect("finished", self._on_intro_finished)
	$LoopPlayer.connect("finished", self._on_loop_finished)

extends Node

var level1_intro: AudioStream = preload("res://assets/audio/music/lv1-intro.wav")
var level1_loop: AudioStream = preload("res://assets/audio/music/lv1-loop.wav")
var level2_intro: AudioStream = preload("res://assets/audio/music/lv2-intro.wav")
var level2_loop: AudioStream = preload("res://assets/audio/music/lv2-loop.wav")
var level3_intro: AudioStream = preload("res://assets/audio/music/lv3-intro.wav")
var level3_loop: AudioStream = preload("res://assets/audio/music/lv3-loop.wav")

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

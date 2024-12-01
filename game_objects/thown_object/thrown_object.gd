extends Node3D

@export var go_up : bool = false
@export var flash_warning : bool = false 
@export var go_down : bool = false
@export var done : bool = false

var up_path : Path3D = null
var up_path_follow : PathFollow3D = null
var down_path : Path3D = null
var flash_warning_sprite : Sprite3D = null
var down_path_follow : PathFollow3D = null
var speed = 10
var timer = 0

func _ready():
	up_path = get_node("Up")
	up_path_follow = get_node("Up/PathFollow3D")
	down_path = get_node("Down")
	down_path_follow = get_node("Down/PathFollow3D")
	flash_warning_sprite = get_node("Down/FlashWarning")
	
	
func _process(delta):
	timer += delta
	
	#step 1 if its been after a second and before the animation is done
	if up_path_follow && up_path:
		if(timer > 1):
			go_up = true
	
	#step 2 enable flash warning
	if down_path_follow && down_path:
		if up_path_follow.progress_ratio == 1:
			flash_warning = true
		if flash_warning_sprite.duration == 0:
			go_down = true
		if down_path_follow.progress_ratio == 1:
			done = true
		


func _on_crowd_meter_crowd_level_changed(crowd_level: Variant) -> void:
	pass # Replace with function body.

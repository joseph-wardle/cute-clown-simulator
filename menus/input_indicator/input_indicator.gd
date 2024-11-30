extends Sprite3D

@export var miss : Texture2D
@export var ok : Texture2D
@export var good : Texture2D
@export var perfect : Texture2D


func _on_rhythm_counter_input_result(input_type: int) -> void:
	match input_type:
		3:
			texture = miss
		2:
			texture = ok
		1:
			texture = good
		0:
			texture = perfect
	
	$AnimationPlayer.play("flash")
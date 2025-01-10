extends Node3D

enum State { GOING_UP, GOING_DOWN }

signal began_decending()
signal collided(area: Area3D, is_caught: bool)

var speed := 0.0

var state := State.GOING_UP

	
func _process(delta: float) -> void:
	match state:
		State.GOING_UP:
			position.y += speed * delta
		State.GOING_DOWN:
			position.y -= speed * delta

	
func _on_timer_timeout() -> void:
	state = State.GOING_DOWN
	position.z = 0.0
	emit_signal("began_decending")
	
	


func _on_collision_area_entered(area: Area3D) -> void:
	if area.get_collision_layer_value(1):
		emit_signal("collided", area, true)
	else:
		emit_signal("collided", area, false)
		
	queue_free()

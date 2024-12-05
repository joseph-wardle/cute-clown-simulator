extends AnimationPlayer

func _ready():
	set_current_animation("Take 001")
	active = true
	speed_scale = 1.2


func _on_projectile_arch_number_of_balls_changes(num_of_balls: int) -> void:
	if(num_of_balls == 2):
		speed_scale *= 2
	if(num_of_balls % 2 != 0 && num_of_balls <= 5):
		speed_scale *= 2

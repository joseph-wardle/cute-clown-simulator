extends MeshInstance3D

var speed = .1
var movement = 0
var rng = RandomNumberGenerator.new()
var random_start = rng.randf_range(-10, 10)
var max_height = .05
var excitement = 5.0 

func _ready():
	movement += random_start

func _process(delta):
	movement += speed * excitement
	position.y += sin(movement) * max_height


func _on_crowd_meter_crowd_level_changed(crowd_level: Variant) -> void:
	if crowd_level > 0:
		excitement = crowd_level/25 + 1
		max_height = excitement/100
	if crowd_level <= 0:
		max_height = 0

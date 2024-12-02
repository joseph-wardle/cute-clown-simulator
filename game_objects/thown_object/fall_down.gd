extends Path3D

var rng = RandomNumberGenerator.new()

func _ready():
	position.x = rng.randf_range(-15, 15)

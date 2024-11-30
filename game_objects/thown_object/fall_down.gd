extends Path3D

var rng = RandomNumberGenerator.new()

func _ready():
	position.x = rng.randf_range(-25, 25)
	print("new position = ", position.x)
		

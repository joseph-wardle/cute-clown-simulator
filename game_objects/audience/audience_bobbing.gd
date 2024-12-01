extends MeshInstance3D

var speed = .1
var movement = 0
var excitement = 1
var rng = RandomNumberGenerator.new()
var random_start = rng.randf_range(-10, 10)
var max_height = .01

func _ready():
	movement += random_start

func _process(delta):
	movement += speed * excitement
	position.y += sin(movement) * max_height

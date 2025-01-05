extends MeshInstance3D

@export var speed := 5.0
@export var base_excitement := 2.0
@export var max_height := 4.0

var excitement := base_excitement
var movement := 0.0
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	movement += rng.randf_range(-10.0, 10.0)

func _process(delta) -> void:
	movement += speed * excitement * delta
	position.y += sin(movement) * max_height * delta


func _on_crowd_level_changed(crowd_level: float) -> void:
	if crowd_level > 0:
		crowd_level -= 50.0
		excitement = base_excitement + (crowd_level / 30.0)
		max_height = excitement / 2.0
	else:
		max_height = 0.0

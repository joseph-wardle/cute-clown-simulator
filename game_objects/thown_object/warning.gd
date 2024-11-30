extends Sprite3D

# Time to flash in seconds
var flash_duration: float = 1.5

func _process(delta):
	if get_parent().get_parent().flash_warning:
		visible = !visible  # Toggle visibility
		# Schedule the next toggle if still flashing
		if flash_duration > 0:
			flash_duration -= delta
		else:
			visible = false  # Make invisible after flashings

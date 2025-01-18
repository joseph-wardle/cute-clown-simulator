extends LineEdit

func sort_ascending(a, b):
	if a[1] > b[1]:
		return true
	return false

func _on_text_submitted(new_text: String) -> void:
	editable = false
	Global.leaderboard.append_array([[new_text,Global.current_score]])
	Global.leaderboard.sort_custom(sort_ascending)
	Global.save()
	Global.save_game()

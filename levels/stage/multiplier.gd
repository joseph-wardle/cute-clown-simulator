extends RichTextLabel

var multiplier = 1

signal multiplier_changed(multiplier_num: int)


func _ready():
	# Customize the RichTextLabel appearance
	bbcode_enabled = true
	set_text_color("yellow")
	update_score_display()
	
func set_text_color(color: String):
	# Set up a BBCode color style for the text
	push_color((color))
	pop()
	
func update_score_display():
	clear()  # Clear the label before updating 
	append_text("[color=red]X: [/color][color=yellow]" + str(multiplier) + " [/color][color=white]" + "[/color]")
	
func _on_rhythm_counter_input_result(input_type: int) -> void:
	if(input_type == 0):
		multiplier += 1
	else:
		multiplier = 1
	multiplier_changed.emit(multiplier)
	update_score_display()

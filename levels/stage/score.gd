extends RichTextLabel

var score = 0
var perfect_score = 1000
var good_score = 250
var ok_score = 50
var multiplier = 0

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
	append_text("[color=red]SCORE: [/color][color=yellow]" + str(score) + " [/color][color=white]" + "[/color]")
	
func _on_rhythm_counter_input_result(input_type: int) -> void:
	match input_type:
		0:
			score += perfect_score * multiplier
		1:
			score += good_score * multiplier
		2:
			score += ok_score * multiplier
			
	update_score_display()
	


func _on_multiplier_multiplier_changed(multiplier_num: int) -> void:
	multiplier = multiplier_num

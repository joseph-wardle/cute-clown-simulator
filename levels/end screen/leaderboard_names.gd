extends LineEdit

@export var place_num = 0
@export var name_or_score = 0
func _ready():
	if(name_or_score == 1):
		text = str(int(Global.leaderboard[place_num-1][name_or_score]))
	else:
		text = str(Global.leaderboard[place_num-1][name_or_score])

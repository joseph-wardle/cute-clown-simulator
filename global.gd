extends Node

func _ready():
	save_game()
	load_game()

#these are the things the player currently has in their own playthrough
var gimbo_gold: int = 5
var equipped_hat = null
var equipped_costume = null

#these are what the player could have
var available_hats = []
var available_costumes = []

#this is just something that the game needs
var leaderboard = [{"test1" : 100}, {"test2" : 100}, {"test3" : 100}, {"test4" : 100}, {"test5" : 100}] 

#here we are going to create save data for the global variables
func save():
	var save_dict = {
		"gimbo_gold" : gimbo_gold,
		"equipped_hat" : equipped_hat,
		"equipped_costume" : equipped_costume,
		"available_hats" : available_hats,
		"available_costumes" : available_costumes,
		"leaderboard" : leaderboard
	}
	return save_dict

func save_game():
	var save_file = FileAccess.open("user://savegame.save",FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	save_file.store_line(json_string)
	
func load_game():
	# first check if the file is there
	if not FileAccess.file_exists("user://savegame.save"):
		return
		
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Creates the helper class to interact with JSON.
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object.
		var node_data = json.data
		
		for i in node_data:
			match i:
				"available_costumes": available_costumes = node_data[i]
				"available_hats": available_hats = node_data[i]
				"equipped_costume": equipped_costume = node_data[i]
				"equipped_hat": equipped_hat = node_data[i]
				"gimbo_gold": gimbo_gold = node_data[i]
				"leaderboard": leaderboard = node_data[i]
				
		print(leaderboard)
				

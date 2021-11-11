extends Node

var player
var location = "user://save_game.dat"

var game_data  = {
	"Player": {
		"coins" : 0,
		"lives" : 5,
		"high_score" :0,
		"weapon_equiped" : 1,
		"Ak47_unlocked" : false,
		"Shotgun_unlocked" : false,
			}
	}

		
func _ready():
	load_save_game()
	print(game_data.Player.coins)
	#chargeT = game_data.get("Player","charge_time")


func save_game():
	print("saving game data")
	var file = File.new()
	file.open(location, File.WRITE)
	#file.open_encrypted_with_pass(location, File.WRITE, "goodnewsn")
	
	file.store_string(to_json(game_data))
	file.close()
	
func load_save_game():
	print("loading game data")
	var file = File.new()
	if file.file_exists(location):
		file.open(location, File.READ)
		#file.open_encrypted_with_pass(location, File.READ, "goodnewsn")
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			game_data = data
		else:
			printerr("corrupted data!")
	else:
		printerr("No Saved Data")























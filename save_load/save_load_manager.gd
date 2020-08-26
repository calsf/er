extends Node

const SAVE_PATH = "user://sav.json"

# Default data to be saved with new save file
var _default_data = {
	"Level0Time" : 0.00,
	"Level0Unlocked" : true,
	
	"Level1Time" : 0.00,
	"Level1Unlocked" : true,
	
	"Level2Time" : 0.00,
	"Level2Unlocked" : false,
	
	"Level3Time" : 0.00,
	"Level3Unlocked" : false,
	
	"Level4Time" : 0.00,
	"Level4Unlocked" : false,
	
	"Level5Time" : 0.00,
	"Level5Unlocked" : false,
	
	"Level6Time" : 0.00,
	"Level6Unlocked" : false,
	
	"Level7Time" : 0.00,
	"Level7Unlocked" : false,
	
	"Level8Time" : 0.00,
	"Level8Unlocked" : false,
	
	"Level9Time" : 0.00,
	"Level9Unlocked" : false,
	
	"Level10Time" : 0.00,
	"Level10Unlocked" : false,
	
	"Level11Time" : 0.00,
	"Level11Unlocked" : false
}

func save_data(data):
	# Create and open file
	var save_file = File.new()
	save_file.open_encrypted_with_pass(SAVE_PATH, File.WRITE, "plzdontcheat")
	
	# Convert data to json, store, and close file
	save_file.store_line(to_json(data))
	save_file.close()

func load_data():
	# If no file to load from, first create save file with default values
	var save_file = File.new()
	if not save_file.file_exists(SAVE_PATH):
		save_data(_default_data)
		
	# Open file
	save_file.open_encrypted_with_pass(SAVE_PATH, File.READ, "plzdontcheat")

	# Parse data then close file
	var data = parse_json(save_file.get_as_text())
	save_file.close()

	return data

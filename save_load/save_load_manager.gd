extends Node

const SAVE_PATH = "user://sav.json"

# Default data to be saved with new save file
var _default_data = {
	"Level0Time" : 0.00,
	
	"LevelsUnlocked" : false,
	
	"Level1Time" : 0.00,
	
	"Level2Time" : 0.00,
	
	"Level3Time" : 0.00,
	
	"Level4Time" : 0.00,
	
	"Level5Time" : 0.00,
	
	"Level6Time" : 0.00,
	
	"Level7Time" : 0.00,
	
	"Level8Time" : 0.00,
	
	"SoundMuted" : false
}

func save_data(data):
	# Create and open file
	var save_file = File.new()
	save_file.open_encrypted_with_pass(SAVE_PATH, File.WRITE, "")
	
	# Convert data to json, store, and close file
	save_file.store_line(to_json(data))
	save_file.close()

func load_data():
	# If no file to load from, first create save file with default values
	var save_file = File.new()
	if not save_file.file_exists(SAVE_PATH):
		save_data(_default_data)
		
	# Open file
	save_file.open_encrypted_with_pass(SAVE_PATH, File.READ, "")

	# Parse data then close file
	var data = parse_json(save_file.get_as_text())
	save_file.close()
	
	# Renew save data if does not match expected structure
	var is_valid = true
	for k in _default_data.keys():
		if not k in data.keys():
			is_valid = false
	if not is_valid:
		save_data(_default_data)
		return _default_data
	else:
		return data

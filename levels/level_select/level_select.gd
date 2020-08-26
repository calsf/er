extends Control

var scene_to_load = ""
onready var level_buttons = $HBoxContainer/LevelButtons
onready var first_button = $HBoxContainer/LevelButtons/LevelButton0
onready var best_time = $HBoxContainer/Sidebar/BestTime/TimeText
onready var title = $HBoxContainer/Sidebar/Title
onready var fade = $Fade	# Fade will block clicks while shown
onready var save_load_manager = $SaveLoadManager
onready var save_data = save_load_manager.load_data()

var level_key = ""
var level_name = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	fade.show()
	fade.fade_out()
	
	# When any of the buttons are pressed, set scene to load and transition to it
	# When focused on a button, display the corresponding details about the level
	for button in level_buttons.get_children():
		button.connect("pressed", self, "_set_scene_to_load", [button.scene_to_load])
		button.connect("focus_entered", self, "_display_focused_level", [button.level_num, button.level_name])
		if !save_data[str("Level", button.level_num, "Unlocked")]:
			button.disabled = true
			button.focus_mode = false

# Set scene to load and begin fade
func _set_scene_to_load(scene):
	scene_to_load = scene
	# Remove focus to prevent input while transitioning scene
	for button in level_buttons.get_children():
		button.focus_mode = false
	fade.fade_in()

# Display details about selected level
func _display_focused_level(level_num, level_name):
	# Display level name
	title.text = level_name
	
	# Display saved best time
	var best = save_data[str("Level", level_num, "Time")]	# Get current saved best time
	
	if (best == 0):
		best_time.text = "--.--.--"
	else:
		var best_minutes = best / 60
		var best_seconds = fmod(best, 60.0)
		
		# Display time
		best_time.text = str("%0*d" % [2, best_minutes], "." , "%0*.*f" % [5, 2, best_seconds])

# Once fade in is finished, change to the scene to be loaded
func _on_Fade_fade_in_finished():
	get_tree().change_scene(scene_to_load)

# Once fade out is finished, activate button focus
func _on_Fade_fade_out_finished():
	first_button.grab_focus()	# Grab focus for keyboard input

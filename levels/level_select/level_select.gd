extends Control

const SOUND_OFF_ICON = preload("res://levels/level_select/sound_off.png")
const SOUND_ON_ICON = preload("res://levels/level_select/sound_on.png")

var scene_to_load = ""
onready var level_buttons = $HBoxContainer/LevelButtons
onready var first_button = $HBoxContainer/LevelButtons/LevelButton0
onready var best_time = $HBoxContainer/Sidebar/BestTime/TimeText
onready var title = $HBoxContainer/Sidebar/Title
onready var fade = $Fade	# Fade will block clicks while shown
onready var save_load_manager = $SaveLoadManager
onready var save_data = save_load_manager.load_data()
onready var sounds = $Sounds
onready var keyboard_controls = $KeyboardControls
onready var gamepad_controls = $GamepadControls
onready var sound_icon = $SoundIcon

var level_key = ""
var level_name = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	fade.show()
	fade.fade_out()
	_set_sound_icon()
	
	# Set visibility of controls
	if (Globals.is_keyboard):
		keyboard_controls.visible = true
		gamepad_controls.visible = false
	else:
		keyboard_controls.visible = false
		gamepad_controls.visible = true
	
	# When any of the buttons are pressed, set scene to load and transition to it
	# When focused on a button, display the corresponding details about the level
	for button in level_buttons.get_children():
		button.connect("pressed", self, "_set_scene_to_load", [button.scene_to_load])
		button.connect("focus_entered", self, "_display_focused_level", [button.level_num, button.level_name])
		if !save_data["LevelsUnlocked"]:
			button.disabled = true
			button.focus_mode = false
	
	# Always have level 0 unlocked
	if !save_data["LevelsUnlocked"]:
		level_buttons.get_node("LevelButton0").disabled = false
		level_buttons.get_node("LevelButton0").focus_mode = true
			
func _input(event):
	# Change visibility of controls based on input type
	if event is InputEventKey:
		Globals.is_keyboard = true
		keyboard_controls.visible = true
		gamepad_controls.visible = false
	elif event is InputEventJoypadButton:
		Globals.is_keyboard = false
		keyboard_controls.visible = false
		gamepad_controls.visible = true

	# Toggle sound off or on and save setting
	if Input.is_key_pressed(KEY_G) or Input.is_joy_button_pressed(0, 3):
		save_data["SoundMuted"] = !save_data["SoundMuted"]
		save_load_manager.save_data(save_data)
		sounds.load_data()
		_set_sound_icon()

# Set scene to load and begin fade
func _set_scene_to_load(scene):
	sounds.play("ButtonPressed")
	scene_to_load = scene
	# Remove focus to prevent input while transitioning scene
	for button in level_buttons.get_children():
		button.focus_mode = false
	fade.fade_in()

# Display details about selected level
func _display_focused_level(level_num, level_name):
	sounds.play("ButtonFocused")
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

# Set image of sound icon based on saved sound setting
func _set_sound_icon():
	if (save_data["SoundMuted"]):
		sound_icon.set_texture(SOUND_OFF_ICON)
	else:
		sound_icon.set_texture(SOUND_ON_ICON)

# Once fade in is finished, change to the scene to be loaded
func _on_Fade_fade_in_finished():
	get_tree().change_scene(scene_to_load)

# Once fade out is finished, activate button focus
func _on_Fade_fade_out_finished():
	first_button.grab_focus()	# Grab focus for keyboard input

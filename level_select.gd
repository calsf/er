extends Control

var scene_to_load = ""
onready var level_buttons = $LevelButtons
onready var first_button = $LevelButtons/Level1Button
onready var fade = $Fade	# Fade will block clicks while shown

# Called when the node enters the scene tree for the first time.
func _ready():
	fade.show()
	fade.fade_out()
	
	# When any of the buttons are pressed, set scene to load and transition to it
	for button in level_buttons.get_children():
		button.connect("pressed", self, "_set_scene_to_load", [button.scene_to_load])

# Set scene to load and begin fade
func _set_scene_to_load(scene):
	scene_to_load = scene
	# Remove focus to prevent input while transitioning scene
	for button in level_buttons.get_children():
		button.focus_mode = false
	fade.show()
	fade.fade_in()

# Once fade in is finished, change to the scene to be loaded
func _on_Fade_fade_in_finished():
	get_tree().change_scene(scene_to_load)

# Once fade out is finished, activate button focus and hide the fade
func _on_Fade_fade_out_finished():
	first_button.grab_focus()	# Grab focus for keyboard input
	fade.hide()

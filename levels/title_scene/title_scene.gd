extends CanvasLayer

var is_exiting = false
onready var fade = $Fade

# Play fade out when scene starts
func _ready():
	fade.fade_out()

func _input(event):
	# When any key is pressed, go to level select
	if (!is_exiting and event is InputEventKey or event is InputEventJoypadButton):
		# Change visibility of displayed controls for level select based on input type
		if event is InputEventKey:
			Globals.is_keyboard = true
		elif event is InputEventJoypadButton:
			Globals.is_keyboard = false
		
		start_leaving_scene()

# Once fade in is finished, return to level select
func _on_Fade_fade_in_finished():
	if (is_exiting):
		get_tree().change_scene("res://levels/level_select/LevelSelect.tscn")

# Toggles fade and will change scene once fade finishes
func start_leaving_scene():
		fade.show()
		fade.fade_in()
		is_exiting = true

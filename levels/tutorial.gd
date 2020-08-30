extends Node2D

onready var keyboard_controls = $KeyboardControls
onready var gamepad_controls = $GamepadControls

func _ready():
	# Set visibility of controls
	if (Globals.is_keyboard):
		keyboard_controls.visible = true
		gamepad_controls.visible = false
	else:
		keyboard_controls.visible = false
		gamepad_controls.visible = true

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

extends Button

# Hold the path to the scene to load if this button is pressed
export var scene_to_load = ""
export var level_num = 0
export var level_name = ""

func _ready():
	text = str(level_num)

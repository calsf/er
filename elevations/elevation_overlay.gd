extends TileMap

export var overlay_elevation = 0
onready var player = get_node("../YSortWorldObjects/Player")

func _process(delta):
	if (player.ground_elevation < overlay_elevation):
		visible = true
	else:
		visible = false

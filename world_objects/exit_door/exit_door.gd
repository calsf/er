extends StaticBody2D

export var elevation = 0
export var layer_num = 0
onready var fade = get_node("../../PlayerHUD/Fade")
var is_exiting = false

func _ready():
	# Set z index based on elevation
	z_index = elevation / (Globals.ELEVATION_UNIT)
	# Set collision layer to corresponding elevation but one elevation unit higher so player collides
	set_collision_layer_bit(layer_num, true)

# Player can enter at same elevation or one jump higher
# One jump will not be enough to jump over door so can still catch entry
# Start fade in upon entering
func _on_ExitArea_body_entered(body):
	if (body.name == "Player" and body.get_curr_elevation() <= (elevation + body.MAX_HEIGHT)):
		body.hide()
		body.player_stopped = true
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

extends StaticBody2D

export var elevation = 32
onready var fade = get_node("../../CanvasLayer/Fade")
var is_exiting = false

func _ready():
	# Set z index based on elevation
	z_index = elevation / (GlobalConst.ELEVATION_UNIT)
	# Set collision layer to corresponding elevation but one elevation unit higher so player collides
	set_collision_layer_bit( 2 + ((elevation / GlobalConst.ELEVATION_UNIT) * 4), true)

# Player can enter at same elevation or one jump higher
# One jump will not be enough to jump over door so can still catch entry
# Start fade in upon entering
func _on_ExitArea_body_entered(body):
	if (body.name == "Player" and body.get_curr_elevation() <= (elevation + body.MAX_HEIGHT)):
		body.hide()
		body.player_stopped = true
		fade.show()
		fade.fade_in()
		is_exiting = true

# Once fade in is finished, return to leve select
func _on_Fade_fade_in_finished():
	if (is_exiting):
		get_tree().change_scene("res://LevelSelect.tscn")

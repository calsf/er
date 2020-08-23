extends Node2D

export var elevation = 32

signal level_finished

func _ready():
	# Set z index based on object elevation
	z_index = elevation / (GlobalConst.ELEVATION_UNIT)

# When player enters area, level is complete
func _on_FinishArea_body_entered(body):
	if (body.name == "Player"):
		body.player_stopped = true	# Will stop getting player input
		emit_signal("level_finished")

extends StaticBody2D

export var elevation = 0

func _ready():
	# Set z index based on object elevation
	z_index = elevation / (GlobalConst.ELEVATION_UNIT)

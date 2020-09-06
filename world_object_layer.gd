extends StaticBody2D

export var elevation = 0

func _ready():
	z_index = elevation / (Globals.ELEVATION_UNIT)
	set_collision_layer_bit( 4 + ((elevation / (Globals.ELEVATION_UNIT)) * 2), true)

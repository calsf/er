extends Area2D

export var knockback_strength = 0
export var elevation = 0

# If true, collides with player if player elevation is below this elevation + extra coverage
# If false, will only collide if player is at same elevation
export var cover_all_elev = false;
export var extra_coverage = 32;

var is_moving = false
var has_set_knockback = false
var has_anim = false

func _ready():
	# Set z index based on object elevation
	get_owner().z_index = elevation / (Globals.ELEVATION_UNIT)

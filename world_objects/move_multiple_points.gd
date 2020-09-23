extends KinematicBody2D


var knockback_vector = Vector2.ZERO

export var move_speed = 0

# If has set knockback, be sure to disable collision
export var has_set_knockback = false
export var is_cycle = false

onready var positions_par = $Positions
var next_pos = 1	# Index of next position, index 0 will always be the starting position so use index 1
var positions = []	# Array of positions to move to based on positions_par children

func _ready():
	$Hitbox.is_moving = true
	$Hitbox.has_set_knockback = has_set_knockback
	
	# Get all global positions of nodes in Positions children as the points to move to
	for node in positions_par.get_children():
		positions.append(node.global_position)

# Move between two positions
func _physics_process(delta):
	global_position = global_position.move_toward(positions[next_pos], move_speed * delta)
	if (global_position.distance_to(positions[next_pos]) <= 0.1):
		next_pos += 1
		
		# If next_pos is outside array, wrap back to beginning
		if (next_pos > positions.size() - 1):
			next_pos = 0
			# If not a cycle, reverse positions array to go back
			if (!is_cycle):
				positions.invert()
	
	# Knockback player in direction this object is moving
	# If has_set_knockback is true, player will always get knocked in this direction
	# Else if has_set_knockback is false, it will only knock in this direction if player is not moving
	knockback_vector = -(global_position - positions[next_pos]).normalized()

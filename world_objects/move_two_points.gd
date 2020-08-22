extends KinematicBody2D

var knockback_vector = Vector2.ZERO

export var move_speed = 0
export var has_set_knockback = false

onready var pos_A = $Pos_A.global_position
onready var pos_B = $Pos_B.global_position
onready var next_pos = pos_B

func _ready():
	$Hitbox.is_moving = true
	$Hitbox.has_set_knockback = has_set_knockback

# Move between two positions
func _physics_process(delta):
	global_position = global_position.move_toward(next_pos, move_speed * delta)
	if (global_position.distance_to(next_pos) <= 0.1):
		if (next_pos == pos_A):
			next_pos = pos_B
		else:
			next_pos = pos_A
	
	# Knockback player in direction this object is moving
	# If has_set_knockback is true, player will always get knocked in this direction
	# Else if has_set_knockback is false, it will only knock in this direction if player is not moving
	knockback_vector = -(global_position - next_pos).normalized()

	

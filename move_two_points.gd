extends KinematicBody2D

export var pos_A = Vector2.ZERO
export var pos_B = Vector2.ZERO
export var move_speed = 0
onready var next_pos = pos_B
var knockback_vector = Vector2.ZERO

func _ready():
	$Hitbox.is_moving = true

# Move between two positions
func _physics_process(delta):
	global_position = global_position.move_toward(next_pos, move_speed * delta)
	if (global_position.distance_to(next_pos) <= 0.1):
		if (next_pos == pos_A):
			next_pos = pos_B
		else:
			next_pos = pos_A
	knockback_vector = -(global_position - next_pos).normalized()

	

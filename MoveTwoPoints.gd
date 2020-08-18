extends Node

export var x1 = 0
export var x2 = 0
export var velocity = Vector2.ZERO

func _physics_process(delta):
	if (get_owner().global_position.y <= x1 or get_owner().global_position.y >= x2):
		velocity *= -1
	get_owner().move_and_collide(velocity * delta, false)

extends Camera2D


var shake_amount = 3.0
var shake = true

func _process(delta):
	if (shake):
		set_offset(Vector2( rand_range(-1.0, 1.0) * shake_amount, rand_range(-1.0, 1.0) * shake_amount ))
		
		# Gradually lower shake amount
		if (shake_amount > 0):
			shake_amount -= 1.25 * delta

func shake_off():
	shake = false

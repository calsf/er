extends StaticBody2D

var knockback_vector = Vector2.DOWN
export var push_delay = .5
export var delay_start = false
onready var animation_player = $AnimationPlayer
onready var hitbox = $Hitbox
onready var push_timer = $PushTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox.has_set_knockback = true
	# If is a delayed start, wait double the time before the first push
	if (delay_start):
		push_timer.start(push_delay * 2)
	else:
		push_timer.start(push_delay)
	set_collision_layer_bit( 4 + ((hitbox.elevation / (Globals.ELEVATION_UNIT)) * 2), true)

# After delay, play push animation
func _on_PushTimer_timeout():
	animation_player.play("Push")

# When push animation is finished, start delay timer again
func _on_AnimationPlayer_animation_finished(anim_name):
	push_timer.start(push_delay)

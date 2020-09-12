extends Node2D

export var delay = .5
export var delay_start = false
onready var animation_player = $AnimationPlayer
onready var hitbox = $Hitbox
onready var timer = $ActivateTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	# If is a delayed start, wait double the time before the first activation
	if (delay_start):
		timer.start(delay * 2)
	else:
		timer.start(delay)
		
# When activate animation is finished, start delay timer again
func _on_AnimationPlayer_animation_finished(anim_name):
	timer.start(delay)

# After delay, play activation animation
func _on_ActivateTimer_timeout():
	animation_player.play("Activate")

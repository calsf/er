extends Control

onready var player = get_node("../../YSortWorldObjects/Player")
onready var player_time = get_node("../PlayerTime")
onready var fade = get_node("../Fade")
onready var countdown = $Countdown
onready var countdown_anim = $Countdown/AnimationPlayer

# Play fade out when scene starts
func _ready():
	fade.fade_out()

# Start countdown animation once fade out is finished
func _on_Fade_fade_out_finished():
	countdown_anim.play("Countdown")

# Start time and allow player input once countdown anim is finished
func _on_AnimationPlayer_animation_finished(anim_name):
	player.player_stopped = false
	player_time._reset_time()
	yield(get_tree().create_timer(.5), "timeout")
	countdown.hide()

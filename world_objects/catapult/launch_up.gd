extends Node

export var launch_strength = 0
onready var player = get_node("../../../YSortWorldObjects/Player")

func _on_AnimationPlayer_animation_started(anim_name):
	player.jump_height = launch_strength;
	player.is_jumping = true;

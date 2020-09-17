extends Node

export var launch_strength = 0
export var player_path = "";
onready var player = get_node(player_path)

func _on_AnimationPlayer_animation_started(anim_name):
	player.has_jumped = false;
	player.has_double_jumped = false;
	player.jump_height = launch_strength;
	player.is_jumping = true;

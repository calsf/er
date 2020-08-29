extends Node2D

onready var save_load_manager = $SaveLoadManager

func play(sound):
	if (!save_load_manager.load_data()["SoundMuted"]):
		get_node(sound).play()


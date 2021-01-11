extends Node2D

onready var save_load_manager = $SaveLoadManager
onready var save_data = save_load_manager.load_data()

func play(sound):
	if (!save_data["SoundMuted"]):
		get_node(sound).play()

func load_data():
	save_data = save_load_manager.load_data()


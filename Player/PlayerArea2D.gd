extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_exited", self, "update_elevation")
	
func update_elevation():
	print("tesitng")

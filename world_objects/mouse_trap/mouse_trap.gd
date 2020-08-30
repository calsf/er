extends Node2D

export var elevation = 0
export var knockback_vector = Vector2.ZERO
export var anim_name = "Snap"
onready var animation_player = $AnimationPlayer
onready var hitbox = $Hitbox

# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox.elevation = elevation
	hitbox.has_set_knockback = true
	hitbox.has_anim = true

func play_anim():
	animation_player.play(anim_name)


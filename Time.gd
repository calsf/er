extends Control


var time = 0
var minutes = 0
onready var time_text = $TimeText
onready var player = get_node("../../YSortWorldObjects/Player")

func _ready():
	# When player_reset signal is emitted, will reset time values
	player.connect("player_reset", self, "reset_time")

func _process(delta):
	time += delta
	if (time > 60):
		minutes += 1
		time = 0
	time_text.text = str("Time: ", minutes, ".", stepify(time, 0.01))

# Reset time values
func reset_time():
	time = 0
	minutes = 0

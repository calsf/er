extends Control


var time = 0
var minutes = 0
var is_stopped = false
onready var time_text = $TimeText
onready var player = get_node("../../YSortWorldObjects/Player")
onready var finish_flag = get_node("../../YSortWorldObjects/FinishFlag/FinishArea")

func _ready():
	# When player_died signal is emitted, will reset stop recording time
	player.connect("player_died", self, "_stop_time")
	# When player_reset signal is emitted, will reset time values
	player.connect("player_reset", self, "_reset_time")
	# When player enters flag area and triggers level_finished, stop time
	finish_flag.connect("level_finished", self, "_stop_time")

func _process(delta):
	# Do not record time if time is stopped
	if (is_stopped):
		return
	
	time += delta
	if (time > 60):
		minutes += 1
		time = 0
	time_text.text = str("Time ", minutes, ".", stepify(time, 0.01))

# Reset time values
func _reset_time():
	is_stopped = false
	time = 0
	minutes = 0

func _stop_time():
	is_stopped = true

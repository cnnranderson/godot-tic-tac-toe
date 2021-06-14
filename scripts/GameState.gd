extends Node

var current_player = "x"
var can_move = true

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	Events.connect("game_won", self, "_Event_game_won")
	Events.connect("game_reset", self, "_Event_game_reset")

func _Event_game_won(winner):
	can_move = false

func _Event_game_reset():
	can_move = true


extends Node2D

func _ready():
	Events.connect("game_won", self, "_Event_game_won")

func _Event_game_won(winner):
	$Hud/WinLabel.visible = true
	GameState.can_move = false

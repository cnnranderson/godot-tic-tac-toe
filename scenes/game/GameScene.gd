extends Node2D

func _ready():
	Events.connect("game_won", self, "_Event_game_won")
	Events.connect("game_reset", self, "_Event_game_reset")

func _process(_delta):
	if Input.is_action_pressed("reset_game"):
		Events.emit_signal("game_reset")

func _Event_game_reset():
	$Hud/WinLabel.visible = false
	$Hud/WinnerLabel.visible = false

func _Event_game_won(winner):
	$Hud/WinLabel.visible = true
	$Hud/WinnerLabel.text = "%s WINS" % winner.capitalize()
	$Hud/WinnerLabel.visible = true

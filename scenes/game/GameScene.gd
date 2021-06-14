extends Node2D

func _ready():
	Events.connect("game_won", self, "_Event_game_won")
	Events.connect("game_reset", self, "_Event_game_reset")
	Events.connect("game_draw", self, "_Event_game_draw")

func _process(_delta):
	if Input.is_action_just_pressed("reset_game"):
		Events.emit_signal("game_reset")

func _show_reset_prompt():
	$Hud/WinCounts/DrawLabel.visible = true
	$Hud/WinCounts/DrawLabel.modulate.a = 0.0
	$Hud/Tween.interpolate_property($Hud/WinCounts/DrawLabel, "modulate:a", 0, 1.0, 2, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.5)
	$Hud/Tween.start()

func _Event_game_reset():
	$Hud/WinLabel.visible = false
	$Hud/WinnerLabel.visible = false
	$Hud/WinCounts/DrawLabel.visible = false
	$Hud/WinCounts/DrawLabel.modulate.a = 0.0

func _Event_game_won(winner):
	_show_reset_prompt()
	$Hud/WinLabel.visible = true
	$Hud/WinnerLabel.text = "%s WINS" % winner.capitalize()
	$Hud/WinnerLabel.visible = true
	match winner:
		"o": $Hud/WinCounts/O/Wins.text = str(int($Hud/WinCounts/O/Wins.text) + 1)
		"x": $Hud/WinCounts/X/Wins.text = str(int($Hud/WinCounts/X/Wins.text) + 1)

func _Event_game_draw():
	_show_reset_prompt()

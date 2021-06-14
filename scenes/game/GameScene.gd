extends Node2D

const x_sprite = preload("res://images/x.png")
const o_sprite = preload("res://images/o.png")

func _ready():
	$Hud/TurnContainer/Image.texture = x_sprite if GameState.current_player == "x" else o_sprite
	Events.connect("game_won", self, "_Event_game_won")
	Events.connect("game_reset", self, "_Event_game_reset")
	Events.connect("game_draw", self, "_Event_game_draw")
	Events.connect("tile_placed", self, "_Event_tile_placed")

func _process(_delta):
	if Input.is_action_just_pressed("reset_game"):
		Events.emit_signal("game_reset")

func _Event_tile_placed(tile, _coordinate):
	$Hud/TurnContainer/Image.texture = x_sprite if tile == "o" else o_sprite

func _show_reset_prompt():
	$Hud/WinCounts/DrawLabel.visible = true
	$Hud/WinCounts/DrawLabel.modulate.a = 0.0
	$Hud/Tween.interpolate_property($Hud/WinCounts/DrawLabel, "modulate:a", 0, 1.0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.5)
	$Hud/Tween.interpolate_property($Hud/TurnContainer, "modulate:a", 1.0, 0, .2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Hud/Tween.start()

func _Event_game_reset():
	$Hud/WinLabel.visible = false
	$Hud/WinnerLabel.visible = false
	$Hud/WinCounts/DrawLabel.visible = false
	$Hud/WinCounts/DrawLabel.modulate.a = 0.0
	$Hud/Tween.interpolate_property($Hud/TurnContainer, "modulate:a", 0, 1.0, .2, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.5)
	$Hud/Tween.start()

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

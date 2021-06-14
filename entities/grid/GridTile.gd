extends Area2D

const x_sprite = preload("res://images/x.png")
const o_sprite = preload("res://images/o.png")

export(Vector2) var coord = Vector2()
export(String) var tile = ""

var resetting = false

func _ready():
	_init_tile()
	Events.connect("game_reset", self, "_Event_game_reset")

func _init_tile():
	$Sprite.visible = false
	self.modulate.a = 1.0
	tile = ""
	resetting = false

func set_tile(tile_type):
	# Short circuit if tile is already taken
	if tile != "" or !GameState.can_move:
		return
	
	# Let everyone know we placed a tile
	Events.emit_signal("tile_placed", tile_type, coord)
	$Sprite.visible = true
	tile = tile_type
	match tile:
		"x": $Sprite.texture = x_sprite
		"o": $Sprite.texture = o_sprite
		_: $Sprite.visible = false

func _on_Tile_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed == true:
			set_tile(GameState.current_player)

func _Event_game_reset():
	if resetting:
		return
	
	resetting = true
	$Tween.interpolate_property(self, "modulate:a", 1.0, 0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	$Timers/ResetTimer.start()

func _on_ResetTimer_timeout():
	_init_tile()

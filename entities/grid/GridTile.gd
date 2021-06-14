extends Area2D

const x_sprite = preload("res://images/x.png")
const o_sprite = preload("res://images/o.png")

export(Vector2) var coord = Vector2()
export(String) var tile = ""

var resetting = false

const PLACE_TILE_SOUND = "res://sounds/place_tile.wav"

func _ready():
	_init_tile()
	Events.connect("game_reset", self, "_Event_game_reset")

func _init_tile():
	$Sprite.visible = false
	$Shadow.visible = false
	self.modulate.a = 1.0
	tile = ""
	resetting = false

func set_tile(tile_type):
	# Short circuit if tile is already taken or grid is locked
	if tile != "" or !GameState.can_move or resetting:
		return
	
	# We placed a tile; let the world know
	Events.emit_signal("tile_placed", tile_type, coord)
	tile = tile_type
	$Sprite.visible = true
	$Shadow.visible = true
	$Sprite.texture = x_sprite if tile == "x" else o_sprite
	$Shadow.texture = x_sprite if tile == "x" else o_sprite
	
	# Animate the tile being placed
	$Tween.interpolate_property($Sprite, "position:y", -15, 0, 0.5, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.interpolate_property($Shadow, "modulate:a", 0, 1.0, 1, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()
	
	# Emit a sound of being placed
	Sounds.play_sound(Sounds.SoundType.SFX, PLACE_TILE_SOUND, 1.4 if tile_type == "x" else 1.0)

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

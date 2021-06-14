extends Area2D

const x_sprite = preload("res://images/x.png")
const o_sprite = preload("res://images/o.png")

export(Vector2) var coord = Vector2()
export(String) var tile = "o"

func _ready():
	$Sprite.visible = false

func _on_Tile_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed == true:
			print(self.name)
			set_tile("x" if tile == "o" else "o")

func set_tile(player):
	$Sprite.visible = true
	tile = player
	match player:
		"x": $Sprite.texture = x_sprite
		"o": $Sprite.texture = o_sprite
		_: $Sprite.visible = false

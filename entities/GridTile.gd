extends Area2D

const x_sprite = preload("res://images/x.png")
const o_sprite = preload("res://images/o.png")

func _ready():
	$Sprite.visible = false

func _on_Tile_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		print(event)

func set_tile(player):
	match player:
		"x": $Sprite.texture = x_sprite
		"o": $Sprite.texture = o_sprite
		_: $Sprite.visible = false

extends Node2D

var grid = []

func _ready():
	_init_grid()
	Events.connect("tile_placed", self, "_Event_tile_placed")

func _init_grid():
	for i in range(3):
		grid.append([])
		for _j in range(3):
			grid[i].append("")

func _check_win(last_tile, last_coord):
	# Check horizontal
	for i in range(3):
		if grid[last_coord.y][i] != last_tile:
			break
		elif i == 2:
			Events.emit_signal("game_won", last_tile)
			return
	
	# Check vertical
	for i in range(3):
		if grid[i][last_coord.x] != last_tile:
			break
		elif i == 2:
			Events.emit_signal("game_won", last_tile)
			return

func _Event_tile_placed(tile, coordinate):
	grid[coordinate.y][coordinate.x] = tile
	_check_win(tile, coordinate)
	GameState.current_player = "x" if tile == "o" else "o"

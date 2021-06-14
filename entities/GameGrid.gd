extends Node2D

var grid = []

func _ready():
	_init_grid()
	pass

func _init_grid():
	for i in range(3):
		grid.append([])
		for j in range(3):
			grid[i].append("test")

func on_Area_clicked(area):
	print("Clicked")

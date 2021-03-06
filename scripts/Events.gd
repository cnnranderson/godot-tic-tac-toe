extends Node

"""
Events Singleton -- used to define events for the entire game.

This allows us to bind events anywhere across the entities used
without having to create complex hierarchies within nodes when
connecting signal subscribers.
"""

# Core Game signals
signal game_draw
signal game_reset
signal game_won(winner)
signal tile_placed(tile, coordinate)

extends Node

@export var board: Board
@export var player_index: int = -1
@onready var rock_pile : RockPile = $"RockPile"
@onready var count_label : Label = $"Label"

func _ready() -> void:
	rock_pile.set_container_size(rock_pile.global_position, Vector2(128, 128))
	board.square_eaten.connect(on_square_eaten)
	board.borrowed_from_stash.connect(on_borrowed_from_stash)
	
func on_square_eaten(index: int, square: Square) -> void:
	if (index == player_index):
		rock_pile.add_rocks(square.rock_pile.rocks())
		count_label.text = "Score: " + str(rock_pile.score())
		square.eat()
	
func on_borrowed_from_stash(index: int, amount: int) -> void:
	if (index == player_index):
		print(index, " - Removed from stash: ", amount)
		rock_pile.remove_rocks(amount)
		count_label.text = "Score: " + str(rock_pile.score())

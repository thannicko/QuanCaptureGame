extends Node

@onready var rock_pile : RockPile = $"RockPile"
@onready var count_label : Label = $"Label"
@export var board: Board

func _ready() -> void:
	rock_pile.set_container_size(Vector2(128, 128))
	board.square_eaten.connect(on_square_eaten)
	
func on_square_eaten(square: Square) -> void:
	rock_pile.add_rocks(square.rock_pile.rocks())
	count_label.text = "Count: " + str(rock_pile.rocks_count())
	square.eat()

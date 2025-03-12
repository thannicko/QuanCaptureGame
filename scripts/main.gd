extends Node2D

@onready var square: Square = $"Square"
@onready var rock_pile: RockPile = $"Square/Rockpile"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	square.rock_pile = rock_pile


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

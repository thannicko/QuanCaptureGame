class_name StateBoardEatSquare extends State

@export var exclamation_mark: Sprite2D

func entry() -> void:
	print("Entered eat square")
	exclamation_mark.hide()
	exclamation_mark.reparent(statemachine.empty_square_to_tap)
	exclamation_mark.position = Vector2(8, 8)
	if (statemachine.empty_square_to_tap is BigSquare):
		exclamation_mark.position.y += 8
	exclamation_mark.show()
	statemachine.empty_square_to_tap.enable()
	statemachine.empty_square_to_tap.square_clicked.connect(on_empty_square_tapped)
	statemachine.eaten_square.square_clicked.connect(on_square_eaten)
	
func on_empty_square_tapped() -> void:
	statemachine.eaten_square.enable()
	exclamation_mark.hide()
	
func on_square_eaten() -> void:
	statemachine.eaten_square.disable()
	statemachine.last_dropoff_square = statemachine.eaten_square
	statemachine.board.square_eaten.emit(statemachine.allowed_row_index, statemachine.eaten_square)
	statemachine.change_to_state("StateBoardCheckTurnEnd") # Check for stacking
	print("Square eaten: ", statemachine.eaten_square)

func exit() -> void:
	statemachine.empty_square_to_tap.square_clicked.disconnect(on_empty_square_tapped)
	statemachine.eaten_square.square_clicked.disconnect(on_square_eaten)

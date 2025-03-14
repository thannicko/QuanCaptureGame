class_name StateBoardEatSquare extends State

func entry() -> void:
	statemachine.empty_square_to_tap.enable()
	statemachine.empty_square_to_tap.square_clicked.connect(on_empty_square_tapped)
	statemachine.eaten_square.square_clicked.connect(on_square_eaten)
	
func on_empty_square_tapped() -> void:
	statemachine.empty_square_to_tap.disable()
	statemachine.eaten_square.enable()
	
func on_square_eaten() -> void:
	statemachine.eaten_square.eat()
	statemachine.board.square_eaten.emit(statemachine.eaten_square)
	statemachine.change_to_state("StateBoardPickupRocks")
	print("Square eaten: ", statemachine.eaten_square)

func exit() -> void:
	pass

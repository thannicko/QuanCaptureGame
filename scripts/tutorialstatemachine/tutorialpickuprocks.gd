class_name StateTutorialPickUpRocks extends State



func entry() -> void:
	statemachine.board.set_paused(false)
	statemachine.next_button.disabled = true
	statemachine.board.picked_up_rock.connect(on_first_rock_picked_up)
	statemachine.board.can_continue_with_rocks.connect(on_can_continue_with_rocks)
	statemachine.board.can_eat_square.connect(on_can_eat_square)
	statemachine.board.square_eaten.connect(on_square_eaten)

func on_first_rock_picked_up() -> void:
	statemachine.show_next_line()
	statemachine.board.picked_up_rock.disconnect(on_first_rock_picked_up)
	
func on_can_eat_square() -> void:
	statemachine.show_next_line()
	statemachine.board.can_eat_square.disconnect(on_can_eat_square)
	
func on_square_eaten(player_index: int, square: Square) -> void:
	statemachine.change_to_state("StateTutorialInitial")
	statemachine.board.square_eaten.disconnect(on_square_eaten)
	
func on_can_continue_with_rocks() -> void:
	statemachine.show_next_line()
	statemachine.board.can_continue_with_rocks.disconnect(on_can_continue_with_rocks)

func exit() -> void:
	statemachine.next_button.disabled = false

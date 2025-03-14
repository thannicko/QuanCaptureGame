class_name StateTurnIdle extends State

func entry() -> void:
	print("Entered: ", name)
	statemachine.board.turn_ended.connect(on_turn_ended)
	statemachine.board.start_turn(statemachine.active_row_index)

func on_turn_ended() -> void:
	statemachine.is_player_turn = !statemachine.is_player_turn
	statemachine.change_to_state("StateTurnCheckPlayer")

func exit() -> void:
	statemachine.board.turn_ended.disconnect(on_turn_ended)

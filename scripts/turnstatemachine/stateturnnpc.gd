class_name StateTurnNpc extends State

func entry() -> void:
	print("Entered: ", name)
	statemachine.board.turn_ended.connect(on_turn_ended)

func on_turn_ended() -> void:
	statemachine.is_player_turn = !statemachine.is_player_turn
	statemachine.change_to_state("StateTurnCheckPlayer")

func exit() -> void:
	statemachine.board.turn_ended.disconnect(on_turn_ended)

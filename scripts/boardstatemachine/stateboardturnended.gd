class_name StateBoardTurnEnded extends State

func entry() -> void:
	statemachine.board.turn_started.connect(on_turn_started)
	
func on_turn_started(player_index : int) -> void:
	statemachine.allowed_row_index = player_index
	statemachine.change_to_state("StateBoardPickupRocks")
	

func exit() -> void:
	statemachine.board.turn_started.disconnect(on_turn_started)

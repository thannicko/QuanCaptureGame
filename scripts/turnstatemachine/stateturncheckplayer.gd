class_name StateTurnCheckPlayer extends State

const OtherRowIndex : int = 0
const PlayerRowIndex : int = 1

func entry() -> void:
	print("Entered: ", name)
	if (statemachine.is_player_turn):
		statemachine.active_row_index = PlayerRowIndex
		statemachine.change_to_state("StateTurnPlayer")
	else:
		statemachine.active_row_index = OtherRowIndex
		if (statemachine.is_playing_against_npc):
			statemachine.change_to_state("StateTurnNpc")
		else:
			# Switch to the other human player
			statemachine.change_to_state("StateTurnPlayer")
	GlobalPrompter.prompt("New turn begins for player of row " + str(statemachine.active_row_index + 1))
			

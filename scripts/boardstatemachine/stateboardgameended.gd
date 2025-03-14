class_name StateBoardGameEnded extends State

func entry() -> void:
	print("Enter: ", name)
	statemachine.board.game_ended.emit()
	GlobalPrompter.prompt("Game ended!")
	#TODO: Restart

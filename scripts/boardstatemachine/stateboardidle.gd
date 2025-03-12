class_name StateBoardIdle extends State

func entry() -> void:
	print("Entered: ", name)
	# TODO: We should wait for external input when player wants to play 
	await statemachine.board.ready
	statemachine.change_to_state("StateBoardSetup")

func exit() -> void:
	pass

class_name StateBoardIdle extends State

func entry() -> void:
	print("Entered: ", name)
	await statemachine.board.ready
	statemachine.change_to_state("StateBoardSetup")

func exit() -> void:
	pass

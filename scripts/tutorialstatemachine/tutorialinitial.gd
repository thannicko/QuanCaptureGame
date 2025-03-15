class_name StateTutorialInitial extends State

func entry() -> void:
	if statemachine.previous_state == null:
		await statemachine.tutorial_dialog.ready
		await statemachine.next_button.ready
	statemachine.next_button_text.text = "Next"
	statemachine.board.set_paused(true)
	statemachine.show_next_line()
	statemachine.tutorial_ended.connect(on_tutorial_ended)
	statemachine.next_button.button_down.connect(on_next_pressed)

func on_next_pressed() -> void:
	if statemachine.dialog_index == statemachine.index_pick_up_rocks:
		statemachine.change_to_state("StateTutorialPickUpRocks")
	statemachine.show_next_line()

func on_tutorial_ended() -> void:
	statemachine.next_button_text.text = "Close"
	statemachine.skip_button.hide()
	statemachine.next_button.button_down.disconnect(on_next_pressed)
	statemachine.next_button.button_down.connect(statemachine.end_tutorial)

func exit() -> void:
	statemachine.tutorial_ended.disconnect(on_tutorial_ended)
	statemachine.next_button.button_down.disconnect(on_next_pressed)

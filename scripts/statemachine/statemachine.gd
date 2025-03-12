class_name StateMachine extends Node

var states: Dictionary = {}
var current_state: State
var previous_state: State

func _ready() -> void:
	for child in get_children():
		states[child.name] = child
		child.statemachine = self
	change_to_state(get_children().front().name)
	
func change_to_state(new_state_name: String) -> void:
	var new_state = states[new_state_name]
	if (current_state != null):
		current_state.exit()
	previous_state = current_state
	current_state = new_state
	new_state.entry()

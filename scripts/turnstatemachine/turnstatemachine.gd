class_name TurnStateMachine extends StateMachine

@export var board: Board

#TODO Add option to have player names and so on later
var is_player_turn : bool = true
var is_playing_against_npc : bool = false
var active_row_index: int = -1

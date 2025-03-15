class_name TutorialStateMachine extends StateMachine

signal tutorial_ended

@export var board: Board
@export var tutorial_dialog: TutorialDialog
@export var next_button: TextureButton
@export var skip_button: TextureButton
@export var next_button_text: Label
@export var tutorials_text: Array[String]

@export_group("Important marks in tutorial texts")
@export var index_pick_up_rocks: int

var dialog_index : int = 0

func _ready() -> void:
	super._ready()
	skip_button.button_down.connect(end_tutorial)

func end_tutorial() -> void:
	next_button.disabled = true
	skip_button.hide()
	next_button.hide()
	tutorial_dialog.hide()
	board.set_paused(false)

func show_next_line() -> void:
	tutorial_dialog.show_text(
		tutorials_text[dialog_index])
	dialog_index += 1
	if (dialog_index == tutorials_text.size()):
		tutorial_ended.emit()

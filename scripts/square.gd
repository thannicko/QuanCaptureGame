class_name Square extends Node2D

signal square_clicked

@onready var area2d: Area2D = $"Area2D"
@onready var rock_pile: RockPile = $"Rockpile"
@onready var disabled_square: Node2D = $"DisableSquare"

var _is_mouse_on_square: bool = false
var disabled : bool = false

func _ready() -> void:
	area2d.mouse_entered.connect(_on_mouse_entered_square)
	area2d.mouse_exited.connect(_on_mouse_exited_square)
	rock_pile.set_container_size(get_size())
	disabled_square.hide()

func is_empty() -> bool:
	return rock_pile.rocks_count() <= 0

func get_size() -> Vector2:
	return 16 * scale

func disable() -> void:
	disabled = true
	disabled_square.show()
	set_process_input(false)

func enable() -> void:
	disabled = false
	disabled_square.hide()
	set_process_input(true)

func _input(event: InputEvent) -> void:
	if (_is_mouse_on_square and event is InputEventMouseButton and event.is_pressed()):
		square_clicked.emit()

func _on_mouse_entered_square():
	_is_mouse_on_square = true;
	modulate = Color.LIGHT_GRAY

func _on_mouse_exited_square():
	_is_mouse_on_square = false;
	modulate = Color.WHITE

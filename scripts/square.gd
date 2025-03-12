class_name Square extends Node2D

signal square_clicked

@onready var area2d: Area2D = $"Area2D"
@onready var rock_pile: RockPile = $"Rockpile"
var _is_mouse_on_square: bool = false

func _ready() -> void:
	area2d.mouse_entered.connect(_on_mouse_entered_square)
	area2d.mouse_exited.connect(_on_mouse_exited_square)
	rock_pile.set_container_size(16 * scale)

func _input(event: InputEvent) -> void:
	if (_is_mouse_on_square and event is InputEventMouseButton and event.is_pressed()):
		square_clicked.emit()
		print(name, " Emit signal square_clicked")

func _on_mouse_entered_square():
	_is_mouse_on_square = true;
	modulate = Color.LIGHT_GRAY

func _on_mouse_exited_square():
	_is_mouse_on_square = false;
	modulate = Color.WHITE

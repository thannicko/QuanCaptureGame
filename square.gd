class_name Square extends Node2D

@onready var area2d: Area2D = $"Area2D"
var rock_pile: RockPile = null
var _is_mouse_on_square: bool = false

func _ready() -> void:
	area2d.mouse_entered.connect(_on_mouse_entered_square)
	area2d.mouse_exited.connect(_on_mouse_exited_square)

func _input(event: InputEvent) -> void:
	if (_is_mouse_on_square and event is InputEventMouseButton and event.is_pressed()):
		print("Pressed square: ", name)
		if (rock_pile != null):
			rock_pile.pick_up()

func _on_mouse_entered_square():
	_is_mouse_on_square = true;
	modulate = Color.LIGHT_GRAY

func _on_mouse_exited_square():
	_is_mouse_on_square = false;
	modulate = Color.WHITE

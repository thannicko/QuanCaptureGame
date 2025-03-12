class_name RockPile extends Node2D

var RockScene: PackedScene = preload("res://rock.tscn")
var picked_up: bool = false
var _position_when_picked_up: Vector2 = Vector2.ZERO

func _ready() -> void:
	set_process(false)

func pick_up():
	_position_when_picked_up = position
	picked_up = true
	set_process(picked_up)

func put_down():
	position = _position_when_picked_up
	picked_up = false
	set_process(false)

func spawn_rocks(number : int) -> void:
	for child in get_children():
		child.queue_free()
	for i in number:
		var rock = RockScene.instantiate() as Node2D
		rock.position.x += i*16
		add_child(rock)


func _process(delta: float) -> void:
	global_position = get_global_mouse_position()

class_name RockPile extends Node2D

const RockSize: int = 16
const RockScene: PackedScene = preload("res://scenes/rock.tscn")
var picked_up: bool = false
var container_size: Vector2
var _position_when_picked_up: Vector2 = Vector2.ZERO
var _rocks: Array[Node2D]

func _ready() -> void:
	_rocks.clear()
	for child in get_children():
		child.queue_free()
	set_process(false)

func set_container_size(size: Vector2) -> void:
	container_size = size - Vector2(30, 30)
	
func is_empty() -> bool:
	return rocks_count() <= 0
	
func rocks_count() -> int:
	return _rocks.size()

func pick_up() -> void:
	_position_when_picked_up = position
	picked_up = true
	set_process(picked_up)

func put_down() -> void:
	position = _position_when_picked_up
	picked_up = false
	set_process(false)

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()

func add_rock(amount : int) -> void:
	var rock = RockScene.instantiate() as Node2D
	if (not _rocks.is_empty()):
		var new_position = rock.position
		new_position.x = _rocks.back().position.x + RockSize
		rock.position = _clamp_position_to_container(new_position)
	_add_rock_to_scene(rock)

func set_rocks(amount : int) -> void:
	_rocks.clear()
	for child in get_children():
		child.queue_free()
	for i in amount:
		var rock = RockScene.instantiate() as Node2D
		var new_position = rock.position
		new_position.x = i*RockSize
		rock.position = _clamp_position_to_container(new_position)
		_add_rock_to_scene(rock)
		
func _clamp_position_to_container(position: Vector2):
	if (position.x >= container_size.x):
		position.x = 0
		position.y = RockSize
	return position
		
func _add_rock_to_scene(rock: Node2D):
	add_child(rock)
	_rocks.append(rock)

class_name RockPile extends Node2D

const RockSize: int = 16
const RockScene: PackedScene = preload("res://scenes/rock.tscn")
const BigRockScene: PackedScene = preload("res://scenes/bigrock.tscn")
var picked_up: bool = false
var container_size: Vector2
var max_rocks_in_row: int
var _position_when_picked_up: Vector2 = Vector2.ZERO
var _rocks: Array[Node2D]

func _ready() -> void:
	_rocks.clear()
	for child in get_children():
		child.queue_free()
	set_process(false)

func set_container_size(size: Vector2) -> void:
	container_size = size - Vector2(30, 30)
	max_rocks_in_row = container_size.x / RockSize
	
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

func pop_front() -> Node2D:
	return _rocks.pop_front()

func add_rock(rock : Node2D) -> void:
	rock.reparent(self)
	_rocks.append(rock)
	_set_rock_position(rock, _rocks.find(rock))

func clear() -> void:
	_rocks.clear()
	for child in get_children():
		child.queue_free()

func set_rocks(amount : int) -> void:
	_set_rocks(RockScene, amount)

func set_big_rocks(amount : int) -> void:
	_set_rocks(BigRockScene, amount)

func _set_rocks(scene: PackedScene, amount : int) -> void:
	clear()
	for i in amount:
		var rock = scene.instantiate() as Node2D
		_add_rock_to_scene(rock)
		_set_rock_position(rock, i)
		
func _set_rock_position(rock: Node2D, index: int) -> void:
	rock.position.x = (index % max_rocks_in_row) * RockSize
	rock.position.x += randi_range(0, 10)
	rock.position.y = (index / max_rocks_in_row) * RockSize
		
func _add_rock_to_scene(rock: Node2D):
	var random_scale = randf_range(0.85, 1.25)
	rock.scale = Vector2(random_scale, random_scale)
	add_child(rock)
	_rocks.append(rock)

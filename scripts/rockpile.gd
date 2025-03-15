class_name RockPile extends Node2D

@export var pileorigin: Marker2D

const RockSize: int = 16
const RockScene: PackedScene = preload("res://scenes/rock.tscn")
const BigRockScene: PackedScene = preload("res://scenes/bigrock.tscn")
var picked_up: bool = false
var _container_global_position: Vector2
var _max_global_position: Vector2
var max_rocks_in_row: int
var _position_when_picked_up: Vector2 = Vector2.ZERO
var _rocks: Array[Rock]
var _starting_position: Vector2

func _ready() -> void:
	_starting_position = global_position
	_rocks.clear()
	for child in get_children():
		child.queue_free()

func set_container_size(global_pos: Vector2, size: Vector2) -> void:
	_container_global_position = global_pos + Vector2(8, 8)
	_max_global_position = _container_global_position + size
	max_rocks_in_row = (size.x - RockSize) / RockSize
	
func is_empty() -> bool:
	return rocks_count() <= 0
	
func rocks_count() -> int:
	return _rocks.size()
	
func score() -> int:
	var score = 0
	for rock in _rocks:
		score += rock.score
	return score
		

func pick_up() -> void:
	_position_when_picked_up = position
	picked_up = true

func put_down() -> void:
	position = _position_when_picked_up
	picked_up = false

func _process(delta: float) -> void:
	if picked_up:
		global_position = get_global_mouse_position()

func pop_front() -> Node2D:
	return _rocks.pop_front()

func add_rock(rock : Rock) -> void:
	picked_up = false
	var new_rock = duplicate_rock(rock)
	add_child(new_rock)
	_rocks.append(new_rock)
	_set_rock_position(new_rock, _rocks.find(new_rock))
	rock.queue_free()

func duplicate_rock(rock: Rock) -> Rock:
	var new_rock: Rock
	if (rock is Rock):
		new_rock = RockScene.instantiate() as Rock
	elif (rock is BigRock):
		new_rock = BigRockScene.instantiate() as BigRock
	new_rock.set_texture(rock.sprite.texture)
	return new_rock

func add_rocks(rocks : Array[Rock]) -> void:
	for rock in rocks:
		add_rock(rock)

func remove_rocks(amount: int) -> void:
	var count: int = 0
	for rock in _rocks:
		if count == amount:
			break
		if rock is BigRock:
			continue
		rock.queue_free()
		_rocks.erase(rock)
		count += 1

func rocks() -> Array[Rock]:
	return _rocks

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
	if (pileorigin != null):
		position = pileorigin.position
	rock.global_position.x += (index % max_rocks_in_row) * RockSize
	rock.global_position.y += (index / max_rocks_in_row) * RockSize
	rock.global_position.x = min(rock.global_position.x, _max_global_position.x)
	rock.global_position.y = min(rock.global_position.y, _max_global_position.y)
	print("Set rock position: ", rock, index, " -> ", rock.global_position, " vs origin: ", global_position)
		
func _add_rock_to_scene(rock: Node2D):
	var random_scale = randf_range(0.85, 1.25)
	rock.scale = Vector2(random_scale, random_scale)
	add_child(rock)
	_rocks.append(rock)

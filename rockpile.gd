class_name RockPile extends Node2D

var RockScene: PackedScene = preload("res://rock.tscn")

func _ready() -> void:
	set_process(false)

func pick_up():
	set_process(true)

func spawn_rocks(number : int) -> void:
	for child in get_children():
		child.queue_free()
	for i in number:
		var rock = RockScene.instantiate() as Node2D
		rock.position.x += i*16
		add_child(rock)


func _process(delta: float) -> void:
	global_position = get_global_mouse_position()

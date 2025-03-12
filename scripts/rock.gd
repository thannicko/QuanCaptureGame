class_name Rock extends Node2D

@export var rock_textures: Array[Texture2D]

@onready var sprite : Sprite2D = $"Sprite2D"

func _ready() -> void:
	print("_Ready, ", rock_textures)
	var index = randi_range(0, rock_textures.size() - 1)
	sprite.texture = rock_textures[index]

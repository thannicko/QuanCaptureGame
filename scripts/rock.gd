class_name Rock extends Node2D

@export var rock_textures: Array[Texture2D]
@export var score: int = 1
@onready var sprite : Sprite2D = $"Sprite2D"

var _stored_texture: Texture2D = null

func _ready() -> void:
	if (_stored_texture == null):
		var index = randi_range(0, rock_textures.size() - 1)
		sprite.texture = rock_textures[index]
	else:
		sprite.texture = _stored_texture

func set_texture(texture: Texture2D) -> void:
	_stored_texture = texture

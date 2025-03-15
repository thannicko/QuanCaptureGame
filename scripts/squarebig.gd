class_name BigSquare extends Square

@onready var sprite : Node2D = $Sprite

const LeftFacingFirstHalfRotation : int = 90
const LeftFacingSecondHalfRotation : int = 180
const RightFacingFirstHalfRotation : int = 0
const RightFacingSecondHalfRotation : int = -90

func _ready() -> void:
	super._ready()
	print(name, " global ", global_position)

func get_size() -> Vector2:
	return Vector2(16 * scale.x * 0.9, 32 * scale.y * 0.9)

func _input(event: InputEvent) -> void:
	super._input(event)

func face_left() -> void:
	sprite.rotation_degrees = 180
	rock_pile.scale.x *= 1
	disabled_square.rotation_degrees = sprite.rotation_degrees
	
func face_right() -> void:
	sprite.rotation_degrees = 0
	rock_pile.scale.x *= -1
	disabled_square.rotation_degrees = sprite.rotation_degrees

class_name BigSquare extends Square

@onready var sprite : Node2D = $Sprite

const LeftFacingFirstHalfRotation : int = 90
const LeftFacingSecondHalfRotation : int = 180
const RightFacingFirstHalfRotation : int = 0
const RightFacingSecondHalfRotation : int = -90

func _input(event: InputEvent) -> void:
	super._input(event)

func face_left() -> void:
	sprite.rotation_degrees = 180
	rock_pile.position.x = 4 # Put the rock in the middle
	
func face_right() -> void:
	sprite.rotation_degrees = 0
	rock_pile.position.x = 8

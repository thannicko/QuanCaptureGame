extends TextureButton


func _ready() -> void:
	button_down.connect(go_to_game)

func go_to_game() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

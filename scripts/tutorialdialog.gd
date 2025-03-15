class_name TutorialDialog extends TextureRect

signal text_shown()

@onready var label: RichTextLabel = $"MarginContainer/RichTextLabel"
@onready var type_timer: Timer = $"TypeTimer"

func _ready() -> void:
	type_timer.timeout.connect(on_type_timeout)

func show_text(text: String) -> void:
	label.text = text
	label.visible_characters = 0
	type_timer.start()

func on_type_timeout() -> void:
	label.visible_characters += 1
	if (label.visible_ratio >= 1):
		type_timer.stop()
		text_shown.emit()
	else:
		type_timer.start()
	

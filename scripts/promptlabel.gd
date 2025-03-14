extends Label

var timer: Timer = Timer.new()

func _ready() -> void:
	GlobalPrompter.new_prompt_requested.connect(update_text)
	timer.one_shot = true
	timer.wait_time = 3.0
	timer.timeout.connect(hide)
	add_child(timer)

func update_text(prompt: String) -> void:
	text = prompt
	show()
	timer.start()
	

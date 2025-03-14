class_name Prompter extends Node

signal new_prompt_requested(prompt: String)

func prompt(text: String) -> void:
	print("Prompt: ", text)
	new_prompt_requested.emit(text)

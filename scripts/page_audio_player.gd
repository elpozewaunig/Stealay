extends Node2D

@onready var page_sound: AudioStreamPlayer = $AudioStreamPlayer

func _on_page_turn() -> void:
	page_sound.play()

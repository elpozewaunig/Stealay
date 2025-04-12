extends Node2D

@onready var click_sound = $ClickSound
@onready var hover_sound = $HoverSound

func _on_click() -> void:
	click_sound.play()
	
func _on_hover() -> void:
	hover_sound.play()

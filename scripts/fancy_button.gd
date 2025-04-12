extends Node2D

func _ready() -> void:
	$Fills.hide()

func _on_area_2d_mouse_entered() -> void:
	$Fills.show()


func _on_area_2d_mouse_exited() -> void:
	$Fills.hide()

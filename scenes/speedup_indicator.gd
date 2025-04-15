extends Control

func _process(delta: float) -> void:
	if Globals.allow_speedup:
		show()
	else:
		hide()

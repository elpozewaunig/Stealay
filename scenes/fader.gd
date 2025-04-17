extends ColorRect

var fademe = false


func _ready() -> void:
	self.color.a = 0

func _on_play_button_pressed() -> void:
	fademe = true

func _process(delta: float) -> void:
	if fademe:
		self.color.a += 1 * delta

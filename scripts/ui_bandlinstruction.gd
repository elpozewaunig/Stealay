extends Control

@export var UpArrowSymbol: Control
@export var DownArrowSymbol: Control
@export var LeftArrowSymbol: Control
@export var RightArrowSymbol: Control
@export var HideArrowSymbol: Control
@export var EmptyArrowSymbol: Control
@export var SelectionRibbon: Control

enum movement { 
	UP,
	DOWN,
	RIGHT, 
	LEFT, 
	HIDE 
	}
	
func _ready() -> void:
	UpArrowSymbol.hide()
	DownArrowSymbol.hide()
	LeftArrowSymbol.hide()
	RightArrowSymbol.hide()
	HideArrowSymbol.hide()
	EmptyArrowSymbol.hide()

func change_visibility(sel: movement, empty) -> void:
	if (sel == movement.UP):
		UpArrowSymbol.show()
		DownArrowSymbol.hide()
		LeftArrowSymbol.hide()
		RightArrowSymbol.hide()
		HideArrowSymbol.hide()
		EmptyArrowSymbol.hide()
	elif (sel == movement.DOWN):
		UpArrowSymbol.hide()
		DownArrowSymbol.show()
		LeftArrowSymbol.hide()
		RightArrowSymbol.hide()
		HideArrowSymbol.hide()
		EmptyArrowSymbol.hide()
	elif (sel == movement.LEFT):
		UpArrowSymbol.hide()
		DownArrowSymbol.hide()
		LeftArrowSymbol.show()
		RightArrowSymbol.hide()
		HideArrowSymbol.hide()
		EmptyArrowSymbol.hide()
	elif (sel == movement.RIGHT):
		UpArrowSymbol.hide()
		DownArrowSymbol.hide()
		LeftArrowSymbol.hide()
		RightArrowSymbol.show()
		HideArrowSymbol.hide()
		EmptyArrowSymbol.hide()
	elif (sel == movement.HIDE):
		UpArrowSymbol.hide()
		DownArrowSymbol.hide()
		LeftArrowSymbol.hide()
		RightArrowSymbol.hide()
		HideArrowSymbol.show()
		EmptyArrowSymbol.hide()
	elif (empty):
		UpArrowSymbol.hide()
		DownArrowSymbol.hide()
		LeftArrowSymbol.hide()
		RightArrowSymbol.hide()
		HideArrowSymbol.hide()
		EmptyArrowSymbol.show()
	else:
		push_error("Falash!!!")

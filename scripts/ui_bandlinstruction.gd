extends Control

@export var UpArrowSymbol: Control
@export var DownArrowSymbol: Control
@export var LeftArrowSymbol: Control
@export var RightArrowSymbol: Control
@export var HideArrowSymbol: Control
@export var EmptyArrowSymbol: Control
@export var SelectionRibbon: Control


@export var above: Control
@export var below: Control
var movementPos = movement.NONE


enum movement { 
	UP,
	DOWN,
	RIGHT, 
	LEFT, 
	HIDE,
	NONE
	}

func _ready() -> void:
	hide_all()

func hide_all(): 
	UpArrowSymbol.hide()
	DownArrowSymbol.hide()
	LeftArrowSymbol.hide()
	RightArrowSymbol.hide()
	HideArrowSymbol.hide()
	EmptyArrowSymbol.hide()
func change_visibility(sel: movement, empty) -> void:
	hide_all()
	movementPos = sel
	if (sel == movement.UP):
		UpArrowSymbol.show()
	elif (sel == movement.DOWN):
		DownArrowSymbol.show()
	elif (sel == movement.LEFT):
		LeftArrowSymbol.show()
	elif (sel == movement.RIGHT):
		RightArrowSymbol.show()
	elif (sel == movement.HIDE):
		HideArrowSymbol.show()
	elif (empty):
		EmptyArrowSymbol.show()
	else:
		push_error("Falash!!!")

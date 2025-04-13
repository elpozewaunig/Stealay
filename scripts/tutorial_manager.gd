extends Control

var tutorial_progress: int = 0

@export var heist_planner: Control
@export var movement_hint: Control
@export var undo_hint: Control
@export var start_hint: Control

@onready var chats: Array[ChatSection] = [
	$Chat,
	$Chat2,
	$Chat3,
	$Chat4,
	$Chat5
]
@onready var instructions: Label = $Instructions

var tutorial_completed: bool = false

var current_chat: ChatSection

func _ready() -> void:
	set_hint_visibility(false)
	for chat in chats:
		chat.hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("SkipTutorial"):
		Globals.tutorial_enabled = false
	
	if Globals.tutorial_enabled and not tutorial_completed:
		show()
		
		if tutorial_progress == 0:
			current_chat = chats[0]
			current_chat.show()
			if current_chat.done:
				current_chat.hide()
				tutorial_progress += 1
		
		if tutorial_progress == 1:
			current_chat = chats[1]
			current_chat.show()
			if current_chat.done:
				current_chat.hide()
				tutorial_progress += 1
		
		if tutorial_progress == 2:
			instructions.text = "Plan your moves using the arrow keys."
			instructions.show()
			movement_hint.show()
			heist_planner.allow_move = true
			
			if heist_planner.move_history.size() > 1:
				print(heist_planner.move_history)
				tutorial_progress += 1
				heist_planner.allow_move = false
				instructions.hide()
		
		if tutorial_progress == 3:
			current_chat = chats[2]
			current_chat.show()
			if current_chat.done:
				current_chat.hide()
				tutorial_progress += 1
		
		if tutorial_progress == 4:
			current_chat = chats[3]
			current_chat.show()
			if current_chat.done:
				current_chat.hide()
				tutorial_progress += 1
		
		if tutorial_progress == 5:
			current_chat = chats[4]
			current_chat.show()
			if current_chat.done:
				current_chat.hide()
				
				tutorial_progress += 1
				instructions.text = "Finish your plan, then execute it by pressing enter."
				instructions.show()
				undo_hint.show()
				start_hint.show()
				heist_planner.allow_move = true
				heist_planner.allow_commit = true
				tutorial_completed = true
				Globals.tutorial_enabled = false
				
		if Input.is_action_just_pressed("PlannerCommit"):
			current_chat.advance_dialogue()
	
	else:
		hide()
		if current_chat != null:
			current_chat.silence()
		set_hint_visibility(true)
		heist_planner.allow_move = true
		heist_planner.allow_commit = true

func set_hint_visibility(visibility: bool) -> void:
	movement_hint.visible = visibility
	undo_hint.visible = visibility
	start_hint.visible = visibility

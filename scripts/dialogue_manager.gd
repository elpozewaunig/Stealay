extends Control

var tutorial_progress: int = 0

@export var heist_planner: Control

@onready var chats: Array[ChatSection] = [
	$Chat,
	$Chat2,
	$Chat3,
	$Chat4,
	$Chat5
]
@onready var instructions: Label = $Instructions

func _ready() -> void:
	for chat in chats:
		chat.hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("SkipTutorial"):
		Globals.tutorial_enabled = false
	
	if Globals.tutorial_enabled:
		var current_chat = chats[0]
		
		if tutorial_progress == 0:
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
				heist_planner.allow_move = true
				heist_planner.allow_commit = true
				Globals.tutorial_enabled = false
				
		if Input.is_action_just_pressed("PlannerCommit"):
				current_chat.advance_dialogue()
	
	else:
		hide()
		heist_planner.allow_move = true
		heist_planner.allow_commit = true

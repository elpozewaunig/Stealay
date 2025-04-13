extends Node2D
class_name ChatSection

@export_multiline var messages: Array[String] = []
@export var voicelines: Array[AudioStream] = []
@export var chat_icon: int = 0
@export var characters_per_second: float = 20

@onready var speech_bubbles: Array[Node2D] = [
	$SpeechBubble,
	$SpeechRect,
	$SpeechRect2
]
@onready var continue_label: Label = $ContinueLabel
@onready var chat_sprite: AnimatedSprite2D = $ChatGuy
@onready var voiceline_player: AudioStreamPlayer = $VoicelinePlayer

var bubble_labels: Array[Label] = []

var active: bool = false
var prev_msg_index: int = -1
var current_msg_index: int = 0
var done: bool = false

var text_finished: bool = false
var character_index: int = 0
var time_btwn_chars: float = 0
var time_elapsed: float = 0

func _ready() -> void:
	chat_sprite.frame = chat_icon
	
	for speech_bubble in speech_bubbles:
		speech_bubble.hide()
		bubble_labels.append(speech_bubble.get_child(0))
	
	for label in bubble_labels:
		label.text = ""
	
	speech_bubbles[0].show()
	time_btwn_chars = 1 / characters_per_second
		

func _process(delta: float) -> void:
	if visible:
		time_elapsed += delta
		
		var current_bubble = speech_bubbles[current_msg_index]
		var current_label = bubble_labels[current_msg_index]

		var current_message = messages[current_msg_index]
		
		current_bubble.show()
		
		# Most recent message just changed
		if prev_msg_index != current_msg_index:
			prev_msg_index = current_msg_index
			text_finished = false
			character_index = 0
			voiceline_player.stream = voicelines[current_msg_index]
			voiceline_player.play()
		
		while time_elapsed > time_btwn_chars:
			time_elapsed -= time_btwn_chars
			if not text_finished:
				current_label.text += current_message[character_index]
				character_index += 1
				if current_label.text.length() == current_message.length():
					text_finished = true
		
		if text_finished:
			continue_label.show()
			continue_label.position.y = current_bubble.position.y + 170
		else:
			continue_label.hide()

func advance_dialogue() -> void:
	if not text_finished:
		finalize_bubble()
		voiceline_player.stop()
	elif current_msg_index < messages.size() - 1:
		current_msg_index += 1
	else:
		done = true
	
func finalize_bubble() -> void:
	bubble_labels[current_msg_index].text = messages[current_msg_index]
	text_finished = true

func silence() -> void:
	voiceline_player.stop()

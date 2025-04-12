extends Sprite2D

@export var current_view: Viewport
#@export var sprite_to_flip: Sprite3D
@export var mesh_material_to_flip: StandardMaterial3D
@export var animation_player: AnimationPlayer


func _ready() -> void:
	show()

func _on_page_flip(direction: int = 3) -> void:
	var current_image = current_view.get_texture().get_image()
	#sprite_to_flip.texture = ImageTexture.create_from_image(current_image)
	mesh_material_to_flip.albedo_texture = ImageTexture.create_from_image(current_image)
	
	# Fly in
	if direction == 1:
		animation_player.play("flip_up")
	# Fly out
	elif direction == 2:
		animation_player.play("flip_down")
		
	elif direction == 3:
		animation_player.play("deformflip")
	show()

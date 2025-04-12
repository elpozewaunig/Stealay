extends Sprite2D

@export var current_view: Viewport
@export var sprite_to_flip: Sprite3D
@export var animation_player: AnimationPlayer

func _on_page_flip(direction: int = 1) -> void:
	var current_image = current_view.get_texture().get_image()
	sprite_to_flip.texture = ImageTexture.create_from_image(current_image)
	
	# Fly in
	if direction > 0:
		animation_player.play("flip_up")
	# Fly out
	if direction < 0:
		animation_player.play("flip_down")

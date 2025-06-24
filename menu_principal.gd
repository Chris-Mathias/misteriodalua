extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicManager.tocar_musica("menu")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://fase_01.tscn")


func _on_sair_pressed() -> void:
	get_tree().quit()

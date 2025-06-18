extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_continuar_pressed() -> void:
	get_tree().paused = false
	queue_free()



func _on_sair_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu_principal.tscn")

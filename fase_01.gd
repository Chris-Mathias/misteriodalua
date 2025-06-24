extends Node2D


func _input(event: InputEvent):
	if Dialogic.current_timeline != null:
		return

	if event.is_action_pressed("ui_accept") and $player.allow_stone_dialog == true:
		Dialogic.start("level01_stone")
		$player.disable_movement()
		get_viewport().set_input_as_handled()

	elif event.is_action_pressed("ui_accept") and $player.allow_npc01_dialog == true:
		Dialogic.start("level01_npc")
		$player.disable_movement()
		get_viewport().set_input_as_handled()

func _ready() -> void:
	MusicManager.tocar_musica("fase1")
	Dialogic.signal_event.connect(_on_dialog_signal)
	Dialogic.start("level01_start")
	$player.disable_movement()


func _process(delta: float) -> void:
	pass


func _on_dialog_signal(argument: String):
	if argument == "enable_movement":
		$player.enable_movement()
	if argument == "next_level":
		get_tree().change_scene_to_file("res://fase_02.tscn")

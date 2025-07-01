extends Node2D


func _input(event: InputEvent):
	if Dialogic.current_timeline != null:
		return

	if event.is_action_pressed("ui_accept") and $player.allow_rocket_dialog == true:
		Dialogic.start("levelfinal_rocket")
		$player.disable_movement()
		get_viewport().set_input_as_handled()


func _ready() -> void:
	MusicManager.tocar_musica("fase_final")
	Dialogic.signal_event.connect(_on_dialog_signal)


func _process(delta: float) -> void:
	pass


func _on_dialog_signal(argument: String):
	if argument == "end":
		Transition.start_transition("res://menu_principal.tscn")

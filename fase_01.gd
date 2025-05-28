extends Node2D


var dialog_stone_allow = false


func _input(event: InputEvent):
	if Dialogic.current_timeline != null:
		return
		
	if event.is_action_pressed("ui_accept") and $player.allow_stone_dialog == true:
		Dialogic.start("level01_stone")
		$player.disable_movement()
		get_viewport().set_input_as_handled()


func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialog_signal)
	pass 


func _process(delta: float) -> void:
	pass


func _on_dialog_signal(argument: String):
	if argument == "enable_movement":
		$player.enable_movement()

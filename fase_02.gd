extends Node2D


@export var allow_xuxa_dialog = true


func _input(event: InputEvent):
	if Dialogic.current_timeline != null:
		return

	if event.is_action_pressed("ui_accept") and $player.allow_npc02_dialog == true:
		Dialogic.start("level02_npc")
		$player.disable_movement()
		get_viewport().set_input_as_handled()

	if event.is_action_pressed("ui_accept") and $player.allow_arch_dialog == true:
		Dialogic.start("level02_arch")
		$player.disable_movement()
		get_viewport().set_input_as_handled()


func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialog_signal)


func _process(delta: float) -> void:
	if $player.play_xuxa_dialog == true and allow_xuxa_dialog == true:
		allow_xuxa_dialog = false
		Dialogic.start("level02_start")
		$player.disable_movement()
		get_viewport().set_input_as_handled()


func _on_dialog_signal(argument: String):
	if argument == "enable_movement":
		$player.enable_movement()
	if argument == "next_level":
		get_tree().change_scene_to_file("res://fase_final.tscn")

class_name Player
extends CharacterBody2D


@export var speed : float = 200.0
@export var animation_tree : AnimationTree
@export var allow_stone_dialog = false
@export var allow_npc01_dialog = false
@export var allow_npc02_dialog = false
@export var play_xuxa_dialog = false

@onready var audio_passos = $AudioPassos

var input : Vector2
var playback : AnimationNodeStateMachinePlayback

const PAUSE_MENU = preload("res://pause_menu.tscn")

func tocar_som_de_passo():
	if not is_on_floor():
		return
	audio_passos.play

func _ready():
	playback = animation_tree["parameters/playback"]


func _physics_process(delta: float) -> void:
	
	
	
	if Input.is_action_just_pressed("ui_cancel"):
		if not has_node("PauseMenu"):
			var menu_instance = PAUSE_MENU.instantiate()
			menu_instance.name = "PauseMenu"
			add_child(menu_instance)

	input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if Input.is_action_pressed("ui_up"):
		input.y -= 1
	if Input.is_action_pressed("ui_down"):
		input.y += 1
	if Input.is_action_pressed("ui_left"):
		input.x -= 1
	if Input.is_action_pressed("ui_right"):
		input.x += 1

	if input != Vector2.ZERO:
		input = input.normalized()

	velocity = Vector2(input.x * 2, input.y) * speed
	move_and_slide()
	select_animation()
	update_animation_parameters()
	
	
func select_animation():
	if velocity == Vector2.ZERO:
		playback.travel("Idle")
	else:
		playback.travel("Walk")
	

func update_animation_parameters():
	if input == Vector2.ZERO:
		return
		
	animation_tree["parameters/Idle/blend_position"] = input
	animation_tree["parameters/Walk/blend_position"] = input


func disable_movement():
	set_physics_process(false)
	set_process_input(false)
	velocity = Vector2.ZERO
	select_animation()


func enable_movement():
	set_physics_process(true)
	set_process_input(true)


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "npc01":
		allow_npc01_dialog = true
	elif body.name == "lunar_tree":
		allow_stone_dialog = true
	elif body.name == "npc02":
		allow_npc02_dialog = true
	elif body.name == "area_xuxa":
		play_xuxa_dialog = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	allow_npc01_dialog = false
	allow_stone_dialog = false
	allow_npc02_dialog = false
	play_xuxa_dialog = false

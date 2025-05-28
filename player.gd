class_name Player
extends CharacterBody2D


@export var speed : float = 50
@export var animation_tree : AnimationTree
@export var allow_stone_dialog = false

var input : Vector2
var playback : AnimationNodeStateMachinePlayback


func _ready():
	playback = animation_tree["parameters/playback"]


func _physics_process(delta: float) -> void:
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


func enable_movement():
	set_physics_process(true)
	set_process_input(true)


func _on_area_2d_body_entered(body: Node2D) -> void:
	allow_stone_dialog = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	allow_stone_dialog = false

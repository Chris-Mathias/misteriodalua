class_name NPC
extends CharacterBody2D

@export var speed: float = 300.0
@export var animation_tree: AnimationTree
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var player_ref: CharacterBody2D = null
var animation_playback: AnimationNodeStateMachinePlayback
var current_animation_direction: Vector2 = Vector2(0, 1)

func _ready():
	if not animation_tree:
		printerr("AnimationTree não está configurado para o NPC!")
		set_physics_process(false)
		return
	
	animation_playback = animation_tree["parameters/playback"]
	
	player_ref = get_tree().get_root().find_child("player", true, false)

	if not is_instance_valid(player_ref):
		printerr("NPC não conseguiu encontrar o jogador!")
		set_physics_process(false)
		return

	if not navigation_agent:
		printerr("NavigationAgent2D não encontrado no NPC!")
		set_physics_process(false)
		return
		
	navigation_agent.target_position = player_ref.global_position


func _physics_process(delta: float) -> void:
	if not is_instance_valid(player_ref):
		velocity = Vector2.ZERO
		current_animation_direction = Vector2.ZERO
		select_animation()
		update_animation_parameters()
		return

	if navigation_agent.target_position != player_ref.global_position:
		navigation_agent.target_position = player_ref.global_position

	if navigation_agent.is_navigation_finished():
		velocity = Vector2.ZERO
	else:
		var next_position = navigation_agent.get_next_path_position()
		var direction = (next_position - global_position).normalized()
		velocity = direction * speed

	move_and_slide()

	if velocity.length_squared() > 0.01:
		current_animation_direction = velocity.normalized()

	select_animation()
	update_animation_parameters()


func select_animation():
	if velocity.length_squared() < 0.01:
		animation_playback.travel("Idle")
	else:
		animation_playback.travel("Walk")
	

func update_animation_parameters():
	animation_tree["parameters/Idle/blend_position"] = current_animation_direction
	animation_tree["parameters/Walk/blend_position"] = current_animation_direction


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	print("NPC: _on_velocity_computed chamada com safe_velocity: ", safe_velocity)
	velocity = safe_velocity
	move_and_slide()

	if velocity.length_squared() > 0.01:
		current_animation_direction = velocity.normalized()

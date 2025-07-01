extends CanvasLayer

signal transition_finished

@onready var anim = $AnimationPlayer
@onready var color_rect = $ColorRect

var should_change_music := false
var nome_da_faixa := ""
var music_player : GlobalMusic = null

func start_transition(scene_path: String, troca_musica := false, nome_faixa := ""):
	should_change_music = troca_musica
	nome_da_faixa = nome_faixa
	
	color_rect.modulate.a = 0.0
	
	anim.play("fade_out")
	await anim.animation_finished
	if should_change_music:
		await MusicManager.fazer_fade_para_faixa(nome_da_faixa)

	get_tree().change_scene_to_file(scene_path)

	anim.play("fade_in")
	await anim.animation_finished

	emit_signal("transition_finished")


func _ready():
	# Garante que começa opaco (se quiser)
	color_rect.modulate.a = 1.0
	anim.play("fade_in")
	await anim.animation_finished

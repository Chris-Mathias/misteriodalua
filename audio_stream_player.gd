extends AudioStreamPlayer

class_name GlobalMusic


var music_tracks = {
	"menu": {
		"track": preload("res://assets/trilha_sonora/menu.mp3"),
		"volume": -5.0
		},
	"fase1": { 
		"track": preload("res://assets/trilha_sonora/fase1.mp3"),
		"volume": -15.0
		},
	"fase_final": {
		"track": preload("res://assets/trilha_sonora/fase final.mp3"),
		"volume": -15.0
	}
}


var musica_atual = null
var fading := false


func tocar_musica(nome_da_faixa):
	if not music_tracks.has(nome_da_faixa):
		print("música não existente")
		return
	
	if musica_atual == nome_da_faixa:
		return
	
	var info_da_faixa = music_tracks[nome_da_faixa]
	musica_atual = nome_da_faixa
	stream = info_da_faixa["track"]
	volume_db = info_da_faixa["volume"]
	play()


func ease_in_out(t: float) -> float:
	return t * t * (3.0 - 2.0 * t)


func fazer_fade_para_faixa(nome_da_faixa: String, tempo := 1.5) -> void:
	if not music_tracks.has(nome_da_faixa) or musica_atual == nome_da_faixa or fading:
		return

	fading = true
	var target_info = music_tracks[nome_da_faixa]
	var target_stream = target_info["track"]
	var target_volume = target_info["volume"]

	# Fade out
	var frames = int(tempo * 60)
	var start_volume = volume_db
	for t in range(frames):
		var progress = float(t) / frames
		var eased = ease_in_out(progress)
		volume_db = lerp(start_volume, -80.0, eased)
		await get_tree().process_frame

	stop()
	stream = target_stream
	musica_atual = nome_da_faixa
	play()

	# Fade in
	for t in range(frames):
		var progress = float(t) / frames
		var eased = ease_in_out(progress)
		volume_db = lerp(-80.0, target_volume, eased)
		await get_tree().process_frame

	volume_db = target_volume
	fading = false


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

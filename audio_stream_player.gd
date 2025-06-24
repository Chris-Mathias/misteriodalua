extends AudioStreamPlayer

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
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

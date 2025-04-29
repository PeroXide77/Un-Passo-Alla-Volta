extends Control

var next_scene = coseDaRicordare.next_scene
func _ready():
	coseDaRicordare._apply_global_size(get_tree().root)
	$ProgressBar.set_deferred("size", Vector2(coseDaRicordare.size[0]/1.5, coseDaRicordare.size[1]/8))
	$ProgressBar.set_anchor_and_offset((SIDE_LEFT), 0.5, -coseDaRicordare.size[0]/3)
	ResourceLoader.load_threaded_request(next_scene)
# in maniera asincrona salviamo la prossima scena in background

#facciamo la funzione che fa vedere effettivemente il progresso nella barra
func _process(_delta): #delta è il tempo trascorso durante un frame
	var progress = []
	ResourceLoader.load_threaded_get_status(next_scene, progress) #proprio in numero, tipo 10%
	$ProgressBar.value = progress[0]*100  #per la percentuale
	if progress[0] == 1:
		var packed_scene = ResourceLoader.load_threaded_get(next_scene)
		get_tree().change_scene_to_packed(packed_scene);

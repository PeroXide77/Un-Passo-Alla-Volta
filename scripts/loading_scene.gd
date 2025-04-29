extends Control

var next_scene = coseDaRicordare.next_scene
func _ready():
	ResourceLoader.load_threaded_request(next_scene)
	_progress()
# in maniera asincrona salviamo la prossima scena in background

#facciamo la funzione che fa vedere effettivemente il progresso nella barra
func _progress(): #delta è il tempo trascorso durante un frame
	var progress = []
	ResourceLoader.load_threaded_get_status(next_scene, progress) #proprio in numero, tipo 10%
	print(progress)
	$ProgressBar.value = progress[0]*100  #per la percentuale
	if progress[0] == 1:
		var packed_scene = ResourceLoader.load_threaded_get(next_scene)
		get_tree().change_scene_to_packed(packed_scene);

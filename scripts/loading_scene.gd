extends Control

var next_scene = Globals.next_scene
func _ready():
	Globals._apply_global_size(get_tree().root)
	Globals.loading_bar_fix($ProgressBar)
	ResourceLoader.load_threaded_request(next_scene)
# in maniera asincrona salviamo la prossima scena in background

#facciamo la funzione che fa vedere effettivemente il progresso nella barra
func _process(_delta): #delta è il tempo trascorso durante un frame
	var progress = []
	ResourceLoader.load_threaded_get_status(next_scene, progress) #proprio in numero, tipo 10%
	$ProgressBar.value = progress[0]*100  #per la percentuale
	if progress[0] == 1:
		$ProgressBar.value = progress[0]*100
		await get_tree().create_timer(1.0).timeout
		Globals.goto_scene(next_scene)
	
	

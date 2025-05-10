extends Control

@onready var progBar : ProgressBar = $ProgressBar

var nextScene = Globals.get_nextScene()
func _ready():
	ResourceLoader.load_threaded_request(nextScene)
# in maniera asincrona salviamo la prossima scena in background

#facciamo la funzione che fa vedere effettivemente il progresso nella barra
func _process(_delta): #delta è il tempo trascorso durante un frame
	var progress = []
	ResourceLoader.load_threaded_get_status(nextScene, progress) #proprio in numero, tipo 10%
	progBar.value = progress[0]*100  #per la percentuale
	if progress[0] == 1:
		progBar.value = progress[0]*100
		await get_tree().create_timer(1.0).timeout
		Globals.goto_scene(nextScene)

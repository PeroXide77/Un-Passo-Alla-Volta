extends Node
##QUESTA è UN AUTOLOAD (O SINGLETON)
## script che viene caricato automaticamente all'avvio del gioco e rimane attivo per tutte le scene.
##Per tenere dati condivisi come punteggio, l'audio
##iniziamo con un valore a caso che poi ogni volta che cambio il volume sullo slide si cambia
var volume = 100

#per caricare la scena successiva
#var loading_screen = preload("res://scenes/loading_page.tscn")
var loading_screen = "res://scenes/loading_page.tscn"
var next_scene
var size = Vector2(1300,750)

func _apply_global_size(node):
	DisplayServer.window_set_size(size)
	DisplayServer.window_set_position(Vector2(300,200))
	if node is Control:
		node.set_deferred("size", size)
	for child in node.get_children():
		if child is ProgressBar:
			pass
		else: 
			_apply_global_size(child)

extends Node
##QUESTA è UN AUTOLOAD (O SINGLETON)
## script che viene caricato automaticamente all'avvio del gioco e rimane attivo per tutte le scene.
##Per tenere dati condivisi come punteggio, l'audio
##iniziamo con un valore a caso che poi ogni volta che cambio il volume sullo slide si cambia
var volume = 100

#per caricare la scena successiva
var loading_screen = preload("res://scene/loading_page.tscn")
var next_scene : String = ""

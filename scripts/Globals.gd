extends Node
##QUESTA è UN AUTOLOAD (O SINGLETON)
## script che viene caricato automaticamente all'avvio del gioco e rimane attivo per tutte le scene.
##Per tenere dati condivisi come punteggio, l'audio

const BTN_SOUND: AudioStream = preload("res://assets/sounds/markerSound.mp3")
const BTN_CLICK: AudioStream = preload("res://assets/sounds/button_click.mp3")
const loading_screen = "res://scenes/loading_page.tscn"
const resolutions = {
	"1920x1080": Vector2i(1920,1080),
	"1280x720": Vector2i(1280,720),
	"854x480": Vector2i(854,480)
}
const npcTutorials = {
	"eyeTrack" : "res://assets/sprites/NPC/Belle.png",
	"regali" : "res://assets/sprites/NPC/Giuseppe.png",
	"school" : "res://assets/sprites/NPC/Rita.png"
}
const eyesId = {
	0 : "arrabbiato",
	1 : "felice",
	2 : "pensieroso",
	3 : "sorpreso",
	4 : "timido",
	5 : "preoccupato",
	6 : "triste",
	7 : "eccitato"
}
const stationeryId = {
	0 : "forbici",
	1 : "gomma",
	2 : "matita",
	3 : "pastello",
	4 : "portamine",
	5 : "riga",
	6 : "scolorina"
}
var current_scene = null
var nextScene = null 
var volume: float = 50
var volumeSuono: float = 50
var resIndex = 0
var gameState: int = 0
var end : bool
var txtTutorial : String = ""
var npcTutorial : String = ""
var flagMinigameEnd : bool = false
var flagDiario : bool = false
var save_path = "res://dataSaving/saving.txt"

func _ready() -> void:
	var root = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)
	load_data()

func save_data():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_line(str(gameState))
	file.close()

func load_data():
	var file = FileAccess.open(save_path, FileAccess.READ)
	if file:
		var gameStateFile: String = file.get_as_text()
		set_gameState(int(gameStateFile))
		file.close()
	else:
		print("Error: Could not open file at " + save_path)

func cancel_data():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_line("0")
	set_gameState(0)
	file.close()

func get_gameState() -> int:
	return gameState

func set_gameState(g : int) -> void:
	gameState = g

func nextState() -> void:
	gameState += 1
	save_data()

func set_volume(v: float) -> void:
	volume = clamp(v, 0.0, 100.0)
	var linear_volume = volume / 100.0
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musica"), linear_to_db(linear_volume))

func get_volume() -> float:
	return volume

func set_volume_suono(v: float) -> void:
	volumeSuono = clamp(v, 0.0, 100.0)
	var linear_volume = volumeSuono / 100.0
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Suoni"), linear_to_db(linear_volume))

func get_volume_suono() -> float:
	return volumeSuono

func get_flag() -> bool:
	return flagDiario

func set_flag(f: bool):
	flagDiario = f

func get_nextScene() -> String:
	return nextScene

func set_nextScene(ns: String):
	nextScene = ns

func is_end(flag : bool):
	end = flag

func get_end() -> bool:
	return end

func get_txtTutorial() -> String:
	return txtTutorial

func set_txtTutorial(s : String) -> void:
	txtTutorial = s

func get_npcTutorial() -> String:
	return npcTutorial

func set_npcTutorial(s : String) -> void:
	npcTutorial = s

func setFlagMinigameEnd(b: bool) -> void:
	flagMinigameEnd = b

func isMinigameEnded() -> bool:
	return flagMinigameEnd

func goto_load_scene(scena):
	nextScene = scena
	goto_scene(loading_screen)

		
func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	_deferred_goto_scene.call_deferred(path)

func sound_marker(a:AudioStreamPlayer):
	a.bus = "Suoni"
	a.set_stream(BTN_SOUND)
	a.play(0)

func btn_hover_enter(b: Button, a:AudioStreamPlayer):
	a.bus = "Suoni"
	a.set_stream(BTN_SOUND)
	b.set_flat(false)
	a.play(0)

func btn_click(a:AudioStreamPlayer):
	a.set_bus("Suoni")
	a.set_stream(BTN_CLICK)
	a.play(0)

func btn_hover_exit(b: Button):
	b.set_flat(true)

func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene

func randomizeColor() -> Color:
	return Color(randf(),randf(),randf())

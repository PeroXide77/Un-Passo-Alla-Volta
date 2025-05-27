extends Node
##QUESTA è UN AUTOLOAD (O SINGLETON)
## script che viene caricato automaticamente all'avvio del gioco e rimane attivo per tutte le scene.
##Per tenere dati condivisi come punteggio, l'audio


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
var current_scene = null
var nextScene = null
var volume: float = 100
var resIndex = 0
var gameState: int = 10
var end : bool
var txtTutorial : String = ""
var npcTutorial : String = ""

func get_gameState() -> int:
	return gameState

func nextState() -> void:
	gameState += 1

func get_volume() -> float:
	return volume

func set_volume(v: float):
	volume = v

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

func _ready():
	var root = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)

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

func btn_hover(b: Button):
	if b.is_hovered():
		b.set_flat(false)
	else:
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

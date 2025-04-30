extends Node
##QUESTA è UN AUTOLOAD (O SINGLETON)
## script che viene caricato automaticamente all'avvio del gioco e rimane attivo per tutte le scene.
##Per tenere dati condivisi come punteggio, l'audio


const loading_screen = "res://scenes/loading_page.tscn"
var current_scene = null
var next_scene = null
var volume = 100
var resolution = Vector2(1300,750)

func _ready():
	var root = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)
	

func loading_bar_fix(barra):
	if barra is ProgressBar:
		barra.set_deferred("size", Vector2(resolution[0]/1.5, resolution[1]/8))
		barra.set_anchor_and_offset((SIDE_LEFT), 0.5, -resolution[0]/3)
	else:
		pass

func menu_buttons_fix(container):
	if container is HBoxContainer:
		for child in container.get_children():
			if child is BaseButton:
				child.set_deferred("size", Vector2(resolution[0]/4, resolution[1]/3))


#da sistemare sicuramente
func _apply_global_size(node):
	DisplayServer.window_set_size(resolution)
	DisplayServer.window_set_position(Vector2(50,50))
	if node is Control:
		node.set_deferred("size", resolution)
	for child in node.get_children():
		if child is Control:
			if child.get_tooltip().match("escludi"):
				child.set_deferred("size", resolution)
				break
			else:
				child.set_deferred("size", resolution)
		else: 
			_apply_global_size(child)

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	_deferred_goto_scene.call_deferred(path)


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

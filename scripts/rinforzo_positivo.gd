extends Control

@onready var postIts = get_tree().get_nodes_in_group("postIt")

func _ready() -> void:
	show_postIts()

func _on_return_pressed() -> void:
	Globals.goto_load_scene("res://scenes/selezione_livelli.tscn")

func show_postIts() -> void:
	var gs = Globals.get_gameState()
	for postIt in postIts:
		if postIt.get_meta("lv") < gs:
			postIt.set_visible(true)

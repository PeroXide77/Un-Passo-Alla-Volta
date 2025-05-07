extends Control


func _on_ritorna_indietro_pressed() -> void:
	Globals.goto_load_scene("res://scenes/mainmenu.tscn")


func _on_livello_0_button_pressed() -> void:
	Globals.goto_load_scene("res://scenes/tutorial.tscn")

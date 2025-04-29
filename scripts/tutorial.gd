extends Control
func _on_ritorna_indietro_pressed() -> void:
	coseDaRicordare.next_scene = "res://scene/mainmenu.tscn"
	get_tree().change_scene_to_packed(coseDaRicordare.loading_screen);

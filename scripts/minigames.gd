extends Control

@onready var popup_imp : Popup = $Impostazioni

func _on_impostazioni_pressed() -> void:
	popup_imp.popup()

func _on_ritorna_indietro_pressed() -> void:
	Globals.goto_load_scene("res://scenes/mainmenu.tscn")

func _on_first_minigame_pressed() -> void:
	Globals.goto_load_scene("res://scenes/mng_regali.tscn")

func _on_second_minigame_pressed() -> void:
	Globals.goto_load_scene("res://scenes/mng_eyeTrack.tscn")

func _on_third_minigame_pressed() -> void:
	Globals.goto_load_scene("res://scenes/mng_school.tscn")

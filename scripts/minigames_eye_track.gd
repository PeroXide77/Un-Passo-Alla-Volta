extends Control

@onready var popup_imp : Popup = $Impostazioni
@onready var preMinigame : Popup = $preMinigame

func _ready() -> void:
	preMinigame.popup()

func _on_impostazioni_pressed() -> void:
	popup_imp.popup()

func _on_ritorna_indietro_pressed() -> void:
	Globals.goto_load_scene("res://scenes/minigames.tscn")

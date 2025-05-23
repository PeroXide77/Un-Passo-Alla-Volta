extends Control

@onready var popup_imp : Popup = $Impostazioni
@onready var scribble3 : TextureRect = $Scribble3
@onready var crediti : Popup = $Impostazioni/crediti

func _ready() -> void:
	scribble3.set_self_modulate(Globals.randomizeColor())

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

func _on_scribble_3_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		scribble3.set_self_modulate(Globals.randomizeColor())

func _on_scribble_4_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		crediti.popup()

func _on_exit_pressed() -> void:
	crediti.hide()

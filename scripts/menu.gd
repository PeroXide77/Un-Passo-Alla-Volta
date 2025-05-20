extends Control

@onready var checkLvl = $VBoxContainer/SelezioneLivelli/CheckLvl
@onready var checkImp = $VBoxContainer/Impostazioni/CheckImp
@onready var checkExit = $VBoxContainer/Exit/CheckExit
@onready var checkMng = $VBoxContainer/Minigames/CheckMng
@onready var impPopUp = $Impostazioni
@onready var options = get_tree().get_nodes_in_group("options")

func _process(_delta: float) -> void:
	for option in options:
		if option is Button:
			Globals.btn_hover(option)

func _on_selezione_livelli_pressed() -> void:
	checkLvl.set_visible(true)
	await get_tree().create_timer(0.5).timeout
	Globals.goto_load_scene("res://scenes/selezione_livelli.tscn")

func _on_esci_pressed() -> void:
	checkExit.set_visible(true)
	await get_tree().create_timer(0.5).timeout
	get_tree().quit();

func _on_impostazioni_pressed() -> void:
	checkImp.set_visible(true)
	await get_tree().create_timer(0.5).timeout
	impPopUp.popup()
	for option in options:
		if option is Button:
			option.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
			option.set_disabled(true)

func _on_impostazioni_popup_hide() -> void:
	for option in options:
		if option is Button:
			option.set_mouse_filter(Control.MOUSE_FILTER_STOP)
			option.set_disabled(false)
	checkImp.set_visible(false)

func _on_minigames_pressed() -> void:
	checkMng.set_visible(true)
	await get_tree().create_timer(0.5).timeout
	Globals.goto_load_scene("res://scenes/minigames.tscn")

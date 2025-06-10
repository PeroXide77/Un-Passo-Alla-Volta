extends Control

@onready var checkLvl = $VBoxContainer/SelezioneLivelli/CheckLvl
@onready var checkImp = $VBoxContainer/Impostazioni/CheckImp
@onready var checkExit = $VBoxContainer/Exit/CheckExit
@onready var checkMng = $VBoxContainer/Minigames/CheckMng
@onready var checkDPT = $VBoxContainer/Diario/CheckDPT
@onready var impPopUp = $Impostazioni
@onready var options = get_tree().get_nodes_in_group("options")
@onready var scribble2_n : TextureRect = $Background/Scribble2
@onready var scribble2_p : TextureRect = $Background/Scribble2_pressed
@onready var cancellaDati = $Impostazioni/SfondoTrasparent/BoxImpostazioni/VBoxContainer/VideoP/CancellaDati
@onready var checkCD = $Impostazioni/SfondoTrasparent/BoxImpostazioni/VBoxContainer/VideoP/CancellaDati/CheckCD
@onready var popupAvvisoBG = $AcceptDialogBG
@onready var popupAvviso = $AcceptDialogBG/AcceptDialog
@onready var anim = $Impostazioni/AnimationPlayer

func _process(_delta: float) -> void:
	for option in options:
		if option is Button:
			Globals.btn_hover(option)
	Globals.btn_hover(cancellaDati)

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

func _on_diario_pressed() -> void:
	checkDPT.set_visible(true)
	await get_tree().create_timer(0.5).timeout
	Globals.set_flag(true)
	Globals.goto_load_scene("res://scenes/rinforzo_positivo.tscn")

func _on_cancella_dati_toggled(_toggled_on: bool) -> void:
	checkCD.set_visible(true)
	await get_tree().create_timer(0.5).timeout
	Globals.cancel_data()
	popupAvvisoBG.show()
	popupAvviso.show()

func _on_scribble_2_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		scribble2_n.set_visible(false)
		scribble2_p.set_visible(true)

func _on_scribble_2_pressed_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		scribble2_p.set_visible(false)
		scribble2_n.set_visible(true)

func _on_accept_dialog_canceled() -> void:
	checkCD.set_visible(false)
	popupAvvisoBG.hide()
	anim.play_backwards("popUp")
	await anim.animation_finished

func _on_accept_dialog_close_requested() -> void:
	_on_accept_dialog_canceled()

func _on_accept_dialog_custom_action(_action: StringName) -> void:
	_on_accept_dialog_canceled()

func _on_accept_dialog_go_back_requested() -> void:
	_on_accept_dialog_canceled()

func _on_accept_dialog_confirmed() -> void:
	_on_accept_dialog_canceled()

func _on_accept_dialog_focus_exited() -> void:
	popupAvviso.hide()
	_on_accept_dialog_canceled()

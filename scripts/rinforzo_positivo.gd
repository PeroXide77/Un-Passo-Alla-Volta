extends Control

@onready var postIts = get_tree().get_nodes_in_group("postIt")
@onready var popup : Panel = $Tips
@onready var text : RichTextLabel = $Tips/ScrollContainer/text
@onready var popup_imp : Popup = $Impostazioni
@onready var sounds : AudioStreamPlayer = $EndSounds
@onready var theresnothingBG : Panel = $TheresNothingBG
@onready var theresnothing : AcceptDialog = $TheresNothingBG/TheresNothingDialog
var postItLevel: TextureRect = null

func _ready() -> void:
	show_postIts()
	for postIt in postIts:
		postIt.gui_input.connect(_on_postIt_gui_input.bind(postIt))

func _on_return_pressed() -> void:
	Globals.btn_click(sounds)
	await sounds.finished
	if Chatbot.get_currentLevel() == 10 :
		Globals.is_end(true)
	if !Globals.get_flag() :
		postItLevel.set_self_modulate(Color("ffffff"))
		Globals.goto_load_scene("res://scenes/selezione_livelli.tscn")
	else :
		Globals.goto_load_scene("res://scenes/mainmenu.tscn")

func show_postIts() -> void:
	var c = 0
	var gs = Globals.get_gameState()
	for postIt in postIts:
		if postIt.get_meta("lv") < gs:
			postIt.set_visible(true)
			c += 1
		if !Globals.get_flag() :
			if postIt.get_meta("lv") == Chatbot.get_currentLevel():
				postIt.set_self_modulate(Color("7fff00"))
				postItLevel = postIt
	if c == 0:
		theresnothingBG.show()
		theresnothing.show()

func _on_postIt_gui_input(event: InputEvent, postIt: TextureRect) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		popup.show()
		var lv = postIt.get_meta("lv")
		Chatbot.dataset_caricamento_TIPS()
		Chatbot.TIPS_caricamento(lv)
		text.set_text(Chatbot.tips_txt)
		text.scroll_to_line(0)

func _on_ritorna_indietro_pressed() -> void:
	popup.hide()

func _on_impostazioni_pressed() -> void:
	Globals.btn_click(sounds)
	popup_imp.popup()

func _on_theres_nothing_dialog_canceled() -> void:
	theresnothingBG.hide()
	Globals.goto_load_scene("res://scenes/mainmenu.tscn")

func _on_theres_nothing_dialog_close_requested() -> void:
	_on_theres_nothing_dialog_canceled()

func _on_theres_nothing_dialog_custom_action(_action: StringName) -> void:
	_on_theres_nothing_dialog_canceled()

func _on_theres_nothing_dialog_go_back_requested() -> void:
	_on_theres_nothing_dialog_canceled()

func _on_theres_nothing_dialog_confirmed() -> void:
	_on_theres_nothing_dialog_canceled()

func _on_theres_nothing_dialog_focus_exited() -> void:
	theresnothing.hide()
	_on_theres_nothing_dialog_canceled()

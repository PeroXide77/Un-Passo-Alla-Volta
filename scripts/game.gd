extends Control

@onready var http_request: HTTPRequest = $HTTPRequest
@onready var user_input: TextEdit = $"Speech Bubble Input/Input"
@onready var response_label: RichTextLabel = $"Speech Bubble Output/Risposta"
@onready var send_button: Button = $Invio
@onready var completedButton: Button = $Completed
@onready var back: Button = $Return
@onready var loading: VideoStreamPlayer = $"Speech Bubble Output/Loading"
@onready var obiettivo: RichTextLabel = $"Obiettivo/Sfondo Opaco/Obiettivo_Panel/ScrollContainer/VBoxContainer/Obiettivo"
@onready var obiettivo_page: Popup = $Obiettivo
@onready var impost: Popup = $Impostazioni
@onready var checkGoal: TextureRect = $Impostazioni/SfondoTrasparent/BoxImpostazioni/VBoxContainer/showGoal/CheckGoal
@onready var showButt: Button = $Impostazioni/SfondoTrasparent/BoxImpostazioni/VBoxContainer/showGoal
@onready var imposButton: Button = $Background/impostazioni
@onready var vignetta : TextureRect = $"Obiettivo/Sfondo Opaco/Obiettivo_Panel/ScrollContainer/VBoxContainer/Vignetta"
@onready var npc: TextureRect = $ContainerNpc/Personaggio

func _process(_delta: float) -> void:
	Globals.btn_hover(showButt)

func _ready():
	Chatbot.dataset_caricamento()
	Chatbot.npc_caricamento(Chatbot.get_currentLevel(), response_label, obiettivo, vignetta, npc)
	obiettivo_page.popup()
	user_input.grab_focus()

func _on_invio_pressed() -> void:
	var user_message = user_input.text.strip_edges()
	if user_message == "":
		return
	
	imposButton.set_disabled(true)
	response_label.set_scroll_active(false)
	back.set_disabled(true)
	completedButton.set_disabled(true)
	user_input.release_focus()
	user_input.set_editable(false)
	
	Chatbot.append_conversation("user", user_message)
	Chatbot.loading_Chat_start(response_label, loading)
	Chatbot.request_chat_npc(user_input, http_request)
	user_input.set_text("")

func _on_http_request_request_completed(_result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code != 200:
		Chatbot.loading_Chat_end(response_label, loading)
		print("Errore nella risposta: codice ", response_code)
		response_label.text = "Errore di rete"
		back.set_disabled(false)
		imposButton.set_disabled(false)
		return

	var body_string = body.get_string_from_utf8()
	var parsed = JSON.parse_string(body_string)
	var npc_reply: String

	if typeof(parsed) == TYPE_DICTIONARY and "response" in parsed:
		npc_reply = parsed["response"]
	else:
		npc_reply = body_string
	
	Chatbot.loading_Chat_end(response_label, loading)
	if "[LIVELLO COMPLETATO]" in npc_reply :
		await Chatbot.print_txt(npc_reply.replace("[LIVELLO COMPLETATO]", ""), response_label)
		completedButton.set_visible(true)
	else :
		await Chatbot.print_txt(npc_reply, response_label)
	response_label.set_scroll_active(true)
	imposButton.set_disabled(false)
	back.set_disabled(false)
	completedButton.set_disabled(false)
	user_input.grab_focus()
	user_input.set_editable(true)
	var clean_reply := npc_reply.replace("[LIVELLO COMPLETATO]", "").replace("[LIVELLO PERSO]", "").strip_edges()
	Chatbot.append_conversation("assistant", clean_reply)

func _on_return_pressed() -> void:
	Globals.goto_load_scene("res://scenes/selezione_livelli.tscn")

func _on_input_gui_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed :
		if event.keycode == KEY_ENTER:
			if user_input.has_focus():
				_on_invio_pressed()
				user_input.clear()
				get_viewport().set_input_as_handled()
		else : if event.keycode == KEY_ESCAPE:
			impost.popup()

func completed_level() -> void:
	if Chatbot.get_currentLevel() == Globals.get_gameState():
		Globals.nextState()
	completedButton.set_visible(true)

func _on_completed_pressed() -> void:
	if Chatbot.get_currentLevel() == Globals.get_gameState():
		Globals.nextState()
	Globals.goto_load_scene("res://scenes/rinforzo_positivo.tscn")

func _on_impostazioni_pressed() -> void:
	impost.popup()

func _on_exit_pressed() -> void:
	obiettivo_page.hide()

func _on_showGoal_toggled(_toggled_on: bool) -> void:
	checkGoal.set_visible(true)
	await get_tree().create_timer(0.5).timeout
	impost.hide()
	checkGoal.set_visible(false)
	obiettivo_page.popup()

extends Control

@onready var http_request: HTTPRequest = $HTTPRequest
@onready var user_input: LineEdit = $Input
@onready var response_label: RichTextLabel = $Risposta
@onready var send_button: Button = $Invio

func _ready():
	Globals._apply_global_size(get_tree().root)
	Chatbot.dataset_caricamento()
	Chatbot.npc_caricamento(Chatbot.current_level, response_label)

func _on_ritorna_indietro_pressed() -> void:
	Globals.goto_scene("res://scenes/mainmenu.tscn")

func _on_invio_pressed() -> void:
	var user_message = user_input.text.strip_edges()
	if user_message == "":
		return
	
	Chatbot.conversation_history.append({"role": "user", "content": user_message})
	Chatbot.request_chat_npc(user_input, http_request)
	user_input.text = ""

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code != 200:
		print("Errore nella risposta: codice ", response_code)
		response_label.text = "Errore di rete"
		return
	var body_string = body.get_string_from_utf8()
	var parsed = JSON.parse_string(body_string)
	var npc_reply
	if typeof(parsed) == TYPE_DICTIONARY and "response" in parsed:
		npc_reply = parsed["response"]
	else:
		npc_reply = body_string
	Chatbot.conversation_history.append({"role": "assistant", "content": npc_reply})
	response_label.text = npc_reply

extends Control

@onready var http_request: HTTPRequest = $HTTPRequest
@onready var user_input: LineEdit = $Input
@onready var response_label: RichTextLabel = $Risposta
@onready var send_button: Button = $Invio

func _ready():
	Chatbot.dataset_caricamento()
	Chatbot.npc_caricamento(Chatbot.current_level, response_label)

func _on_invio_pressed() -> void:
	var user_message = user_input.text.strip_edges()
	if user_message == "":
		return
	
	Chatbot.append_conversation("user", user_message)
	Chatbot.request_chat_npc(user_input, http_request)
	user_input.text = ""

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code != 200:
		print("Errore nella risposta: codice ", response_code)
		response_label.text = "Errore di rete"
		return

	var body_string = body.get_string_from_utf8()
	var parsed = JSON.parse_string(body_string)
	var npc_reply: String

	if typeof(parsed) == TYPE_DICTIONARY and "response" in parsed:
		npc_reply = parsed["response"]
	else:
		npc_reply = body_string

	response_label.text = npc_reply
	var clean_reply := npc_reply.replace("[LIVELLO COMPLETATO]", "").replace("[LIVELLO PERSO]", "").strip_edges()
	Chatbot.append_conversation("assistant", clean_reply)




func _on_return_pressed() -> void:
	Globals.goto_load_scene("res://scenes/selezione_livelli.tscn")

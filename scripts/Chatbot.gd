extends Node

var npc_dataset = []
var current_level = 0
var npc_name = ""
var personality = ""
var stop_word_v = ""
var stop_word_p = ""
var conversation_history = []

func dataset_caricamento():
	var file_path := "res://assets/sprites/first_dataset_UnPassoAllaVolta.json"
	if not FileAccess.file_exists(file_path):
		push_error("Il file NPC non esiste: " + file_path)
		return

	var file := FileAccess.open(file_path, FileAccess.READ)
	var content := file.get_as_text()
	file.close()

	var parsed = JSON.parse_string(content)
	if parsed is Array:
		npc_dataset = parsed
	else:
		push_error("Errore nel parsing del JSON.")

func npc_caricamento(level: int, label : RichTextLabel):
	if level >= 0 and level < npc_dataset.size():
		var npc_data = npc_dataset[level]
		npc_name = npc_data.get("name", "Sconosciuto")
		personality = npc_data.get("personality", "")
		stop_word_v = npc_data.get("stop_word_v", "")
		stop_word_p = npc_data.get("stop_word_p", "")
		conversation_history.clear()
		conversation_history.append({"role": "system", "content": personality})
		label.text = "Parli con: " + npc_name
	else:
		push_error("Livello fuori dal range del dataset.")

func request_chat_npc(user_input : LineEdit, http_request : HTTPRequest):
	var url = "https://lucielle1234-unpassoallavolta-chatbot.hf.space/chat"
	var headers = ["Content-Type: application/json"]
	
	var latest_input = user_input.text.strip_edges()
	var data = {
		"user_input": latest_input,
		"personality": personality,
		"stop_word_v": stop_word_v,
		"stop_word_p": stop_word_p
	}
	var json_data = JSON.stringify(data)
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, json_data)
	
	if error != OK:
		print("Errore nella richiesta HTTP: ", error)

func append_conversation(role : String, content : Variant):
	conversation_history.append({"role": role, "content": content})
	print(conversation_history)

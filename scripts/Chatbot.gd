extends Node

var npc_dataset = []
var tips_dataset = []
var currentLevel : int

var npc_name = ""
var personality = ""
var stop_word_v = ""
var stop_word_p = ""
var conversation_history = []

var tips_lvl = ""
var tips_txt = ""

func get_currentLevel() -> int:
	return currentLevel

func set_currentLevel(lv: int):
	currentLevel = lv

func dataset_caricamento():
	var file_path := "res://assets/sprites/datasets/first_dataset_UnPassoAllaVolta.json"
	if not FileAccess.file_exists(file_path):
		push_error("Il file NPC non esiste: " + file_path)
		return

	var file := FileAccess.open(file_path, FileAccess.READ)
	var content := file.get_as_text()
	file.close()

	var parsed: Array = JSON.parse_string(content)
	npc_dataset = parsed

func npc_caricamento(level: int, label : RichTextLabel, goal : RichTextLabel, vignetta : TextureRect, npc : TextureRect):
	if level >= 0 and level < npc_dataset.size():
		var npc_data = npc_dataset[level]
		npc_name = npc_data.get("name", "")
		personality = npc_data.get("personality", "")
		stop_word_v = npc_data.get("stop_word_v", "")
		stop_word_p = npc_data.get("stop_word_p", "")
		conversation_history.clear()
		conversation_history.append({"role": "system", "content": personality})
		conversation_history.append({"role": "assistant", "content": npc_data.get("firstLine", "")})
		label.set_text(npc_data.get("firstLine",""))
		goal.set_text(npc_data.get("goal", ""))
		goal.add_text("\n\nUn esempio di interazione che puoi avere in questo livello:\n")
		vignetta.set_texture(load("res://assets/sprites/vignetteGoal/livello"+str(currentLevel)+".png"))
		npc.set_texture(load("res://assets/sprites/NPC/"+npc_name+".png"))
	else:
		push_error("Livello fuori dal range del dataset.")

func dataset_caricamento_TIPS():
	var file_path := "res://assets/sprites/datasets/dataset_TIPS.json"
	if not FileAccess.file_exists(file_path):
		push_error("Il file TIPS non esiste: " + file_path)
		return

	var file := FileAccess.open(file_path, FileAccess.READ)
	var content := file.get_as_text()
	file.close()

	var parsed: Array = JSON.parse_string(content)
	tips_dataset = parsed

func TIPS_caricamento(level: int):
	if level >= 0 and level < tips_dataset.size():
		var tips_data = tips_dataset[level]
		tips_lvl = tips_data.get("livello", "")
		tips_txt = tips_data.get("tips", "")
	else:
		push_error("Livello fuori dal range del dataset.")

func request_chat_npc(user_input : TextEdit, http_request : HTTPRequest):
	var url = "https://lucielle1234-unpassoallavolta-chatbot.hf.space/chat"
	var headers = ["Content-Type: application/json"]
	
	var latest_input = user_input.text.strip_edges()
	var data = {
		"user_input": latest_input,
		"personality": personality,
		"conversation_history": conversation_history,
		"stop_word_v": stop_word_v,
		"stop_word_p": stop_word_p
	}
	var json_data = JSON.stringify(data)
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, json_data)
	
	if error != OK:
		print("Errore nella richiesta HTTP: ", error)

func append_conversation(role : String, content : Variant):
	conversation_history.append({"role": role, "content": content})

func print_txt(risposta: String, nuvola: RichTextLabel):
	nuvola.set_text("")
	var c: int = 0
	while c < risposta.length():
		await get_tree().create_timer(0.001).timeout
		nuvola.text += risposta[c]
		c += 1

func loading_Chat_start(response : RichTextLabel, loading : VideoStreamPlayer) -> void:
	response.set_visible(false)
	loading.set_visible(true)
	loading.play()

func loading_Chat_end(response : RichTextLabel, loading : VideoStreamPlayer) -> void:
	loading.stop()
	loading.set_visible(false)
	response.set_visible(true)

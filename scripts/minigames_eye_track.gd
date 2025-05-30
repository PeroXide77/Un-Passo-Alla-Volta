extends Control

@export var eyes: ButtonGroup
@export var emotions: ButtonGroup
@onready var popup_imp : Popup = $Impostazioni
@onready var preMinigame : Popup = $preMinigame
var rand : int
var eyePressed : BaseButton = null

func _init() -> void:
	
	Globals.set_txtTutorial("Testo prova per il tutorial di minigioco eyeTrack")
	Globals.set_npcTutorial("res://assets/sprites/NPC/Belle.png")

func _ready() -> void:
	game_start()
	eyes.pressed.connect(eye_pressed)
	emotions.pressed.connect(emotion_pressed)
	set_buttons_disabled(emotions, true)
	preMinigame.popup()

func eye_pressed(b : BaseButton) :
	b.add_theme_stylebox_override("disabled", load("res://assets/styles/eyeGamesSelected.tres"))
	eyePressed = b
	set_buttons_disabled(eyes, true)
	set_buttons_disabled(emotions, false)

func emotion_pressed(b: BaseButton) :
	if eyePressed.get_meta("emotion") == b.get_text():
		eyePressed.add_theme_stylebox_override("disabled", load("res://assets/styles/eyeGameDone.tres"))
		b.add_theme_stylebox_override("disabled", load("res://assets/styles/eyeGameDone.tres"))
		eyePressed.set_meta("done", true)
		b.set_meta("done", true)
	set_buttons_disabled(eyes, false)
	set_buttons_disabled(emotions, true)

func set_buttons_disabled(bg : ButtonGroup , flag: bool):
	for b in bg.get_buttons():
		if b.get_meta("done"):
			b.set_disabled(true)
		else: 
			b.set_disabled(flag)

func _on_impostazioni_pressed() -> void:
	popup_imp.popup()

func _on_ritorna_indietro_pressed() -> void:
	Globals.goto_load_scene("res://scenes/minigames.tscn")

func game_start():
	var ids = [-1, -1, -1]
	var n : int = 0
	while ids[2] == -1:
		rand = randi_range(0,6)
		if !ids.any(equals):
			ids[n] = rand
			n += 1
	print(ids)
	
	var eyesB = eyes.get_buttons()
	var emotionsB = emotions.get_buttons()
	eyesB[0].set_button_icon(load("res://assets/sprites/eyeMinigame/"+Globals.eyesId[ids[0]]+".jpg"))
	eyesB[1].set_button_icon(load("res://assets/sprites/eyeMinigame/"+Globals.eyesId[ids[1]]+".jpg"))
	eyesB[2].set_button_icon(load("res://assets/sprites/eyeMinigame/"+Globals.eyesId[ids[2]]+".jpg"))
	eyesB[0].set_meta("emotion", Globals.eyesId[ids[0]])
	eyesB[1].set_meta("emotion", Globals.eyesId[ids[1]])
	eyesB[2].set_meta("emotion", Globals.eyesId[ids[2]])
	
	var start : int = randi_range(0,2)
	var flag : bool = randi_range(0,1) == 0
	
	emotionsB[0].set_text(Globals.eyesId[ids[start]])
	if flag:
		start += 1
		if start == 3:
			start = 0
		emotionsB[1].set_text(Globals.eyesId[ids[start]])
		start += 1
		if start == 3:
			start = 0
		emotionsB[2].set_text(Globals.eyesId[ids[start]])
	else:
		start -= 1
		if start == -1:
			start = 2
		emotionsB[1].set_text(Globals.eyesId[ids[start]])
		start -= 1
		if start == -1:
			start = 2
		emotionsB[2].set_text(Globals.eyesId[ids[start]])

func equals(i: int) -> bool:
	return i == rand

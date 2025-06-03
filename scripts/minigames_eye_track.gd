extends Control

@export var eyes: ButtonGroup
@export var emotions: ButtonGroup
@onready var popup_imp : Popup = $Impostazioni
@onready var npcDialog : Panel = $Npc
var rand : int
var eyePressed : BaseButton = null

func _init() -> void:
	Globals.set_txtTutorial("Per la lezione di oggi voglio proporvi un piccolo gioco. In questo gioco dovrete associare degli sguardi alle loro emozioni. Inizia cliccando uno sguardo; gli altri sguardi si disattiveranno e dovrai scegliere un'emozione. Non ti preoccupare se sbagli, potrai sempre riprovare! \nUna volta che avrai fatto un'associazione corretta sia lo sguardo che l'emozione diventeranno verdi e potrai proseguire con gli altri. \nOra che sai come si gioca, cominciamo!")
	Globals.set_npcTutorial("res://assets/sprites/NPC/Caterina.png")

func _ready() -> void:
	game_start()
	eyes.pressed.connect(eye_pressed)
	emotions.pressed.connect(emotion_pressed)
	set_buttons_disabled(emotions, true)
	npcDialog.show()

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
	else :
		eyePressed.add_theme_stylebox_override("disabled", load("res://assets/styles/eyeGameDisabled.tres"))
		b.set_pressed_no_signal(false)
		eyePressed.set_pressed_no_signal(false)
		Globals.set_txtTutorial("Non hai scelto l'emozione corretta ma non ti preoccupare, riprova!")
		npcDialog.show()
	gameEnd()
	if Globals.isMinigameEnded():
		Globals.set_txtTutorial("Complimenti, hai finito il gioco! Torna quando vuoi per provare ad associare nuovi sguardi a nuove emozioni!")
		npcDialog.show()
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

func gameEnd() -> void:
	if eyes.get_buttons().all(isDone):
		Globals.setFlagMinigameEnd(true)
	else:
		Globals.setFlagMinigameEnd(false)

func isDone(button : BaseButton):
	return button.get_meta("done")

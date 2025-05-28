extends Control

@export var eyes: ButtonGroup
@export var emotions: ButtonGroup
@onready var popup_imp : Popup = $Impostazioni
@onready var preMinigame : Popup = $preMinigame

var eyePressed : BaseButton = null

func _init() -> void:
	Globals.set_txtTutorial("Testo prova per il tutorial di minigioco eyeTrack")
	Globals.set_npcTutorial("res://assets/sprites/NPC/Belle.png")

func _ready() -> void:
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
	set_buttons_disabled(eyes, false)
	set_buttons_disabled(emotions, true)

func set_buttons_disabled(bg : ButtonGroup , flag: bool):
	for b in bg.get_buttons():
		b.set_disabled(flag)

func _on_impostazioni_pressed() -> void:
	popup_imp.popup()

func _on_ritorna_indietro_pressed() -> void:
	Globals.goto_load_scene("res://scenes/minigames.tscn")

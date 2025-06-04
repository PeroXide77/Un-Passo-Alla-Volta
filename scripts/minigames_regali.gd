extends Control

@export var regali: ButtonGroup
@onready var popup_imp : Popup = $Impostazioni
@onready var npcDialog : Panel = $Npc

func _init() -> void:
	Globals.set_txtTutorial("Testo prova per il tutorial di minigioco regali")
	Globals.set_npcTutorial("res://assets/sprites/NPC/Rita.png")

func _ready() -> void:
	game_start()
	regali.pressed.connect(gift_pressed)
	npcDialog.show()

func _on_impostazioni_pressed() -> void:
	popup_imp.popup()

func _on_ritorna_indietro_pressed() -> void:
	Globals.goto_load_scene("res://scenes/minigames.tscn")

func game_start():
	var regaliB = regali.get_buttons()
	var flagowner : bool
	var randGift : int
	for i: int in range(8) :
		flagowner = randi_range(0,1) == 0		
		if flagowner:
			if i == 7 and !regaliB.any(isMine):
				regaliB.get(i).set_button_icon(load("res://assets/sprites/giftMinigame/giftMine.png"))
				regaliB.get(i).set_meta("owner", true)
			else:
				randGift = randi_range(1,6)
				regaliB.get(i).set_button_icon(load("res://assets/sprites/giftMinigame/giftAny"+str(randGift)+".png"))
				regaliB.get(i).set_meta("owner", false)
		else:
			regaliB.get(i).set_button_icon(load("res://assets/sprites/giftMinigame/giftMine.png"))
			regaliB.get(i).set_meta("owner", true)

func isMine(button : BaseButton):
	return button.get_meta("owner")

func gift_pressed(b : BaseButton) :
	b.release_focus()
	if b.get_meta("owner"):
		b.set_button_icon(load("res://assets/sprites/giftMinigame/giftMineOpen.png"))
		b.set_meta("owner", false)
	else:
		b.set_pressed_no_signal(false)
		Globals.set_txtTutorial("Mmh, non penso che sia tuo questo regalo, apro solo i tuoi!")
		npcDialog.show()
	gameEnd()
	if Globals.isMinigameEnded():
		Globals.set_txtTutorial("Spero sei felice dei tuoi regali!")
		npcDialog.show()

func gameEnd() -> void:
	if !regali.get_buttons().any(isMine):
		Globals.setFlagMinigameEnd(true)
	else:
		Globals.setFlagMinigameEnd(false)

extends Control

@export var astucci: ButtonGroup
@export var oggetti: ButtonGroup
@onready var popup_imp : Popup = $Impostazioni
@onready var npcDialog : Panel = $Npc
var rand: int
var itemPressed : BaseButton = null

func _init() -> void:
	Globals.set_txtTutorial("Ciao! È successo un bel pasticcio: i nostri astucci sono caduti e tutte le nostre cose si sono mischiate. Per fortuna, sulle mie cose c'è sempre un'etichetta con il mio nome, così possiamo riconoscerle! Per sistemarle, basta cliccare su un oggetto e poi sull’astuccio della persona a cui pensi che appartenga. Non ti preoccupare, ti avviserò io se l'oggetto non è nell'astuccio giusto. Potresti aiutarmi a rimettere apposto?")
	Globals.set_npcTutorial("res://assets/sprites/NPC/Giuseppe.png")

func _ready() -> void:
	game_start()
	oggetti.pressed.connect(item_pressed)
	astucci.pressed.connect(case_pressed)
	set_buttons_disabled(astucci, true)
	npcDialog.show()

func _on_impostazioni_pressed() -> void:
	popup_imp.popup()

func _on_ritorna_indietro_pressed() -> void:
	Globals.goto_load_scene("res://scenes/minigames.tscn")

func game_start():
	var oggettiB = oggetti.get_buttons()
	var flagowner : bool
	var checkLast: bool
	var item : int
	for i: int in range(7) :
		flagowner = randi_range(0,1) == 0
		item = randi_range(0,6)
		if flagowner:
			oggettiB.get(i).set_button_icon(load("res://assets/sprites/schoolMinigame/Giuseppe/"+Globals.stationeryId[item]+"Giuseppe.png"))
			oggettiB.get(i).set_meta("owner", false)
		else:
			oggettiB.get(i).set_button_icon(load("res://assets/sprites/schoolMinigame/Protagonista/"+Globals.stationeryId[item]+".png"))
			oggettiB.get(i).set_meta("owner", true)
		if i == 6:
			if oggettiB.all(isMine):
				oggettiB.get(i).set_button_icon(load("res://assets/sprites/schoolMinigame/Giuseppe/"+Globals.stationeryId[item]+"Giuseppe.png"))
				oggettiB.get(i).set_meta("owner", false)
			else:
				checkLast = oggettiB.get(6).get_meta("owner")
				oggettiB.get(6).set_meta("owner", false)
				if !oggettiB.any(isMine):
					oggettiB.get(i).set_button_icon(load("res://assets/sprites/schoolMinigame/Protagonista/"+Globals.stationeryId[item]+".png"))
					oggettiB.get(i).set_meta("owner", true)
				else:
					oggettiB.get(i).set_meta("owner", checkLast)

func item_pressed(b : BaseButton) :
	b.release_focus()
	b.set_flat(false)
	b.add_theme_stylebox_override("disabled", load("res://assets/styles/eyeGamesSelected.tres"))
	itemPressed = b
	set_buttons_disabled(oggetti, true)
	set_buttons_disabled(astucci, false)

func case_pressed(b: BaseButton) :
	b.release_focus()
	if itemPressed.get_meta("owner") == b.get_meta("owner"):
		itemPressed.set_visible(false)
		b.set_pressed_no_signal(false)
	else :
		itemPressed.set_flat(true)
		b.set_pressed_no_signal(false)
		Globals.set_txtTutorial("Mmh, non penso che sia giusto cosi, riprova!")
		npcDialog.show()
	gameEnd()
	if Globals.isMinigameEnded():
		Globals.set_txtTutorial("Grazie mille per l'aiuto, alla prossima! Torna quando vuoi per aiutarmi a sistemare ancora, posso sempre contare sul tuo aiuto.")
		npcDialog.show()
	else:
		set_buttons_disabled(astucci, true)
		set_buttons_disabled(oggetti, false)

func equals(i: int) -> bool:
	return i == rand

func gameEnd() -> void:
	if oggetti.get_buttons().all(isDone):
		Globals.setFlagMinigameEnd(true)
	else:
		Globals.setFlagMinigameEnd(false)

func isDone(button : BaseButton):
	return !button.is_visible()

func isMine(button : BaseButton):
	return button.get_meta("owner")

func set_buttons_disabled(bg : ButtonGroup , flag: bool):
	for b in bg.get_buttons():
		b.set_disabled(flag)

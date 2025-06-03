extends Control

@export var astucci: ButtonGroup
@export var oggetti: ButtonGroup
@onready var popup_imp : Popup = $Impostazioni
@onready var npcDialog : Panel = $Npc
var rand: int
var itemPressed : BaseButton = null

func _init() -> void:
	Globals.set_txtTutorial("Ciao! È successo un pasticcio! Sono caduti i nostri astucci e adesso le nostre cose sono tutte mischiate. \nPotresti aiutarmi a sistemarle? Per fortuna sulle mie cose ho messo un etichetta col mio nome quindi sarà più semplice.")
	Globals.set_npcTutorial("res://assets/sprites/NPC/Giuseppe.png")

func _ready() -> void:
	game_start()
	npcDialog.show()

func _on_impostazioni_pressed() -> void:
	popup_imp.popup()

func _on_ritorna_indietro_pressed() -> void:
	Globals.goto_load_scene("res://scenes/minigames.tscn")

func game_start():
	var oggettiB = oggetti.get_buttons()
	var flagowner : bool
	var item : int
	for i: int in range(7) :
		flagowner = randi_range(0,1) == 0
		item = randi_range(0,6)
		if flagowner:
			oggettiB.get(i).set_button_icon(load("res://assets/sprites/schoolMinigame/Giuseppe/"+Globals.stationeryId[item]+"Giuseppe.png"))
		else:
			oggettiB.get(i).set_button_icon(load("res://assets/sprites/schoolMinigame/Protagonista/"+Globals.stationeryId[item]+".png"))
func equals(i: int) -> bool:
	return i == rand

func gameEnd() -> void:
	if oggetti.get_buttons().all(isDone):
		Globals.setFlagMinigameEnd(true)
	else:
		Globals.setFlagMinigameEnd(false)

func isDone(button : BaseButton):
	return button.get_meta("done")

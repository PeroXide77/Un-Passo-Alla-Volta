extends Control

@onready var popup_imp : Popup = $Impostazioni
@onready var npcDialog : Panel = $Npc
var rand: int

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
	var ids = [-1, -1, -1, -1, -1]
	var n : int = 0
	while ids[2] == -1:
		rand = randi_range(0,6)
		if !ids.any(equals):
			ids[n] = rand
			n += 1
	
	#var eyesB = eyes.get_buttons()
	#var emotionsB = emotions.get_buttons()
	
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

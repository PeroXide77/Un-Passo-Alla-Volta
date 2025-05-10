extends Control

@export var levelGroup: ButtonGroup

func _ready():
	levelGroup.pressed.connect(buttonGroup_pressed)

func _on_ritorna_indietro_pressed() -> void:
	Globals.goto_load_scene("res://scenes/mainmenu.tscn")

func buttonGroup_pressed(buttonPressed: BaseButton):
	var lv: int = buttonPressed.get_meta("lv")
	Chatbot.set_currentLevel(lv)
	levelGroup.get_pressed_button().set_pressed_no_signal(false)
	Globals.goto_load_scene("res://scenes/game.tscn")

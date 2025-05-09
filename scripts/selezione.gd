extends Control

@export var levelGroup: ButtonGroup

func _ready():
	levelGroup.pressed.connect(buttonGroup_pressed)

func _on_ritorna_indietro_pressed() -> void:
	Globals.goto_load_scene("res://scenes/mainmenu.tscn")

func buttonGroup_pressed(button: BaseButton):
	var lv = levelGroup.get_pressed_button().get_meta("lv")
	Chatbot.current_level = lv
	levelGroup.get_pressed_button().set_pressed_no_signal(false)
	Globals.goto_load_scene("res://scenes/game.tscn")

extends Control

@export var levelGroup: ButtonGroup
@onready var spaces = get_tree().get_nodes_in_group("spaces")

func _ready():
	levelGroup.pressed.connect(buttonGroup_pressed)
	for button in levelGroup.get_buttons():
		if button.get_meta("lv") <= Globals.get_gameState():
			button.set_visible(true)
			if button.get_meta("lv") < Globals.get_gameState():
				button.add_theme_constant_override("outline_size", 7)
				button.add_theme_color_override("font_hover_pressed_color", Color(0,255,0))
				button.add_theme_color_override("font_hover_color", Color(0,255,0))
				button.add_theme_color_override("font_color", Color(0,255,0))
		else:
			button.set_visible(false)
	for space in spaces:
		if space.get_meta("lv") <= Globals.get_gameState():
			space.set_visible(true)
		else:
			space.set_visible(false)
	


func _on_ritorna_indietro_pressed() -> void:
	Globals.goto_load_scene("res://scenes/mainmenu.tscn")

func buttonGroup_pressed(buttonPressed: BaseButton):
	var lv: int = buttonPressed.get_meta("lv")
	Chatbot.set_currentLevel(lv)
	levelGroup.get_pressed_button().set_pressed_no_signal(false)
	Globals.goto_load_scene("res://scenes/game.tscn")

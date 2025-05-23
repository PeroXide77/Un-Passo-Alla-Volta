extends Control

@export var levelGroup: ButtonGroup
@onready var spaces = get_tree().get_nodes_in_group("spaces")
@onready var popup_end : Panel = $end_game
@onready var popup_imp : Popup = $"../Impostazioni"
@onready var scribble3 : TextureRect = $Scribble3
@onready var crediti : Popup = $"../Impostazioni/crediti"

func _ready():
	levelGroup.pressed.connect(buttonGroup_pressed)
	scribble3.set_self_modulate(Globals.randomizeColor())
	set_completedLevels()
	if Globals.get_end() == true :
		popup_end.show()

func _on_ritorna_indietro_pressed() -> void:
	Globals.goto_load_scene("res://scenes/mainmenu.tscn")

func buttonGroup_pressed(buttonPressed: BaseButton):
	var lv: int = buttonPressed.get_meta("lv")
	Chatbot.set_currentLevel(lv)
	levelGroup.get_pressed_button().set_pressed_no_signal(false)
	Globals.goto_load_scene("res://scenes/game.tscn")

func set_completedLevels():
	var gs: int = Globals.get_gameState()
	for button in levelGroup.get_buttons():
		if button.get_meta("lv") <= gs:
			button.set_visible(true)
			if button.get_meta("lv") < gs:
				button.add_theme_constant_override("outline_size", 7)
				button.add_theme_color_override("font_hover_pressed_color", Color(0,255,0))
				button.add_theme_color_override("font_hover_color", Color(0,255,0))
				button.add_theme_color_override("font_color", Color(0,255,0))
				button.add_theme_color_override("font_pressed_color", Color(0,255,0))
		else:
			button.set_visible(false)
	for space in spaces:
		if space.get_meta("lv") <= gs:
			space.set_visible(true)
		else:
			space.set_visible(false)

func _on_back_pressed() -> void:
	popup_end.hide()
	Globals.is_end(false)

func _on_impostazioni_pressed() -> void:
	popup_imp.popup()

func _on_scribble_3_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		scribble3.set_self_modulate(Globals.randomizeColor())

func _on_scribble_4_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		crediti.popup()

func _on_exit_pressed() -> void:
	crediti.hide()

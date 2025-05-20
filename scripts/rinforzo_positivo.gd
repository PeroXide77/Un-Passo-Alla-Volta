extends Control

@onready var postIts = get_tree().get_nodes_in_group("postIt")
@onready var circles = get_tree().get_nodes_in_group("circles")
@onready var popup : Panel = $Tips
@onready var text : RichTextLabel = $Tips/ScrollContainer/text
@onready var circle_end : TextureRect = $"Post-It10/Circle10"

func _ready() -> void:
	show_postIts()
	for postIt in postIts:
		postIt.gui_input.connect(_on_postIt_gui_input.bind(postIt))

func _on_return_pressed() -> void:
	if circle_end.is_visible() :
		circle_end.set_visible(false)
		Globals.is_end(true)
	Globals.goto_load_scene("res://scenes/selezione_livelli.tscn")

func show_postIts() -> void:
	var gs = Globals.get_gameState()
	for postIt in postIts:
		if postIt.get_meta("lv") < gs:
			postIt.set_visible(true)
	for circle in circles:
		if circle.get_meta("lv") == Chatbot.get_currentLevel():
			circle.set_visible(true)
		else:
			circle.set_visible(false)

func _on_postIt_gui_input(event: InputEvent, postIt: TextureRect) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		popup.show()
		var lv = postIt.get_meta("lv")
		Chatbot.dataset_caricamento_TIPS()
		Chatbot.TIPS_caricamento(lv)
		text.set_text(Chatbot.tips_txt)
		text.scroll_to_line(0)

func _on_ritorna_indietro_pressed() -> void:
	popup.hide()

extends Panel

@onready var talk = $"SfondoTrasparent/Speech Bubble Output/Speech"
@onready var next = $SfondoTrasparent/Completed
@onready var this = $"."
@onready var npc : TextureRect = $SfondoTrasparent/Personaggio

func _on_completed_pressed() -> void:
	next.set_visible(false)
	if Globals.isMinigameEnded():
		Globals.goto_load_scene("res://scenes/minigames.tscn")
		Globals.setFlagMinigameEnd(false)
	else: 
		this.hide()

func npcTalk():
	await Chatbot.print_txt(Globals.get_txtTutorial(), talk)
	next.set_visible(true)

func _on_visibility_changed() -> void:
	if this.is_visible():
		npc.set_texture(load(Globals.get_npcTutorial()))
		npcTalk()

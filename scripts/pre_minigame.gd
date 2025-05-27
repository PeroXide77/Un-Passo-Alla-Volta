extends Popup

@onready var talk = $"SfondoTrasparent/Speech Bubble Output/Speech"
@onready var next = $SfondoTrasparent/Completed
@onready var this = $"."
@onready var npc : TextureRect = $SfondoTrasparent/Personaggio



func _ready():
	npc.set_texture(load(Globals.get_npcTutorial()))
	await Chatbot.print_txt(Globals.get_txtTutorial(), talk)
	next.set_visible(true)

func _on_completed_pressed() -> void:
	this.hide()
	

extends Popup

@onready var talk = $"SfondoTrasparent/Speech Bubble Output/Speech"
@onready var next = $SfondoTrasparent/Completed
@onready var this = $"."

func _ready():
	await Chatbot.print_txt("testo di prova per il tutorial del minigame sugli occhi", talk)
	next.set_visible(true)

func _on_completed_pressed() -> void:
	this.hide()

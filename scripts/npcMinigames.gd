extends Panel

@onready var talk = $"SfondoTrasparent/Speech Bubble Output/Speech"
@onready var next = $SfondoTrasparent/Completed
@onready var this = $"."
@onready var npc : TextureRect = $SfondoTrasparent/Personaggio
@onready var audio : AudioStreamPlayer2D = $AudioNpc
@onready var speak : BaseButton = $SfondoTrasparent/Speak
@onready var music : AudioStreamPlayer = $"../MngMusic"

func _on_completed_pressed() -> void:
	next.set_visible(false)
	if audio.is_playing():
		audio.stop()
		audio.seek(0)
	if speak.is_visible():
		speak.hide()
	if Globals.isMinigameEnded():
		Globals.goto_load_scene("res://scenes/minigames.tscn")
		Globals.setFlagMinigameEnd(false)
	else: 
		this.hide()
		music.play(0)

func npcTalk():
	#if speak.is_visible():
	#	speak.set_disabled(true)
	await Chatbot.print_txt(Globals.get_txtTutorial(), talk)
	next.set_visible(true)
	#if speak.is_visible():
	#	speak.set_disabled(false)

func _on_visibility_changed() -> void:
	if this.is_visible():
		npc.set_texture(load(Globals.get_npcTutorial()))
		npcTalk()

func _on_speak_pressed() -> void:
	if audio.is_playing():
		audio.stop()
		audio.seek(0)
	else:
		audio.play()

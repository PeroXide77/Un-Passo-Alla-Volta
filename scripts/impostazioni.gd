extends Popup

@onready var volume = $SfondoTrasparent/BoxImpostazioni/VBoxContainer/VolumeP/volume
@onready var resolutionMenu = $SfondoTrasparent/BoxImpostazioni/VBoxContainer/VideoP/OptionButton
@onready var fullScreen = $SfondoTrasparent/BoxImpostazioni/VBoxContainer/VideoP/FullScreen
@onready var checkFS = $SfondoTrasparent/BoxImpostazioni/VBoxContainer/VideoP/FullScreen/CheckFS
@onready var imp = $"."
@onready var anim = $AnimationPlayer

func _process(_delta: float) -> void:
	Globals.btn_hover(fullScreen)

func _ready():
	volume.value = Globals.get_volume();
	add_resolutions()
	resolutionMenu.select(Globals.resIndex)
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		resolutionMenu.set_disabled(true)
		checkFS.set_visible(true)
		fullScreen.set_pressed_no_signal(true)
	else :
		resolutionMenu.set_disabled(false)
		checkFS.set_visible(false)
		fullScreen.set_pressed_no_signal(false)

func _on_volume_value_changed(value: float) -> void:
	Globals.set_volume(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value / 100));

func add_resolutions():
	var now = DisplayServer.window_get_size()
	for r in Globals.resolutions:
		resolutionMenu.add_item(r)
		if now == Globals.resolutions[r]:
			Globals.resIndex = resolutionMenu.item_count - 1

func _on_option_button_item_selected(index: int) -> void:
	var key = resolutionMenu.get_item_text(index)
	DisplayServer.window_set_size(Globals.resolutions[key])
	DisplayServer.window_set_position(Vector2(30,30))

func _on_full_screen_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		resolutionMenu.set_disabled(true)
		checkFS.set_visible(true)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		resolutionMenu.set_disabled(false)
		checkFS.set_visible(false)

func _on_ritorna_indietro_pressed() -> void:
	anim.play_backwards("popUp")
	await anim.animation_finished
	imp.hide()

func _on_about_to_popup() -> void:
	anim.play("popUp")

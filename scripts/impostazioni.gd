extends Popup

@onready var volume = $SfondoTrasparent/BoxImpostazioni/VBoxContainer/VolumeP/volume
@onready var resolutionMenu = $SfondoTrasparent/BoxImpostazioni/VBoxContainer/VideoP/OptionButton
@onready var fullScreen: Button = $SfondoTrasparent/BoxImpostazioni/VBoxContainer/VideoP/FullScreen
@onready var checkFS = $SfondoTrasparent/BoxImpostazioni/VBoxContainer/VideoP/FullScreen/CheckFS
@onready var imp = $"."
@onready var crediti : Popup = $crediti
@onready var anim = $AnimationPlayer
@onready var audio : AudioStreamPlayer = $ImpostazioniSounds

func _ready():
	fullScreen.mouse_entered.connect(Globals.btn_hover_enter.bind(fullScreen, audio))
	fullScreen.mouse_exited.connect(Globals.btn_hover_exit.bind(fullScreen))
	volume.value = Globals.get_volume()
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

func _on_go_back_requested() -> void:
	_on_ritorna_indietro_pressed()

func _on_close_requested() -> void:
	_on_ritorna_indietro_pressed()

func _on_window_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			_on_ritorna_indietro_pressed()

func _on_about_to_popup() -> void:
	anim.play("popUp")

func _on_scribble_4_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		crediti.popup()

func _on_exit_pressed() -> void:
	crediti.hide()

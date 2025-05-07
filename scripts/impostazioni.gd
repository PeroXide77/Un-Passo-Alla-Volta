extends Popup

@onready var volume = $SfondoTrasparent/BoxImpostazioni/VBoxContainer/VolumeP/volume
@onready var resolutionMenu = $SfondoTrasparent/BoxImpostazioni/VBoxContainer/VideoP/OptionButton
@onready var fullScreen = $SfondoTrasparent/BoxImpostazioni/VBoxContainer/VideoP/FullScreen
@onready var checkFS = $SfondoTrasparent/BoxImpostazioni/VBoxContainer/VideoP/FullScreen/CheckFS

func _ready(): ##appena si apre il container
	volume.value = Globals.volume;
	add_resolutions()
	
func _on_volume_value_changed(value: float) -> void:
	Globals.volume = value;

func add_resolutions():
	var now = DisplayServer.window_get_size()
	for r in Globals.resolutions:
		resolutionMenu.add_item(r)
		if now == Globals.resolutions[r]:
			resolutionMenu.select(resolutionMenu.item_count - 1)

func _on_option_button_item_selected(index: int) -> void:
	var key = resolutionMenu.get_item_text(index)
	DisplayServer.window_set_size(Globals.resolutions[key])
	DisplayServer.window_set_position(Vector2(30,30))

func _on_impostazioni_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		resolutionMenu.set_disabled(true)
		checkFS.set_visible(true)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		resolutionMenu.set_disabled(false)
		checkFS.set_visible(false)

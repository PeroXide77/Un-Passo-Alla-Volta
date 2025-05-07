extends Popup

@onready var volume = $SfondoTrasparent/BoxImpostazioni/VBoxContainer/volume
@onready var resolutionMenu = $SfondoTrasparent/BoxImpostazioni/VBoxContainer/OptionButton
@onready var fullScreen = $SfondoTrasparent/BoxImpostazioni/VBoxContainer/CheckBox

func _ready(): ##appena si apre il container
	volume.value = Globals.volume;
	add_resolutions()
	
func _on_volume_value_changed(value: float) -> void:
	Globals.volume = value;

func add_resolutions():
	for r in Globals.resolutions:
		resolutionMenu.add_item(r)

func _on_ritorna_indietro_pressed() -> void:
	$".".hide()


func _on_option_button_item_selected(index: int) -> void:
	var key = resolutionMenu.get_item_text(index)
	DisplayServer.window_set_size(Globals.resolutions[key])
	DisplayServer.window_set_position(Vector2(30,30))

func _on_check_box_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

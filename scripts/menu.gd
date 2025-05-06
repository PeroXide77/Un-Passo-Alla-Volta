extends Control

func _ready():
	Globals._apply_global_size(get_tree().root)
	Globals.menu_buttons_fix($"Escludi/VBoxContainer")

func _on_nuova_partita_pressed() -> void:
	Globals.next_scene = "res://scenes/Tutorial.tscn"
	Globals.goto_scene(Globals.loading_screen)

func _on_esci_pressed() -> void:
	get_tree().quit();

func _on_impostazioni_pressed() -> void:
	$Escludi/FinestraImpostazione.popup_centered()
	
func _on_volume_value_changed(value: float) -> void:
	Globals.volume = value;
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value / 100));
	

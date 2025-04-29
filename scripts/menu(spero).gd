extends Control

func _on_nuova_partita_pressed() -> void:
	coseDaRicordare.next_scene = "res://scenes/Tutorial.tscn"
	get_tree().change_scene_to_packed(coseDaRicordare.loading_screen);


func _on_esci_pressed() -> void:
	get_tree().quit();


func _on_impostazioni_pressed() -> void:
	$FinestraImpostazione.popup_centered();
	
func _on_volume_value_changed(value: float) -> void:
	coseDaRicordare.volume = value;
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value / 100));
	

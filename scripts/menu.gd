extends Control

@onready var checkLvl = $VBoxContainer/SelezioneLivelli/CheckLvl
@onready var checkImp = $VBoxContainer/Impostazioni/CheckImp
@onready var checkExit = $VBoxContainer/Exit/CheckExit
@onready var impPopUp = $Impostazioni

func _on_selezione_livelli_pressed() -> void:
	checkLvl.set_visible(true)
	await get_tree().create_timer(0.5).timeout
	Globals.goto_load_scene("res://scenes/Tutorial.tscn")

func _on_esci_pressed() -> void:
	checkExit.set_visible(true)
	await get_tree().create_timer(0.5).timeout
	get_tree().quit();

func _on_impostazioni_pressed() -> void:
	checkImp.set_visible(true)
	await get_tree().create_timer(0.5).timeout
	impPopUp.popup()
	
func _on_volume_value_changed(value: float) -> void:
	Globals.volume = value;
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value / 100));

func _on_ritorna_indietro_pressed() -> void:
	checkImp.set_visible(false)
	impPopUp.hide()

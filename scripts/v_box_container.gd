extends VBoxContainer
func _ready(): ##appena si apre il container
	$volume.value = coseDaRicordare.volume;
	
func _on_volume_value_changed(value: float) -> void:
	coseDaRicordare.volume = value;

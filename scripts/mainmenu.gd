extends Node2D
func _ready():
	Globals._apply_global_size(get_tree().root)
	Globals.menu_buttons_fix($"Menu(spero)/Escludi/VBoxContainer")

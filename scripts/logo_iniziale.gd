extends Control

func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	Input.set_custom_mouse_cursor(load("res://icons/cursor.png"))
	#DisplayServer.window_set_size(Vector2(1280,720))
	#DisplayServer.window_set_position(Vector2(30,30))

func _on_video_stream_player_finished() -> void:
	Globals.goto_load_scene("res://scenes/mainmenu.tscn")
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			$VideoStreamPlayer.stop()
			Globals.goto_load_scene("res://scenes/mainmenu.tscn")

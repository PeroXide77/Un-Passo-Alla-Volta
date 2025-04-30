extends Node2D

func _ready():
	Globals._apply_global_size(get_tree().root)

func _on_video_stream_player_finished() -> void:
	Globals.next_scene = "res://scenes/mainmenu.tscn"
	Globals.goto_scene(Globals.loading_screen)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			$Logo_Iniziale/VideoStreamPlayer.stop()
			Globals.next_scene = "res://scenes/mainmenu.tscn"
			Globals.goto_scene(Globals.loading_screen)

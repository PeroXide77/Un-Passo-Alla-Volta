extends Node2D

func _on_video_stream_player_finished() -> void:
	coseDaRicordare.next_scene = "res://scenes/mainmenu.tscn"
	get_tree().change_scene_to_file(coseDaRicordare.loading_screen)

func _ready():
	coseDaRicordare._apply_global_size(get_tree().root)

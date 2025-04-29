extends Node2D

func _on_video_stream_player_finished() -> void:
	#coseDaRicordare.next_scene = "res://scene/mainmenu.tscn"
	#get_tree().change_scene_to_packed(coseDaRicordare.loading_screen);
	get_tree().change_scene_to_file("res://scene/mainmenu.tscn")

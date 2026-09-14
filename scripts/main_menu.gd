extends Control

func _ready():
	AudioManager.play_music()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_quit_button_pressed():
	get_tree().quit()

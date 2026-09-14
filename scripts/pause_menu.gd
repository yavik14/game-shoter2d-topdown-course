extends Control

@onready var pause_btn = $"../PauseBtn/TextureButton"

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		pause_or_unpause()
		

func pause_or_unpause():
	if get_tree().paused == true:
		hide()
		pause_btn.show()
		get_tree().paused = false
	elif get_tree().paused == false:
		show()
		pause_btn.hide()
		get_tree().paused = true


func _on_pause_button_pressed():
	pause_or_unpause()


func _on_resume_button_pressed():
	pause_or_unpause()

func _on_menu_button_pressed():
	get_tree().paused=false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

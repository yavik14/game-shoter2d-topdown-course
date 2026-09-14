extends Control

func _ready():
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim_name: String):
	if anim_name=="scroll":
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

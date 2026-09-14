extends Node2D

func _ready():
	play_music()
	
	
func play_music():
	$Music.play()
	$CreditsMusic.stop()
	
func stop_music():
	$Music.stop()
	
func play_shoot_sound():
	$Shoot.play()
	
func play_credits_music():
	stop_music()
	$CreditsMusic.play()
	

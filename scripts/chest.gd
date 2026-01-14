extends Node2D

@export var opened: bool = false

@onready var animations = $AnimatedSprite2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player") and not opened:
		opened = true
		animations.play("open")
		await  animations.animation_finished

extends Node2D

@onready var animations = $AnimationPlayer

func shoot():
	const BULLET = preload("res://scenes/bullet.tscn")
	var newBullet = BULLET.instantiate()
	newBullet.global_position = $Sprite2D/ShotPoint.global_position
	newBullet.global_rotation = $Sprite2D/ShotPoint.global_rotation
	get_tree().current_scene.add_child(newBullet)
	
func _physics_process(delta):
	var targetPosition = get_global_mouse_position()
	var direction = (targetPosition - global_position).angle()
	rotation = direction
	if Input.is_action_just_pressed("shoot"):
		animations.play("shoot")
		shoot()

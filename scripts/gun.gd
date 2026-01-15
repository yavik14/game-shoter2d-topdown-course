extends Node2D

@export var projectile_scene: PackedScene

@onready var animations = $AnimationPlayer

func shoot():
	var projectile = projectile_scene.instantiate()
	
	projectile.global_position = $Sprite2D/ShotPoint.global_position
	projectile.global_rotation = $Sprite2D/ShotPoint.global_rotation
	get_tree().current_scene.add_child(projectile)
	
func _physics_process(delta):
	var targetPosition = get_global_mouse_position()
	var direction = (targetPosition - global_position).angle()
	rotation = direction
	if Input.is_action_just_pressed("shoot"):
		animations.play("shoot")
		shoot()

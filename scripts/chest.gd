extends Node2D

@export var opened: bool = false

@onready var animations = $AnimatedSprite2D
@onready var spawn_point: Marker2D = $Marker2D

var item_scene: PackedScene = preload("res://scenes/item_bow.tscn")

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player") and not opened:
		opened = true
		animations.play("open")
		await  animations.animation_finished
		spawn_item()
		
func spawn_item():
	var item_instance = item_scene.instantiate()
	item_instance.global_position = spawn_point.global_position
	get_parent().add_child(item_instance)

extends Area2D

@export var speed = 200

var direction: Vector2 = Vector2.ZERO

func _ready():
	await get_tree().create_timer(5.0).timeout
	queue_free()

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("Walls"):
		_explotion()

func _explotion():
	var explotion = preload("res://scenes/enemy_bullet_explotion.tscn").instantiate()
	explotion.global_position = global_position
	get_tree().current_scene.add_child(explotion)
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("Player"):
		_explotion()
		if area.get_parent().has_method("take_damage"):
			area.get_parent().take_damage(5)

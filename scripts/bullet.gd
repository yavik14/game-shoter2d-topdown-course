extends Area2D

@export var speed = 200

func _ready():
	await get_tree().create_timer(5.0).timeout
	queue_free()

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("Enemies"):
		_explotion()
		body.queue_free()
	elif body.is_in_group("Walls"):
		_explotion()

func _explotion():
	var explotion = preload("res://scenes/bullet_explotion.tscn").instantiate()
	explotion.global_position = global_position
	get_tree().current_scene.add_child(explotion)
	queue_free()

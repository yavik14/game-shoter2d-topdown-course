extends CharacterBody2D

@export var speed = 25
@export var health = 3
@export var shoot_interval = 1.5

@onready var player = get_node("/root/Level/Player")
@onready var anims = $AnimationPlayer
@onready var sprite = $Sprite2D

var bullet_scene = preload("res://scenes/enemy_bullet.tscn")

signal enemy_died

func _ready():
	anims.play("fly")
	anims.connect("animation_finished", self._on_animation_finished)
	start_shoot_loop()

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	if velocity.x < 0: 
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
func take_damage():
	anims.stop()
	anims.play("hurt")
	health -= 1
	if (health <= 0):
		emit_signal("enemy_died")
		queue_free()
		
func _on_animation_finished(anim_name):
	if anim_name == "hurt":
		anims.play("fly")
		
func start_shoot_loop():
	await  get_tree().create_timer(shoot_interval).timeout
	spawn_bullet()
	start_shoot_loop()
	
func spawn_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	var bullet_dir = global_position.direction_to(player.global_position)
	bullet.direction = bullet_dir
	get_parent().add_child(bullet)

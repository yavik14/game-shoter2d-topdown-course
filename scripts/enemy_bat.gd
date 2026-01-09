extends CharacterBody2D

@export var speed = 25
@export var health = 3

@onready var player = get_node("/root/Level01/Player")
@onready var anims = $AnimationPlayer
@onready var sprite = $Sprite2D

func _ready():
	anims.play("fly")
	anims.connect("animation_finished", self._on_animation_finished)

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
		queue_free()
		
func _on_animation_finished(anim_name):
	if anim_name == "hurt":
		anims.play("fly")
		

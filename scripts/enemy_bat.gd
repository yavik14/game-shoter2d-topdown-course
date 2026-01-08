extends CharacterBody2D

@export var speed = 25

@onready var player = get_node("/root/Level01/Player")
@onready var anims = $AnimationPlayer

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	if velocity.x < 0: 
		anims.play("flyLeft")
	else:
		anims.play("flyRight")

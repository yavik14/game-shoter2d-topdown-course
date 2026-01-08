extends CharacterBody2D

@export var speed = 125

@onready var anims = $AnimationPlayer

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	
	if direction.length() > 0 :
		if velocity.x < 0: 
			anims.play("walkLeft")
		else:
			anims.play("walkRight")
	else:
		anims.play("idle")

extends CharacterBody2D

@export var speed = 125

@onready var anims = $AnimationPlayer

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	
	var targetPosion = get_global_mouse_position()
	
	if direction.length() > 0 :
		if targetPosion.x < global_position.x:
			anims.play("walkLeft")
		else:
			anims.play("walkRight")
	else:
		anims.play("idle")

	

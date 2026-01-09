extends CharacterBody2D

@export var speed = 125
@export var health = 100

@onready var anims = $AnimationPlayer
@onready var hurtZone = $HurtZone
@onready var sprite = $Sprite2D

var isHurt = false

func _ready():
	anims.animation_finished.connect(_on_animation_finished)

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
		
	if (isHurt == false) :		
		if direction.length() > 0 :
			anims.play("walk")
		else:
			anims.play("idle")
			
	var targetPosion = get_global_mouse_position()
			
	if targetPosion.x < global_position.x:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
	var overlapping_enemies = hurtZone.get_overlapping_bodies()
	for enemy in overlapping_enemies:
		if enemy.is_in_group("Enemies"):
			take_damage(1)
			break
			
func take_damage(amount):
	health -= amount
	isHurt = true
	anims.play("hurt")
	if health <= 0:
		die()
		
func die():
	get_tree().reload_current_scene()
	
func _on_animation_finished(anim_name):
	if anim_name == "hurt":
		isHurt = false

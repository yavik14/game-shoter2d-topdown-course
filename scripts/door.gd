extends Node2D

@onready var animations = $AnimatedSprite2D
@onready var leftDoorCollision = $OpenedStaticBody2D/LeftCollisionShape2D
@onready var rightDoorCollision = $OpenedStaticBody2D/RightCollisionShape2D
@onready var closedDoorCollision = $ClosedStaticBody2D/ClosedCollisionShape2D

@export var opened: bool = false

func _ready():
	animations.animation_finished.connect(_on_animation_finished)
	leftDoorCollision.disabled = true
	rightDoorCollision.disabled = true

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player") and not opened:
		opened = true
		animations.play("open")
		
func _on_animation_finished():
	if animations.animation == "open":
		closedDoorCollision.disabled = true
		leftDoorCollision.disabled = false
		rightDoorCollision.disabled = false

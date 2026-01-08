extends Node2D

@onready var camera = $Camera2D
@onready var rigitBody2d = $RigidBody2D

var number = 0

const DEFAULT_ZOOM = 2.0

func _ready():
	print("Hello world!")
	camera.zoom = Vector2(DEFAULT_ZOOM, DEFAULT_ZOOM)
	rigitBody2d.gravity_scale = number
	
func _process(delta):
	pass

extends Node

@onready var boss_camera = $"../Camera2D"

func _ready():
	boss_camera.make_current()

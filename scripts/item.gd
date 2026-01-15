extends Area2D

@onready var animations = $AnimationPlayer

func _ready():
	animations.play("spawn")
	animations.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim_name: StringName):
	if anim_name == "spawn":
		animations.play("fly")


func _on_area_entered(area):
	if area.is_in_group("Player"):
		var weapon_manager = area.get_parent().get_node("WeaponManager")
		if weapon_manager:
			weapon_manager.pickup_weapon_by_name("Bow")
		queue_free()

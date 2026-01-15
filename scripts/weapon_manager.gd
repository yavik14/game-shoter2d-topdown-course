extends Node2D

@onready var weapon_icon_path = $"CanvasLayer/WeaponsInventory/VBoxContainer/Control/TextureRect"
var weapon_icons = {
	"Gun":preload("res://art/weapons/gun.png"),
	"Bow":preload("res://art/weapons/bow.png"),
}

var weapons = []
var owned_weapons = []
var current_weapon_index = 0

func _ready():
	weapons=[$Gun, $Bow]
	
	var starting_weapon = weapons[0]
	owned_weapons.append(starting_weapon)
	
	for weapon in weapons:
		set_weapon_enabled(weapon, weapon == starting_weapon)
		
	update_weapon_ui()
		

func set_weapon_enabled(weapon, enabled):
	weapon.visible = enabled
	weapon.set_process(enabled)
	weapon.set_physics_process(enabled)
	

func equip_weapon(delta):
	if owned_weapons.size() <= 1:
		return
	
	set_weapon_enabled(owned_weapons[current_weapon_index], false)
	current_weapon_index = (current_weapon_index + delta + owned_weapons.size()) % owned_weapons.size()
	set_weapon_enabled(owned_weapons[current_weapon_index], true)
	
	update_weapon_ui()
	
	
func pickup_weapon_by_name(_weapon_name):
	for weapon in get_children():
		if weapon.name == _weapon_name:
			if weapon not in owned_weapons:
				owned_weapons.append(weapon)
				set_weapon_enabled(weapon, false)
			return
			
func _physics_process(delta):
	if Input.is_action_just_pressed("weapon"):
		equip_weapon(1)
		
		
func update_weapon_ui():
	var current_name = owned_weapons[current_weapon_index].name
	if weapon_icon_path and current_name in weapon_icons:
		weapon_icon_path.texture = weapon_icons[current_name]

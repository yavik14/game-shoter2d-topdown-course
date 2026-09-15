extends Node

var owned_weapons: Array[String]=[]
var current_weapon: String = ""
var current_weapon_index: int = 0

func add_weapon(weapon_name: String):
	if weapon_name not in owned_weapons:
		owned_weapons.append(weapon_name)
		
func has_weapon(weapon_name: String) -> bool:
	return weapon_name in owned_weapons

func set_current_weapon(weapon_name: String):
	current_weapon = weapon_name
	
func set_current_weapon_index(weapon_index: int):
	current_weapon_index = weapon_index

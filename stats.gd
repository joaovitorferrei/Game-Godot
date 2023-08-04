extends Node2D
class_name stats


export onready var player: KinematicBody2D = get_parent()


var shielding: bool = false

var base_health: int = 15
var base_mana: int = 10
var base_attack: int = 1
var base_magic_attack: int = 3
var base_defense: int = 1

var bonus_health: int = 0
var bonus_mana: int = 0
var bonus_attack: int = 0
var bonus_magic_attack: int = 0
var bonus_defense: int = 0

var current_mana: int
var current_health: int

var max_mana: int
var max_healt: int

var current_xp: int = 0

var level: int = 1
var level_dict: Dictionary = {
	"1": 25,
	"2": 50,
	"3": 100,
	"4": 150,
	"5": 250,
	"6": 350,
	"7": 500,
	"8": 650,
	"9": 850,
	"10": 1050
}

func _ready() -> void:
	current_mana = base_mana + bonus_mana
	max_mana = current_mana
	
	current_health = base_health + bonus_health
	max_healt = current_health
	
func update_xp(value: int) -> void:
	current_xp +- value
	if current_xp >= level_dict[str(level)] and level < 10:
		var leftover: int = current_xp - level_dict[str(level)]
		current_xp = leftover
		on_level_up()
		level += 1
	elif current_xp >= level_dict[str(level)] and level == 9:
		current_xp = level_dict[str(level)]
	

	
func on_level_up() -> void:
	current_mana = base_mana + bonus_mana
	current_health = base_health + bonus_health
	

func update_health(type: String, value: int) -> void:
	match type:
		"increase":
			current_health += value
			if current_health > max_healt:
				current_health = max_healt
		
		"decrease":
			verify_shield(value)
			if current_health <= 0:
				player.dead = true
			else:
				player.on_hit = true
				player.attacking = false

			
func verify_shield(value: int) -> void:
	if shielding:
		if (base_defense + bonus_defense) >= value:
			return
		
		var damage: float = abs((base_defense + bonus_defense) - value)
		current_health -= damage
	
	else:
		current_health -= value
		
		
func update_mana(type: String, value: int) -> void:
	match type:
		"increase":
			current_mana += value
			if current_mana > max_mana:
				current_mana = max_mana
		
		"decrease":
			current_mana -= value
	
	
func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_select"):
		update_health("decrease", 5)

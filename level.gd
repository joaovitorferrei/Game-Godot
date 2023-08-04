extends Node2D
class_name level

onready var player: KinematicBody2D = get_node("player")

func _ready() -> void:
	var _game_over: bool = player.get_node("texture").connect("game_over", self, "on_game_over")

func on_game_over() -> void:
	var _reload: bool = get_tree().reload_current_scene()

extends Area2D
class_name detection_area

export(NodePath) onready var enemy = get_node(".") as KinematicBody2D





func _on_body_entered(body: player):
	enemy.player_ref = body


func _on_body_exited(_body: player):
	enemy.player_ref = null

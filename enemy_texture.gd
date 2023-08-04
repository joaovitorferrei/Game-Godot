extends Sprite
class_name enemy_texture

export(NodePath) onready var animation = get_node(animation) as AnimationPlayer
export(NodePath) onready var enemy = get_node(".")
export(NodePath) onready var attack_area_collision = get_node(attack_area_collision) as CollisionShape2D

func animate(velocity: Vector2) -> void:
	pass




func _on_animation_finished(anim_name):
	pass # Replace with function body.

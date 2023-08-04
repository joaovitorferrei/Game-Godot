extends enemy_texture
class_name texture_whale

func animate(velocity: Vector2) -> void:
	move_behavior(velocity)
	
func move_behavior(velocity: Vector2) -> void:
	if velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")

extends ParallaxBackground
class_name background

#export(bool) var can_process
#export(Array, int) var layer_speed

func _read():
	pass
	#if can_process == false:
	#	set_physics_process(true)
		
func _physics_process(delta):
	pass
	#for index in get_child_count():
	#	if get_child(index) is ParallaxLayer:
	#		get_child(index).motion_offset.x -= delta * layer_speed[index]

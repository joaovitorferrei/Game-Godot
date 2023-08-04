extends KinematicBody2D
class_name player

onready var player_sprite: Sprite = get_node("texture")
onready var wall_ray: RayCast2D = get_node("wall_ray")
onready var stats: Node = get_node("stats")


var velocity: Vector2 #(75, 75) (x, y)

var jump_count: int = 0


var on_hit: bool = false
var dead: bool = false
var landing: bool = false
var attacking: bool = false
var defending: bool = false
var crouching: bool = false
# Quando em attack/crouch/shield boqueia as outras ações
var can_track_input: bool = true 

var direction: int = 1
var on_wall: bool = false
var not_on_wall: bool = true

export(int) var speed
export(int) var jump_speed
export(int) var wall_jump_speed

export(int) var player_gravity
export(int) var wall_gravity
export(int) var wall_impulse_speed

func _physics_process(delta):
	horizontal_movement()
	vertical_movement()
	actions()
	
	gravity(delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	player_sprite.animate(velocity)
	
func horizontal_movement() -> void:
	var input_direction: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if can_track_input == false or attacking:
		velocity.x = 0
		return
		
	velocity.x = input_direction * speed
	

func vertical_movement() -> void:
	if is_on_floor() or is_on_wall():
		jump_count = 0
		
	
	var jump_condition: bool = can_track_input and not attacking
	if Input.is_action_just_pressed("ui_select") and jump_count < 2 and jump_condition:
		jump_count += 1
		if next_to_wall() and not is_on_floor():
			velocity.y = wall_jump_speed
			velocity.x += wall_impulse_speed * direction
		else:
			velocity.y = jump_speed
		
func actions() -> void:
	attack()
	crouch()
	defense()

func attack() -> void:
	var attack_condition: bool = not attacking and not crouching and not defending
	if Input.is_action_just_pressed("attack") and attack_condition and is_on_floor():
		attacking = true
		player_sprite.normal_attack = true
			
func crouch() -> void:
	if Input.is_action_pressed("crouch") and not defending and is_on_floor():
		crouching = true
		#stats.shielding = false
		can_track_input = false
	elif not defending:
		crouching = false
		#stats.shielding = false
		can_track_input = true
		player_sprite.crouching_off = true
		
func defense() -> void:
	if Input.is_action_pressed("shield") and not crouching and is_on_floor():
		defending = true
		#stats.shielding = true
		can_track_input = false
	elif not crouching:
		defending = false
		#stats.shielding = false
		can_track_input = true
		player_sprite.shield_off = true
		


func gravity(delta) -> void:
	if next_to_wall():
		velocity.y += delta * wall_gravity
		if velocity.y >= wall_gravity:
			velocity.y = wall_gravity
	else:
		velocity.y += delta * player_gravity
		if velocity.y >= player_gravity:
			velocity.y = player_gravity

func next_to_wall() -> bool:
	if wall_ray.is_colliding() and not is_on_floor():
		if not_on_wall:
			velocity.y = 0
			not_on_wall = false
		
		return true
		
	else:
		not_on_wall = true
		return false

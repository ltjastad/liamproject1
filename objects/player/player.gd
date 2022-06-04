extends KinematicBody2D

export(int) var movement_speed = 3000 # left and right movement speed
export(int) var max_x_velocity = 3000 # maximum left and right velocity (speed)
export(int) var gravity = 200 # gravity pushing down on player
export(float) var slide_force = 50
export(int) var max_fall_speed = 7000 # max speed when falling
export(int) var jump_force = 16000 # upwards jumping force

onready var _collision_shape_offset = $CollisionShape2D.position

var _vel = Vector2(0,0)

func _ready():
	
	# create an area for player detection
	var areashape = $CollisionShape2D.duplicate()
	areashape.name = "areashape"
	$Area2D.add_child(areashape)
	add_collision_exception_with($Area2D)
	

func _physics_process(delta):
	
	
	
	_handle_input(delta)

func _handle_input(delta):
	
	var move_dir = Vector2(0,0)
	var climbing = false
	
	# if player is on the floor, zero out the y velocity
	if is_on_floor(): _vel.y = 0
	# if player hits the ceiling, zero out the y velocity
	if is_on_ceiling(): _vel.y = 0
	
	# if player is commanding left/right movement
	if Input.is_action_pressed("ui_left"): move_dir.x -= 1
	if Input.is_action_pressed("ui_right"): move_dir.x += 1
	
	# animate
	if move_dir != Vector2(0,0): $sprite/AnimationPlayer.play("walk")
	else: $sprite/AnimationPlayer.play("idle")
	if move_dir.x < 0 and $sprite.flip_h:
		$sprite.flip_h = false
		$CollisionShape2D.position = _collision_shape_offset
		$Area2D.get_node("areashape").position = $CollisionShape2D.position
	elif move_dir.x > 0 and !$sprite.flip_h:
		$sprite.flip_h = true
		$CollisionShape2D.position = Vector2(-_collision_shape_offset.x, _collision_shape_offset.y)
		$Area2D.get_node("areashape").position = $CollisionShape2D.position
	
	# if on a climbable area, enable climbing
	var bodies = $Area2D.get_overlapping_areas()
	for b in bodies:
		if b.get_parent().has_method("is_climbable"):
			climbing = true
			break
	
	if climbing:
		if Input.is_action_pressed("ui_up"): move_dir.y -= 1
		if Input.is_action_pressed("ui_down"): move_dir.y += 1
	
	# add to velocity
	_vel.x += move_dir.x * movement_speed
	
	if Input.is_action_just_pressed("ui_jump"):
		if is_on_floor():
			_vel.y -= jump_force
	
	# apply gravity
	if !climbing: _vel.y += gravity
	else:
		_vel.y = movement_speed * move_dir.y
	
	_vel.x = clamp(_vel.x, -max_x_velocity, max_x_velocity)
	_vel.y = clamp(_vel.y, -max_fall_speed, max_fall_speed)
	
	# if player is not moving left or right, add drag to movement
	if move_dir.x == 0:
		_vel.x = _vel.x * slide_force * delta
	
	move_and_slide(_vel*delta, Vector2(0,-1))
	
	

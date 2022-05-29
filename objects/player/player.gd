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
	pass

func _physics_process(delta):
	
	_handle_input(delta)

func _handle_input(delta):
	
	var move_dir = Vector2(0,0)
	
	# if player is commanding left/right movement
	if Input.is_action_pressed("ui_left"): move_dir.x -= 1
	if Input.is_action_pressed("ui_right"): move_dir.x += 1
	
	# animate
	if move_dir != Vector2(0,0): $sprite/AnimationPlayer.play("walk")
	else: $sprite/AnimationPlayer.play("idle")
	if move_dir.x < 0 and $sprite.flip_h:
		$sprite.flip_h = false
		$CollisionShape2D.position = _collision_shape_offset
	elif move_dir.x > 0 and !$sprite.flip_h:
		$sprite.flip_h = true
		$CollisionShape2D.position = Vector2(-_collision_shape_offset.x, _collision_shape_offset.y)
	
	# add to velocity
	_vel.x += move_dir.x * movement_speed
	
	if Input.is_action_just_pressed("ui_jump"):
		if is_on_floor():
			_vel.y -= jump_force
	
	# apply gravity
	_vel.y += gravity
	
	_vel.x = clamp(_vel.x, -max_x_velocity, max_x_velocity)
	_vel.y = clamp(_vel.y, -max_fall_speed, max_fall_speed)
	
	# if player is not moving left or right, add drag to movement
	if move_dir.x == 0:
		_vel.x = _vel.x * slide_force * delta
	
	move_and_slide(_vel*delta, Vector2(0,-1))
	
	

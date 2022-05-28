extends KinematicBody2D

export(int) var movement_speed = 3000
export(int) var gravity = 150
export(int) var jump_force = 300

var _vel = Vector2(0,0)

func _ready():
	pass

func _physics_process(delta):
	
	_handle_input(delta)

func _handle_input(delta):
	
	var move_dir = Vector2(0,0)
	
	# if move keys are pressed, set player move direction
	if Input.is_action_pressed("ui_left"): move_dir.x -= 1
	if Input.is_action_pressed("ui_right"): move_dir.x += 1
	if Input.is_action_pressed("ui_up"): move_dir.y -= 1
	#if Input.is_action_pressed("ui_down"): move_dir.y += 1
	
	# animate
	if move_dir != Vector2(0,0): $sprite/AnimationPlayer.play("walk")
	else: $sprite/AnimationPlayer.play("idle")
	
	if move_dir.x < 0: $sprite.flip_h = false
	elif move_dir.x > 0: $sprite.flip_h = true
	
	# add movedir to vel
	_vel += move_dir*movement_speed
	
	if Input.is_action_just_pressed("ui_jump"):
		if is_on_floor():
			_vel.y -= jump_force * delta
	
	# apply gravity
	_vel.y += gravity*delta
	
	move_and_slide(_vel*delta, Vector2(0,-1))
	
	

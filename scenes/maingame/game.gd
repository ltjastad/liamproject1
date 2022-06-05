extends Node2D

var current_message = null

func _ready():
	pass

func _physics_process(delta):
	
	# make camera follow player
	$camera.position = $player.position
	
func _input(event):
	if event.is_action_pressed("ui_cancel"): get_tree().quit()

func print_message(var tmsg:String):
	
	# delete existing message
	clear_message()
	
	var dbox = preload("res://ui/dialogue_box/dialogue_box.tscn").instance()
	dbox.message = tmsg
	current_message = dbox
	$CanvasLayer.add_child(dbox)

func clear_message():
	if current_message != null:
		if is_instance_valid(current_message):
			var oldmsg = current_message
			$CanvasLayer.remove_child(current_message)
			oldmsg.queue_free()
			current_message = null

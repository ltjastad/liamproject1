extends Node2D

func _physics_process(delta):
	
	# make camera follow player
	$camera.position = $player.position
	
func _input(event):
	if event.is_action_pressed("ui_cancel"): get_tree().quit()

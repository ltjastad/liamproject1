extends Node2D

func _physics_process(delta):
	
	# make camera follow player
	$camera.position = $player.position
	

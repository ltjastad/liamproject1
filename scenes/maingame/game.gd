extends Node2D

func _ready():
	dialogue_message("Yo!")

func _physics_process(delta):
	
	# make camera follow player
	$camera.position = $player.position
	
func _input(event):
	if event.is_action_pressed("ui_cancel"): get_tree().quit()

func dialogue_message(msg):
	var new_dlg = preload("res://ui/dialogue_box/dialogue_box.tscn").instance()
	new_dlg.msg = msg
	new_dlg.rect_size = Vector2(0,0)
	$CanvasLayer.add_child(new_dlg)

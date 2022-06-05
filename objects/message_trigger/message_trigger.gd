extends Area2D

export(String) var message = ""
export(bool) var trigger_once = false

func _ready():
	
	connect("body_entered", self, "on_body_entered")
	connect("body_exited", self, "on_body_exited")
	
func on_body_entered(body):
	if body == get_tree().current_scene.get_node("player"):
		get_tree().current_scene.print_message(message)
		
func on_body_exited(body):
	if body == get_tree().current_scene.get_node("player"):
		get_tree().current_scene.clear_message()
	if trigger_once: queue_free()

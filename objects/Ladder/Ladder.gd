tool
extends Node2D

export(bool) var flip_horizontally = false
export(bool) var flip_vertically = false

func _ready():
	$Ladder.flip_h = flip_horizontally
	$Ladder.flip_v = flip_vertically
	
	
	
func _process(delta):
	
	if Engine.editor_hint:
		$Ladder.flip_h = flip_horizontally
		$Ladder.flip_v = flip_vertically
		
func is_climbable(): return true

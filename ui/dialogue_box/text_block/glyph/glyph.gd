extends Node2D

const WIDTH = 8
const HEIGHT = 12

var charcode = 0

func set_char(var tchar:String):
	if tchar.length() == 1:
		charcode = tchar.to_ascii()[0]
		$fg.frame = charcode

func set_foreground_color(var fgcolor:Color):
	$fg.material.set_shader_param("foreground_color", fgcolor)
	
func set_background_color(var bgcolor:Color):
	$bg.material.set_shader_param("foreground_color", bgcolor)

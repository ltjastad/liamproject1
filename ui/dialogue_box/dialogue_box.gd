extends Control

var scale = 2
var border_size = 2
var border_color = Color(1,1,1)
var background_color = Color(0,0,0)
var margin = 8
var distance_from_bottom = 32
var message = ""

func _ready():
	
	# create message block
	$Panel/text_block.print_message(message)
	$Panel/text_block.scale = Vector2(scale, scale)
	$Panel/text_block.position = Vector2(margin, margin)
	
	# set panel size
	$Panel.rect_size = ($Panel/text_block.get_size()*scale) + Vector2(margin*2, margin*2)
	
	# create style box
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = background_color
	stylebox.border_color = border_color
	stylebox.border_width_bottom = border_size
	stylebox.border_width_left = border_size
	stylebox.border_width_right = border_size
	stylebox.border_width_top = border_size
	stylebox.expand_margin_bottom = border_size
	stylebox.expand_margin_left = border_size
	stylebox.expand_margin_right = border_size
	stylebox.expand_margin_top = border_size
	
	# set style box
	$Panel.set("custom_styles/panel", stylebox)
	
	# position panel
	$Panel.rect_position = Vector2( (get_viewport().size.x/2)-($Panel.rect_size.x/2), get_viewport().size.y - $Panel.rect_size.y - distance_from_bottom)
	

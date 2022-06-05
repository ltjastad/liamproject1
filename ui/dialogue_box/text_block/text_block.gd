extends Node2D

var _glyph_scene = preload("res://ui/dialogue_box/text_block/glyph/glyph.tscn")
var _width = 0
var _height = 1

var max_width = 32
var message = ""

func _set_dimensions(width, height):
	
	# remove old structure (if it exists)
	var oldrows
	if has_node("rows"):
		oldrows = get_node("rows")
		remove_child(oldrows)
		oldrows.queue_free()
	
	# create structure
	var rows = Node2D.new()
	rows.name = "rows"
	
	for y in range(0, height):
		var newrow = Node2D.new()
		newrow.name = str("row",y)
		rows.add_child(newrow)
		for x in range(0, width):
			var newcol = _glyph_scene.instance()
			newcol.name = str("col",x)
			newcol.position = Vector2(x*newcol.WIDTH, y*newcol.HEIGHT)
			newrow.add_child(newcol)
			
	
	add_child(rows)

func _print_message():
	for c in message.length():
		var row = c / _width
		var col = c - (row*_width)
		get_node("rows").get_child(row).get_child(col).set_char(message[c])
		
func print_message(var tmsg:String):
	
	message = tmsg
	
	# get text blocks width
	_width = message.length()
	if _width > max_width: _width = max_width
	
	# make sure whole words fit on a line
	# to-do
	
	# get text blocks height
	if message.length() > _width:
		_height = int(float(message.length())/float(_width)) + 1
	
	# set dimensions
	_set_dimensions(_width,_height)
	_print_message()	

func get_size():
	var glyph = _glyph_scene.instance()
	return Vector2(_width*glyph.WIDTH, _height*glyph.HEIGHT)


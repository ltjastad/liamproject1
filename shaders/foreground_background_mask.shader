shader_type canvas_item;

uniform vec4 background_color: hint_color;
uniform vec4 foreground_color: hint_color;

void fragment() {
	vec4 current_color = texture(TEXTURE, UV); // get pixel color
	if (current_color == vec4(1,0,1,1) )
	{
		current_color = background_color;
	}
	else if(current_color == vec4(1,1,1,1))
	{
		current_color = foreground_color
	}
	COLOR = current_color;
}


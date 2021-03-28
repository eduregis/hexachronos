shader_type canvas_item;

void fragment() {
	vec4 previous_color = texture(TEXTURE, UV);
	if (previous_color.r < 0.33) {
		if (previous_color.g > 0.55) {
			if (previous_color.b < 0.33) {
				COLOR = vec4(0.0, 1.0, 1.0, 0.0);
			} else {
				COLOR = previous_color
			}
		} else {
			COLOR = previous_color
		} 
	} else {
		COLOR = previous_color
	}
}
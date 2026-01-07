shader_type canvas_item;

uniform vec2 delta = vec2(0.01, 0.1);  // left up 

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR.r += texture(TEXTURE, UV + delta).r;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

shader_type canvas_item;

uniform vec4 edges;

void fragment() {
	float left = step(edges.x,UV.x);
	float top = step(edges.y,UV.y);
	float right = 1.0 - step(edges.z,UV.x);
	float bottom = 1.0 - step(edges.w,UV.y);
	float colour = min(top,left);
	colour = min(colour,bottom);
	colour = min(colour,right);
	COLOR = vec4(vec3(colour),1.0);
}

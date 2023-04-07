shader_type canvas_item;

uniform vec4 data;

void fragment() {
	vec2 linear_dist = data.xy - UV;
	float dist = linear_dist.x * linear_dist.x + linear_dist.y * linear_dist.y ;
	float colour = 1.0-step(data.z,dist);
	COLOR = vec4(vec3(colour),1.0);
}

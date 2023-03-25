// Vertex attributes, specified in the "attributes" entry of the pipeline
attribute vec3 vertex_position;
attribute vec3 vertex_normal;

// Per-vertex outputs passed on to the fragment shader

/* #TODO GL2.3
	Pass the values needed for per-pixel
	Create a vertex-to-fragment variable.
*/
//varying ...
varying vec3 color;

// Global variables specified in "uniforms" entry of the pipeline
uniform mat4 mat_mvp;
uniform mat4 mat_model_view;
uniform mat3 mat_normals_to_view;

uniform vec3 light_position; //in camera space coordinates already

uniform vec3 material_color;
uniform float material_shininess;
uniform vec3 light_color;

void main() {
	float material_ambient = 0.1;

	/** #TODO GL2.3 Gouraud lighting
	Compute the visible object color based on the Blinn-Phong formula.

	Hint: Compute the vertex position, normal and light_position in eye space.
	Hint: Write the final vertex position to gl_Position
	*/

	color = vec3(0., 0., 0.);

	vec4 vertex_position_eye = mat_model_view * vec4(vertex_position, 1.);

	vec3 vertex_normal = normalize(mat_normals_to_view * vertex_normal);

	vec4 light_position_eye = vec4(light_position, 1.);

	vec3 direction_to_camera = normalize(-vertex_position_eye.xyz);

	vec3 direction_to_light = normalize(light_position_eye.xyz - vertex_position_eye.xyz);

	vec3 diffuse = light_color * material_color * dot(direction_to_light, vertex_normal);

	vec3 specular_blinn;
	vec3 half_vector = normalize(direction_to_light + direction_to_camera);
	
	specular_blinn = light_color *  material_color * pow(dot(vertex_normal, half_vector), material_shininess);
	vec3 blinn_light = diffuse + specular_blinn;

	if(dot(vertex_normal, direction_to_light) < 0.)
		color = vec3(0., 0., 0.);
	else if(dot(vertex_normal, half_vector) < 0.)
		color = diffuse;
	else
		color = blinn_light;
	
	color += light_color * material_ambient * material_color;
	gl_Position = mat_mvp * vec4(vertex_position, 1);
}

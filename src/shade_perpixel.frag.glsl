precision mediump float;

/* #TODO GL2.4
	Setup the varying values needed to compue the Phong shader:
	* surface normal
	* lighting vector: direction to light
	* view vector: direction to camera
*/
//varying ...
//varying ...
//varying ...
varying vec3 normal;
varying vec3 direction_to_light;
varying vec3 direction_to_camera;

uniform vec3 material_color;
uniform float material_shininess;
uniform vec3 light_color;

void main()
{
	float material_ambient = 0.1;

	/*
	/** #TODO GL2.4: Apply the Blinn-Phong lighting model

	Implement the Blinn-Phong shading model by using the passed
	variables and write the resulting color to `color`.

	Make sure to normalize values which may have been affected by interpolation!
	*/
	vec3 color = vec3(0., 0., 0.);

	vec3 norm_normal = normalize(normal);
	vec3 norm_direction_to_light = normalize(direction_to_light);
	vec3 norm_direction_to_camera = normalize(direction_to_camera);

	vec3 diffuse = light_color * material_color * dot(norm_direction_to_light, norm_normal);

	vec3 specular_blinn;
	vec3 half_vector = normalize(norm_direction_to_light + norm_direction_to_camera);
	
	specular_blinn = light_color *  material_color * pow(dot(norm_normal, half_vector), material_shininess);
	vec3 blinn_light = diffuse + specular_blinn;

	if(dot(norm_normal, norm_direction_to_light) < 0.)
		color = vec3(0., 0., 0.);
	else if(dot(norm_normal, half_vector) < 0.)
		color = diffuse;
	else
		color = blinn_light;
	
	color += light_color * material_ambient * material_color;
	gl_FragColor = vec4(color, 1.); // output: RGBA in 0..1 range
}

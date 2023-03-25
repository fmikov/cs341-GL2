precision mediump float;
		
/* #TODO GL2.2.1
	Pass the normal to the fragment shader. 
	Create a vertex-to-fragment variable.
*/
varying vec3 norm;

void main()
{
	/* #TODO GL2.2.1
	Visualize the normals as false color. 
	*/
	vec3 color = normalize(norm)*0.5 + 0.5; // set the color from normals

	gl_FragColor = vec4(color, 1.); // output: RGBA in 0..1 range
}

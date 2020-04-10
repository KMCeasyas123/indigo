shader_type canvas_item;
uniform float strength = 1;
uniform float noiseScale = 1;
uniform float timeStep = .25f;
uniform sampler2D noiseTex;
uniform float portalSpeed;
uniform vec2 center;
uniform float lineSize;
void fragment() {
	//Round to nearest texel
	vec2 rounded = round(UV/TEXTURE_PIXEL_SIZE) * TEXTURE_PIXEL_SIZE;
	//Round to nearest time step
	float roundedTime = round(TIME/timeStep) * timeStep;
	//Calculate a -1 to 1 offset
	vec2 offset = texture(noiseTex,fract((rounded + roundedTime ) * noiseScale)).xy * 2.0 - 1.0;
	//Calculate a texel offset
	vec2 coord = (vec2(offset.x * TEXTURE_PIXEL_SIZE.x * strength, offset.y * TEXTURE_PIXEL_SIZE.y * strength));
	//Sample noisily
	vec4 col = texture(TEXTURE,UV + coord);
	vec2 texelRound = round((UV + coord)/TEXTURE_PIXEL_SIZE) * TEXTURE_PIXEL_SIZE;
	float dist = distance(center,texelRound) + TIME * -(portalSpeed);
	
	//Calculate distance from nearest line then compare it to quarter line size for width
	if((round(dist / lineSize) * lineSize) - dist > lineSize/4.0) col.rgb = vec3(.317,.345,.368);
    COLOR = col;
}
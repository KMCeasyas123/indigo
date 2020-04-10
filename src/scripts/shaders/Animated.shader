shader_type canvas_item;
uniform float strength = 1;
uniform float noiseScale = 1;
uniform float timeStep = .25f;
uniform sampler2D noiseTex;
void fragment() {
	vec2 rounded = round(UV/TEXTURE_PIXEL_SIZE) * TEXTURE_PIXEL_SIZE;
	float roundedTime = round(TIME/timeStep) * timeStep;
	vec2 offset = texture(noiseTex,fract((rounded + roundedTime ) * noiseScale)).xy * 2.0 - 1.0;
	vec2 coord = (vec2(offset.x * TEXTURE_PIXEL_SIZE.x * strength, offset.y * TEXTURE_PIXEL_SIZE.y * strength));
	vec4 col = texture(TEXTURE,UV + coord);
    COLOR = col; // use red for material albedo
}
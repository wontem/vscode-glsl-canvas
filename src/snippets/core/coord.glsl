/* Coordinate and unit utils */
vec2 coord(in vec2 p) {
	p = p / u_resolution.xy;
    // correct aspect ratio
    if (u_resolution.x > u_resolution.y) {
        p.x *= u_resolution.x / u_resolution.y;
        p.x += (u_resolution.y - u_resolution.x) / u_resolution.y / 2.0;
    } else {
        p.y *= u_resolution.y / u_resolution.x;
	    p.y += (u_resolution.x - u_resolution.y) / u_resolution.x / 2.0;
    }
    // centering
    p -= 0.5;
    p *= vec2(-1.0, 1.0);
	return p;
}
#define rx 1.0 / min(u_resolution.x, u_resolution.y)
#define uv gl_FragCoord.xy / u_resolution.xy
#define st coord(gl_FragCoord.xy)
#define mx coord(u_mouse)
vec2 pos(in float x, in float y) { return st + vec2(x * rx, y * rx); }
vec2 pos(in float x) { return pos(x, x); }
vec2 pos(in vec2 p) { return pos(p.x, p.y); }
float pix(in float x) { return x * rx; }
vec2 pix(in float x, in float y) { return vec2(x * rx, y * rx); }
float swing (float size) { return (1.0 + cos(u_time)) / 2.0 * pix(size); }
vec2 swing (in float x, in float y) { return (1.0 + cos(u_time)) / 2.0 * pix(x, y); }
vec3 draw(in sampler2D t, in vec2 pos, in vec2 size) { vec2 s = size / 1.0; s.x *= -1.0; return texture2D(t, pos / s + 0.5).rgb; }
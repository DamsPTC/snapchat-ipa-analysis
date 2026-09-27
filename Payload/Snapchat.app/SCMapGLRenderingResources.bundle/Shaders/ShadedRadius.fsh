#ifdef GL_OES_standard_derivatives
#   extension GL_OES_standard_derivatives : enable
#endif

precision highp int;
precision highp float;

varying vec2 v_coord;
uniform float u_alpha;

uniform float u_inner_circle_radius;
uniform float u_outer_circle_radius;
uniform float u_shadow_radius;

const vec2 zero_coord = vec2(0.0, 0.0);

const vec4 inner_circle_color = vec4(15. / 255., 173. / 255., 255. / 255., 1) * 0.5;
const vec4 inner_circle_color_shadow_background_color = vec4(1, 1, 1, 1) * 0.4;
const vec4 outer_circle_color = vec4(15. / 255., 173. / 255., 255. / 255., 1.0);
const vec4 shadow_color = vec4(0.0, 0.0, 0.0, 0.03);

float f_delta(float x) {
#ifdef GL_OES_standard_derivatives
    return fwidth(x);
#else
    return 0.0;
#endif
}

vec4 mix_colors(vec4 src, vec4 dest) {
    return clamp(src + dest * (1.0 - src.a), 0.0, 1.0);
}

float shadow_smoothstep(float edge0, float edge1, float x) {
    x = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0);
    return x * x * (3.0 - 2.0 * x) * pow(x, -0.1);
}

void main() {
    float dist = distance(v_coord, zero_coord);
    float delta = f_delta(dist);

    float shadowMask = 1.0 - shadow_smoothstep(u_outer_circle_radius, u_shadow_radius, dist);
    float outerCircleMask = 1.0 - smoothstep(u_outer_circle_radius - delta, u_outer_circle_radius, dist);
    float innerCircleMask = 1.0 - smoothstep(u_inner_circle_radius - delta, u_inner_circle_radius, dist);

    shadowMask = clamp(shadowMask - innerCircleMask, 0.0, 1.0);
    outerCircleMask = clamp(outerCircleMask - innerCircleMask, 0.0, 1.0);

    vec4 innerCircleShadowBackgroundColor = inner_circle_color_shadow_background_color * innerCircleMask;
    vec4 innerCircleColor = mix_colors(inner_circle_color * innerCircleMask, innerCircleShadowBackgroundColor);
    vec4 outerCircleColor = outer_circle_color * outerCircleMask;
    vec4 shadowColor = shadow_color * clamp(shadowMask - innerCircleMask, 0.0, 1.0);

    vec4 circleColor = mix_colors(innerCircleColor, outerCircleColor);

    gl_FragColor = mix_colors(circleColor, shadowColor) * u_alpha;
}

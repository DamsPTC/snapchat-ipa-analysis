#ifdef GL_OES_standard_derivatives
#   extension GL_OES_standard_derivatives : enable
#endif

precision highp int;
precision highp float;

varying float v_pixel_x;
varying float v_pixel_y;

uniform float u_total_length;

uniform float u_dash_width;
uniform float u_dash_length;
uniform float u_gap_length;
uniform float u_shadow_width;

const float SHADOW_ALPHA = 0.1;

// fwidth isn't included in the standard OpenGL ES 2 library, so
// we'll include it here (as `f_delta`) if available
float f_delta(float x) {
#ifdef GL_OES_standard_derivatives
    return fwidth(x);
#else
    return 0.0;
#endif
}

void main() {
    // The starting x-pixel of the dash immediately preceding this fragment
    float closest_dash_start = floor(v_pixel_x / (u_dash_length + u_gap_length)) * (u_dash_length + u_gap_length);
    
    if (closest_dash_start + u_dash_length > u_total_length) {
        // Don't draw the last dash
        discard;
    }
    
    float x_offset = v_pixel_x - closest_dash_start;
    float rect_start_x = u_shadow_width + u_dash_width;
    float rect_end_x = u_dash_length - u_shadow_width - u_dash_width;
    
    vec2 first_cap_center = vec2(rect_start_x, 0.0);
    vec2 second_cap_center = vec2(rect_end_x, 0.0);
    float rect_addition = 2.0 * u_dash_width * abs(floor((x_offset - rect_start_x) / (rect_end_x - rect_start_x)));
    
    float radius = min(min(distance(first_cap_center, vec2(x_offset, v_pixel_y)),
                       distance(second_cap_center, vec2(x_offset, v_pixel_y))),
                       abs(v_pixel_y) + rect_addition);
    float aa_factor = f_delta(radius + v_pixel_x); // Antialiasing factor
    float shade = 1.0 - smoothstep(u_dash_width - aa_factor, u_dash_width, radius);
    
    float base_alpha = shade * (1.0 - SHADOW_ALPHA) + SHADOW_ALPHA * (1.0 - smoothstep(u_dash_width, rect_start_x, radius));
    float smoothed_x = 0.3 * smoothstep(0.0, u_total_length, v_pixel_x) + 0.7;
    float alpha = base_alpha * smoothed_x; // Make line transparent -> opaque from start -> end
    gl_FragColor = vec4(shade, shade, shade, 1.0) * alpha;
}

#ifdef GL_OES_standard_derivatives
#   extension GL_OES_standard_derivatives : enable
#endif

precision highp int;
precision highp float;

varying float v_pixel_x;
varying float v_pixel_y;

uniform float u_total_length;
uniform float u_current_length;

uniform float u_min_width;
uniform float u_max_width;

uniform float u_shadow_width;

const float ARC_START_ALPHA = 0.2;
const float SHADOW_ALPHA = 0.2;
const float SWOOSH_EXPAND_LENGTH = 320.0;
const float CENTER_WIDTH_WEIGHT = 1.0;

// fwidth isn't included in the standard OpenGL ES 2 library, so
// we'll include it here (as `f_delta`) if available
float f_delta(float x) {
#ifdef GL_OES_standard_derivatives
    return fwidth(x);
#else
    return 0.0;
#endif
}

// Takes the three arguments for `smoothstep`, followed by scaled output bounds
// (`min_out` and `max_out`) and returns the smoothstep result scaled between the
// output bounds.
float scaled_smoothstep(float edge0, float edge1, float x, float min_out, float max_out) {
    return (max_out - min_out) * smoothstep(edge0, edge1, x) + min_out;
}

/**
 * A flight path has three parts: start cap, arc, and end cap. The start and end caps are semicircles
 * at the start and end of the path. The arc is the connective area between these semicircles. This
 * shader computes the path's edge (i.e. maximum radius) respective to the center of the path and end
 * caps.
 *
 * The edge is fixed for the start cap. The edge for the end cap and the arc is dependent on the
 * current length of the path relative to the total length.
 *
 * The current pixel is colored based on which side of the edge it lies on. The inside of the edge is
 * colored white with some increasing alpha along the path. The outside is given a shadow for some
 * width beyond the edge. The shadow is black with some decreasing alpha as the distance from the
 * edge increases (and the distance to the shadow's width decreases to zero). Any pixels beyond the
 * shadow's width are left transparent.
 *
 * The edge of the path (between the white fill and the shadow) is antialiased.
 */
void main() {
    // Calculate the start circle radius as a factor of the total width.
    float start_cap_radius = u_min_width / 2.0;
    
    // Based on the total length of the path, calculate the width of the widest part of the path
    // and the width of the shadow.
    float width_ratio = smoothstep(u_min_width, SWOOSH_EXPAND_LENGTH, u_total_length);
    float scaled_shadow_width = (u_shadow_width / 2.0) * width_ratio + (u_shadow_width / 2.0);
    
    // Find how far the current length is from the midpoint of the final length
    float progress = smoothstep(start_cap_radius, u_total_length - start_cap_radius, u_current_length);
    float weighted_percent_from_center = pow(2.0 * abs(progress - 0.5), CENTER_WIDTH_WEIGHT);
    
    // Calculate the maximum allowed radius and the radius of the end circle
    float max_radius = u_max_width / 2.0;
    float end_cap_radius = (max_radius - start_cap_radius) * width_ratio * (1.0 - weighted_percent_from_center) + start_cap_radius;

    // Calculate the current pixel's position along the final arc as a percentage (i.e. zero means the
    // current pixel is before the arc begins and one means the current pixel is after the arc ends).
    float rect_start_x = scaled_shadow_width + start_cap_radius;
    float rect_cur_end_x = u_current_length - scaled_shadow_width - end_cap_radius;
    float rect_final_end_x = u_total_length - scaled_shadow_width - end_cap_radius;
    float smoothed_x = smoothstep(rect_start_x, rect_final_end_x, v_pixel_x);
    
    // Calculate the edge
    float middle_max_radius = scaled_smoothstep(u_min_width, SWOOSH_EXPAND_LENGTH, u_total_length, start_cap_radius, max_radius);
    float x_from_center = 2.0 * abs(smoothed_x - 0.5); // zero at rect center, one at rect start/end
    float edge = scaled_smoothstep(0.0, 1.0, x_from_center, middle_max_radius, start_cap_radius);
    
    vec2 first_cap_center = vec2(rect_start_x, 0.0);
    vec2 second_cap_center = vec2(rect_cur_end_x, 0.0);
    float rect_addition = 2.0 * edge * abs(floor((v_pixel_x - rect_start_x) / (rect_cur_end_x - rect_start_x)));

    // Set the shade to 1.0 inside the arc and 0.0 outside the arc (with antialiasing)
    float radius = min(min(distance(first_cap_center, vec2(v_pixel_x, v_pixel_y)),
                           distance(second_cap_center, vec2(v_pixel_x, v_pixel_y))),
                       abs(v_pixel_y) + rect_addition);
    float aa_factor = f_delta(radius + v_pixel_x); // Antialiasing factor
    float shade = 1.0 - smoothstep(edge - aa_factor, edge, radius);
    
    // Recalculate the width of the shadow so it's wider below the path
    float shadow_width = (scaled_shadow_width / 2.0) * (1.0 - smoothstep(-start_cap_radius, start_cap_radius, v_pixel_y)) + (scaled_shadow_width / 2.0);
    
    // Calculate the alpha, such that the fill is 1.0 and the edge is SHADOW_ALPHA (with antialiasing)
    float alpha_y_to_edge = 1.0 - scaled_smoothstep(edge - aa_factor, edge, radius, 0.0, 1.0 - SHADOW_ALPHA);
    
    // Subtract the alpha beyond the edge to fade out the shadow
    float alpha_y = alpha_y_to_edge - smoothstep(edge - aa_factor, edge, radius) * scaled_smoothstep(edge, edge + shadow_width, radius, 0.0, SHADOW_ALPHA);

    // Calculate the alpha as a factor of the arc's length (where it is fully opaque by the middle)
    float alpha_x = scaled_smoothstep(rect_start_x, u_total_length / 2.0, v_pixel_x, ARC_START_ALPHA, 1.0);
    
    // Multiply the alpha along X by the alpha along Y to get our final alpha across both X and Y
    float alpha = alpha_x * alpha_y;
    gl_FragColor = vec4(shade, shade, shade, 1.0) * alpha;
}


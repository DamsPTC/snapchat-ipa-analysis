#include <metal_stdlib>
#include <metal_common>
#include <metal_math>
using namespace metal;

// Vertex to fragment interface
struct V2F {
    float4 gl_Position [[ position ]];
    float2 v_pixel;
};

vertex V2F dashedPathVertex(device const float4* a_pos_array [[ buffer(0) ]],
                            uint vertexId [[ vertex_id ]]) {
    const float4 a_pos = a_pos_array[vertexId];
    V2F out;
    out.gl_Position = float4(a_pos[0], a_pos[1], 0.0, 1.0);
    out.v_pixel = float2(a_pos[2], a_pos[3]);
    return out;
}


// Fragment Output
struct FragmentOutput {
    float4 gl_FragColor [[color(0)]];
};

fragment FragmentOutput dashedPathFragment(V2F in [[stage_in]],
                                           device const float& u_total_length [[ buffer(0) ]],
                                           device const float& u_dash_width [[ buffer(1) ]],
                                           device const float& u_dash_length [[ buffer(2) ]],
                                           device const float& u_gap_length [[ buffer(3) ]],
                                           device const float& u_shadow_width [[ buffer(4) ]])
{
    const float SHADOW_ALPHA = 0.1;
    // The starting x-pixel of the dash immediately preceding this fragment
    float closest_dash_start = floor(in.v_pixel.x / (u_dash_length + u_gap_length)) * (u_dash_length + u_gap_length);
    
    if (closest_dash_start + u_dash_length > u_total_length) {
        // Don't draw the last dash
        discard_fragment();
    }
    
    float x_offset = in.v_pixel.x - closest_dash_start;
    float rect_start_x = u_shadow_width + u_dash_width;
    float rect_end_x = u_dash_length - u_shadow_width - u_dash_width;
    
    float2 first_cap_center = float2(rect_start_x, 0.0);
    float2 second_cap_center = float2(rect_end_x, 0.0);
    float rect_addition = 2.0 * u_dash_width * abs(floor((x_offset - rect_start_x) / (rect_end_x - rect_start_x)));
    
    float radius = min(min(distance(first_cap_center, float2(x_offset, in.v_pixel.y)),
                       distance(second_cap_center, float2(x_offset, in.v_pixel.y))),
                       abs(in.v_pixel.y) + rect_addition);
    float aa_factor = fwidth(radius + in.v_pixel.x); // Antialiasing factor
    float shade = 1.0 - smoothstep(u_dash_width - aa_factor, u_dash_width, radius);
    
    float base_alpha = shade * (1.0 - SHADOW_ALPHA) + SHADOW_ALPHA * (1.0 - smoothstep(u_dash_width, rect_start_x, radius));
    float smoothed_x = 0.3 * smoothstep(0.0, u_total_length, in.v_pixel.x) + 0.7;
    float alpha = base_alpha * smoothed_x; // Make line transparent -> opaque from start -> end
    
    FragmentOutput out;
    out.gl_FragColor = float4(shade, shade, shade, 1.0) * alpha;
    return out;
}

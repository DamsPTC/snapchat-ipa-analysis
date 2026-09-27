#include <metal_stdlib>
#include <metal_common>
#include <metal_math>
using namespace metal;

struct V2F {
    float4 gl_Position [[ position ]];
    float2 v_texCoord;
};

vertex V2F spriteVertex(device const float2* a_pos_array [[ buffer(0) ]],
                        device const float2& u_scale [[ buffer(1) ]],
                        device const float2& u_translate [[ buffer(2) ]],
                        device const float2& u_anchor_point [[ buffer(3) ]],
                        device const float2& u_rotate [[ buffer(4) ]],
                        uint vertexId [[ vertex_id ]]) {
    V2F out;
    float2 a_pos = a_pos_array[vertexId];
    float2 normalized_anchor = u_anchor_point * 2.0 - 1.0;
    out.gl_Position = float4(a_pos - normalized_anchor, 0.0, 1.0);

    // u_rotate[0] = sin(theta), u_rotate[1] = cos(theta)
    float x = out.gl_Position.x * u_rotate[1] - out.gl_Position.y * u_rotate[0];
    float y = out.gl_Position.x * u_rotate[0] + out.gl_Position.y * u_rotate[1];
    out.gl_Position.xy = float2(x, y) * u_scale + u_translate;

    out.v_texCoord = (a_pos + 1.0) / 2.0;
    return out;
}

fragment float4 spriteFragment(V2F in [[stage_in]],
                               device const float& u_alpha [[ buffer(0) ]],
                               texture2d<half> u_sprite_texture [[ texture(0) ]]) {
    constexpr sampler textureSampler(mag_filter::linear, min_filter::linear);
    float4 sprite = (float4)u_sprite_texture.sample(textureSampler, in.v_texCoord);
    return sprite * u_alpha;
}

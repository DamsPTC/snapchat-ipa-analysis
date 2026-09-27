#pragma once
//SG_REFLECTION_BEGIN(100)
//SG_REFLECTION_END
#if defined VERTEX_SHADER
#elif defined FRAGMENT_SHADER // #if defined VERTEX_SHADER
#include <required2.glsl>
#include <std2_vs.glsl>
#include <std2_fs.glsl>
#include <std2_texture.glsl>
uniform float debugMode;
float interleavedGradientNoise()
{
return fract(52.982918*fract(dot(gl_FragCoord.xy,vec2(0.067110561,0.0058371499))));
}
#endif // #elif defined FRAGMENT_SHADER // #if defined VERTEX_SHADER

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "required2.metal"
#include "std2_texture.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//output vec4 fragColor 0
//sampler sampler shadowPrepassTextureSmp 2:27
//texture texture2D shadowPrepassTexture 2:13:2:27
//ubo float UserUniforms 2:28:80 {
//float4 searchParamResultsSize 0
//float4 colorInputSize 16
//float4 aoBufferTextureSize 32
//float3 cameraPosition 48
//float distanceNormalizationScale 64
//bool stochasticEnabled 68
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 searchParamResultsSize;
float4 colorInputSize;
float4 aoBufferTextureSize;
float3 cameraPosition;
float distanceNormalizationScale;
int stochasticEnabled;
};
#ifndef sc_UseFragDepth
#define sc_UseFragDepth 0
#elif sc_UseFragDepth==1
#undef sc_UseFragDepth
#define sc_UseFragDepth 1
#endif
struct sc_Set2
{
texture2d<float> shadowPrepassTexture [[id(13)]];
sampler shadowPrepassTextureSmp [[id(27)]];
constant userUniformsObj* UserUniforms [[id(28)]];
};
struct sc_VertOut
{
sc_SysOut sc_sysOut;
};
struct sc_VertIn
{
sc_SysAttributes sc_sysAttributes;
};
vertex sc_VertOut main_vert(sc_VertIn sc_vertIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],uint gl_InstanceIndex [[instance_id]],uint gl_VertexIndex [[vertex_id]])
{
sc_SysIn sc_sysIn;
sc_sysIn.sc_sysAttributes=sc_vertIn.sc_sysAttributes;
sc_sysIn.gl_VertexIndex=gl_VertexIndex;
sc_sysIn.gl_InstanceIndex=gl_InstanceIndex;
sc_VertOut sc_vertOut={};
float4 param=float4(sc_sysIn.sc_sysAttributes.position.xy,0.0,1.0);
sc_SetClipPosition(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 searchParamResultsSize;
float4 colorInputSize;
float4 aoBufferTextureSize;
float3 cameraPosition;
float distanceNormalizationScale;
int stochasticEnabled;
};
#ifndef sc_UseFragDepth
#define sc_UseFragDepth 0
#elif sc_UseFragDepth==1
#undef sc_UseFragDepth
#define sc_UseFragDepth 1
#endif
struct sc_Set2
{
texture2d<float> shadowPrepassTexture [[id(13)]];
sampler shadowPrepassTextureSmp [[id(27)]];
constant userUniformsObj* UserUniforms [[id(28)]];
};
struct sc_FragOut
{
float4 fragColor [[color(0)]];
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
};
float lray_readShadowPrepassTexture(thread const int2& screenPos,thread texture2d<float> shadowPrepassTexture,thread sampler shadowPrepassTextureSmp)
{
return shadowPrepassTexture.read(uint2(screenPos),0).x;
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
bool stochastic_reflections=false;
int2 screenPos=int2(sc_GetGlFragCoord(sc_fragIn.sc_sysIn,sc_set0,sc_set1).xy);
int2 param=screenPos;
float shadowPrepass=lray_readShadowPrepassTexture(param,sc_set2.shadowPrepassTexture,sc_set2.shadowPrepassTextureSmp);
if (shadowPrepass==(-1000.0))
{
sc_fragOut.fragColor=float4(1.0);
}
else
{
if (shadowPrepass==1000.0)
{
sc_fragOut.fragColor=float4(1.0,1.0,0.0,1.0);
}
else
{
sc_fragOut.fragColor=float4(abs(shadowPrepass),0.0,0.0,1.0);
}
}
return sc_fragOut;
}
} // FRAGMENT SHADER

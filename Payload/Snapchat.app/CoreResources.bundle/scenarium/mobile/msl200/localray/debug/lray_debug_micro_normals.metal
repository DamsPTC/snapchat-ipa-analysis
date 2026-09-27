#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "required2.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//output vec4 color 0
//sampler sampler microNormalsSmp 2:18
//texture texture2D microNormals 2:4:2:18
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
texture2d<float> microNormals [[id(4)]];
sampler microNormalsSmp [[id(18)]];
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
sc_vertOut.sc_sysOut.varPackedTex=float4(sc_sysIn.sc_sysAttributes.texture0.x,sc_sysIn.sc_sysAttributes.texture0.y,sc_vertOut.sc_sysOut.varPackedTex.z,sc_vertOut.sc_sysOut.varPackedTex.w);
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
texture2d<float> microNormals [[id(4)]];
sampler microNormalsSmp [[id(18)]];
constant userUniformsObj* UserUniforms [[id(28)]];
};
struct sc_FragOut
{
float4 color [[color(0)]];
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
};
float2 lray_readMicroNormals(thread const int2& screenPos,thread texture2d<float> microNormals,thread sampler microNormalsSmp)
{
return microNormals.read(uint2(screenPos),0).xy;
}
float3 decode_normal(thread const float2& f)
{
float3 n=float3(f.x,f.y,(1.0-abs(f.x))-abs(f.y));
float t=fast::max(-n.z,0.0);
float l9_0;
if (n.x>=0.0)
{
l9_0=-t;
}
else
{
l9_0=t;
}
float l9_1=l9_0;
float l9_2;
if (n.y>=0.0)
{
l9_2=-t;
}
else
{
l9_2=t;
}
float2 l9_3=n.xy+float2(l9_1,l9_2);
n=float3(l9_3.x,l9_3.y,n.z);
return normalize(n);
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
bool stochastic_reflections=false;
int2 p=int2(sc_GetGlFragCoord(sc_fragIn.sc_sysIn,sc_set0,sc_set1).xy);
int2 param=p;
float2 raw=lray_readMicroNormals(param,sc_set2.microNormals,sc_set2.microNormalsSmp);
float2 param_1=raw;
float3 micro_normal=decode_normal(param_1);
sc_fragOut.color=float4((micro_normal*0.5)+float3(0.5),1.0);
return sc_fragOut;
}
} // FRAGMENT SHADER

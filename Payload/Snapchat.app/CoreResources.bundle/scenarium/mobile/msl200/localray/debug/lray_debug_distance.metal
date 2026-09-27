#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "required2.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//output vec4 fragColor 0
//sampler sampler hitDistanceSmp 2:17
//texture utexture2D hitDistance 2:3:2:17
//ubo float UserUniforms 2:28:64 {
//float4 searchParamResultsSize 0
//float4 colorInputSize 16
//float4 aoBufferTextureSize 32
//float distanceNormalizationScale 48
//float sceneMagnitude 52
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 searchParamResultsSize;
float4 colorInputSize;
float4 aoBufferTextureSize;
float distanceNormalizationScale;
float sceneMagnitude;
};
struct sc_Set2
{
texture2d<uint> hitDistance [[id(3)]];
sampler hitDistanceSmp [[id(17)]];
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
float4 param=float4(sc_sysIn.sc_sysAttributes.position.xy,-1.0,1.0);
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
float distanceNormalizationScale;
float sceneMagnitude;
};
struct sc_Set2
{
texture2d<uint> hitDistance [[id(3)]];
sampler hitDistanceSmp [[id(17)]];
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
uint lray_readHitDistance(thread const int2& screenPos,thread texture2d<uint> hitDistance,thread sampler hitDistanceSmp)
{
return hitDistance.read(uint2(screenPos),0).x;
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
int2 screenPos=int2(sc_GetGlFragCoord(sc_fragIn.sc_sysIn,sc_set0,sc_set1).xy);
int2 param=screenPos;
uint distance_raw=lray_readHitDistance(param,sc_set2.hitDistance,sc_set2.hitDistanceSmp);
if (distance_raw==4294967295u)
{
int2 m=(screenPos/int2(4))%int2(2);
float f=float(abs(m.x-m.y));
sc_fragOut.fragColor=float4(float3(f),1.0);
}
else
{
float _distance=float(distance_raw)/(*sc_set2.UserUniforms).distanceNormalizationScale;
float r=1.0-fract(_distance);
float g=1.0-fract(_distance*0.1);
float b=1.0-fract(_distance*0.0099999998);
sc_fragOut.fragColor=float4(r,g,b,1.0);
}
return sc_fragOut;
}
} // FRAGMENT SHADER

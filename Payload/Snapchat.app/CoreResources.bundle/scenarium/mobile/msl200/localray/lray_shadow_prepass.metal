#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "std2.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//output float pre_shadow 0
//sampler sampler shadowHitDistanceSmp 2:25
//sampler sampler shadowOriginAndMaskSmp 2:26
//texture utexture2D shadowHitDistance 2:11:2:25
//texture utexture2D shadowOriginAndMask 2:12:2:26
//ubo float UserUniforms 2:28:96 {
//float4 searchParamResultsSize 0
//float4 colorInputSize 16
//float4 aoBufferTextureSize 32
//float3 cameraPosition 48
//float distanceNormalizationScale 64
//bool stochasticEnabled 68
//float lightRadius 72
//float3 lightPos 80
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
float lightRadius;
float3 lightPos;
};
#ifndef sc_UseFragDepth
#define sc_UseFragDepth 0
#elif sc_UseFragDepth==1
#undef sc_UseFragDepth
#define sc_UseFragDepth 1
#endif
struct sc_Set2
{
texture2d<uint> shadowHitDistance [[id(11)]];
texture2d<uint> shadowOriginAndMask [[id(12)]];
sampler shadowHitDistanceSmp [[id(25)]];
sampler shadowOriginAndMaskSmp [[id(26)]];
constant userUniformsObj* UserUniforms [[id(28)]];
};
constant int2 g9_52[33]={ int2(0),int2(0,1),int2(0,-1),int2(-1,0),int2(1,0),int2(-1),int2(1),int2(-1,1),int2(1,-1),int2(2,-2),int2(-2,2),int2(2),int2(-2),int2(-3,-1),int2(-1,-3),int2(1,-3),int2(3,-1),int2(3,1),int2(1,3),int2(-1,3),int2(-3,1),int2(-2,-4),int2(0,-4),int2(2,-4),int2(-2,4),int2(0,4),int2(2,4),int2(-4,-2),int2(-4,0),int2(-4,2),int2(4,-2),int2(4,0),int2(4,2) };
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
float lightRadius;
float3 lightPos;
};
#ifndef sc_UseFragDepth
#define sc_UseFragDepth 0
#elif sc_UseFragDepth==1
#undef sc_UseFragDepth
#define sc_UseFragDepth 1
#endif
struct sc_Set2
{
texture2d<uint> shadowHitDistance [[id(11)]];
texture2d<uint> shadowOriginAndMask [[id(12)]];
sampler shadowHitDistanceSmp [[id(25)]];
sampler shadowOriginAndMaskSmp [[id(26)]];
constant userUniformsObj* UserUniforms [[id(28)]];
};
constant int2 g9_11[33]={ int2(0),int2(0,1),int2(0,-1),int2(-1,0),int2(1,0),int2(-1),int2(1),int2(-1,1),int2(1,-1),int2(2,-2),int2(-2,2),int2(2),int2(-2),int2(-3,-1),int2(-1,-3),int2(1,-3),int2(3,-1),int2(3,1),int2(1,3),int2(-1,3),int2(-3,1),int2(-2,-4),int2(0,-4),int2(2,-4),int2(-2,4),int2(0,4),int2(2,4),int2(-4,-2),int2(-4,0),int2(-4,2),int2(4,-2),int2(4,0),int2(4,2) };
struct sc_FragOut
{
float pre_shadow [[color(0)]];
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
};
uint4 lray_readshadowOriginAndMask(thread const int2& screenPos,thread texture2d<uint> shadowOriginAndMask,thread sampler shadowOriginAndMaskSmp)
{
return shadowOriginAndMask.read(uint2(screenPos),0);
}
uint lray_readShadowHitDistance(thread const int2& screenPos,thread texture2d<uint> shadowHitDistance,thread sampler shadowHitDistanceSmp)
{
return shadowHitDistance.read(uint2(screenPos),0).x;
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
bool stochastic_reflections=false;
int2 p=int2(gl_FragCoord.xy);
uint neighbor_count=0u;
float ratio_sum=0.0;
int2 param=p;
uint4 origins_and_mask=lray_readshadowOriginAndMask(param,sc_set2.shadowOriginAndMask,sc_set2.shadowOriginAndMaskSmp);
if (float2(as_type<half2>(origins_and_mask.w)).x==0.0)
{
sc_fragOut.pre_shadow=-1000.0;
return sc_fragOut;
}
int2 param_1=p;
uint raw_dist=lray_readShadowHitDistance(param_1,sc_set2.shadowHitDistance,sc_set2.shadowHitDistanceSmp);
float hitDist=float(raw_dist)/(*sc_set2.UserUniforms).distanceNormalizationScale;
float3 originPos=(float3(origins_and_mask.xyz)/(*sc_set0.LibraryUniforms).OriginNormalizationScale)+(*sc_set0.LibraryUniforms).OriginNormalizationOffset;
float3 originToLight=originPos-(*sc_set2.UserUniforms).lightPos;
float lightDist=length(originToLight)-(*sc_set2.UserUniforms).lightRadius;
originToLight/=float3(lightDist);
float ratio=hitDist/lightDist;
uint i=0u;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (i<33u)
{
int2 param_2=p+g9_11[i];
uint neighbor_raw_dist=lray_readShadowHitDistance(param_2,sc_set2.shadowHitDistance,sc_set2.shadowHitDistanceSmp);
if (neighbor_raw_dist==4294967295u)
{
i++;
continue;
}
int2 param_3=p+g9_11[i];
uint4 neighbor_origins_and_mask=lray_readshadowOriginAndMask(param_3,sc_set2.shadowOriginAndMask,sc_set2.shadowOriginAndMaskSmp);
float3 neighborPos=(float3(neighbor_origins_and_mask.xyz)/(*sc_set0.LibraryUniforms).OriginNormalizationScale)+(*sc_set0.LibraryUniforms).OriginNormalizationOffset;
float neighbor_lightDist=length(neighborPos-(*sc_set2.UserUniforms).lightPos)-(*sc_set2.UserUniforms).lightRadius;
if ((fast::max(lightDist,neighbor_lightDist)/fast::min(lightDist,neighbor_lightDist))>1.01)
{
i++;
continue;
}
float neighbor_hitDist=float(neighbor_raw_dist)/(*sc_set2.UserUniforms).distanceNormalizationScale;
float neighbor_ratio=neighbor_hitDist/neighbor_lightDist;
if ((neighbor_ratio<0.99000001)||(i==0u))
{
neighbor_count++;
ratio_sum+=neighbor_ratio;
}
i++;
continue;
}
else
{
break;
}
}
float ave_ratio=ratio_sum/float(neighbor_count);
float worldPenumbraRadius=((*sc_set2.UserUniforms).lightRadius*ave_ratio)/(1.0-ave_ratio);
if (neighbor_count<=1u)
{
sc_fragOut.pre_shadow=1000.0;
}
else
{
if (neighbor_count==33u)
{
sc_fragOut.pre_shadow=-1000.0;
}
else
{
float l9_0;
if (ratio<0.99000001)
{
l9_0=-worldPenumbraRadius;
}
else
{
l9_0=worldPenumbraRadius;
}
sc_fragOut.pre_shadow=l9_0;
}
}
return sc_fragOut;
}
} // FRAGMENT SHADER

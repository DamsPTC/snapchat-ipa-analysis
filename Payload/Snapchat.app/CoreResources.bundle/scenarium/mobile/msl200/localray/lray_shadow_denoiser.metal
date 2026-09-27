#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "std2.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//output float sbuffer 0
//sampler sampler shadowOriginAndMaskSmp 2:26
//sampler sampler shadowPrepassTextureSmp 2:27
//texture utexture2D shadowOriginAndMask 2:12:2:26
//texture texture2D shadowPrepassTexture 2:13:2:27
//ubo float UserUniforms 2:28:128 {
//float4 searchParamResultsSize 0
//float4 colorInputSize 16
//float4 aoBufferTextureSize 32
//float3 cameraPosition 48
//float distanceNormalizationScale 64
//bool stochasticEnabled 68
//float3 cameraPos 80
//float3 lightPos 96
//float sinFovHalf 112
//int camViewportHeight 116
//int FilterMaxRadius 120
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
float3 cameraPos;
float3 lightPos;
float sinFovHalf;
int camViewportHeight;
int FilterMaxRadius;
};
#ifndef sc_UseFragDepth
#define sc_UseFragDepth 0
#elif sc_UseFragDepth==1
#undef sc_UseFragDepth
#define sc_UseFragDepth 1
#endif
struct sc_Set2
{
texture2d<uint> shadowOriginAndMask [[id(12)]];
texture2d<float> shadowPrepassTexture [[id(13)]];
sampler shadowOriginAndMaskSmp [[id(26)]];
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
float3 cameraPos;
float3 lightPos;
float sinFovHalf;
int camViewportHeight;
int FilterMaxRadius;
};
#ifndef sc_UseFragDepth
#define sc_UseFragDepth 0
#elif sc_UseFragDepth==1
#undef sc_UseFragDepth
#define sc_UseFragDepth 1
#endif
struct sc_Set2
{
texture2d<uint> shadowOriginAndMask [[id(12)]];
texture2d<float> shadowPrepassTexture [[id(13)]];
sampler shadowOriginAndMaskSmp [[id(26)]];
sampler shadowPrepassTextureSmp [[id(27)]];
constant userUniformsObj* UserUniforms [[id(28)]];
};
constant float3 g9_23[266]={ float3(0.0),float3(0.0,1.0,1.0),float3(1.0,0.0,1.0),float3(-1.0,0.0,1.0),float3(0.0,-1.0,1.0),float3(1.0,1.0,1.4141999),float3(0.0,2.0,2.0),float3(-2.0,0.0,2.0),float3(2.0,0.0,2.0),float3(1.0,-2.0,2.2361),float3(-1.0,-2.0,2.2361),float3(-2.0,-1.0,2.2361),float3(2.0,-1.0,2.2361),float3(-1.0,2.0,2.2361),float3(-2.0,-2.0,2.8283999),float3(2.0,-2.0,2.8283999),float3(-2.0,2.0,2.8283999),float3(2.0,2.0,2.8283999),float3(0.0,-3.0,3.0),float3(3.0,0.0,3.0),float3(0.0,3.0,3.0),float3(-3.0,0.0,3.0),float3(-1.0,3.0,3.1623001),float3(3.0,1.0,3.1623001),float3(1.0,-3.0,3.1623001),float3(-2.0,3.0,3.6056001),float3(-2.0,-3.0,3.6056001),float3(3.0,-2.0,3.6056001),float3(3.0,2.0,3.6056001),float3(2.0,3.0,3.6056001),float3(2.0,-3.0,3.6056001),float3(4.0,0.0,4.0),float3(-4.0,0.0,4.0),float3(-4.0,1.0,4.1230998),float3(4.0,1.0,4.1230998),float3(1.0,4.0,4.1230998),float3(-1.0,-4.0,4.1230998),float3(-3.0,-3.0,4.2426),float3(-3.0,3.0,4.2426),float3(2.0,4.0,4.4720998),float3(4.0,-2.0,4.4720998),float3(-4.0,-2.0,4.4720998),float3(-4.0,2.0,4.4720998),float3(2.0,-4.0,4.4720998),float3(-4.0,-3.0,5.0),float3(4.0,3.0,5.0),float3(-3.0,4.0,5.0),float3(-1.0,-5.0,5.099),float3(-5.0,1.0,5.099),float3(1.0,5.0,5.099),float3(-1.0,5.0,5.099),float3(-5.0,-1.0,5.099),float3(5.0,-1.0,5.099),float3(2.0,-5.0,5.3852),float3(5.0,-2.0,5.3852),float3(2.0,5.0,5.3852),float3(-2.0,-5.0,5.3852),float3(-2.0,5.0,5.3852),float3(5.0,2.0,5.3852),float3(-4.0,-4.0,5.6568999),float3(4.0,-4.0,5.6568999),float3(3.0,-5.0,5.8309999),float3(3.0,5.0,5.8309999),float3(5.0,-3.0,5.8309999),float3(-5.0,-3.0,5.8309999),float3(-5.0,3.0,5.8309999),float3(-3.0,5.0,5.8309999),float3(-3.0,-5.0,5.8309999),float3(0.0,-6.0,6.0),float3(0.0,6.0,6.0),float3(-1.0,-6.0,6.0827999),float3(6.0,-1.0,6.0827999),float3(-1.0,6.0,6.0827999),float3(6.0,1.0,6.0827999),float3(-6.0,1.0,6.0827999),float3(2.0,-6.0,6.3246002),float3(6.0,2.0,6.3246002),float3(-6.0,-2.0,6.3246002),float3(-6.0,2.0,6.3246002),float3(5.0,4.0,6.4031),float3(-4.0,5.0,6.4031),float3(-3.0,-6.0,6.7082),float3(7.0,0.0,7.0),float3(-7.0,0.0,7.0),float3(1.0,7.0,7.0711002),float3(7.0,-1.0,7.0711002),float3(-1.0,7.0,7.0711002),float3(-7.0,-1.0,7.0711002),float3(5.0,5.0,7.0711002),float3(-5.0,-5.0,7.0711002),float3(1.0,-7.0,7.0711002),float3(4.0,6.0,7.2111001),float3(-4.0,6.0,7.2111001),float3(6.0,-4.0,7.2111001),float3(-6.0,4.0,7.2111001),float3(-7.0,2.0,7.2800999),float3(-2.0,7.0,7.2800999),float3(7.0,2.0,7.2800999),float3(2.0,7.0,7.2800999),float3(-7.0,-2.0,7.2800999),float3(3.0,-7.0,7.6157999),float3(-7.0,3.0,7.6157999),float3(-7.0,-3.0,7.6157999),float3(3.0,7.0,7.6157999),float3(-5.0,-6.0,7.8102002),float3(5.0,6.0,7.8102002),float3(6.0,-5.0,7.8102002),float3(6.0,5.0,7.8102002),float3(-6.0,5.0,7.8102002),float3(-8.0,0.0,8.0),float3(-7.0,-4.0,8.0622997),float3(1.0,-8.0,8.0622997),float3(7.0,-4.0,8.0622997),float3(-4.0,-7.0,8.0622997),float3(1.0,8.0,8.0622997),float3(4.0,-7.0,8.0622997),float3(-2.0,-8.0,8.2461996),float3(8.0,-2.0,8.2461996),float3(8.0,2.0,8.2461996),float3(6.0,-6.0,8.4853001),float3(-6.0,6.0,8.4853001),float3(8.0,3.0,8.5439997),float3(-3.0,-8.0,8.5439997),float3(-5.0,-7.0,8.6022997),float3(-7.0,5.0,8.6022997),float3(7.0,5.0,8.6022997),float3(-8.0,4.0,8.9442997),float3(8.0,-4.0,8.9442997),float3(4.0,-8.0,8.9442997),float3(4.0,8.0,8.9442997),float3(-4.0,8.0,8.9442997),float3(-8.0,-4.0,8.9442997),float3(0.0,9.0,9.0),float3(0.0,-9.0,9.0),float3(9.0,0.0,9.0),float3(-9.0,1.0,9.0553999),float3(-1.0,-9.0,9.0553999),float3(-6.0,7.0,9.2194996),float3(2.0,-9.0,9.2194996),float3(-9.0,-2.0,9.2194996),float3(-2.0,9.0,9.2194996),float3(-9.0,2.0,9.2194996),float3(-7.0,-6.0,9.2194996),float3(6.0,-7.0,9.2194996),float3(8.0,5.0,9.434),float3(-5.0,-8.0,9.434),float3(-5.0,8.0,9.434),float3(-3.0,9.0,9.4868002),float3(9.0,4.0,9.8488998),float3(4.0,9.0,9.8488998),float3(9.0,-4.0,9.8488998),float3(4.0,-9.0,9.8488998),float3(-9.0,-4.0,9.8488998),float3(-9.0,4.0,9.8488998),float3(7.0,7.0,9.8994999),float3(10.0,0.0,10.0),float3(-8.0,-6.0,10.0),float3(6.0,8.0,10.0),float3(1.0,10.0,10.0499),float3(10.0,-2.0,10.198),float3(-10.0,-2.0,10.198),float3(2.0,10.0,10.198),float3(10.0,2.0,10.198),float3(-5.0,9.0,10.2956),float3(-3.0,10.0,10.4403),float3(-7.0,-8.0,10.6301),float3(8.0,-7.0,10.6301),float3(7.0,8.0,10.6301),float3(10.0,4.0,10.7703),float3(-10.0,4.0,10.7703),float3(-6.0,-9.0,10.8167),float3(6.0,-9.0,10.8167),float3(-11.0,0.0,11.0),float3(-1.0,11.0,11.0454),float3(1.0,-11.0,11.0454),float3(11.0,1.0,11.0454),float3(-1.0,-11.0,11.0454),float3(5.0,-10.0,11.1803),float3(10.0,-5.0,11.1803),float3(-11.0,2.0,11.1803),float3(11.0,-2.0,11.1803),float3(2.0,11.0,11.1803),float3(-8.0,8.0,11.3137),float3(-8.0,-8.0,11.3137),float3(-3.0,-11.0,11.4018),float3(-9.0,7.0,11.4018),float3(-11.0,-3.0,11.4018),float3(9.0,-7.0,11.4018),float3(9.0,7.0,11.4018),float3(-10.0,-6.0,11.6619),float3(-10.0,6.0,11.6619),float3(6.0,10.0,11.6619),float3(-4.0,11.0,11.7047),float3(4.0,-11.0,11.7047),float3(-4.0,-11.0,11.7047),float3(4.0,11.0,11.7047),float3(-11.0,-4.0,11.7047),float3(1.0,12.0,12.0416),float3(-12.0,1.0,12.0416),float3(11.0,-5.0,12.083),float3(-5.0,-11.0,12.083),float3(-12.0,-2.0,12.1655),float3(-2.0,12.0,12.1655),float3(3.0,-12.0,12.3693),float3(-12.0,3.0,12.3693),float3(6.0,-11.0,12.53),float3(-6.0,11.0,12.53),float3(11.0,6.0,12.53),float3(12.0,4.0,12.6491),float3(9.0,-9.0,12.7279),float3(-9.0,9.0,12.7279),float3(-8.0,10.0,12.8062),float3(8.0,10.0,12.8062),float3(0.0,-13.0,13.0),float3(13.0,1.0,13.0384),float3(-11.0,-7.0,13.0384),float3(-7.0,-11.0,13.0384),float3(13.0,-2.0,13.1529),float3(-2.0,13.0,13.1529),float3(2.0,-13.0,13.1529),float3(9.0,-10.0,13.4536),float3(-13.0,-4.0,13.6015),float3(-4.0,13.0,13.6015),float3(13.0,4.0,13.6015),float3(-4.0,-13.0,13.6015),float3(4.0,-13.0,13.6015),float3(7.0,-12.0,13.8924),float3(5.0,13.0,13.9284),float3(-13.0,5.0,13.9284),float3(0.0,14.0,14.0),float3(14.0,0.0,14.0),float3(-14.0,-1.0,14.0357),float3(-14.0,1.0,14.0357),float3(-10.0,-10.0,14.1421),float3(10.0,10.0,14.1421),float3(11.0,9.0,14.2127),float3(-3.0,-14.0,14.3178),float3(-6.0,13.0,14.3178),float3(14.0,-3.0,14.3178),float3(3.0,14.0,14.3178),float3(12.0,-8.0,14.4222),float3(-12.0,-8.0,14.4222),float3(-12.0,8.0,14.4222),float3(-8.0,-12.0,14.4222),float3(-14.0,4.0,14.5602),float3(-13.0,-7.0,14.7648),float3(-13.0,7.0,14.7648),float3(7.0,13.0,14.7648),float3(13.0,-7.0,14.7648),float3(-10.0,-11.0,14.8661),float3(14.0,-5.0,14.8661),float3(-10.0,11.0,14.8661),float3(12.0,-9.0,15.0),float3(15.0,2.0,15.1327),float3(-14.0,-6.0,15.2315),float3(-6.0,-14.0,15.2315),float3(13.0,8.0,15.2643),float3(8.0,-13.0,15.2643),float3(-15.0,-3.0,15.2971),float3(3.0,-15.0,15.2971),float3(-15.0,3.0,15.2971),float3(3.0,15.0,15.2971),float3(-12.0,10.0,15.6205),float3(10.0,12.0,15.6205),float3(7.0,14.0,15.6525),float3(15.0,-5.0,15.8114) };
struct sc_FragOut
{
float sbuffer [[color(0)]];
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
};
uint4 lray_readshadowOriginAndMask(thread const int2& screenPos,thread texture2d<uint> shadowOriginAndMask,thread sampler shadowOriginAndMaskSmp)
{
return shadowOriginAndMask.read(uint2(screenPos),0);
}
float lray_readShadowPrepassTexture(thread const int2& screenPos,thread texture2d<float> shadowPrepassTexture,thread sampler shadowPrepassTextureSmp)
{
return shadowPrepassTexture.read(uint2(screenPos),0).x;
}
float applyProgressiveFilter(thread const int2& p,thread const uint& radius,thread const float3& originPos,thread const float& coverageWS,thread texture2d<uint> shadowOriginAndMask,thread sampler shadowOriginAndMaskSmp,constant userUniformsObj& UserUniforms,thread texture2d<float> shadowPrepassTexture,thread sampler shadowPrepassTextureSmp,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float3 originToLight=normalize(UserUniforms.lightPos-originPos);
float center_light_dist=length(UserUniforms.lightPos-originPos);
float numerator=0.0;
float denominator=0.0099999998;
int2 param=p+int2(0);
float neighbor_raw=lray_readShadowPrepassTexture(param,shadowPrepassTexture,shadowPrepassTextureSmp);
int2 param_1=p+int2(0);
uint4 neighbor_origins_and_mask=lray_readshadowOriginAndMask(param_1,shadowOriginAndMask,shadowOriginAndMaskSmp);
float l9_0;
uint i=0u;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (i<266u)
{
if (g9_23[i].z>float(radius))
{
break;
}
int2 param_2=p+int2(g9_23[(i+1u)%266u].xy);
float neighbor_raw_next=lray_readShadowPrepassTexture(param_2,shadowPrepassTexture,shadowPrepassTextureSmp);
int2 param_3=p+int2(g9_23[(i+1u)%266u].xy);
uint4 neighbor_origins_and_mask_next=lray_readshadowOriginAndMask(param_3,shadowOriginAndMask,shadowOriginAndMaskSmp);
float3 neighborPos=(float3(neighbor_origins_and_mask.xyz)/(*sc_set0.LibraryUniforms).OriginNormalizationScale)+(*sc_set0.LibraryUniforms).OriginNormalizationOffset;
float3 neighbor_originToLight=normalize(UserUniforms.lightPos-neighborPos);
float neighbor_lightDist=length(UserUniforms.lightPos-neighborPos);
float neighbor_value=0.0;
uint l9_1=neighbor_origins_and_mask.w;
bool l9_2=l9_1!=0u;
bool l9_3;
if (l9_2)
{
l9_3=(fast::max(center_light_dist,neighbor_lightDist)/fast::min(center_light_dist,neighbor_lightDist))<=1.01;
}
else
{
l9_3=l9_2;
}
bool l9_4;
if (l9_3)
{
l9_4=dot(neighbor_originToLight,originToLight)>=0.99000001;
}
else
{
l9_4=l9_3;
}
bool neighborValid=l9_4;
if (neighborValid)
{
l9_0=float(neighbor_raw<0.0);
}
else
{
l9_0=0.0;
}
neighbor_value=l9_0;
float fl=length(originPos-neighborPos);
float distFactor=((-fl)*fl)/coverageWS;
float r=pow(2.7182817,distFactor);
float w=neighborValid ? r : 0.0;
numerator+=(neighbor_value*w);
denominator+=w;
neighbor_raw=neighbor_raw_next;
neighbor_origins_and_mask=neighbor_origins_and_mask_next;
i++;
continue;
}
else
{
break;
}
}
return numerator/denominator;
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
bool stochastic_reflections=false;
int2 p=int2(gl_FragCoord.xy);
int2 param=p;
uint4 origins_and_mask=lray_readshadowOriginAndMask(param,sc_set2.shadowOriginAndMask,sc_set2.shadowOriginAndMaskSmp);
if (origins_and_mask.w==0u)
{
sc_fragOut.sbuffer=1.0;
return sc_fragOut;
}
int2 param_1=p;
float prepassResult=lray_readShadowPrepassTexture(param_1,sc_set2.shadowPrepassTexture,sc_set2.shadowPrepassTextureSmp);
if (abs(prepassResult)==1000.0)
{
sc_fragOut.sbuffer=(prepassResult==1000.0) ? 0.0 : 1.0;
}
else
{
float3 originPos=(float3(origins_and_mask.xyz)/(*sc_set0.LibraryUniforms).OriginNormalizationScale)+(*sc_set0.LibraryUniforms).OriginNormalizationOffset;
float depth=length((*sc_set2.UserUniforms).cameraPos-originPos);
uint finalFilterRadius=uint(ceil(0.69999999+(((abs(prepassResult)*(*sc_set2.UserUniforms).sinFovHalf)*float((*sc_set2.UserUniforms).camViewportHeight))/depth)));
finalFilterRadius=min(uint((*sc_set2.UserUniforms).FilterMaxRadius),finalFilterRadius);
int2 param_2=p;
uint param_3=finalFilterRadius;
float3 param_4=originPos;
float param_5=abs(prepassResult);
float filtered=applyProgressiveFilter(param_2,param_3,param_4,param_5,sc_set2.shadowOriginAndMask,sc_set2.shadowOriginAndMaskSmp,(*sc_set2.UserUniforms),sc_set2.shadowPrepassTexture,sc_set2.shadowPrepassTextureSmp,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
sc_fragOut.sbuffer=filtered;
}
return sc_fragOut;
}
} // FRAGMENT SHADER

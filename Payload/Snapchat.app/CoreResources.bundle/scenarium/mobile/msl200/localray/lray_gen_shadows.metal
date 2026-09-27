#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "std2.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//output uvec4 origin_and_mask 0
//output uint max_distance 2
//output vec2 direction 1
//sampler sampler receivers0Smp 2:20
//sampler sampler receivers1Smp 2:21
//texture utexture2D receivers0 2:6:2:20
//texture utexture2D receivers1 2:7:2:21
//ubo float UserUniforms 2:28:128 {
//float4 searchParamResultsSize 0
//float4 colorInputSize 16
//float4 aoBufferTextureSize 32
//float3 cameraPosition 48
//float distanceNormalizationScale 64
//bool stochasticEnabled 68
//float lightRadius 72
//float3 _posLightWS 80
//float4 lightDirectionAndAngle 96
//float _lightRange 112
//int _maskLight 116
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
float3 _posLightWS;
float4 lightDirectionAndAngle;
float _lightRange;
int _maskLight;
};
#ifndef sc_UseFragDepth
#define sc_UseFragDepth 0
#elif sc_UseFragDepth==1
#undef sc_UseFragDepth
#define sc_UseFragDepth 1
#endif
struct sc_Set2
{
texture2d<uint> receivers0 [[id(6)]];
texture2d<uint> receivers1 [[id(7)]];
sampler receivers0Smp [[id(20)]];
sampler receivers1Smp [[id(21)]];
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
float lightRadius;
float3 _posLightWS;
float4 lightDirectionAndAngle;
float _lightRange;
int _maskLight;
};
#ifndef sc_UseFragDepth
#define sc_UseFragDepth 0
#elif sc_UseFragDepth==1
#undef sc_UseFragDepth
#define sc_UseFragDepth 1
#endif
struct sc_Set2
{
texture2d<uint> receivers0 [[id(6)]];
texture2d<uint> receivers1 [[id(7)]];
sampler receivers0Smp [[id(20)]];
sampler receivers1Smp [[id(21)]];
constant userUniformsObj* UserUniforms [[id(28)]];
};
constant int g9_24[121]={ 97,44,122,224,200,243,80,27,69,245,4,158,192,21,88,63,110,124,156,190,35,131,74,236,143,179,165,209,0,220,95,118,211,10,103,55,129,14,42,239,145,48,175,230,33,188,215,249,76,101,184,61,19,82,167,65,90,116,25,154,228,133,198,112,251,137,152,241,46,171,205,86,29,162,222,6,203,126,194,2,141,59,12,120,71,52,99,40,23,78,217,105,234,177,247,213,148,181,232,114,160,67,186,93,135,38,107,16,84,173,207,253,31,150,8,50,169,196,226,139,57 };
constant int g9_25[169]={ 4,159,198,48,63,1,107,45,252,216,36,231,118,213,95,236,113,228,151,89,192,168,99,81,195,134,248,84,31,142,175,204,24,136,56,7,154,65,22,166,57,190,10,77,40,239,116,224,177,242,109,42,149,119,222,130,103,215,162,13,74,34,125,210,183,72,207,19,178,245,62,93,184,199,145,87,227,0,98,254,49,86,27,152,122,46,251,104,16,53,137,33,169,110,143,230,193,3,133,218,66,165,237,196,157,233,6,69,163,209,37,80,172,25,189,115,78,60,181,202,121,54,96,243,112,225,148,43,128,12,90,131,39,221,15,187,139,59,9,92,246,206,219,240,146,101,249,83,156,30,180,201,160,68,106,28,186,71,21,171,127,212,234,75,124,18,140,174,51 };
struct sc_FragOut
{
uint4 origin_and_mask [[color(0)]];
float2 direction [[color(1)]];
uint max_distance [[color(2)]];
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
};
uint4 lray_readReceivers0(thread const int2& screenPos,thread texture2d<uint> receivers0,thread sampler receivers0Smp)
{
return receivers0.read(uint2(screenPos),0);
}
uint4 lray_readReceivers1(thread const int2& screenPos,thread texture2d<uint> receivers1,thread sampler receivers1Smp)
{
return receivers1.read(uint2(screenPos),0);
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
float2 encode_normal(thread float3& d)
{
float l1norm=dot(abs(d),float3(1.0));
d/=float3(l1norm);
float t=fast::clamp(-d.z,0.0,1.0);
float2 ret=d.xy;
float l9_0;
if (d.x>=0.0)
{
l9_0=t;
}
else
{
l9_0=-t;
}
ret.x+=l9_0;
float l9_1;
if (d.y>=0.0)
{
l9_1=t;
}
else
{
l9_1=-t;
}
ret.y+=l9_1;
return ret;
}
float3 gen_ray(thread const float3& posLight,thread const int2& l2,thread const float3& posReceiver,constant userUniformsObj& UserUniforms)
{
float3 normal=normalize(posReceiver-posLight);
float3 temp=float3(0.0,0.0,1.0);
if (dot(normal,temp)<9.9999997e-05)
{
temp=float3(0.0,1.0,0.0);
}
float3 up=normalize(cross(normal,temp));
float3 perp=normalize(cross(normal,up));
int blue_x=l2.x%11;
int blue_y=l2.y%11;
int blue_index_angle=blue_x+(11*blue_y);
float theta=6.2831855*(float(g9_24[blue_index_angle])/255.0);
float sinTheta=sin(theta);
float cosTheta=cos(theta);
blue_x=l2.x%13;
blue_y=l2.y%13;
int blue_index_radius=blue_x+(13*blue_y);
float radius=sqrt(float(g9_25[blue_index_radius])/255.0)*UserUniforms.lightRadius;
float3x3 W=float3x3(float3(0.0,-normal.z,normal.y),float3(normal.z,0.0,-normal.x),float3(-normal.y,normal.x,0.0));
float3x3 I=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
float3x3 l9_0=W*sinTheta;
float3x3 l9_1=float3x3(I[0]+l9_0[0],I[1]+l9_0[1],I[2]+l9_0[2]);
float3x3 l9_2=(W*W)*(1.0-cosTheta);
float3x3 rotationMat=float3x3(l9_1[0]+l9_2[0],l9_1[1]+l9_2[1],l9_1[2]+l9_2[2]);
up*=rotationMat;
perp*=rotationMat;
float3 ray=normalize(((posLight+(perp*(radius*0.70710671)))+(up*(radius*0.70710671)))-posReceiver);
return ray;
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
bool stochastic_reflections=false;
int2 p=int2(sc_GetGlFragCoord(sc_fragIn.sc_sysIn,sc_set0,sc_set1).xy);
int2 param=p;
uint4 rec0u=lray_readReceivers0(param,sc_set2.receivers0,sc_set2.receivers0Smp);
int2 param_1=p;
uint4 rec1u=lray_readReceivers1(param_1,sc_set2.receivers1,sc_set2.receivers1Smp);
float2 rec1=float2(float2(as_type<half2>(rec1u.x)).x,float2(as_type<half2>(rec1u.y)).x);
float3 position=(float3(rec0u.xyz)*(*sc_set0.LibraryUniforms).OriginNormalizationScaleInv)+(*sc_set0.LibraryUniforms).OriginNormalizationOffset;
float2 param_2=rec1;
float3 normal=decode_normal(param_2);
float3 origin=position+float3(normal*0.0099999998);
uint3 l9_0=uint3((origin-(*sc_set0.LibraryUniforms).OriginNormalizationOffset)*(*sc_set0.LibraryUniforms).OriginNormalizationScale);
sc_fragOut.origin_and_mask=uint4(l9_0.x,l9_0.y,l9_0.z,sc_fragOut.origin_and_mask.w);
sc_fragOut.origin_and_mask.w=65535u;
bool l9_1=length((*sc_set2.UserUniforms).lightDirectionAndAngle.xyz)>0.0;
bool l9_2;
if (l9_1)
{
l9_2=(*sc_set2.UserUniforms).lightDirectionAndAngle.w==0.0;
}
else
{
l9_2=l9_1;
}
bool directionalLight=l9_2;
bool l9_3=length((*sc_set2.UserUniforms).lightDirectionAndAngle.xyz)>0.0;
bool l9_4;
if (l9_3)
{
l9_4=(*sc_set2.UserUniforms).lightDirectionAndAngle.w>0.0;
}
else
{
l9_4=l9_3;
}
bool spotLight=l9_4;
if (directionalLight)
{
bool shouldDiscard=dot(normal,(*sc_set2.UserUniforms).lightDirectionAndAngle.xyz)<0.0;
if (shouldDiscard)
{
sc_fragOut.max_distance=4294967295u;
sc_fragOut.origin_and_mask.w=0u;
return sc_fragOut;
}
float3 param_3=(*sc_set2.UserUniforms).lightDirectionAndAngle.xyz;
float2 l9_5=encode_normal(param_3);
sc_fragOut.direction=l9_5;
sc_fragOut.max_distance=4294967295u;
}
else
{
if (spotLight)
{
sc_fragOut.direction=float2(0.0);
sc_fragOut.max_distance=4294967295u;
}
else
{
float3 dir=(*sc_set2.UserUniforms)._posLightWS-origin;
float3 l9_6=normal;
float3 l9_7=dir;
bool l9_8=dot(l9_6,l9_7)<(-(*sc_set2.UserUniforms).lightRadius);
bool l9_9;
if (!l9_8)
{
bool l9_10=(*sc_set2.UserUniforms)._lightRange>0.0;
bool l9_11;
if (l9_10)
{
l9_11=length(dir)>(*sc_set2.UserUniforms)._lightRange;
}
else
{
l9_11=l9_10;
}
l9_9=l9_11;
}
else
{
l9_9=l9_8;
}
bool shouldDiscard_1=l9_9;
if (shouldDiscard_1)
{
sc_fragOut.max_distance=4294967295u;
sc_fragOut.origin_and_mask.w=0u;
return sc_fragOut;
}
sc_fragOut.max_distance=uint((length(dir)+(*sc_set2.UserUniforms).lightRadius)*(*sc_set2.UserUniforms).distanceNormalizationScale);
float3 param_4=(*sc_set2.UserUniforms)._posLightWS;
int2 param_5=p;
float3 param_6=origin;
float3 param_7=gen_ray(param_4,param_5,param_6,(*sc_set2.UserUniforms));
float2 l9_12=encode_normal(param_7);
sc_fragOut.direction=l9_12;
}
}
return sc_fragOut;
}
} // FRAGMENT SHADER

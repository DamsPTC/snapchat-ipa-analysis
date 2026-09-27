#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "std2.metal"
#include "std2_vs.metal"
#include "std2_fs.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler baseTexSmpSC 2:2
//sampler sampler prevTexSmpSC 2:3
//texture texture2D baseTex 2:0:2:2
//texture texture2D prevTex 2:1:2:3
//ubo float UserUniforms 2:4:272 {
//float4 baseTexSize 0
//float4 baseTexDims 16
//float4 baseTexView 32
//float3x3 baseTexTransform 48
//float4 baseTexUvMinMax 96
//float4 baseTexBorderColor 112
//float4 prevTexSize 128
//float4 prevTexDims 144
//float4 prevTexView 160
//float3x3 prevTexTransform 176
//float4 prevTexUvMinMax 224
//float4 prevTexBorderColor 240
//float uniBorderMixCoeff 256
//float2 RTSize 264
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 baseTexSize;
float4 baseTexDims;
float4 baseTexView;
float3x3 baseTexTransform;
float4 baseTexUvMinMax;
float4 baseTexBorderColor;
float4 prevTexSize;
float4 prevTexDims;
float4 prevTexView;
float3x3 prevTexTransform;
float4 prevTexUvMinMax;
float4 prevTexBorderColor;
float uniBorderMixCoeff;
float2 RTSize;
};
#ifndef baseTexHasSwappedViews
#define baseTexHasSwappedViews 0
#elif baseTexHasSwappedViews==1
#undef baseTexHasSwappedViews
#define baseTexHasSwappedViews 1
#endif
#ifndef baseTexLayout
#define baseTexLayout 0
#endif
#ifndef prevTexHasSwappedViews
#define prevTexHasSwappedViews 0
#elif prevTexHasSwappedViews==1
#undef prevTexHasSwappedViews
#define prevTexHasSwappedViews 1
#endif
#ifndef prevTexLayout
#define prevTexLayout 0
#endif
#ifndef baseTexUV
#define baseTexUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 0
#elif SC_USE_UV_TRANSFORM_baseTex==1
#undef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_baseTex
#define SC_SOFTWARE_WRAP_MODE_U_baseTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_baseTex
#define SC_SOFTWARE_WRAP_MODE_V_baseTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 0
#elif SC_USE_UV_MIN_MAX_baseTex==1
#undef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 0
#elif SC_USE_CLAMP_TO_BORDER_baseTex==1
#undef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 1
#endif
#ifndef prevTexUV
#define prevTexUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_prevTex
#define SC_USE_UV_TRANSFORM_prevTex 0
#elif SC_USE_UV_TRANSFORM_prevTex==1
#undef SC_USE_UV_TRANSFORM_prevTex
#define SC_USE_UV_TRANSFORM_prevTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_prevTex
#define SC_SOFTWARE_WRAP_MODE_U_prevTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_prevTex
#define SC_SOFTWARE_WRAP_MODE_V_prevTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_prevTex
#define SC_USE_UV_MIN_MAX_prevTex 0
#elif SC_USE_UV_MIN_MAX_prevTex==1
#undef SC_USE_UV_MIN_MAX_prevTex
#define SC_USE_UV_MIN_MAX_prevTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_prevTex
#define SC_USE_CLAMP_TO_BORDER_prevTex 0
#elif SC_USE_CLAMP_TO_BORDER_prevTex==1
#undef SC_USE_CLAMP_TO_BORDER_prevTex
#define SC_USE_CLAMP_TO_BORDER_prevTex 1
#endif
struct sc_Set2
{
texture2d<float> baseTex [[id(0)]];
texture2d<float> prevTex [[id(1)]];
sampler baseTexSmpSC [[id(2)]];
sampler prevTexSmpSC [[id(3)]];
constant userUniformsObj* UserUniforms [[id(4)]];
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
sc_Vertex_t v=sc_LoadVertexAttributes(sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
float2 l9_0=float2(((*sc_set2.UserUniforms).prevTexTransform*float3(v.texture0,1.0)).xy);
sc_vertOut.sc_sysOut.varPackedTex=float4(sc_vertOut.sc_sysOut.varPackedTex.x,sc_vertOut.sc_sysOut.varPackedTex.y,l9_0.x,l9_0.y);
v.position=float4((v.texture0*2.0)-float2(1.0),0.0,1.0);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 baseTexSize;
float4 baseTexDims;
float4 baseTexView;
float3x3 baseTexTransform;
float4 baseTexUvMinMax;
float4 baseTexBorderColor;
float4 prevTexSize;
float4 prevTexDims;
float4 prevTexView;
float3x3 prevTexTransform;
float4 prevTexUvMinMax;
float4 prevTexBorderColor;
float uniBorderMixCoeff;
float2 RTSize;
};
#ifndef baseTexHasSwappedViews
#define baseTexHasSwappedViews 0
#elif baseTexHasSwappedViews==1
#undef baseTexHasSwappedViews
#define baseTexHasSwappedViews 1
#endif
#ifndef baseTexLayout
#define baseTexLayout 0
#endif
#ifndef prevTexHasSwappedViews
#define prevTexHasSwappedViews 0
#elif prevTexHasSwappedViews==1
#undef prevTexHasSwappedViews
#define prevTexHasSwappedViews 1
#endif
#ifndef prevTexLayout
#define prevTexLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 0
#elif SC_USE_UV_TRANSFORM_baseTex==1
#undef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_baseTex
#define SC_SOFTWARE_WRAP_MODE_U_baseTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_baseTex
#define SC_SOFTWARE_WRAP_MODE_V_baseTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 0
#elif SC_USE_UV_MIN_MAX_baseTex==1
#undef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 0
#elif SC_USE_CLAMP_TO_BORDER_baseTex==1
#undef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_prevTex
#define SC_SOFTWARE_WRAP_MODE_U_prevTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_prevTex
#define SC_SOFTWARE_WRAP_MODE_V_prevTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_prevTex
#define SC_USE_UV_MIN_MAX_prevTex 0
#elif SC_USE_UV_MIN_MAX_prevTex==1
#undef SC_USE_UV_MIN_MAX_prevTex
#define SC_USE_UV_MIN_MAX_prevTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_prevTex
#define SC_USE_CLAMP_TO_BORDER_prevTex 0
#elif SC_USE_CLAMP_TO_BORDER_prevTex==1
#undef SC_USE_CLAMP_TO_BORDER_prevTex
#define SC_USE_CLAMP_TO_BORDER_prevTex 1
#endif
#ifndef baseTexUV
#define baseTexUV 0
#endif
#ifndef prevTexUV
#define prevTexUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_prevTex
#define SC_USE_UV_TRANSFORM_prevTex 0
#elif SC_USE_UV_TRANSFORM_prevTex==1
#undef SC_USE_UV_TRANSFORM_prevTex
#define SC_USE_UV_TRANSFORM_prevTex 1
#endif
struct sc_Set2
{
texture2d<float> baseTex [[id(0)]];
texture2d<float> prevTex [[id(1)]];
sampler baseTexSmpSC [[id(2)]];
sampler prevTexSmpSC [[id(3)]];
constant userUniformsObj* UserUniforms [[id(4)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
};
float2 baseTexGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.baseTexDims.xy;
}
int baseTexGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (baseTexHasSwappedViews)
{
result=1-sc_GetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
}
#else
{
result=sc_GetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
}
#endif
return result;
}
float2 putCoordsOnEdge(thread const float2& uv)
{
float2 a=uv-float2(0.5);
return float2(0.5)+(sign(a)*0.5);
}
float2 prevTexGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.prevTexDims.xy;
}
int prevTexGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (prevTexHasSwappedViews)
{
result=1-sc_GetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
}
#else
{
result=sc_GetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
}
#endif
return result;
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
float2 nearBorderXY=float2(fast::max(step(gl_FragCoord.x,1.0),step((*sc_set2.UserUniforms).RTSize.x-1.0,gl_FragCoord.x)),fast::max(step(gl_FragCoord.y,1.0),step((*sc_set2.UserUniforms).RTSize.y-1.0,gl_FragCoord.y)));
if (fast::max(nearBorderXY.x,nearBorderXY.y)<0.5)
{
discard_fragment();
}
float2 param=baseTexGetDims2D((*sc_set2.UserUniforms));
int param_1=baseTexLayout;
int param_2=baseTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=(int(SC_USE_UV_TRANSFORM_baseTex)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).baseTexTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex);
bool param_7=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
float4 param_8=(*sc_set2.UserUniforms).baseTexUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
float4 param_10=(*sc_set2.UserUniforms).baseTexBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.baseTex,sc_set2.baseTexSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 finColor=l9_0;
float2 param_12=sc_fragIn.sc_sysIn.varPackedTex.zw;
float2 edgeCoords=putCoordsOnEdge(param_12);
float2 prevCoords=mix(sc_fragIn.sc_sysIn.varPackedTex.zw,edgeCoords,nearBorderXY);
float2 param_13=prevTexGetDims2D((*sc_set2.UserUniforms));
int param_14=prevTexLayout;
int param_15=prevTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_16=prevCoords;
bool param_17=false;
float3x3 param_18=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_19=int2(SC_SOFTWARE_WRAP_MODE_U_prevTex,SC_SOFTWARE_WRAP_MODE_V_prevTex);
bool param_20=(int(SC_USE_UV_MIN_MAX_prevTex)!=0);
float4 param_21=(*sc_set2.UserUniforms).prevTexUvMinMax;
bool param_22=(int(SC_USE_CLAMP_TO_BORDER_prevTex)!=0);
float4 param_23=(*sc_set2.UserUniforms).prevTexBorderColor;
float param_24=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.prevTex,sc_set2.prevTexSmpSC,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23,param_24);
float4 l9_3=l9_2;
float4 prevTexSample=l9_2;
float4 prevColor=prevTexSample;
finColor=mix(finColor,prevColor,float4((*sc_set2.UserUniforms).uniBorderMixCoeff));
float4 param_25=finColor;
sc_writeFragData0(param_25,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

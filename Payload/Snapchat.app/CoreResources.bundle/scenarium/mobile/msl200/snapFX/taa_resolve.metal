#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "required2.metal"
#include "std2_vs.metal"
#include "std2_fs.metal"
#include "std2_texture.metal"
#include "std2_taa.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler sc_TAAColorTextureSmpSC 2:4
//sampler sampler sc_TAAHistoryTextureSmpSC 2:6
//sampler sampler sc_TAAMotionVectorTextureSmpSC 2:7
//texture texture2D sc_TAAColorTexture 2:0:2:4
//texture texture2D sc_TAAHistoryTexture 2:2:2:6
//texture texture2D sc_TAAMotionVectorTexture 2:3:2:7
//SG_REFLECTION_END

namespace SNAP_VS {
struct sc_VertOut
{
sc_SysOut sc_sysOut;
};
struct sc_VertIn
{
sc_SysAttributes sc_sysAttributes;
};
vertex sc_VertOut main_vert(sc_VertIn sc_vertIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],uint gl_InstanceIndex [[instance_id]])
{
sc_SysIn sc_sysIn;
sc_sysIn.sc_sysAttributes=sc_vertIn.sc_sysAttributes;
sc_sysIn.gl_VertexIndex=gl_VertexIndex;
sc_sysIn.gl_InstanceIndex=gl_InstanceIndex;
sc_VertOut sc_vertOut={};
sc_Vertex_t v=sc_LoadVertexAttributes(sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
v.position=float4(sc_sysIn.sc_sysAttributes.position.xy,0.0,1.0);
float2 l9_0=(v.position.xy*0.5)+float2(0.5);
sc_vertOut.sc_sysOut.varPackedTex=float4(l9_0.x,l9_0.y,sc_vertOut.sc_sysOut.varPackedTex.z,sc_vertOut.sc_sysOut.varPackedTex.w);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 sc_TAAColorTextureSize;
float4 sc_TAAColorTextureDims;
float4 sc_TAAColorTextureView;
float3x3 sc_TAAColorTextureTransform;
float4 sc_TAAColorTextureUvMinMax;
float4 sc_TAAColorTextureBorderColor;
float4 sc_TAAHistoryTextureSize;
float4 sc_TAAHistoryTextureDims;
float4 sc_TAAHistoryTextureView;
float3x3 sc_TAAHistoryTextureTransform;
float4 sc_TAAHistoryTextureUvMinMax;
float4 sc_TAAHistoryTextureBorderColor;
float4 sc_TAADepthTextureSize;
float4 sc_TAADepthTextureDims;
float4 sc_TAADepthTextureView;
float3x3 sc_TAADepthTextureTransform;
float4 sc_TAADepthTextureUvMinMax;
float4 sc_TAADepthTextureBorderColor;
float4 sc_TAAMotionVectorTextureSize;
float4 sc_TAAMotionVectorTextureDims;
float4 sc_TAAMotionVectorTextureView;
float3x3 sc_TAAMotionVectorTextureTransform;
float4 sc_TAAMotionVectorTextureUvMinMax;
float4 sc_TAAMotionVectorTextureBorderColor;
float colorWeight;
float historyWeight;
};
#ifndef sc_TAAColorTextureHasSwappedViews
#define sc_TAAColorTextureHasSwappedViews 0
#elif sc_TAAColorTextureHasSwappedViews==1
#undef sc_TAAColorTextureHasSwappedViews
#define sc_TAAColorTextureHasSwappedViews 1
#endif
#ifndef sc_TAAColorTextureLayout
#define sc_TAAColorTextureLayout 0
#endif
#ifndef sc_TAAHistoryTextureHasSwappedViews
#define sc_TAAHistoryTextureHasSwappedViews 0
#elif sc_TAAHistoryTextureHasSwappedViews==1
#undef sc_TAAHistoryTextureHasSwappedViews
#define sc_TAAHistoryTextureHasSwappedViews 1
#endif
#ifndef sc_TAAHistoryTextureLayout
#define sc_TAAHistoryTextureLayout 0
#endif
#ifndef sc_TAADepthTextureHasSwappedViews
#define sc_TAADepthTextureHasSwappedViews 0
#elif sc_TAADepthTextureHasSwappedViews==1
#undef sc_TAADepthTextureHasSwappedViews
#define sc_TAADepthTextureHasSwappedViews 1
#endif
#ifndef sc_TAADepthTextureLayout
#define sc_TAADepthTextureLayout 0
#endif
#ifndef sc_TAAMotionVectorTextureHasSwappedViews
#define sc_TAAMotionVectorTextureHasSwappedViews 0
#elif sc_TAAMotionVectorTextureHasSwappedViews==1
#undef sc_TAAMotionVectorTextureHasSwappedViews
#define sc_TAAMotionVectorTextureHasSwappedViews 1
#endif
#ifndef sc_TAAMotionVectorTextureLayout
#define sc_TAAMotionVectorTextureLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_sc_TAAColorTexture
#define SC_USE_UV_TRANSFORM_sc_TAAColorTexture 0
#elif SC_USE_UV_TRANSFORM_sc_TAAColorTexture==1
#undef SC_USE_UV_TRANSFORM_sc_TAAColorTexture
#define SC_USE_UV_TRANSFORM_sc_TAAColorTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_sc_TAAColorTexture
#define SC_SOFTWARE_WRAP_MODE_U_sc_TAAColorTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_sc_TAAColorTexture
#define SC_SOFTWARE_WRAP_MODE_V_sc_TAAColorTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_sc_TAAColorTexture
#define SC_USE_UV_MIN_MAX_sc_TAAColorTexture 0
#elif SC_USE_UV_MIN_MAX_sc_TAAColorTexture==1
#undef SC_USE_UV_MIN_MAX_sc_TAAColorTexture
#define SC_USE_UV_MIN_MAX_sc_TAAColorTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_sc_TAAColorTexture
#define SC_USE_CLAMP_TO_BORDER_sc_TAAColorTexture 0
#elif SC_USE_CLAMP_TO_BORDER_sc_TAAColorTexture==1
#undef SC_USE_CLAMP_TO_BORDER_sc_TAAColorTexture
#define SC_USE_CLAMP_TO_BORDER_sc_TAAColorTexture 1
#endif
#ifndef SC_USE_UV_TRANSFORM_sc_TAAMotionVectorTexture
#define SC_USE_UV_TRANSFORM_sc_TAAMotionVectorTexture 0
#elif SC_USE_UV_TRANSFORM_sc_TAAMotionVectorTexture==1
#undef SC_USE_UV_TRANSFORM_sc_TAAMotionVectorTexture
#define SC_USE_UV_TRANSFORM_sc_TAAMotionVectorTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_sc_TAAMotionVectorTexture
#define SC_SOFTWARE_WRAP_MODE_U_sc_TAAMotionVectorTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_sc_TAAMotionVectorTexture
#define SC_SOFTWARE_WRAP_MODE_V_sc_TAAMotionVectorTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_sc_TAAMotionVectorTexture
#define SC_USE_UV_MIN_MAX_sc_TAAMotionVectorTexture 0
#elif SC_USE_UV_MIN_MAX_sc_TAAMotionVectorTexture==1
#undef SC_USE_UV_MIN_MAX_sc_TAAMotionVectorTexture
#define SC_USE_UV_MIN_MAX_sc_TAAMotionVectorTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_sc_TAAMotionVectorTexture
#define SC_USE_CLAMP_TO_BORDER_sc_TAAMotionVectorTexture 0
#elif SC_USE_CLAMP_TO_BORDER_sc_TAAMotionVectorTexture==1
#undef SC_USE_CLAMP_TO_BORDER_sc_TAAMotionVectorTexture
#define SC_USE_CLAMP_TO_BORDER_sc_TAAMotionVectorTexture 1
#endif
#ifndef SC_USE_UV_TRANSFORM_sc_TAAHistoryTexture
#define SC_USE_UV_TRANSFORM_sc_TAAHistoryTexture 0
#elif SC_USE_UV_TRANSFORM_sc_TAAHistoryTexture==1
#undef SC_USE_UV_TRANSFORM_sc_TAAHistoryTexture
#define SC_USE_UV_TRANSFORM_sc_TAAHistoryTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_sc_TAAHistoryTexture
#define SC_SOFTWARE_WRAP_MODE_U_sc_TAAHistoryTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_sc_TAAHistoryTexture
#define SC_SOFTWARE_WRAP_MODE_V_sc_TAAHistoryTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_sc_TAAHistoryTexture
#define SC_USE_UV_MIN_MAX_sc_TAAHistoryTexture 0
#elif SC_USE_UV_MIN_MAX_sc_TAAHistoryTexture==1
#undef SC_USE_UV_MIN_MAX_sc_TAAHistoryTexture
#define SC_USE_UV_MIN_MAX_sc_TAAHistoryTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_sc_TAAHistoryTexture
#define SC_USE_CLAMP_TO_BORDER_sc_TAAHistoryTexture 0
#elif SC_USE_CLAMP_TO_BORDER_sc_TAAHistoryTexture==1
#undef SC_USE_CLAMP_TO_BORDER_sc_TAAHistoryTexture
#define SC_USE_CLAMP_TO_BORDER_sc_TAAHistoryTexture 1
#endif
#ifndef sc_TAAColorTextureUV
#define sc_TAAColorTextureUV 0
#endif
#ifndef sc_TAAHistoryTextureUV
#define sc_TAAHistoryTextureUV 0
#endif
#ifndef sc_TAADepthTextureUV
#define sc_TAADepthTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_sc_TAADepthTexture
#define SC_USE_UV_TRANSFORM_sc_TAADepthTexture 0
#elif SC_USE_UV_TRANSFORM_sc_TAADepthTexture==1
#undef SC_USE_UV_TRANSFORM_sc_TAADepthTexture
#define SC_USE_UV_TRANSFORM_sc_TAADepthTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_sc_TAADepthTexture
#define SC_SOFTWARE_WRAP_MODE_U_sc_TAADepthTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_sc_TAADepthTexture
#define SC_SOFTWARE_WRAP_MODE_V_sc_TAADepthTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_sc_TAADepthTexture
#define SC_USE_UV_MIN_MAX_sc_TAADepthTexture 0
#elif SC_USE_UV_MIN_MAX_sc_TAADepthTexture==1
#undef SC_USE_UV_MIN_MAX_sc_TAADepthTexture
#define SC_USE_UV_MIN_MAX_sc_TAADepthTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_sc_TAADepthTexture
#define SC_USE_CLAMP_TO_BORDER_sc_TAADepthTexture 0
#elif SC_USE_CLAMP_TO_BORDER_sc_TAADepthTexture==1
#undef SC_USE_CLAMP_TO_BORDER_sc_TAADepthTexture
#define SC_USE_CLAMP_TO_BORDER_sc_TAADepthTexture 1
#endif
#ifndef sc_TAAMotionVectorTextureUV
#define sc_TAAMotionVectorTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> sc_TAAColorTexture [[id(0)]];
texture2d<float> sc_TAAHistoryTexture [[id(2)]];
texture2d<float> sc_TAAMotionVectorTexture [[id(3)]];
sampler sc_TAAColorTextureSmpSC [[id(4)]];
sampler sc_TAAHistoryTextureSmpSC [[id(6)]];
sampler sc_TAAMotionVectorTextureSmpSC [[id(7)]];
constant userUniformsObj* UserUniforms [[id(8)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
};
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
float2 l9_0=(*sc_set2.UserUniforms).sc_TAAColorTextureDims.xy;
float2 l9_1=l9_0;
int l9_2;
#if (sc_TAAColorTextureHasSwappedViews)
{
l9_2=1-sc_GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
}
#else
{
l9_2=sc_GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
}
#endif
int l9_3=l9_2;
float2 param=l9_1;
int param_1=sc_TAAColorTextureLayout;
int param_2=l9_3;
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=(int(SC_USE_UV_TRANSFORM_sc_TAAColorTexture)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).sc_TAAColorTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_sc_TAAColorTexture,SC_SOFTWARE_WRAP_MODE_V_sc_TAAColorTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_sc_TAAColorTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).sc_TAAColorTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_sc_TAAColorTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).sc_TAAColorTextureBorderColor;
float param_11=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(sc_set2.sc_TAAColorTexture,sc_set2.sc_TAAColorTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_5=l9_4;
float4 sc_TAAColorTextureSample=l9_4;
float3 color=sc_TAAColorTextureSample.xyz;
float2 l9_6=(*sc_set2.UserUniforms).sc_TAAMotionVectorTextureDims.xy;
float2 l9_7=l9_6;
int l9_8;
#if (sc_TAAMotionVectorTextureHasSwappedViews)
{
l9_8=1-sc_GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
}
#else
{
l9_8=sc_GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
}
#endif
int l9_9=l9_8;
float2 param_12=l9_7;
int param_13=sc_TAAMotionVectorTextureLayout;
int param_14=l9_9;
float2 param_15=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_16=(int(SC_USE_UV_TRANSFORM_sc_TAAMotionVectorTexture)!=0);
float3x3 param_17=(*sc_set2.UserUniforms).sc_TAAMotionVectorTextureTransform;
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_sc_TAAMotionVectorTexture,SC_SOFTWARE_WRAP_MODE_V_sc_TAAMotionVectorTexture);
bool param_19=(int(SC_USE_UV_MIN_MAX_sc_TAAMotionVectorTexture)!=0);
float4 param_20=(*sc_set2.UserUniforms).sc_TAAMotionVectorTextureUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_sc_TAAMotionVectorTexture)!=0);
float4 param_22=(*sc_set2.UserUniforms).sc_TAAMotionVectorTextureBorderColor;
float param_23=0.0;
float4 l9_10=sc_SampleTextureBiasOrLevel(sc_set2.sc_TAAMotionVectorTexture,sc_set2.sc_TAAMotionVectorTextureSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_11=l9_10;
float4 sc_TAAMotionVectorTextureSample=l9_10;
float4 param_24=sc_TAAMotionVectorTextureSample;
float2 velocity=decodeMotionVector(param_24);
float2 historyUV=sc_fragIn.sc_sysIn.varPackedTex.xy-velocity;
float2 l9_12=(*sc_set2.UserUniforms).sc_TAAHistoryTextureDims.xy;
float2 l9_13=l9_12;
int l9_14;
#if (sc_TAAHistoryTextureHasSwappedViews)
{
l9_14=1-sc_GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
}
#else
{
l9_14=sc_GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
}
#endif
int l9_15=l9_14;
float2 param_25=l9_13;
int param_26=sc_TAAHistoryTextureLayout;
int param_27=l9_15;
float2 param_28=historyUV;
bool param_29=(int(SC_USE_UV_TRANSFORM_sc_TAAHistoryTexture)!=0);
float3x3 param_30=(*sc_set2.UserUniforms).sc_TAAHistoryTextureTransform;
int2 param_31=int2(SC_SOFTWARE_WRAP_MODE_U_sc_TAAHistoryTexture,SC_SOFTWARE_WRAP_MODE_V_sc_TAAHistoryTexture);
bool param_32=(int(SC_USE_UV_MIN_MAX_sc_TAAHistoryTexture)!=0);
float4 param_33=(*sc_set2.UserUniforms).sc_TAAHistoryTextureUvMinMax;
bool param_34=(int(SC_USE_CLAMP_TO_BORDER_sc_TAAHistoryTexture)!=0);
float4 param_35=(*sc_set2.UserUniforms).sc_TAAHistoryTextureBorderColor;
float param_36=0.0;
float4 l9_16=sc_SampleTextureBiasOrLevel(sc_set2.sc_TAAHistoryTexture,sc_set2.sc_TAAHistoryTextureSmpSC,param_25,param_26,param_27,param_28,param_29,param_30,param_31,param_32,param_33,param_34,param_35,param_36);
float4 l9_17=l9_16;
float4 sc_TAAHistoryTextureSample=l9_16;
float3 history=sc_TAAHistoryTextureSample.xyz;
float4 result=float4((history*(*sc_set2.UserUniforms).historyWeight)+(color*(*sc_set2.UserUniforms).colorWeight),1.0);
float4 param_37=fast::max(float4(0.0),result);
sc_writeFragData0(param_37,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

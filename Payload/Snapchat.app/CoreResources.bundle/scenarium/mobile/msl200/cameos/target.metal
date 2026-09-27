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
//sampler sampler alphaTextureSmpSC 2:2
//sampler sampler targetTextureSmpSC 2:3
//texture texture2D alphaTexture 2:0:2:2
//texture texture2D targetTexture 2:1:2:3
//ubo float UserUniforms 2:4:272 {
//float4 targetTextureSize 0
//float4 targetTextureDims 16
//float4 targetTextureView 32
//float3x3 targetTextureTransform 48
//float4 targetTextureUvMinMax 96
//float4 targetTextureBorderColor 112
//float4 alphaTextureSize 128
//float4 alphaTextureDims 144
//float4 alphaTextureView 160
//float3x3 alphaTextureTransform 176
//float4 alphaTextureUvMinMax 224
//float4 alphaTextureBorderColor 240
//float opacity 256
//float2 inverseScreenSize 264
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 targetTextureSize;
float4 targetTextureDims;
float4 targetTextureView;
float3x3 targetTextureTransform;
float4 targetTextureUvMinMax;
float4 targetTextureBorderColor;
float4 alphaTextureSize;
float4 alphaTextureDims;
float4 alphaTextureView;
float3x3 alphaTextureTransform;
float4 alphaTextureUvMinMax;
float4 alphaTextureBorderColor;
float opacity;
float2 inverseScreenSize;
};
#ifndef targetTextureHasSwappedViews
#define targetTextureHasSwappedViews 0
#elif targetTextureHasSwappedViews==1
#undef targetTextureHasSwappedViews
#define targetTextureHasSwappedViews 1
#endif
#ifndef targetTextureLayout
#define targetTextureLayout 0
#endif
#ifndef alphaTextureHasSwappedViews
#define alphaTextureHasSwappedViews 0
#elif alphaTextureHasSwappedViews==1
#undef alphaTextureHasSwappedViews
#define alphaTextureHasSwappedViews 1
#endif
#ifndef alphaTextureLayout
#define alphaTextureLayout 0
#endif
#ifndef ALPHA_PATCH
#define ALPHA_PATCH 0
#elif ALPHA_PATCH==1
#undef ALPHA_PATCH
#define ALPHA_PATCH 1
#endif
#ifndef targetTextureUV
#define targetTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_targetTexture
#define SC_USE_UV_TRANSFORM_targetTexture 0
#elif SC_USE_UV_TRANSFORM_targetTexture==1
#undef SC_USE_UV_TRANSFORM_targetTexture
#define SC_USE_UV_TRANSFORM_targetTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_targetTexture
#define SC_SOFTWARE_WRAP_MODE_U_targetTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_targetTexture
#define SC_SOFTWARE_WRAP_MODE_V_targetTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_targetTexture
#define SC_USE_UV_MIN_MAX_targetTexture 0
#elif SC_USE_UV_MIN_MAX_targetTexture==1
#undef SC_USE_UV_MIN_MAX_targetTexture
#define SC_USE_UV_MIN_MAX_targetTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_targetTexture
#define SC_USE_CLAMP_TO_BORDER_targetTexture 0
#elif SC_USE_CLAMP_TO_BORDER_targetTexture==1
#undef SC_USE_CLAMP_TO_BORDER_targetTexture
#define SC_USE_CLAMP_TO_BORDER_targetTexture 1
#endif
#ifndef alphaTextureUV
#define alphaTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_alphaTexture
#define SC_USE_UV_TRANSFORM_alphaTexture 0
#elif SC_USE_UV_TRANSFORM_alphaTexture==1
#undef SC_USE_UV_TRANSFORM_alphaTexture
#define SC_USE_UV_TRANSFORM_alphaTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_alphaTexture
#define SC_SOFTWARE_WRAP_MODE_U_alphaTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_alphaTexture
#define SC_SOFTWARE_WRAP_MODE_V_alphaTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_alphaTexture
#define SC_USE_UV_MIN_MAX_alphaTexture 0
#elif SC_USE_UV_MIN_MAX_alphaTexture==1
#undef SC_USE_UV_MIN_MAX_alphaTexture
#define SC_USE_UV_MIN_MAX_alphaTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_alphaTexture
#define SC_USE_CLAMP_TO_BORDER_alphaTexture 0
#elif SC_USE_CLAMP_TO_BORDER_alphaTexture==1
#undef SC_USE_CLAMP_TO_BORDER_alphaTexture
#define SC_USE_CLAMP_TO_BORDER_alphaTexture 1
#endif
struct sc_Set2
{
texture2d<float> alphaTexture [[id(0)]];
texture2d<float> targetTexture [[id(1)]];
sampler alphaTextureSmpSC [[id(2)]];
sampler targetTextureSmpSC [[id(3)]];
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
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 targetTextureSize;
float4 targetTextureDims;
float4 targetTextureView;
float3x3 targetTextureTransform;
float4 targetTextureUvMinMax;
float4 targetTextureBorderColor;
float4 alphaTextureSize;
float4 alphaTextureDims;
float4 alphaTextureView;
float3x3 alphaTextureTransform;
float4 alphaTextureUvMinMax;
float4 alphaTextureBorderColor;
float opacity;
float2 inverseScreenSize;
};
#ifndef targetTextureHasSwappedViews
#define targetTextureHasSwappedViews 0
#elif targetTextureHasSwappedViews==1
#undef targetTextureHasSwappedViews
#define targetTextureHasSwappedViews 1
#endif
#ifndef targetTextureLayout
#define targetTextureLayout 0
#endif
#ifndef alphaTextureHasSwappedViews
#define alphaTextureHasSwappedViews 0
#elif alphaTextureHasSwappedViews==1
#undef alphaTextureHasSwappedViews
#define alphaTextureHasSwappedViews 1
#endif
#ifndef alphaTextureLayout
#define alphaTextureLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_targetTexture
#define SC_USE_UV_TRANSFORM_targetTexture 0
#elif SC_USE_UV_TRANSFORM_targetTexture==1
#undef SC_USE_UV_TRANSFORM_targetTexture
#define SC_USE_UV_TRANSFORM_targetTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_targetTexture
#define SC_SOFTWARE_WRAP_MODE_U_targetTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_targetTexture
#define SC_SOFTWARE_WRAP_MODE_V_targetTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_targetTexture
#define SC_USE_UV_MIN_MAX_targetTexture 0
#elif SC_USE_UV_MIN_MAX_targetTexture==1
#undef SC_USE_UV_MIN_MAX_targetTexture
#define SC_USE_UV_MIN_MAX_targetTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_targetTexture
#define SC_USE_CLAMP_TO_BORDER_targetTexture 0
#elif SC_USE_CLAMP_TO_BORDER_targetTexture==1
#undef SC_USE_CLAMP_TO_BORDER_targetTexture
#define SC_USE_CLAMP_TO_BORDER_targetTexture 1
#endif
#ifndef ALPHA_PATCH
#define ALPHA_PATCH 0
#elif ALPHA_PATCH==1
#undef ALPHA_PATCH
#define ALPHA_PATCH 1
#endif
#ifndef SC_USE_UV_TRANSFORM_alphaTexture
#define SC_USE_UV_TRANSFORM_alphaTexture 0
#elif SC_USE_UV_TRANSFORM_alphaTexture==1
#undef SC_USE_UV_TRANSFORM_alphaTexture
#define SC_USE_UV_TRANSFORM_alphaTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_alphaTexture
#define SC_SOFTWARE_WRAP_MODE_U_alphaTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_alphaTexture
#define SC_SOFTWARE_WRAP_MODE_V_alphaTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_alphaTexture
#define SC_USE_UV_MIN_MAX_alphaTexture 0
#elif SC_USE_UV_MIN_MAX_alphaTexture==1
#undef SC_USE_UV_MIN_MAX_alphaTexture
#define SC_USE_UV_MIN_MAX_alphaTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_alphaTexture
#define SC_USE_CLAMP_TO_BORDER_alphaTexture 0
#elif SC_USE_CLAMP_TO_BORDER_alphaTexture==1
#undef SC_USE_CLAMP_TO_BORDER_alphaTexture
#define SC_USE_CLAMP_TO_BORDER_alphaTexture 1
#endif
#ifndef targetTextureUV
#define targetTextureUV 0
#endif
#ifndef alphaTextureUV
#define alphaTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> alphaTexture [[id(0)]];
texture2d<float> targetTexture [[id(1)]];
sampler alphaTextureSmpSC [[id(2)]];
sampler targetTextureSmpSC [[id(3)]];
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
float2 targetTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.targetTextureDims.xy;
}
int targetTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (targetTextureHasSwappedViews)
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
float2 alphaTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.alphaTextureDims.xy;
}
int alphaTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (alphaTextureHasSwappedViews)
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
float2 param=targetTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=targetTextureLayout;
int param_2=targetTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=(int(SC_USE_UV_TRANSFORM_targetTexture)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).targetTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_targetTexture,SC_SOFTWARE_WRAP_MODE_V_targetTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_targetTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).targetTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_targetTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).targetTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.targetTexture,sc_set2.targetTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 warpedColor=l9_0;
float alpha=1.0;
#if (ALPHA_PATCH)
{
float2 param_12=alphaTextureGetDims2D((*sc_set2.UserUniforms));
int param_13=alphaTextureLayout;
int param_14=alphaTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_15=gl_FragCoord.xy*(*sc_set2.UserUniforms).inverseScreenSize;
bool param_16=(int(SC_USE_UV_TRANSFORM_alphaTexture)!=0);
float3x3 param_17=(*sc_set2.UserUniforms).alphaTextureTransform;
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_alphaTexture,SC_SOFTWARE_WRAP_MODE_V_alphaTexture);
bool param_19=(int(SC_USE_UV_MIN_MAX_alphaTexture)!=0);
float4 param_20=(*sc_set2.UserUniforms).alphaTextureUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_alphaTexture)!=0);
float4 param_22=(*sc_set2.UserUniforms).alphaTextureBorderColor;
float param_23=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.alphaTexture,sc_set2.alphaTextureSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_3=l9_2;
alpha=l9_2.x;
}
#endif
float4 param_24=float4(warpedColor.xyz,(warpedColor.w*alpha)*(*sc_set2.UserUniforms).opacity);
sc_writeFragData0(param_24,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

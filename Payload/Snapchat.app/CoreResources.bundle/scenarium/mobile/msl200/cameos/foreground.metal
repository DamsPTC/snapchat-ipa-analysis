#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#include "std2.metal"
#include "std2_vs.metal"
#include "std2_fs.metal"
//SG_REFLECTION_BEGIN(100)
//attribute vec2 texture2 18
//sampler sampler bgTextureSmpSC 2:3
//sampler sampler fgAlphaTextureSmpSC 2:4
//sampler sampler fgTextureSmpSC 2:5
//texture texture2D bgTexture 2:0:2:3
//texture texture2D fgAlphaTexture 2:1:2:4
//texture texture2D fgTexture 2:2:2:5
//ubo float UserUniforms 2:6:400 {
//float4 fgTextureSize 0
//float4 fgTextureDims 16
//float4 fgTextureView 32
//float3x3 fgTextureTransform 48
//float4 fgTextureUvMinMax 96
//float4 fgTextureBorderColor 112
//float4 fgAlphaTextureSize 128
//float4 fgAlphaTextureDims 144
//float4 fgAlphaTextureView 160
//float3x3 fgAlphaTextureTransform 176
//float4 fgAlphaTextureUvMinMax 224
//float4 fgAlphaTextureBorderColor 240
//float4 bgTextureSize 256
//float4 bgTextureDims 272
//float4 bgTextureView 288
//float3x3 bgTextureTransform 304
//float4 bgTextureUvMinMax 352
//float4 bgTextureBorderColor 368
//float opacity 384
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 fgTextureSize;
float4 fgTextureDims;
float4 fgTextureView;
float3x3 fgTextureTransform;
float4 fgTextureUvMinMax;
float4 fgTextureBorderColor;
float4 fgAlphaTextureSize;
float4 fgAlphaTextureDims;
float4 fgAlphaTextureView;
float3x3 fgAlphaTextureTransform;
float4 fgAlphaTextureUvMinMax;
float4 fgAlphaTextureBorderColor;
float4 bgTextureSize;
float4 bgTextureDims;
float4 bgTextureView;
float3x3 bgTextureTransform;
float4 bgTextureUvMinMax;
float4 bgTextureBorderColor;
float opacity;
};
#ifndef fgTextureHasSwappedViews
#define fgTextureHasSwappedViews 0
#elif fgTextureHasSwappedViews==1
#undef fgTextureHasSwappedViews
#define fgTextureHasSwappedViews 1
#endif
#ifndef fgTextureLayout
#define fgTextureLayout 0
#endif
#ifndef fgAlphaTextureHasSwappedViews
#define fgAlphaTextureHasSwappedViews 0
#elif fgAlphaTextureHasSwappedViews==1
#undef fgAlphaTextureHasSwappedViews
#define fgAlphaTextureHasSwappedViews 1
#endif
#ifndef fgAlphaTextureLayout
#define fgAlphaTextureLayout 0
#endif
#ifndef bgTextureHasSwappedViews
#define bgTextureHasSwappedViews 0
#elif bgTextureHasSwappedViews==1
#undef bgTextureHasSwappedViews
#define bgTextureHasSwappedViews 1
#endif
#ifndef bgTextureLayout
#define bgTextureLayout 0
#endif
#ifndef ALPHA_EXISTS
#define ALPHA_EXISTS 0
#elif ALPHA_EXISTS==1
#undef ALPHA_EXISTS
#define ALPHA_EXISTS 1
#endif
#ifndef CUSTOM_BLENDING
#define CUSTOM_BLENDING 0
#elif CUSTOM_BLENDING==1
#undef CUSTOM_BLENDING
#define CUSTOM_BLENDING 1
#endif
#ifndef NONE_BLENDING
#define NONE_BLENDING 0
#elif NONE_BLENDING==1
#undef NONE_BLENDING
#define NONE_BLENDING 1
#endif
#ifndef MULTIPLY_BLENDING
#define MULTIPLY_BLENDING 0
#elif MULTIPLY_BLENDING==1
#undef MULTIPLY_BLENDING
#define MULTIPLY_BLENDING 1
#endif
#ifndef SCREEN_BLENDING
#define SCREEN_BLENDING 0
#elif SCREEN_BLENDING==1
#undef SCREEN_BLENDING
#define SCREEN_BLENDING 1
#endif
#ifndef LIGHTEN_BLENDING
#define LIGHTEN_BLENDING 0
#elif LIGHTEN_BLENDING==1
#undef LIGHTEN_BLENDING
#define LIGHTEN_BLENDING 1
#endif
#ifndef COLOR_DODGE_BLENDING
#define COLOR_DODGE_BLENDING 0
#elif COLOR_DODGE_BLENDING==1
#undef COLOR_DODGE_BLENDING
#define COLOR_DODGE_BLENDING 1
#endif
#ifndef OVERLAY_BLENDING
#define OVERLAY_BLENDING 0
#elif OVERLAY_BLENDING==1
#undef OVERLAY_BLENDING
#define OVERLAY_BLENDING 1
#endif
#ifndef SOFT_LIGHT_BLENDING
#define SOFT_LIGHT_BLENDING 0
#elif SOFT_LIGHT_BLENDING==1
#undef SOFT_LIGHT_BLENDING
#define SOFT_LIGHT_BLENDING 1
#endif
#ifndef ADDITION_BLENDING
#define ADDITION_BLENDING 0
#elif ADDITION_BLENDING==1
#undef ADDITION_BLENDING
#define ADDITION_BLENDING 1
#endif
#ifndef VIVID_LIGHT_BLENDING
#define VIVID_LIGHT_BLENDING 0
#elif VIVID_LIGHT_BLENDING==1
#undef VIVID_LIGHT_BLENDING
#define VIVID_LIGHT_BLENDING 1
#endif
#ifndef LINEAR_LIGHT_BLENDING
#define LINEAR_LIGHT_BLENDING 0
#elif LINEAR_LIGHT_BLENDING==1
#undef LINEAR_LIGHT_BLENDING
#define LINEAR_LIGHT_BLENDING 1
#endif
#ifndef HARD_LIGHT_BLENDING
#define HARD_LIGHT_BLENDING 0
#elif HARD_LIGHT_BLENDING==1
#undef HARD_LIGHT_BLENDING
#define HARD_LIGHT_BLENDING 1
#endif
#ifndef fgTextureUV
#define fgTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_fgTexture
#define SC_USE_UV_TRANSFORM_fgTexture 0
#elif SC_USE_UV_TRANSFORM_fgTexture==1
#undef SC_USE_UV_TRANSFORM_fgTexture
#define SC_USE_UV_TRANSFORM_fgTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_fgTexture
#define SC_SOFTWARE_WRAP_MODE_U_fgTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_fgTexture
#define SC_SOFTWARE_WRAP_MODE_V_fgTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_fgTexture
#define SC_USE_UV_MIN_MAX_fgTexture 0
#elif SC_USE_UV_MIN_MAX_fgTexture==1
#undef SC_USE_UV_MIN_MAX_fgTexture
#define SC_USE_UV_MIN_MAX_fgTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_fgTexture
#define SC_USE_CLAMP_TO_BORDER_fgTexture 0
#elif SC_USE_CLAMP_TO_BORDER_fgTexture==1
#undef SC_USE_CLAMP_TO_BORDER_fgTexture
#define SC_USE_CLAMP_TO_BORDER_fgTexture 1
#endif
#ifndef fgAlphaTextureUV
#define fgAlphaTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_fgAlphaTexture
#define SC_USE_UV_TRANSFORM_fgAlphaTexture 0
#elif SC_USE_UV_TRANSFORM_fgAlphaTexture==1
#undef SC_USE_UV_TRANSFORM_fgAlphaTexture
#define SC_USE_UV_TRANSFORM_fgAlphaTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_fgAlphaTexture
#define SC_SOFTWARE_WRAP_MODE_U_fgAlphaTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_fgAlphaTexture
#define SC_SOFTWARE_WRAP_MODE_V_fgAlphaTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_fgAlphaTexture
#define SC_USE_UV_MIN_MAX_fgAlphaTexture 0
#elif SC_USE_UV_MIN_MAX_fgAlphaTexture==1
#undef SC_USE_UV_MIN_MAX_fgAlphaTexture
#define SC_USE_UV_MIN_MAX_fgAlphaTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_fgAlphaTexture
#define SC_USE_CLAMP_TO_BORDER_fgAlphaTexture 0
#elif SC_USE_CLAMP_TO_BORDER_fgAlphaTexture==1
#undef SC_USE_CLAMP_TO_BORDER_fgAlphaTexture
#define SC_USE_CLAMP_TO_BORDER_fgAlphaTexture 1
#endif
#ifndef bgTextureUV
#define bgTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_bgTexture
#define SC_USE_UV_TRANSFORM_bgTexture 0
#elif SC_USE_UV_TRANSFORM_bgTexture==1
#undef SC_USE_UV_TRANSFORM_bgTexture
#define SC_USE_UV_TRANSFORM_bgTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_bgTexture
#define SC_SOFTWARE_WRAP_MODE_U_bgTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_bgTexture
#define SC_SOFTWARE_WRAP_MODE_V_bgTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_bgTexture
#define SC_USE_UV_MIN_MAX_bgTexture 0
#elif SC_USE_UV_MIN_MAX_bgTexture==1
#undef SC_USE_UV_MIN_MAX_bgTexture
#define SC_USE_UV_MIN_MAX_bgTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_bgTexture
#define SC_USE_CLAMP_TO_BORDER_bgTexture 0
#elif SC_USE_CLAMP_TO_BORDER_bgTexture==1
#undef SC_USE_CLAMP_TO_BORDER_bgTexture
#define SC_USE_CLAMP_TO_BORDER_bgTexture 1
#endif
struct sc_Set2
{
texture2d<float> bgTexture [[id(0)]];
texture2d<float> fgAlphaTexture [[id(1)]];
texture2d<float> fgTexture [[id(2)]];
sampler bgTextureSmpSC [[id(3)]];
sampler fgAlphaTextureSmpSC [[id(4)]];
sampler fgTextureSmpSC [[id(5)]];
constant userUniformsObj* UserUniforms [[id(6)]];
};
struct sc_VertOut
{
sc_SysOut sc_sysOut;
float2 varTex2 [[user(locn10)]];
};
struct sc_VertIn
{
sc_SysAttributes sc_sysAttributes;
float2 texture2 [[attribute(18)]];
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
sc_vertOut.varTex2=sc_vertIn.texture2;
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 fgTextureSize;
float4 fgTextureDims;
float4 fgTextureView;
float3x3 fgTextureTransform;
float4 fgTextureUvMinMax;
float4 fgTextureBorderColor;
float4 fgAlphaTextureSize;
float4 fgAlphaTextureDims;
float4 fgAlphaTextureView;
float3x3 fgAlphaTextureTransform;
float4 fgAlphaTextureUvMinMax;
float4 fgAlphaTextureBorderColor;
float4 bgTextureSize;
float4 bgTextureDims;
float4 bgTextureView;
float3x3 bgTextureTransform;
float4 bgTextureUvMinMax;
float4 bgTextureBorderColor;
float opacity;
};
#ifndef fgTextureHasSwappedViews
#define fgTextureHasSwappedViews 0
#elif fgTextureHasSwappedViews==1
#undef fgTextureHasSwappedViews
#define fgTextureHasSwappedViews 1
#endif
#ifndef fgTextureLayout
#define fgTextureLayout 0
#endif
#ifndef fgAlphaTextureHasSwappedViews
#define fgAlphaTextureHasSwappedViews 0
#elif fgAlphaTextureHasSwappedViews==1
#undef fgAlphaTextureHasSwappedViews
#define fgAlphaTextureHasSwappedViews 1
#endif
#ifndef fgAlphaTextureLayout
#define fgAlphaTextureLayout 0
#endif
#ifndef bgTextureHasSwappedViews
#define bgTextureHasSwappedViews 0
#elif bgTextureHasSwappedViews==1
#undef bgTextureHasSwappedViews
#define bgTextureHasSwappedViews 1
#endif
#ifndef bgTextureLayout
#define bgTextureLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_fgTexture
#define SC_USE_UV_TRANSFORM_fgTexture 0
#elif SC_USE_UV_TRANSFORM_fgTexture==1
#undef SC_USE_UV_TRANSFORM_fgTexture
#define SC_USE_UV_TRANSFORM_fgTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_fgTexture
#define SC_SOFTWARE_WRAP_MODE_U_fgTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_fgTexture
#define SC_SOFTWARE_WRAP_MODE_V_fgTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_fgTexture
#define SC_USE_UV_MIN_MAX_fgTexture 0
#elif SC_USE_UV_MIN_MAX_fgTexture==1
#undef SC_USE_UV_MIN_MAX_fgTexture
#define SC_USE_UV_MIN_MAX_fgTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_fgTexture
#define SC_USE_CLAMP_TO_BORDER_fgTexture 0
#elif SC_USE_CLAMP_TO_BORDER_fgTexture==1
#undef SC_USE_CLAMP_TO_BORDER_fgTexture
#define SC_USE_CLAMP_TO_BORDER_fgTexture 1
#endif
#ifndef ALPHA_EXISTS
#define ALPHA_EXISTS 0
#elif ALPHA_EXISTS==1
#undef ALPHA_EXISTS
#define ALPHA_EXISTS 1
#endif
#ifndef SC_USE_UV_TRANSFORM_fgAlphaTexture
#define SC_USE_UV_TRANSFORM_fgAlphaTexture 0
#elif SC_USE_UV_TRANSFORM_fgAlphaTexture==1
#undef SC_USE_UV_TRANSFORM_fgAlphaTexture
#define SC_USE_UV_TRANSFORM_fgAlphaTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_fgAlphaTexture
#define SC_SOFTWARE_WRAP_MODE_U_fgAlphaTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_fgAlphaTexture
#define SC_SOFTWARE_WRAP_MODE_V_fgAlphaTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_fgAlphaTexture
#define SC_USE_UV_MIN_MAX_fgAlphaTexture 0
#elif SC_USE_UV_MIN_MAX_fgAlphaTexture==1
#undef SC_USE_UV_MIN_MAX_fgAlphaTexture
#define SC_USE_UV_MIN_MAX_fgAlphaTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_fgAlphaTexture
#define SC_USE_CLAMP_TO_BORDER_fgAlphaTexture 0
#elif SC_USE_CLAMP_TO_BORDER_fgAlphaTexture==1
#undef SC_USE_CLAMP_TO_BORDER_fgAlphaTexture
#define SC_USE_CLAMP_TO_BORDER_fgAlphaTexture 1
#endif
#ifndef CUSTOM_BLENDING
#define CUSTOM_BLENDING 0
#elif CUSTOM_BLENDING==1
#undef CUSTOM_BLENDING
#define CUSTOM_BLENDING 1
#endif
#ifndef SC_USE_UV_TRANSFORM_bgTexture
#define SC_USE_UV_TRANSFORM_bgTexture 0
#elif SC_USE_UV_TRANSFORM_bgTexture==1
#undef SC_USE_UV_TRANSFORM_bgTexture
#define SC_USE_UV_TRANSFORM_bgTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_bgTexture
#define SC_SOFTWARE_WRAP_MODE_U_bgTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_bgTexture
#define SC_SOFTWARE_WRAP_MODE_V_bgTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_bgTexture
#define SC_USE_UV_MIN_MAX_bgTexture 0
#elif SC_USE_UV_MIN_MAX_bgTexture==1
#undef SC_USE_UV_MIN_MAX_bgTexture
#define SC_USE_UV_MIN_MAX_bgTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_bgTexture
#define SC_USE_CLAMP_TO_BORDER_bgTexture 0
#elif SC_USE_CLAMP_TO_BORDER_bgTexture==1
#undef SC_USE_CLAMP_TO_BORDER_bgTexture
#define SC_USE_CLAMP_TO_BORDER_bgTexture 1
#endif
#ifndef NONE_BLENDING
#define NONE_BLENDING 0
#elif NONE_BLENDING==1
#undef NONE_BLENDING
#define NONE_BLENDING 1
#endif
#ifndef MULTIPLY_BLENDING
#define MULTIPLY_BLENDING 0
#elif MULTIPLY_BLENDING==1
#undef MULTIPLY_BLENDING
#define MULTIPLY_BLENDING 1
#endif
#ifndef SCREEN_BLENDING
#define SCREEN_BLENDING 0
#elif SCREEN_BLENDING==1
#undef SCREEN_BLENDING
#define SCREEN_BLENDING 1
#endif
#ifndef LIGHTEN_BLENDING
#define LIGHTEN_BLENDING 0
#elif LIGHTEN_BLENDING==1
#undef LIGHTEN_BLENDING
#define LIGHTEN_BLENDING 1
#endif
#ifndef COLOR_DODGE_BLENDING
#define COLOR_DODGE_BLENDING 0
#elif COLOR_DODGE_BLENDING==1
#undef COLOR_DODGE_BLENDING
#define COLOR_DODGE_BLENDING 1
#endif
#ifndef OVERLAY_BLENDING
#define OVERLAY_BLENDING 0
#elif OVERLAY_BLENDING==1
#undef OVERLAY_BLENDING
#define OVERLAY_BLENDING 1
#endif
#ifndef SOFT_LIGHT_BLENDING
#define SOFT_LIGHT_BLENDING 0
#elif SOFT_LIGHT_BLENDING==1
#undef SOFT_LIGHT_BLENDING
#define SOFT_LIGHT_BLENDING 1
#endif
#ifndef ADDITION_BLENDING
#define ADDITION_BLENDING 0
#elif ADDITION_BLENDING==1
#undef ADDITION_BLENDING
#define ADDITION_BLENDING 1
#endif
#ifndef VIVID_LIGHT_BLENDING
#define VIVID_LIGHT_BLENDING 0
#elif VIVID_LIGHT_BLENDING==1
#undef VIVID_LIGHT_BLENDING
#define VIVID_LIGHT_BLENDING 1
#endif
#ifndef LINEAR_LIGHT_BLENDING
#define LINEAR_LIGHT_BLENDING 0
#elif LINEAR_LIGHT_BLENDING==1
#undef LINEAR_LIGHT_BLENDING
#define LINEAR_LIGHT_BLENDING 1
#endif
#ifndef HARD_LIGHT_BLENDING
#define HARD_LIGHT_BLENDING 0
#elif HARD_LIGHT_BLENDING==1
#undef HARD_LIGHT_BLENDING
#define HARD_LIGHT_BLENDING 1
#endif
#ifndef fgTextureUV
#define fgTextureUV 0
#endif
#ifndef fgAlphaTextureUV
#define fgAlphaTextureUV 0
#endif
#ifndef bgTextureUV
#define bgTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> bgTexture [[id(0)]];
texture2d<float> fgAlphaTexture [[id(1)]];
texture2d<float> fgTexture [[id(2)]];
sampler bgTextureSmpSC [[id(3)]];
sampler fgAlphaTextureSmpSC [[id(4)]];
sampler fgTextureSmpSC [[id(5)]];
constant userUniformsObj* UserUniforms [[id(6)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
float2 varTex2 [[user(locn10)]];
};
float2 fgTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.fgTextureDims.xy;
}
int fgTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (fgTextureHasSwappedViews)
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
float2 fgAlphaTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.fgAlphaTextureDims.xy;
}
int fgAlphaTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (fgAlphaTextureHasSwappedViews)
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
float2 bgTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.bgTextureDims.xy;
}
int bgTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (bgTextureHasSwappedViews)
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
float2 param=fgTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=fgTextureLayout;
int param_2=fgTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=(int(SC_USE_UV_TRANSFORM_fgTexture)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).fgTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_fgTexture,SC_SOFTWARE_WRAP_MODE_V_fgTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_fgTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).fgTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_fgTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).fgTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.fgTexture,sc_set2.fgTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 color=l9_0;
float3 fg=color.xyz;
float alpha;
#if (ALPHA_EXISTS)
{
float2 param_12=fgAlphaTextureGetDims2D((*sc_set2.UserUniforms));
int param_13=fgAlphaTextureLayout;
int param_14=fgAlphaTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_15=sc_fragIn.sc_sysIn.varPackedTex.zw;
bool param_16=(int(SC_USE_UV_TRANSFORM_fgAlphaTexture)!=0);
float3x3 param_17=(*sc_set2.UserUniforms).fgAlphaTextureTransform;
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_fgAlphaTexture,SC_SOFTWARE_WRAP_MODE_V_fgAlphaTexture);
bool param_19=(int(SC_USE_UV_MIN_MAX_fgAlphaTexture)!=0);
float4 param_20=(*sc_set2.UserUniforms).fgAlphaTextureUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_fgAlphaTexture)!=0);
float4 param_22=(*sc_set2.UserUniforms).fgAlphaTextureBorderColor;
float param_23=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.fgAlphaTexture,sc_set2.fgAlphaTextureSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_3=l9_2;
alpha=l9_2.x;
}
#else
{
alpha=color.w;
}
#endif
alpha*=(*sc_set2.UserUniforms).opacity;
float4 result;
#if (CUSTOM_BLENDING)
{
float2 param_24=bgTextureGetDims2D((*sc_set2.UserUniforms));
int param_25=bgTextureLayout;
int param_26=bgTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_27=sc_fragIn.varTex2;
bool param_28=(int(SC_USE_UV_TRANSFORM_bgTexture)!=0);
float3x3 param_29=(*sc_set2.UserUniforms).bgTextureTransform;
int2 param_30=int2(SC_SOFTWARE_WRAP_MODE_U_bgTexture,SC_SOFTWARE_WRAP_MODE_V_bgTexture);
bool param_31=(int(SC_USE_UV_MIN_MAX_bgTexture)!=0);
float4 param_32=(*sc_set2.UserUniforms).bgTextureUvMinMax;
bool param_33=(int(SC_USE_CLAMP_TO_BORDER_bgTexture)!=0);
float4 param_34=(*sc_set2.UserUniforms).bgTextureBorderColor;
float param_35=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(sc_set2.bgTexture,sc_set2.bgTextureSmpSC,param_24,param_25,param_26,param_27,param_28,param_29,param_30,param_31,param_32,param_33,param_34,param_35);
float4 l9_5=l9_4;
float3 bg=l9_4.xyz;
#if (NONE_BLENDING)
{
result=float4(mix(bg,fg,float3(alpha)),alpha);
}
#else
{
#if (MULTIPLY_BLENDING)
{
result=float4(mix(bg,bg*fg,float3(alpha)),alpha);
}
#else
{
#if (SCREEN_BLENDING)
{
result=float4(mix(bg,float3(1.0)-((float3(1.0)-bg)*(float3(1.0)-fg)),float3(alpha)),alpha);
}
#else
{
#if (LIGHTEN_BLENDING)
{
result=float4(mix(bg,fast::max(bg,fg),float3(alpha)),alpha);
}
#else
{
#if (COLOR_DODGE_BLENDING)
{
result=float4(mix(bg,bg/((float3(1.0)-fg)+float3(0.0099999998)),float3(alpha)),alpha);
}
#else
{
#if (OVERLAY_BLENDING)
{
float3 st=step(bg,float3(0.5));
float3 blendColor=mix(float3(1.0)-(((float3(1.0)-bg)*2.0)*(float3(1.0)-fg)),(bg*2.0)*fg,st);
result=float4(mix(bg,blendColor,float3(alpha)),alpha);
}
#else
{
#if (SOFT_LIGHT_BLENDING)
{
float3 blendColor_1=(fast::max(float3(1.0)-(fg*2.0),float3(0.0))*bg)*bg;
blendColor_1+=((fast::min(fg,float3(1.0)-fg)*2.0)*bg);
blendColor_1+=(fast::max((fg*2.0)-float3(1.0),float3(0.0))*sqrt(bg));
result=float4(mix(bg,blendColor_1,float3(alpha)),alpha);
}
#else
{
#if (ADDITION_BLENDING)
{
result=float4(mix(bg,fast::min(bg+fg,float3(1.0)),float3(alpha)),alpha);
}
#else
{
#if (VIVID_LIGHT_BLENDING)
{
float3 blendColor_2;
int i=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (i<3)
{
if (fg[i]>0.5)
{
blendColor_2[i]=bg[i]/((2.0*(1.0-fg[i]))+0.0039215689);
}
else
{
blendColor_2[i]=1.0-((1.0-bg[i])/((2.0*fg[i])+0.0039215689));
}
i++;
continue;
}
else
{
break;
}
}
result=float4(mix(bg,blendColor_2,float3(alpha)),alpha);
}
#else
{
#if (LINEAR_LIGHT_BLENDING)
{
result=float4(mix(bg,(bg+(fg*2.0))-float3(1.0),float3(alpha)),alpha);
}
#else
{
#if (HARD_LIGHT_BLENDING)
{
float3 st_1=step(fg,float3(0.5));
float3 blendColor_3=mix(float3(1.0)-(((float3(1.0)-bg)*2.0)*(float3(1.0)-fg)),(bg*2.0)*fg,st_1);
result=float4(mix(bg,blendColor_3,float3(alpha)),alpha);
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#else
{
result=float4(fg,alpha);
}
#endif
float4 param_36=result;
sc_writeFragData0(param_36,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

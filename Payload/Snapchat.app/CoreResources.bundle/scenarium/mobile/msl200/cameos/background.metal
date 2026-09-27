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
//sampler sampler bgTextureAlphaSmpSC 2:2
//sampler sampler bgTextureSmpSC 2:3
//texture texture2D bgTexture 2:0:2:3
//texture texture2D bgTextureAlpha 2:1:2:2
//ubo float UserUniforms 2:4:272 {
//float4 bgTextureSize 0
//float4 bgTextureDims 16
//float4 bgTextureView 32
//float3x3 bgTextureTransform 48
//float4 bgTextureUvMinMax 96
//float4 bgTextureBorderColor 112
//float4 bgTextureAlphaSize 128
//float4 bgTextureAlphaDims 144
//float4 bgTextureAlphaView 160
//float3x3 bgTextureAlphaTransform 176
//float4 bgTextureAlphaUvMinMax 224
//float4 bgTextureAlphaBorderColor 240
//float4 bgColor 256
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 bgTextureSize;
float4 bgTextureDims;
float4 bgTextureView;
float3x3 bgTextureTransform;
float4 bgTextureUvMinMax;
float4 bgTextureBorderColor;
float4 bgTextureAlphaSize;
float4 bgTextureAlphaDims;
float4 bgTextureAlphaView;
float3x3 bgTextureAlphaTransform;
float4 bgTextureAlphaUvMinMax;
float4 bgTextureAlphaBorderColor;
float4 bgColor;
};
#ifndef bgTextureHasSwappedViews
#define bgTextureHasSwappedViews 0
#elif bgTextureHasSwappedViews==1
#undef bgTextureHasSwappedViews
#define bgTextureHasSwappedViews 1
#endif
#ifndef bgTextureLayout
#define bgTextureLayout 0
#endif
#ifndef bgTextureAlphaHasSwappedViews
#define bgTextureAlphaHasSwappedViews 0
#elif bgTextureAlphaHasSwappedViews==1
#undef bgTextureAlphaHasSwappedViews
#define bgTextureAlphaHasSwappedViews 1
#endif
#ifndef bgTextureAlphaLayout
#define bgTextureAlphaLayout 0
#endif
#ifndef ALPHA_EXISTS
#define ALPHA_EXISTS 0
#elif ALPHA_EXISTS==1
#undef ALPHA_EXISTS
#define ALPHA_EXISTS 1
#endif
#ifndef TEXTURE_EXISTS
#define TEXTURE_EXISTS 0
#elif TEXTURE_EXISTS==1
#undef TEXTURE_EXISTS
#define TEXTURE_EXISTS 1
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
#ifndef bgTextureAlphaUV
#define bgTextureAlphaUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_bgTextureAlpha
#define SC_USE_UV_TRANSFORM_bgTextureAlpha 0
#elif SC_USE_UV_TRANSFORM_bgTextureAlpha==1
#undef SC_USE_UV_TRANSFORM_bgTextureAlpha
#define SC_USE_UV_TRANSFORM_bgTextureAlpha 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_bgTextureAlpha
#define SC_SOFTWARE_WRAP_MODE_U_bgTextureAlpha -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_bgTextureAlpha
#define SC_SOFTWARE_WRAP_MODE_V_bgTextureAlpha -1
#endif
#ifndef SC_USE_UV_MIN_MAX_bgTextureAlpha
#define SC_USE_UV_MIN_MAX_bgTextureAlpha 0
#elif SC_USE_UV_MIN_MAX_bgTextureAlpha==1
#undef SC_USE_UV_MIN_MAX_bgTextureAlpha
#define SC_USE_UV_MIN_MAX_bgTextureAlpha 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_bgTextureAlpha
#define SC_USE_CLAMP_TO_BORDER_bgTextureAlpha 0
#elif SC_USE_CLAMP_TO_BORDER_bgTextureAlpha==1
#undef SC_USE_CLAMP_TO_BORDER_bgTextureAlpha
#define SC_USE_CLAMP_TO_BORDER_bgTextureAlpha 1
#endif
struct sc_Set2
{
texture2d<float> bgTexture [[id(0)]];
texture2d<float> bgTextureAlpha [[id(1)]];
sampler bgTextureAlphaSmpSC [[id(2)]];
sampler bgTextureSmpSC [[id(3)]];
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
float4 bgTextureSize;
float4 bgTextureDims;
float4 bgTextureView;
float3x3 bgTextureTransform;
float4 bgTextureUvMinMax;
float4 bgTextureBorderColor;
float4 bgTextureAlphaSize;
float4 bgTextureAlphaDims;
float4 bgTextureAlphaView;
float3x3 bgTextureAlphaTransform;
float4 bgTextureAlphaUvMinMax;
float4 bgTextureAlphaBorderColor;
float4 bgColor;
};
#ifndef bgTextureHasSwappedViews
#define bgTextureHasSwappedViews 0
#elif bgTextureHasSwappedViews==1
#undef bgTextureHasSwappedViews
#define bgTextureHasSwappedViews 1
#endif
#ifndef bgTextureLayout
#define bgTextureLayout 0
#endif
#ifndef bgTextureAlphaHasSwappedViews
#define bgTextureAlphaHasSwappedViews 0
#elif bgTextureAlphaHasSwappedViews==1
#undef bgTextureAlphaHasSwappedViews
#define bgTextureAlphaHasSwappedViews 1
#endif
#ifndef bgTextureAlphaLayout
#define bgTextureAlphaLayout 0
#endif
#ifndef ALPHA_EXISTS
#define ALPHA_EXISTS 0
#elif ALPHA_EXISTS==1
#undef ALPHA_EXISTS
#define ALPHA_EXISTS 1
#endif
#ifndef SC_USE_UV_TRANSFORM_bgTextureAlpha
#define SC_USE_UV_TRANSFORM_bgTextureAlpha 0
#elif SC_USE_UV_TRANSFORM_bgTextureAlpha==1
#undef SC_USE_UV_TRANSFORM_bgTextureAlpha
#define SC_USE_UV_TRANSFORM_bgTextureAlpha 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_bgTextureAlpha
#define SC_SOFTWARE_WRAP_MODE_U_bgTextureAlpha -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_bgTextureAlpha
#define SC_SOFTWARE_WRAP_MODE_V_bgTextureAlpha -1
#endif
#ifndef SC_USE_UV_MIN_MAX_bgTextureAlpha
#define SC_USE_UV_MIN_MAX_bgTextureAlpha 0
#elif SC_USE_UV_MIN_MAX_bgTextureAlpha==1
#undef SC_USE_UV_MIN_MAX_bgTextureAlpha
#define SC_USE_UV_MIN_MAX_bgTextureAlpha 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_bgTextureAlpha
#define SC_USE_CLAMP_TO_BORDER_bgTextureAlpha 0
#elif SC_USE_CLAMP_TO_BORDER_bgTextureAlpha==1
#undef SC_USE_CLAMP_TO_BORDER_bgTextureAlpha
#define SC_USE_CLAMP_TO_BORDER_bgTextureAlpha 1
#endif
#ifndef TEXTURE_EXISTS
#define TEXTURE_EXISTS 0
#elif TEXTURE_EXISTS==1
#undef TEXTURE_EXISTS
#define TEXTURE_EXISTS 1
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
#ifndef bgTextureUV
#define bgTextureUV 0
#endif
#ifndef bgTextureAlphaUV
#define bgTextureAlphaUV 0
#endif
struct sc_Set2
{
texture2d<float> bgTexture [[id(0)]];
texture2d<float> bgTextureAlpha [[id(1)]];
sampler bgTextureAlphaSmpSC [[id(2)]];
sampler bgTextureSmpSC [[id(3)]];
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
float2 bgTextureAlphaGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.bgTextureAlphaDims.xy;
}
int bgTextureAlphaGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (bgTextureAlphaHasSwappedViews)
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
float alpha=1.0;
#if (ALPHA_EXISTS)
{
float2 param=bgTextureAlphaGetDims2D((*sc_set2.UserUniforms));
int param_1=bgTextureAlphaLayout;
int param_2=bgTextureAlphaGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.zw;
bool param_4=(int(SC_USE_UV_TRANSFORM_bgTextureAlpha)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).bgTextureAlphaTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_bgTextureAlpha,SC_SOFTWARE_WRAP_MODE_V_bgTextureAlpha);
bool param_7=(int(SC_USE_UV_MIN_MAX_bgTextureAlpha)!=0);
float4 param_8=(*sc_set2.UserUniforms).bgTextureAlphaUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_bgTextureAlpha)!=0);
float4 param_10=(*sc_set2.UserUniforms).bgTextureAlphaBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.bgTextureAlpha,sc_set2.bgTextureAlphaSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
alpha=l9_0.x;
}
#endif
float4 l9_2;
#if (TEXTURE_EXISTS)
{
float2 param_12=bgTextureGetDims2D((*sc_set2.UserUniforms));
int param_13=bgTextureLayout;
int param_14=bgTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_15=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_16=(int(SC_USE_UV_TRANSFORM_bgTexture)!=0);
float3x3 param_17=(*sc_set2.UserUniforms).bgTextureTransform;
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_bgTexture,SC_SOFTWARE_WRAP_MODE_V_bgTexture);
bool param_19=(int(SC_USE_UV_MIN_MAX_bgTexture)!=0);
float4 param_20=(*sc_set2.UserUniforms).bgTextureUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_bgTexture)!=0);
float4 param_22=(*sc_set2.UserUniforms).bgTextureBorderColor;
float param_23=0.0;
float4 l9_3=sc_SampleTextureBiasOrLevel(sc_set2.bgTexture,sc_set2.bgTextureSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_4=l9_3;
l9_2=float4(l9_3.xyz,alpha);
}
#else
{
l9_2=(*sc_set2.UserUniforms).bgColor;
}
#endif
float4 result=l9_2;
float4 param_24=result;
sc_writeFragData0(param_24,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

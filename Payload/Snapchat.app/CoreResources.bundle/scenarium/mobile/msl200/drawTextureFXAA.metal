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
//sampler sampler backTextureSmpSC 2:3
//sampler sampler inputTextureSmpSC 2:4
//sampler sampler maskTextureSmpSC 2:5
//texture texture2D backTexture 2:0:2:3
//texture texture2D inputTexture 2:1:2:4
//texture texture2D maskTexture 2:2:2:5
//ubo float UserUniforms 2:6:512 {
//float4 inputTextureSize 0
//float4 inputTextureDims 16
//float4 inputTextureView 32
//float3x3 inputTextureTransform 48
//float4 inputTextureUvMinMax 96
//float4 inputTextureBorderColor 112
//float4 maskTextureSize 128
//float4 maskTextureDims 144
//float4 maskTextureView 160
//float3x3 maskTextureTransform 176
//float4 maskTextureUvMinMax 224
//float4 maskTextureBorderColor 240
//float4 backTextureSize 256
//float4 backTextureDims 272
//float4 backTextureView 288
//float3x3 backTextureTransform 304
//float4 backTextureUvMinMax 352
//float4 backTextureBorderColor 368
//float3x3 maskTransform 384
//float3x3 backTransform 432
//float4 backColorMult 480
//float2 inputTextureScale 496
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 inputTextureSize;
float4 inputTextureDims;
float4 inputTextureView;
float3x3 inputTextureTransform;
float4 inputTextureUvMinMax;
float4 inputTextureBorderColor;
float4 maskTextureSize;
float4 maskTextureDims;
float4 maskTextureView;
float3x3 maskTextureTransform;
float4 maskTextureUvMinMax;
float4 maskTextureBorderColor;
float4 backTextureSize;
float4 backTextureDims;
float4 backTextureView;
float3x3 backTextureTransform;
float4 backTextureUvMinMax;
float4 backTextureBorderColor;
float3x3 maskTransform;
float3x3 backTransform;
float4 backColorMult;
float2 inputTextureScale;
};
#ifndef inputTextureHasSwappedViews
#define inputTextureHasSwappedViews 0
#elif inputTextureHasSwappedViews==1
#undef inputTextureHasSwappedViews
#define inputTextureHasSwappedViews 1
#endif
#ifndef inputTextureLayout
#define inputTextureLayout 0
#endif
#ifndef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 0
#elif maskTextureHasSwappedViews==1
#undef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 1
#endif
#ifndef maskTextureLayout
#define maskTextureLayout 0
#endif
#ifndef backTextureHasSwappedViews
#define backTextureHasSwappedViews 0
#elif backTextureHasSwappedViews==1
#undef backTextureHasSwappedViews
#define backTextureHasSwappedViews 1
#endif
#ifndef backTextureLayout
#define backTextureLayout 0
#endif
#ifndef FXAA
#define FXAA 0
#elif FXAA==1
#undef FXAA
#define FXAA 1
#endif
#ifndef MASK
#define MASK 0
#elif MASK==1
#undef MASK
#define MASK 1
#endif
#ifndef MASK_CHANNEL
#define MASK_CHANNEL 0
#endif
#ifndef inputTextureUV
#define inputTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_inputTexture
#define SC_USE_UV_TRANSFORM_inputTexture 0
#elif SC_USE_UV_TRANSFORM_inputTexture==1
#undef SC_USE_UV_TRANSFORM_inputTexture
#define SC_USE_UV_TRANSFORM_inputTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_inputTexture
#define SC_SOFTWARE_WRAP_MODE_U_inputTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_inputTexture
#define SC_SOFTWARE_WRAP_MODE_V_inputTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_inputTexture
#define SC_USE_UV_MIN_MAX_inputTexture 0
#elif SC_USE_UV_MIN_MAX_inputTexture==1
#undef SC_USE_UV_MIN_MAX_inputTexture
#define SC_USE_UV_MIN_MAX_inputTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_inputTexture
#define SC_USE_CLAMP_TO_BORDER_inputTexture 0
#elif SC_USE_CLAMP_TO_BORDER_inputTexture==1
#undef SC_USE_CLAMP_TO_BORDER_inputTexture
#define SC_USE_CLAMP_TO_BORDER_inputTexture 1
#endif
#ifndef maskTextureUV
#define maskTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_maskTexture
#define SC_USE_UV_TRANSFORM_maskTexture 0
#elif SC_USE_UV_TRANSFORM_maskTexture==1
#undef SC_USE_UV_TRANSFORM_maskTexture
#define SC_USE_UV_TRANSFORM_maskTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_maskTexture
#define SC_SOFTWARE_WRAP_MODE_U_maskTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_maskTexture
#define SC_SOFTWARE_WRAP_MODE_V_maskTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_maskTexture
#define SC_USE_UV_MIN_MAX_maskTexture 0
#elif SC_USE_UV_MIN_MAX_maskTexture==1
#undef SC_USE_UV_MIN_MAX_maskTexture
#define SC_USE_UV_MIN_MAX_maskTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_maskTexture
#define SC_USE_CLAMP_TO_BORDER_maskTexture 0
#elif SC_USE_CLAMP_TO_BORDER_maskTexture==1
#undef SC_USE_CLAMP_TO_BORDER_maskTexture
#define SC_USE_CLAMP_TO_BORDER_maskTexture 1
#endif
#ifndef backTextureUV
#define backTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_backTexture
#define SC_USE_UV_TRANSFORM_backTexture 0
#elif SC_USE_UV_TRANSFORM_backTexture==1
#undef SC_USE_UV_TRANSFORM_backTexture
#define SC_USE_UV_TRANSFORM_backTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_backTexture
#define SC_SOFTWARE_WRAP_MODE_U_backTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_backTexture
#define SC_SOFTWARE_WRAP_MODE_V_backTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_backTexture
#define SC_USE_UV_MIN_MAX_backTexture 0
#elif SC_USE_UV_MIN_MAX_backTexture==1
#undef SC_USE_UV_MIN_MAX_backTexture
#define SC_USE_UV_MIN_MAX_backTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_backTexture
#define SC_USE_CLAMP_TO_BORDER_backTexture 0
#elif SC_USE_CLAMP_TO_BORDER_backTexture==1
#undef SC_USE_CLAMP_TO_BORDER_backTexture
#define SC_USE_CLAMP_TO_BORDER_backTexture 1
#endif
struct sc_Set2
{
texture2d<float> backTexture [[id(0)]];
texture2d<float> inputTexture [[id(1)]];
texture2d<float> maskTexture [[id(2)]];
sampler backTextureSmpSC [[id(3)]];
sampler inputTextureSmpSC [[id(4)]];
sampler maskTextureSmpSC [[id(5)]];
constant userUniformsObj* UserUniforms [[id(6)]];
};
struct sc_VertOut
{
sc_SysOut sc_sysOut;
float4 varTexMaskAndBack [[user(locn10)]];
float4 varTex12 [[user(locn11)]];
float4 varTex34 [[user(locn12)]];
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
float3 origTex0=float3(v.texture0,1.0);
v.texture0=float2(((*sc_set2.UserUniforms).inputTextureTransform*origTex0).xy);
#if (FXAA)
{
float2 l9_0=v.texture0+(float2(-1.0)*(*sc_set2.UserUniforms).inputTextureScale);
sc_vertOut.varTex12=float4(l9_0.x,l9_0.y,sc_vertOut.varTex12.z,sc_vertOut.varTex12.w);
float2 l9_1=v.texture0+(float2(1.0,-1.0)*(*sc_set2.UserUniforms).inputTextureScale);
sc_vertOut.varTex12=float4(sc_vertOut.varTex12.x,sc_vertOut.varTex12.y,l9_1.x,l9_1.y);
float2 l9_2=v.texture0+(float2(-1.0,1.0)*(*sc_set2.UserUniforms).inputTextureScale);
sc_vertOut.varTex34=float4(l9_2.x,l9_2.y,sc_vertOut.varTex34.z,sc_vertOut.varTex34.w);
float2 l9_3=v.texture0+(float2(1.0)*(*sc_set2.UserUniforms).inputTextureScale);
sc_vertOut.varTex34=float4(sc_vertOut.varTex34.x,sc_vertOut.varTex34.y,l9_3.x,l9_3.y);
}
#endif
#if (MASK)
{
float2 l9_4=float2(((*sc_set2.UserUniforms).maskTransform*origTex0).xy);
sc_vertOut.varTexMaskAndBack=float4(l9_4.x,l9_4.y,sc_vertOut.varTexMaskAndBack.z,sc_vertOut.varTexMaskAndBack.w);
float2 l9_5=float2(((*sc_set2.UserUniforms).backTransform*origTex0).xy);
sc_vertOut.varTexMaskAndBack=float4(sc_vertOut.varTexMaskAndBack.x,sc_vertOut.varTexMaskAndBack.y,l9_5.x,l9_5.y);
}
#endif
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 inputTextureSize;
float4 inputTextureDims;
float4 inputTextureView;
float3x3 inputTextureTransform;
float4 inputTextureUvMinMax;
float4 inputTextureBorderColor;
float4 maskTextureSize;
float4 maskTextureDims;
float4 maskTextureView;
float3x3 maskTextureTransform;
float4 maskTextureUvMinMax;
float4 maskTextureBorderColor;
float4 backTextureSize;
float4 backTextureDims;
float4 backTextureView;
float3x3 backTextureTransform;
float4 backTextureUvMinMax;
float4 backTextureBorderColor;
float3x3 maskTransform;
float3x3 backTransform;
float4 backColorMult;
float2 inputTextureScale;
};
#ifndef inputTextureHasSwappedViews
#define inputTextureHasSwappedViews 0
#elif inputTextureHasSwappedViews==1
#undef inputTextureHasSwappedViews
#define inputTextureHasSwappedViews 1
#endif
#ifndef inputTextureLayout
#define inputTextureLayout 0
#endif
#ifndef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 0
#elif maskTextureHasSwappedViews==1
#undef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 1
#endif
#ifndef maskTextureLayout
#define maskTextureLayout 0
#endif
#ifndef backTextureHasSwappedViews
#define backTextureHasSwappedViews 0
#elif backTextureHasSwappedViews==1
#undef backTextureHasSwappedViews
#define backTextureHasSwappedViews 1
#endif
#ifndef backTextureLayout
#define backTextureLayout 0
#endif
#ifndef FXAA
#define FXAA 0
#elif FXAA==1
#undef FXAA
#define FXAA 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_inputTexture
#define SC_SOFTWARE_WRAP_MODE_U_inputTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_inputTexture
#define SC_SOFTWARE_WRAP_MODE_V_inputTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_inputTexture
#define SC_USE_UV_MIN_MAX_inputTexture 0
#elif SC_USE_UV_MIN_MAX_inputTexture==1
#undef SC_USE_UV_MIN_MAX_inputTexture
#define SC_USE_UV_MIN_MAX_inputTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_inputTexture
#define SC_USE_CLAMP_TO_BORDER_inputTexture 0
#elif SC_USE_CLAMP_TO_BORDER_inputTexture==1
#undef SC_USE_CLAMP_TO_BORDER_inputTexture
#define SC_USE_CLAMP_TO_BORDER_inputTexture 1
#endif
#ifndef MASK
#define MASK 0
#elif MASK==1
#undef MASK
#define MASK 1
#endif
#ifndef MASK_CHANNEL
#define MASK_CHANNEL 0
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_maskTexture
#define SC_SOFTWARE_WRAP_MODE_U_maskTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_maskTexture
#define SC_SOFTWARE_WRAP_MODE_V_maskTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_maskTexture
#define SC_USE_UV_MIN_MAX_maskTexture 0
#elif SC_USE_UV_MIN_MAX_maskTexture==1
#undef SC_USE_UV_MIN_MAX_maskTexture
#define SC_USE_UV_MIN_MAX_maskTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_maskTexture
#define SC_USE_CLAMP_TO_BORDER_maskTexture 0
#elif SC_USE_CLAMP_TO_BORDER_maskTexture==1
#undef SC_USE_CLAMP_TO_BORDER_maskTexture
#define SC_USE_CLAMP_TO_BORDER_maskTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_backTexture
#define SC_SOFTWARE_WRAP_MODE_U_backTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_backTexture
#define SC_SOFTWARE_WRAP_MODE_V_backTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_backTexture
#define SC_USE_UV_MIN_MAX_backTexture 0
#elif SC_USE_UV_MIN_MAX_backTexture==1
#undef SC_USE_UV_MIN_MAX_backTexture
#define SC_USE_UV_MIN_MAX_backTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_backTexture
#define SC_USE_CLAMP_TO_BORDER_backTexture 0
#elif SC_USE_CLAMP_TO_BORDER_backTexture==1
#undef SC_USE_CLAMP_TO_BORDER_backTexture
#define SC_USE_CLAMP_TO_BORDER_backTexture 1
#endif
#ifndef inputTextureUV
#define inputTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_inputTexture
#define SC_USE_UV_TRANSFORM_inputTexture 0
#elif SC_USE_UV_TRANSFORM_inputTexture==1
#undef SC_USE_UV_TRANSFORM_inputTexture
#define SC_USE_UV_TRANSFORM_inputTexture 1
#endif
#ifndef maskTextureUV
#define maskTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_maskTexture
#define SC_USE_UV_TRANSFORM_maskTexture 0
#elif SC_USE_UV_TRANSFORM_maskTexture==1
#undef SC_USE_UV_TRANSFORM_maskTexture
#define SC_USE_UV_TRANSFORM_maskTexture 1
#endif
#ifndef backTextureUV
#define backTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_backTexture
#define SC_USE_UV_TRANSFORM_backTexture 0
#elif SC_USE_UV_TRANSFORM_backTexture==1
#undef SC_USE_UV_TRANSFORM_backTexture
#define SC_USE_UV_TRANSFORM_backTexture 1
#endif
struct sc_Set2
{
texture2d<float> backTexture [[id(0)]];
texture2d<float> inputTexture [[id(1)]];
texture2d<float> maskTexture [[id(2)]];
sampler backTextureSmpSC [[id(3)]];
sampler inputTextureSmpSC [[id(4)]];
sampler maskTextureSmpSC [[id(5)]];
constant userUniformsObj* UserUniforms [[id(6)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
float4 varTexMaskAndBack [[user(locn10)]];
float4 varTex12 [[user(locn11)]];
float4 varTex34 [[user(locn12)]];
};
float2 inputTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.inputTextureDims.xy;
}
int inputTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (inputTextureHasSwappedViews)
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
float2 maskTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.maskTextureDims.xy;
}
int maskTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (maskTextureHasSwappedViews)
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
float2 backTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.backTextureDims.xy;
}
int backTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (backTextureHasSwappedViews)
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
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float4 result=float4(0.0);
#if (FXAA)
{
float FXAA_SPAN_MAX=8.0;
float FXAA_REDUCE_MUL=0.125;
float FXAA_REDUCE_MIN=0.0078125;
float2 param=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=inputTextureLayout;
int param_2=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.varTex12.xy;
bool param_4=false;
float3x3 param_5=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 inputTextureSample=l9_0;
float3 rgbNW=inputTextureSample.xyz;
float2 param_12=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_13=inputTextureLayout;
int param_14=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_15=sc_fragIn.varTex12.zw;
bool param_16=false;
float3x3 param_17=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_19=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_20=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_22=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_23=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_3=l9_2;
float4 inputTextureSample_1=l9_2;
float3 rgbNE=inputTextureSample_1.xyz;
float2 param_24=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_25=inputTextureLayout;
int param_26=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_27=sc_fragIn.varTex34.xy;
bool param_28=false;
float3x3 param_29=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_30=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_31=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_32=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_33=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_34=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_35=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param_24,param_25,param_26,param_27,param_28,param_29,param_30,param_31,param_32,param_33,param_34,param_35);
float4 l9_5=l9_4;
float4 inputTextureSample_2=l9_4;
float3 rgbSW=inputTextureSample_2.xyz;
float2 param_36=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_37=inputTextureLayout;
int param_38=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_39=sc_fragIn.varTex34.zw;
bool param_40=false;
float3x3 param_41=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_42=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_43=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_44=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_45=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_46=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_47=0.0;
float4 l9_6=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param_36,param_37,param_38,param_39,param_40,param_41,param_42,param_43,param_44,param_45,param_46,param_47);
float4 l9_7=l9_6;
float4 inputTextureSample_3=l9_6;
float3 rgbSE=inputTextureSample_3.xyz;
float2 param_48=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_49=inputTextureLayout;
int param_50=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_51=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_52=false;
float3x3 param_53=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_54=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_55=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_56=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_57=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_58=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_59=0.0;
float4 l9_8=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param_48,param_49,param_50,param_51,param_52,param_53,param_54,param_55,param_56,param_57,param_58,param_59);
float4 l9_9=l9_8;
float4 inputTextureSample_4=l9_8;
float3 rgbM=inputTextureSample_4.xyz;
float3 luma=float3(0.29899999,0.58700001,0.114);
float lumaNW=dot(rgbNW,luma);
float lumaNE=dot(rgbNE,luma);
float lumaSW=dot(rgbSW,luma);
float lumaSE=dot(rgbSE,luma);
float lumaM=dot(rgbM,luma);
float lumaMin=fast::min(lumaM,fast::min(fast::min(lumaNW,lumaNE),fast::min(lumaSW,lumaSE)));
float lumaMax=fast::max(lumaM,fast::max(fast::max(lumaNW,lumaNE),fast::max(lumaSW,lumaSE)));
float2 dir;
dir.x=-((lumaNW+lumaNE)-(lumaSW+lumaSE));
dir.y=(lumaNW+lumaSW)-(lumaNE+lumaSE);
float dirReduce=fast::max((((lumaNW+lumaNE)+lumaSW)+lumaSE)*(0.25*FXAA_REDUCE_MUL),FXAA_REDUCE_MIN);
float rcpDirMin=1.0/(fast::min(abs(dir.x),abs(dir.y))+dirReduce);
dir=fast::min(float2(FXAA_SPAN_MAX,FXAA_SPAN_MAX),fast::max(float2(-FXAA_SPAN_MAX,-FXAA_SPAN_MAX),dir*rcpDirMin))*(*sc_set2.UserUniforms).inputTextureScale;
float2 param_60=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_61=inputTextureLayout;
int param_62=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_63=sc_fragIn.sc_sysIn.varPackedTex.xy-((dir*1.0)/float2(6.0));
bool param_64=false;
float3x3 param_65=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_66=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_67=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_68=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_69=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_70=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_71=0.0;
float4 l9_10=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param_60,param_61,param_62,param_63,param_64,param_65,param_66,param_67,param_68,param_69,param_70,param_71);
float4 l9_11=l9_10;
float4 inputTextureSample_5=l9_10;
float4 colorA=inputTextureSample_5;
float2 param_72=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_73=inputTextureLayout;
int param_74=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_75=sc_fragIn.sc_sysIn.varPackedTex.xy+((dir*1.0)/float2(6.0));
bool param_76=false;
float3x3 param_77=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_78=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_79=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_80=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_81=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_82=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_83=0.0;
float4 l9_12=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param_72,param_73,param_74,param_75,param_76,param_77,param_78,param_79,param_80,param_81,param_82,param_83);
float4 l9_13=l9_12;
float4 inputTextureSample_6=l9_12;
colorA+=inputTextureSample_6;
float2 param_84=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_85=inputTextureLayout;
int param_86=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_87=sc_fragIn.sc_sysIn.varPackedTex.xy-(dir*0.5);
bool param_88=false;
float3x3 param_89=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_90=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_91=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_92=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_93=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_94=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_95=0.0;
float4 l9_14=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param_84,param_85,param_86,param_87,param_88,param_89,param_90,param_91,param_92,param_93,param_94,param_95);
float4 l9_15=l9_14;
float4 inputTextureSample_7=l9_14;
float4 colorB=inputTextureSample_7;
float2 param_96=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_97=inputTextureLayout;
int param_98=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_99=sc_fragIn.sc_sysIn.varPackedTex.xy+(dir*0.5);
bool param_100=false;
float3x3 param_101=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_102=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_103=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_104=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_105=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_106=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_107=0.0;
float4 l9_16=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param_96,param_97,param_98,param_99,param_100,param_101,param_102,param_103,param_104,param_105,param_106,param_107);
float4 l9_17=l9_16;
float4 inputTextureSample_8=l9_16;
colorB+=inputTextureSample_8;
colorA*=0.5;
colorB=(colorA*0.5)+(colorB*0.25);
float lumaB=dot(colorB.xyz,luma);
if ((lumaB<lumaMin)||(lumaB>lumaMax))
{
result=colorA;
}
else
{
result=colorB;
}
}
#else
{
float2 param_108=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_109=inputTextureLayout;
int param_110=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_111=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_112=false;
float3x3 param_113=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_114=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_115=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_116=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_117=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_118=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_119=0.0;
float4 l9_18=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param_108,param_109,param_110,param_111,param_112,param_113,param_114,param_115,param_116,param_117,param_118,param_119);
float4 l9_19=l9_18;
float4 inputTextureSample_9=l9_18;
result=inputTextureSample_9;
}
#endif
#if (MASK)
{
float4 mask=float4(0.0);
#if (MASK_CHANNEL==0)
{
float2 param_120=maskTextureGetDims2D((*sc_set2.UserUniforms));
int param_121=maskTextureLayout;
int param_122=maskTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_123=sc_fragIn.varTexMaskAndBack.xy;
bool param_124=false;
float3x3 param_125=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_126=int2(SC_SOFTWARE_WRAP_MODE_U_maskTexture,SC_SOFTWARE_WRAP_MODE_V_maskTexture);
bool param_127=(int(SC_USE_UV_MIN_MAX_maskTexture)!=0);
float4 param_128=(*sc_set2.UserUniforms).maskTextureUvMinMax;
bool param_129=(int(SC_USE_CLAMP_TO_BORDER_maskTexture)!=0);
float4 param_130=(*sc_set2.UserUniforms).maskTextureBorderColor;
float param_131=0.0;
float4 l9_20=sc_SampleTextureBiasOrLevel(sc_set2.maskTexture,sc_set2.maskTextureSmpSC,param_120,param_121,param_122,param_123,param_124,param_125,param_126,param_127,param_128,param_129,param_130,param_131);
float4 l9_21=l9_20;
float4 maskTextureSample=l9_20;
mask=maskTextureSample.xxxx;
}
#else
{
#if (MASK_CHANNEL==1)
{
float2 param_132=maskTextureGetDims2D((*sc_set2.UserUniforms));
int param_133=maskTextureLayout;
int param_134=maskTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_135=sc_fragIn.varTexMaskAndBack.xy;
bool param_136=false;
float3x3 param_137=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_138=int2(SC_SOFTWARE_WRAP_MODE_U_maskTexture,SC_SOFTWARE_WRAP_MODE_V_maskTexture);
bool param_139=(int(SC_USE_UV_MIN_MAX_maskTexture)!=0);
float4 param_140=(*sc_set2.UserUniforms).maskTextureUvMinMax;
bool param_141=(int(SC_USE_CLAMP_TO_BORDER_maskTexture)!=0);
float4 param_142=(*sc_set2.UserUniforms).maskTextureBorderColor;
float param_143=0.0;
float4 l9_22=sc_SampleTextureBiasOrLevel(sc_set2.maskTexture,sc_set2.maskTextureSmpSC,param_132,param_133,param_134,param_135,param_136,param_137,param_138,param_139,param_140,param_141,param_142,param_143);
float4 l9_23=l9_22;
float4 maskTextureSample_1=l9_22;
mask=maskTextureSample_1;
}
#else
{
#if (MASK_CHANNEL==2)
{
float2 param_144=maskTextureGetDims2D((*sc_set2.UserUniforms));
int param_145=maskTextureLayout;
int param_146=maskTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_147=sc_fragIn.varTexMaskAndBack.xy;
bool param_148=false;
float3x3 param_149=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_150=int2(SC_SOFTWARE_WRAP_MODE_U_maskTexture,SC_SOFTWARE_WRAP_MODE_V_maskTexture);
bool param_151=(int(SC_USE_UV_MIN_MAX_maskTexture)!=0);
float4 param_152=(*sc_set2.UserUniforms).maskTextureUvMinMax;
bool param_153=(int(SC_USE_CLAMP_TO_BORDER_maskTexture)!=0);
float4 param_154=(*sc_set2.UserUniforms).maskTextureBorderColor;
float param_155=0.0;
float4 l9_24=sc_SampleTextureBiasOrLevel(sc_set2.maskTexture,sc_set2.maskTextureSmpSC,param_144,param_145,param_146,param_147,param_148,param_149,param_150,param_151,param_152,param_153,param_154,param_155);
float4 l9_25=l9_24;
float4 maskTextureSample_2=l9_24;
mask=maskTextureSample_2.wwww;
}
#endif
}
#endif
}
#endif
float2 param_156=backTextureGetDims2D((*sc_set2.UserUniforms));
int param_157=backTextureLayout;
int param_158=backTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_159=sc_fragIn.varTexMaskAndBack.zw;
bool param_160=false;
float3x3 param_161=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_162=int2(SC_SOFTWARE_WRAP_MODE_U_backTexture,SC_SOFTWARE_WRAP_MODE_V_backTexture);
bool param_163=(int(SC_USE_UV_MIN_MAX_backTexture)!=0);
float4 param_164=(*sc_set2.UserUniforms).backTextureUvMinMax;
bool param_165=(int(SC_USE_CLAMP_TO_BORDER_backTexture)!=0);
float4 param_166=(*sc_set2.UserUniforms).backTextureBorderColor;
float param_167=0.0;
float4 l9_26=sc_SampleTextureBiasOrLevel(sc_set2.backTexture,sc_set2.backTextureSmpSC,param_156,param_157,param_158,param_159,param_160,param_161,param_162,param_163,param_164,param_165,param_166,param_167);
float4 l9_27=l9_26;
float4 backTextureSample=l9_26;
float4 back=backTextureSample*(*sc_set2.UserUniforms).backColorMult;
result=mix(back,result,mask);
}
#endif
float4 param_168=result;
sc_writeFragData0(param_168,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

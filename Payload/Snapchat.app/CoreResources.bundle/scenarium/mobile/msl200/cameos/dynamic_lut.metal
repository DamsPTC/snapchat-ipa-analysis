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
//sampler sampler bgTextureSmpSC 2:2
//sampler sampler lutTextureSmpSC 2:3
//texture texture2D bgTexture 2:0:2:2
//texture texture2D lutTexture 2:1:2:3
//ubo float UserUniforms 2:4:272 {
//float4 bgTextureSize 0
//float4 bgTextureDims 16
//float4 bgTextureView 32
//float3x3 bgTextureTransform 48
//float4 bgTextureUvMinMax 96
//float4 bgTextureBorderColor 112
//float4 lutTextureSize 128
//float4 lutTextureDims 144
//float4 lutTextureView 160
//float3x3 lutTextureTransform 176
//float4 lutTextureUvMinMax 224
//float4 lutTextureBorderColor 240
//float opacity 256
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
float4 lutTextureSize;
float4 lutTextureDims;
float4 lutTextureView;
float3x3 lutTextureTransform;
float4 lutTextureUvMinMax;
float4 lutTextureBorderColor;
float opacity;
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
#ifndef lutTextureHasSwappedViews
#define lutTextureHasSwappedViews 0
#elif lutTextureHasSwappedViews==1
#undef lutTextureHasSwappedViews
#define lutTextureHasSwappedViews 1
#endif
#ifndef lutTextureLayout
#define lutTextureLayout 0
#endif
#ifndef LINEAR_LUT
#define LINEAR_LUT 0
#elif LINEAR_LUT==1
#undef LINEAR_LUT
#define LINEAR_LUT 1
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
#ifndef lutTextureUV
#define lutTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_lutTexture
#define SC_USE_UV_TRANSFORM_lutTexture 0
#elif SC_USE_UV_TRANSFORM_lutTexture==1
#undef SC_USE_UV_TRANSFORM_lutTexture
#define SC_USE_UV_TRANSFORM_lutTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_lutTexture
#define SC_SOFTWARE_WRAP_MODE_U_lutTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_lutTexture
#define SC_SOFTWARE_WRAP_MODE_V_lutTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_lutTexture
#define SC_USE_UV_MIN_MAX_lutTexture 0
#elif SC_USE_UV_MIN_MAX_lutTexture==1
#undef SC_USE_UV_MIN_MAX_lutTexture
#define SC_USE_UV_MIN_MAX_lutTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_lutTexture
#define SC_USE_CLAMP_TO_BORDER_lutTexture 0
#elif SC_USE_CLAMP_TO_BORDER_lutTexture==1
#undef SC_USE_CLAMP_TO_BORDER_lutTexture
#define SC_USE_CLAMP_TO_BORDER_lutTexture 1
#endif
struct sc_Set2
{
texture2d<float> bgTexture [[id(0)]];
texture2d<float> lutTexture [[id(1)]];
sampler bgTextureSmpSC [[id(2)]];
sampler lutTextureSmpSC [[id(3)]];
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
float4 lutTextureSize;
float4 lutTextureDims;
float4 lutTextureView;
float3x3 lutTextureTransform;
float4 lutTextureUvMinMax;
float4 lutTextureBorderColor;
float opacity;
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
#ifndef lutTextureHasSwappedViews
#define lutTextureHasSwappedViews 0
#elif lutTextureHasSwappedViews==1
#undef lutTextureHasSwappedViews
#define lutTextureHasSwappedViews 1
#endif
#ifndef lutTextureLayout
#define lutTextureLayout 0
#endif
#ifndef LINEAR_LUT
#define LINEAR_LUT 0
#elif LINEAR_LUT==1
#undef LINEAR_LUT
#define LINEAR_LUT 1
#endif
#ifndef SC_USE_UV_TRANSFORM_lutTexture
#define SC_USE_UV_TRANSFORM_lutTexture 0
#elif SC_USE_UV_TRANSFORM_lutTexture==1
#undef SC_USE_UV_TRANSFORM_lutTexture
#define SC_USE_UV_TRANSFORM_lutTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_lutTexture
#define SC_SOFTWARE_WRAP_MODE_U_lutTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_lutTexture
#define SC_SOFTWARE_WRAP_MODE_V_lutTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_lutTexture
#define SC_USE_UV_MIN_MAX_lutTexture 0
#elif SC_USE_UV_MIN_MAX_lutTexture==1
#undef SC_USE_UV_MIN_MAX_lutTexture
#define SC_USE_UV_MIN_MAX_lutTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_lutTexture
#define SC_USE_CLAMP_TO_BORDER_lutTexture 0
#elif SC_USE_CLAMP_TO_BORDER_lutTexture==1
#undef SC_USE_CLAMP_TO_BORDER_lutTexture
#define SC_USE_CLAMP_TO_BORDER_lutTexture 1
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
#ifndef lutTextureUV
#define lutTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> bgTexture [[id(0)]];
texture2d<float> lutTexture [[id(1)]];
sampler bgTextureSmpSC [[id(2)]];
sampler lutTextureSmpSC [[id(3)]];
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
float2 lutTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.lutTextureDims.xy;
}
int lutTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (lutTextureHasSwappedViews)
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
float4 lookup(thread const float4& textureColor,constant userUniformsObj& UserUniforms,thread texture2d<float> lutTexture,thread sampler lutTextureSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 newColor;
#if (LINEAR_LUT)
{
float2 param=lutTextureGetDims2D(UserUniforms);
int param_1=lutTextureLayout;
int param_2=lutTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_3=float2(textureColor.z,0.5);
bool param_4=(int(SC_USE_UV_TRANSFORM_lutTexture)!=0);
float3x3 param_5=UserUniforms.lutTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_lutTexture,SC_SOFTWARE_WRAP_MODE_V_lutTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_lutTexture)!=0);
float4 param_8=UserUniforms.lutTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_lutTexture)!=0);
float4 param_10=UserUniforms.lutTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(lutTexture,lutTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
newColor.x=l9_0.x;
float2 param_12=lutTextureGetDims2D(UserUniforms);
int param_13=lutTextureLayout;
int param_14=lutTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_15=float2(textureColor.y,0.5);
bool param_16=(int(SC_USE_UV_TRANSFORM_lutTexture)!=0);
float3x3 param_17=UserUniforms.lutTextureTransform;
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_lutTexture,SC_SOFTWARE_WRAP_MODE_V_lutTexture);
bool param_19=(int(SC_USE_UV_MIN_MAX_lutTexture)!=0);
float4 param_20=UserUniforms.lutTextureUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_lutTexture)!=0);
float4 param_22=UserUniforms.lutTextureBorderColor;
float param_23=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(lutTexture,lutTextureSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_3=l9_2;
newColor.y=l9_2.y;
float2 param_24=lutTextureGetDims2D(UserUniforms);
int param_25=lutTextureLayout;
int param_26=lutTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_27=float2(textureColor.x,0.5);
bool param_28=(int(SC_USE_UV_TRANSFORM_lutTexture)!=0);
float3x3 param_29=UserUniforms.lutTextureTransform;
int2 param_30=int2(SC_SOFTWARE_WRAP_MODE_U_lutTexture,SC_SOFTWARE_WRAP_MODE_V_lutTexture);
bool param_31=(int(SC_USE_UV_MIN_MAX_lutTexture)!=0);
float4 param_32=UserUniforms.lutTextureUvMinMax;
bool param_33=(int(SC_USE_CLAMP_TO_BORDER_lutTexture)!=0);
float4 param_34=UserUniforms.lutTextureBorderColor;
float param_35=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(lutTexture,lutTextureSmpSC,param_24,param_25,param_26,param_27,param_28,param_29,param_30,param_31,param_32,param_33,param_34,param_35);
float4 l9_5=l9_4;
newColor.z=l9_4.z;
}
#else
{
float blueColor=textureColor.z*63.0;
float2 quad1;
quad1.y=floor(floor(blueColor)/8.0);
quad1.x=floor(blueColor)-(quad1.y*8.0);
float2 quad2;
quad2.y=floor(ceil(blueColor)/8.0);
quad2.x=ceil(blueColor)-(quad2.y*8.0);
float2 texPos1;
texPos1.x=((quad1.x*0.125)+0.0009765625)+(0.12304688*textureColor.x);
texPos1.y=((1.0-(quad1.y*0.125))-0.0009765625)-(0.12304688*textureColor.y);
float2 texPos2;
texPos2.x=((quad2.x*0.125)+0.0009765625)+(0.12304688*textureColor.x);
texPos2.y=((1.0-(quad2.y*0.125))-0.0009765625)-(0.12304688*textureColor.y);
float2 param_36=lutTextureGetDims2D(UserUniforms);
int param_37=lutTextureLayout;
int param_38=lutTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_39=texPos1;
bool param_40=(int(SC_USE_UV_TRANSFORM_lutTexture)!=0);
float3x3 param_41=UserUniforms.lutTextureTransform;
int2 param_42=int2(SC_SOFTWARE_WRAP_MODE_U_lutTexture,SC_SOFTWARE_WRAP_MODE_V_lutTexture);
bool param_43=(int(SC_USE_UV_MIN_MAX_lutTexture)!=0);
float4 param_44=UserUniforms.lutTextureUvMinMax;
bool param_45=(int(SC_USE_CLAMP_TO_BORDER_lutTexture)!=0);
float4 param_46=UserUniforms.lutTextureBorderColor;
float param_47=0.0;
float4 l9_6=sc_SampleTextureBiasOrLevel(lutTexture,lutTextureSmpSC,param_36,param_37,param_38,param_39,param_40,param_41,param_42,param_43,param_44,param_45,param_46,param_47);
float4 l9_7=l9_6;
float4 newColor1=l9_6;
float2 param_48=lutTextureGetDims2D(UserUniforms);
int param_49=lutTextureLayout;
int param_50=lutTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_51=texPos2;
bool param_52=(int(SC_USE_UV_TRANSFORM_lutTexture)!=0);
float3x3 param_53=UserUniforms.lutTextureTransform;
int2 param_54=int2(SC_SOFTWARE_WRAP_MODE_U_lutTexture,SC_SOFTWARE_WRAP_MODE_V_lutTexture);
bool param_55=(int(SC_USE_UV_MIN_MAX_lutTexture)!=0);
float4 param_56=UserUniforms.lutTextureUvMinMax;
bool param_57=(int(SC_USE_CLAMP_TO_BORDER_lutTexture)!=0);
float4 param_58=UserUniforms.lutTextureBorderColor;
float param_59=0.0;
float4 l9_8=sc_SampleTextureBiasOrLevel(lutTexture,lutTextureSmpSC,param_48,param_49,param_50,param_51,param_52,param_53,param_54,param_55,param_56,param_57,param_58,param_59);
float4 l9_9=l9_8;
float4 newColor2=l9_8;
float4 newColor_1=mix(newColor1,newColor2,float4(fract(blueColor)));
}
#endif
return newColor;
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
float2 param=bgTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=bgTextureLayout;
int param_2=bgTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=(int(SC_USE_UV_TRANSFORM_bgTexture)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).bgTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_bgTexture,SC_SOFTWARE_WRAP_MODE_V_bgTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_bgTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).bgTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_bgTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).bgTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.bgTexture,sc_set2.bgTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 param_12=l9_0;
float3 color=lookup(param_12,(*sc_set2.UserUniforms),sc_set2.lutTexture,sc_set2.lutTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1).xyz;
float4 param_13=float4(color,(*sc_set2.UserUniforms).opacity);
sc_writeFragData0(param_13,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

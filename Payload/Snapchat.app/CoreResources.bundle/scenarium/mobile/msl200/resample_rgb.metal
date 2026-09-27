#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "std2_vs.metal"
#include "std2_fs.metal"
#include "std2_texture.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler mainTextureSmpSC 2:2
//sampler sampler segmentationMaskSmpSC 2:3
//texture texture2D mainTexture 2:0:2:2
//texture texture2D segmentationMask 2:1:2:3
//ubo float UserUniforms 2:4:256 {
//float4 segmentationMaskSize 0
//float4 segmentationMaskDims 16
//float4 segmentationMaskView 32
//float3x3 segmentationMaskTransform 48
//float4 segmentationMaskUvMinMax 96
//float4 segmentationMaskBorderColor 112
//float4 mainTextureSize 128
//float4 mainTextureDims 144
//float4 mainTextureView 160
//float3x3 mainTextureTransform 176
//float4 mainTextureUvMinMax 224
//float4 mainTextureBorderColor 240
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 segmentationMaskSize;
float4 segmentationMaskDims;
float4 segmentationMaskView;
float3x3 segmentationMaskTransform;
float4 segmentationMaskUvMinMax;
float4 segmentationMaskBorderColor;
float4 mainTextureSize;
float4 mainTextureDims;
float4 mainTextureView;
float3x3 mainTextureTransform;
float4 mainTextureUvMinMax;
float4 mainTextureBorderColor;
};
#ifndef segmentationMaskHasSwappedViews
#define segmentationMaskHasSwappedViews 0
#elif segmentationMaskHasSwappedViews==1
#undef segmentationMaskHasSwappedViews
#define segmentationMaskHasSwappedViews 1
#endif
#ifndef segmentationMaskLayout
#define segmentationMaskLayout 0
#endif
#ifndef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 0
#elif mainTextureHasSwappedViews==1
#undef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 1
#endif
#ifndef mainTextureLayout
#define mainTextureLayout 0
#endif
#ifndef RG_RB_GB
#define RG_RB_GB 0
#elif RG_RB_GB==1
#undef RG_RB_GB
#define RG_RB_GB 1
#endif
#ifndef RR_GG_BB
#define RR_GG_BB 0
#elif RR_GG_BB==1
#undef RR_GG_BB
#define RR_GG_BB 1
#endif
#ifndef R_G_B
#define R_G_B 0
#elif R_G_B==1
#undef R_G_B
#define R_G_B 1
#endif
#ifndef RY_GY_BY_Y
#define RY_GY_BY_Y 0
#elif RY_GY_BY_Y==1
#undef RY_GY_BY_Y
#define RY_GY_BY_Y 1
#endif
#ifndef GRAY_SCALE
#define GRAY_SCALE 0
#elif GRAY_SCALE==1
#undef GRAY_SCALE
#define GRAY_SCALE 1
#endif
#ifndef segmentationMaskUV
#define segmentationMaskUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_segmentationMask
#define SC_USE_UV_TRANSFORM_segmentationMask 0
#elif SC_USE_UV_TRANSFORM_segmentationMask==1
#undef SC_USE_UV_TRANSFORM_segmentationMask
#define SC_USE_UV_TRANSFORM_segmentationMask 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_segmentationMask
#define SC_SOFTWARE_WRAP_MODE_U_segmentationMask -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_segmentationMask
#define SC_SOFTWARE_WRAP_MODE_V_segmentationMask -1
#endif
#ifndef SC_USE_UV_MIN_MAX_segmentationMask
#define SC_USE_UV_MIN_MAX_segmentationMask 0
#elif SC_USE_UV_MIN_MAX_segmentationMask==1
#undef SC_USE_UV_MIN_MAX_segmentationMask
#define SC_USE_UV_MIN_MAX_segmentationMask 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_segmentationMask
#define SC_USE_CLAMP_TO_BORDER_segmentationMask 0
#elif SC_USE_CLAMP_TO_BORDER_segmentationMask==1
#undef SC_USE_CLAMP_TO_BORDER_segmentationMask
#define SC_USE_CLAMP_TO_BORDER_segmentationMask 1
#endif
#ifndef mainTextureUV
#define mainTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_mainTexture
#define SC_USE_UV_TRANSFORM_mainTexture 0
#elif SC_USE_UV_TRANSFORM_mainTexture==1
#undef SC_USE_UV_TRANSFORM_mainTexture
#define SC_USE_UV_TRANSFORM_mainTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_mainTexture
#define SC_SOFTWARE_WRAP_MODE_U_mainTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_mainTexture
#define SC_SOFTWARE_WRAP_MODE_V_mainTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_mainTexture
#define SC_USE_UV_MIN_MAX_mainTexture 0
#elif SC_USE_UV_MIN_MAX_mainTexture==1
#undef SC_USE_UV_MIN_MAX_mainTexture
#define SC_USE_UV_MIN_MAX_mainTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_mainTexture
#define SC_USE_CLAMP_TO_BORDER_mainTexture 0
#elif SC_USE_CLAMP_TO_BORDER_mainTexture==1
#undef SC_USE_CLAMP_TO_BORDER_mainTexture
#define SC_USE_CLAMP_TO_BORDER_mainTexture 1
#endif
struct sc_Set2
{
texture2d<float> mainTexture [[id(0)]];
texture2d<float> segmentationMask [[id(1)]];
sampler mainTextureSmpSC [[id(2)]];
sampler segmentationMaskSmpSC [[id(3)]];
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
float2 texPos=(v.position.xy*0.5)+float2(0.5);
float2 l9_0=float2(texPos.x,1.0-texPos.y);
sc_vertOut.sc_sysOut.varPackedTex=float4(sc_vertOut.sc_sysOut.varPackedTex.x,sc_vertOut.sc_sysOut.varPackedTex.y,l9_0.x,l9_0.y);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 segmentationMaskSize;
float4 segmentationMaskDims;
float4 segmentationMaskView;
float3x3 segmentationMaskTransform;
float4 segmentationMaskUvMinMax;
float4 segmentationMaskBorderColor;
float4 mainTextureSize;
float4 mainTextureDims;
float4 mainTextureView;
float3x3 mainTextureTransform;
float4 mainTextureUvMinMax;
float4 mainTextureBorderColor;
};
#ifndef segmentationMaskHasSwappedViews
#define segmentationMaskHasSwappedViews 0
#elif segmentationMaskHasSwappedViews==1
#undef segmentationMaskHasSwappedViews
#define segmentationMaskHasSwappedViews 1
#endif
#ifndef segmentationMaskLayout
#define segmentationMaskLayout 0
#endif
#ifndef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 0
#elif mainTextureHasSwappedViews==1
#undef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 1
#endif
#ifndef mainTextureLayout
#define mainTextureLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_mainTexture
#define SC_USE_UV_TRANSFORM_mainTexture 0
#elif SC_USE_UV_TRANSFORM_mainTexture==1
#undef SC_USE_UV_TRANSFORM_mainTexture
#define SC_USE_UV_TRANSFORM_mainTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_mainTexture
#define SC_SOFTWARE_WRAP_MODE_U_mainTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_mainTexture
#define SC_SOFTWARE_WRAP_MODE_V_mainTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_mainTexture
#define SC_USE_UV_MIN_MAX_mainTexture 0
#elif SC_USE_UV_MIN_MAX_mainTexture==1
#undef SC_USE_UV_MIN_MAX_mainTexture
#define SC_USE_UV_MIN_MAX_mainTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_mainTexture
#define SC_USE_CLAMP_TO_BORDER_mainTexture 0
#elif SC_USE_CLAMP_TO_BORDER_mainTexture==1
#undef SC_USE_CLAMP_TO_BORDER_mainTexture
#define SC_USE_CLAMP_TO_BORDER_mainTexture 1
#endif
#ifndef GRAY_SCALE
#define GRAY_SCALE 0
#elif GRAY_SCALE==1
#undef GRAY_SCALE
#define GRAY_SCALE 1
#endif
#ifndef RG_RB_GB
#define RG_RB_GB 0
#elif RG_RB_GB==1
#undef RG_RB_GB
#define RG_RB_GB 1
#endif
#ifndef RR_GG_BB
#define RR_GG_BB 0
#elif RR_GG_BB==1
#undef RR_GG_BB
#define RR_GG_BB 1
#endif
#ifndef R_G_B
#define R_G_B 0
#elif R_G_B==1
#undef R_G_B
#define R_G_B 1
#endif
#ifndef RY_GY_BY_Y
#define RY_GY_BY_Y 0
#elif RY_GY_BY_Y==1
#undef RY_GY_BY_Y
#define RY_GY_BY_Y 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_segmentationMask
#define SC_SOFTWARE_WRAP_MODE_U_segmentationMask -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_segmentationMask
#define SC_SOFTWARE_WRAP_MODE_V_segmentationMask -1
#endif
#ifndef SC_USE_UV_MIN_MAX_segmentationMask
#define SC_USE_UV_MIN_MAX_segmentationMask 0
#elif SC_USE_UV_MIN_MAX_segmentationMask==1
#undef SC_USE_UV_MIN_MAX_segmentationMask
#define SC_USE_UV_MIN_MAX_segmentationMask 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_segmentationMask
#define SC_USE_CLAMP_TO_BORDER_segmentationMask 0
#elif SC_USE_CLAMP_TO_BORDER_segmentationMask==1
#undef SC_USE_CLAMP_TO_BORDER_segmentationMask
#define SC_USE_CLAMP_TO_BORDER_segmentationMask 1
#endif
#ifndef segmentationMaskUV
#define segmentationMaskUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_segmentationMask
#define SC_USE_UV_TRANSFORM_segmentationMask 0
#elif SC_USE_UV_TRANSFORM_segmentationMask==1
#undef SC_USE_UV_TRANSFORM_segmentationMask
#define SC_USE_UV_TRANSFORM_segmentationMask 1
#endif
#ifndef mainTextureUV
#define mainTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> mainTexture [[id(0)]];
texture2d<float> segmentationMask [[id(1)]];
sampler mainTextureSmpSC [[id(2)]];
sampler segmentationMaskSmpSC [[id(3)]];
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
float2 mainTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.mainTextureDims.xy;
}
int mainTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (mainTextureHasSwappedViews)
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
float grayscale(thread const float3& color)
{
return dot(color,float3(0.21259999,0.71520001,0.0722));
}
float2 segmentationMaskGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.segmentationMaskDims.xy;
}
int segmentationMaskGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (segmentationMaskHasSwappedViews)
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
float2 param=sc_fragIn.sc_sysIn.varPackedTex.xy;
float2 param_1=mainTextureGetDims2D((*sc_set2.UserUniforms));
int param_2=mainTextureLayout;
int param_3=mainTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_4=sc_PlatformFlipV(param);
bool param_5=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_6=(*sc_set2.UserUniforms).mainTextureTransform;
int2 param_7=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_8=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_9=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool param_10=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_11=(*sc_set2.UserUniforms).mainTextureBorderColor;
float param_12=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.mainTexture,sc_set2.mainTextureSmpSC,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11,param_12);
float4 l9_1=l9_0;
float4 mainTextureSample=l9_0;
float3 color=mainTextureSample.xyz;
float4 result=float4(0.0);
#if (GRAY_SCALE)
{
float3 param_13=color;
color=float3(grayscale(param_13));
}
#endif
#if (RG_RB_GB)
{
result=float4(color.xxy*color.yzz,1.0);
}
#else
{
#if (RR_GG_BB)
{
result=float4(color*color,1.0);
}
#else
{
#if (R_G_B)
{
result=float4(color,1.0);
}
#else
{
#if (RY_GY_BY_Y)
{
float2 param_14=segmentationMaskGetDims2D((*sc_set2.UserUniforms));
int param_15=segmentationMaskLayout;
int param_16=segmentationMaskGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_17=sc_fragIn.sc_sysIn.varPackedTex.zw;
bool param_18=false;
float3x3 param_19=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_20=int2(SC_SOFTWARE_WRAP_MODE_U_segmentationMask,SC_SOFTWARE_WRAP_MODE_V_segmentationMask);
bool param_21=(int(SC_USE_UV_MIN_MAX_segmentationMask)!=0);
float4 param_22=(*sc_set2.UserUniforms).segmentationMaskUvMinMax;
bool param_23=(int(SC_USE_CLAMP_TO_BORDER_segmentationMask)!=0);
float4 param_24=(*sc_set2.UserUniforms).segmentationMaskBorderColor;
float param_25=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.segmentationMask,sc_set2.segmentationMaskSmpSC,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23,param_24,param_25);
float4 l9_3=l9_2;
float4 segmentationMaskSample=l9_2;
float mask=segmentationMaskSample.x;
result=float4(color*mask,mask);
}
#else
{
#if (GRAY_SCALE)
{
float2 param_26=segmentationMaskGetDims2D((*sc_set2.UserUniforms));
int param_27=segmentationMaskLayout;
int param_28=segmentationMaskGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_29=sc_fragIn.sc_sysIn.varPackedTex.zw;
bool param_30=false;
float3x3 param_31=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_32=int2(SC_SOFTWARE_WRAP_MODE_U_segmentationMask,SC_SOFTWARE_WRAP_MODE_V_segmentationMask);
bool param_33=(int(SC_USE_UV_MIN_MAX_segmentationMask)!=0);
float4 param_34=(*sc_set2.UserUniforms).segmentationMaskUvMinMax;
bool param_35=(int(SC_USE_CLAMP_TO_BORDER_segmentationMask)!=0);
float4 param_36=(*sc_set2.UserUniforms).segmentationMaskBorderColor;
float param_37=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(sc_set2.segmentationMask,sc_set2.segmentationMaskSmpSC,param_26,param_27,param_28,param_29,param_30,param_31,param_32,param_33,param_34,param_35,param_36,param_37);
float4 l9_5=l9_4;
float4 segmentationMaskSample_1=l9_4;
float mask_1=segmentationMaskSample_1.x;
result=float4(color.x,mask_1,color.x*mask_1,color.x*color.x);
}
#else
{
result=float4(1.0,0.0,1.0,1.0);
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
float4 param_38=result;
sc_writeFragData0(param_38,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

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
//sampler sampler uvTextureSmpSC 2:2
//sampler sampler yTextureSmpSC 2:3
//texture texture2D uvTexture 2:0:2:2
//texture texture2D yTexture 2:1:2:3
//ubo float UserUniforms 2:4:256 {
//float4 yTextureSize 0
//float4 yTextureDims 16
//float4 yTextureView 32
//float3x3 yTextureTransform 48
//float4 yTextureUvMinMax 96
//float4 yTextureBorderColor 112
//float4 uvTextureSize 128
//float4 uvTextureDims 144
//float4 uvTextureView 160
//float3x3 uvTextureTransform 176
//float4 uvTextureUvMinMax 224
//float4 uvTextureBorderColor 240
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 yTextureSize;
float4 yTextureDims;
float4 yTextureView;
float3x3 yTextureTransform;
float4 yTextureUvMinMax;
float4 yTextureBorderColor;
float4 uvTextureSize;
float4 uvTextureDims;
float4 uvTextureView;
float3x3 uvTextureTransform;
float4 uvTextureUvMinMax;
float4 uvTextureBorderColor;
};
#ifndef yTextureHasSwappedViews
#define yTextureHasSwappedViews 0
#elif yTextureHasSwappedViews==1
#undef yTextureHasSwappedViews
#define yTextureHasSwappedViews 1
#endif
#ifndef yTextureLayout
#define yTextureLayout 0
#endif
#ifndef uvTextureHasSwappedViews
#define uvTextureHasSwappedViews 0
#elif uvTextureHasSwappedViews==1
#undef uvTextureHasSwappedViews
#define uvTextureHasSwappedViews 1
#endif
#ifndef uvTextureLayout
#define uvTextureLayout 0
#endif
#ifndef FORMAT_NV12
#define FORMAT_NV12 0
#elif FORMAT_NV12==1
#undef FORMAT_NV12
#define FORMAT_NV12 1
#endif
#ifndef FORMAT_NV21
#define FORMAT_NV21 0
#elif FORMAT_NV21==1
#undef FORMAT_NV21
#define FORMAT_NV21 1
#endif
#ifndef yTextureUV
#define yTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_yTexture
#define SC_USE_UV_TRANSFORM_yTexture 0
#elif SC_USE_UV_TRANSFORM_yTexture==1
#undef SC_USE_UV_TRANSFORM_yTexture
#define SC_USE_UV_TRANSFORM_yTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_yTexture
#define SC_SOFTWARE_WRAP_MODE_U_yTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_yTexture
#define SC_SOFTWARE_WRAP_MODE_V_yTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_yTexture
#define SC_USE_UV_MIN_MAX_yTexture 0
#elif SC_USE_UV_MIN_MAX_yTexture==1
#undef SC_USE_UV_MIN_MAX_yTexture
#define SC_USE_UV_MIN_MAX_yTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_yTexture
#define SC_USE_CLAMP_TO_BORDER_yTexture 0
#elif SC_USE_CLAMP_TO_BORDER_yTexture==1
#undef SC_USE_CLAMP_TO_BORDER_yTexture
#define SC_USE_CLAMP_TO_BORDER_yTexture 1
#endif
#ifndef uvTextureUV
#define uvTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_uvTexture
#define SC_USE_UV_TRANSFORM_uvTexture 0
#elif SC_USE_UV_TRANSFORM_uvTexture==1
#undef SC_USE_UV_TRANSFORM_uvTexture
#define SC_USE_UV_TRANSFORM_uvTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_uvTexture
#define SC_SOFTWARE_WRAP_MODE_U_uvTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_uvTexture
#define SC_SOFTWARE_WRAP_MODE_V_uvTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_uvTexture
#define SC_USE_UV_MIN_MAX_uvTexture 0
#elif SC_USE_UV_MIN_MAX_uvTexture==1
#undef SC_USE_UV_MIN_MAX_uvTexture
#define SC_USE_UV_MIN_MAX_uvTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_uvTexture
#define SC_USE_CLAMP_TO_BORDER_uvTexture 0
#elif SC_USE_CLAMP_TO_BORDER_uvTexture==1
#undef SC_USE_CLAMP_TO_BORDER_uvTexture
#define SC_USE_CLAMP_TO_BORDER_uvTexture 1
#endif
struct sc_Set2
{
texture2d<float> uvTexture [[id(0)]];
texture2d<float> yTexture [[id(1)]];
sampler uvTextureSmpSC [[id(2)]];
sampler yTextureSmpSC [[id(3)]];
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
float4 yTextureSize;
float4 yTextureDims;
float4 yTextureView;
float3x3 yTextureTransform;
float4 yTextureUvMinMax;
float4 yTextureBorderColor;
float4 uvTextureSize;
float4 uvTextureDims;
float4 uvTextureView;
float3x3 uvTextureTransform;
float4 uvTextureUvMinMax;
float4 uvTextureBorderColor;
};
#ifndef yTextureHasSwappedViews
#define yTextureHasSwappedViews 0
#elif yTextureHasSwappedViews==1
#undef yTextureHasSwappedViews
#define yTextureHasSwappedViews 1
#endif
#ifndef yTextureLayout
#define yTextureLayout 0
#endif
#ifndef uvTextureHasSwappedViews
#define uvTextureHasSwappedViews 0
#elif uvTextureHasSwappedViews==1
#undef uvTextureHasSwappedViews
#define uvTextureHasSwappedViews 1
#endif
#ifndef uvTextureLayout
#define uvTextureLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_yTexture
#define SC_USE_UV_TRANSFORM_yTexture 0
#elif SC_USE_UV_TRANSFORM_yTexture==1
#undef SC_USE_UV_TRANSFORM_yTexture
#define SC_USE_UV_TRANSFORM_yTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_yTexture
#define SC_SOFTWARE_WRAP_MODE_U_yTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_yTexture
#define SC_SOFTWARE_WRAP_MODE_V_yTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_yTexture
#define SC_USE_UV_MIN_MAX_yTexture 0
#elif SC_USE_UV_MIN_MAX_yTexture==1
#undef SC_USE_UV_MIN_MAX_yTexture
#define SC_USE_UV_MIN_MAX_yTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_yTexture
#define SC_USE_CLAMP_TO_BORDER_yTexture 0
#elif SC_USE_CLAMP_TO_BORDER_yTexture==1
#undef SC_USE_CLAMP_TO_BORDER_yTexture
#define SC_USE_CLAMP_TO_BORDER_yTexture 1
#endif
#ifndef SC_USE_UV_TRANSFORM_uvTexture
#define SC_USE_UV_TRANSFORM_uvTexture 0
#elif SC_USE_UV_TRANSFORM_uvTexture==1
#undef SC_USE_UV_TRANSFORM_uvTexture
#define SC_USE_UV_TRANSFORM_uvTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_uvTexture
#define SC_SOFTWARE_WRAP_MODE_U_uvTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_uvTexture
#define SC_SOFTWARE_WRAP_MODE_V_uvTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_uvTexture
#define SC_USE_UV_MIN_MAX_uvTexture 0
#elif SC_USE_UV_MIN_MAX_uvTexture==1
#undef SC_USE_UV_MIN_MAX_uvTexture
#define SC_USE_UV_MIN_MAX_uvTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_uvTexture
#define SC_USE_CLAMP_TO_BORDER_uvTexture 0
#elif SC_USE_CLAMP_TO_BORDER_uvTexture==1
#undef SC_USE_CLAMP_TO_BORDER_uvTexture
#define SC_USE_CLAMP_TO_BORDER_uvTexture 1
#endif
#ifndef FORMAT_NV12
#define FORMAT_NV12 0
#elif FORMAT_NV12==1
#undef FORMAT_NV12
#define FORMAT_NV12 1
#endif
#ifndef FORMAT_NV21
#define FORMAT_NV21 0
#elif FORMAT_NV21==1
#undef FORMAT_NV21
#define FORMAT_NV21 1
#endif
#ifndef yTextureUV
#define yTextureUV 0
#endif
#ifndef uvTextureUV
#define uvTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> uvTexture [[id(0)]];
texture2d<float> yTexture [[id(1)]];
sampler uvTextureSmpSC [[id(2)]];
sampler yTextureSmpSC [[id(3)]];
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
float2 yTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.yTextureDims.xy;
}
int yTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (yTextureHasSwappedViews)
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
float2 uvTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.uvTextureDims.xy;
}
int uvTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (uvTextureHasSwappedViews)
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
float3 getRGB(thread const float3& yuv)
{
return (float3x3(float3(1.0),float3(0.0,-0.33763301,1.732446),float3(1.370705,-0.69800103,0.0))*yuv)+float3(-0.6853525,0.51781702,-0.86622298);
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param=yTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=yTextureLayout;
int param_2=yTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=(int(SC_USE_UV_TRANSFORM_yTexture)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).yTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_yTexture,SC_SOFTWARE_WRAP_MODE_V_yTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_yTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).yTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_yTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).yTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.yTexture,sc_set2.yTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 yTextureSample=l9_0;
float2 param_12=uvTextureGetDims2D((*sc_set2.UserUniforms));
int param_13=uvTextureLayout;
int param_14=uvTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_15=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_16=(int(SC_USE_UV_TRANSFORM_uvTexture)!=0);
float3x3 param_17=(*sc_set2.UserUniforms).uvTextureTransform;
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_uvTexture,SC_SOFTWARE_WRAP_MODE_V_uvTexture);
bool param_19=(int(SC_USE_UV_MIN_MAX_uvTexture)!=0);
float4 param_20=(*sc_set2.UserUniforms).uvTextureUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_uvTexture)!=0);
float4 param_22=(*sc_set2.UserUniforms).uvTextureBorderColor;
float param_23=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.uvTexture,sc_set2.uvTextureSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_3=l9_2;
float4 uvTextureSample=l9_2;
float yVal=yTextureSample.x;
float2 uv=uvTextureSample.xy;
float3 rgb=float3(0.0);
#if (FORMAT_NV12)
{
float3 param_24=float3(yVal,uv.x,uv.y);
rgb=getRGB(param_24);
}
#else
{
#if (FORMAT_NV21)
{
float3 param_25=float3(yVal,uv.y,uv.x);
rgb=getRGB(param_25);
}
#endif
}
#endif
float4 param_26=float4(rgb,1.0);
sc_writeFragData0(param_26,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

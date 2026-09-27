#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "std2_vs.metal"
#include "std2_fs.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler cameraTextureSmpSC 2:1
//texture texture2D cameraTexture 2:0:2:1
//ubo float UserUniforms 2:2:160 {
//float4 cameraTextureSize 0
//float4 cameraTextureDims 16
//float4 cameraTextureView 32
//float3x3 cameraTextureTransform 48
//float4 cameraTextureUvMinMax 96
//float4 cameraTextureBorderColor 112
//float4 leftSampleOffsetSize 128
//float4 rightSampleOffsetSize 144
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 cameraTextureSize;
float4 cameraTextureDims;
float4 cameraTextureView;
float3x3 cameraTextureTransform;
float4 cameraTextureUvMinMax;
float4 cameraTextureBorderColor;
float4 leftSampleOffsetSize;
float4 rightSampleOffsetSize;
};
#ifndef cameraTextureHasSwappedViews
#define cameraTextureHasSwappedViews 0
#elif cameraTextureHasSwappedViews==1
#undef cameraTextureHasSwappedViews
#define cameraTextureHasSwappedViews 1
#endif
#ifndef cameraTextureLayout
#define cameraTextureLayout 0
#endif
#ifndef cameraTextureUV
#define cameraTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_cameraTexture
#define SC_USE_UV_TRANSFORM_cameraTexture 0
#elif SC_USE_UV_TRANSFORM_cameraTexture==1
#undef SC_USE_UV_TRANSFORM_cameraTexture
#define SC_USE_UV_TRANSFORM_cameraTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_cameraTexture
#define SC_SOFTWARE_WRAP_MODE_U_cameraTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_cameraTexture
#define SC_SOFTWARE_WRAP_MODE_V_cameraTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_cameraTexture
#define SC_USE_UV_MIN_MAX_cameraTexture 0
#elif SC_USE_UV_MIN_MAX_cameraTexture==1
#undef SC_USE_UV_MIN_MAX_cameraTexture
#define SC_USE_UV_MIN_MAX_cameraTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_cameraTexture
#define SC_USE_CLAMP_TO_BORDER_cameraTexture 0
#elif SC_USE_CLAMP_TO_BORDER_cameraTexture==1
#undef SC_USE_CLAMP_TO_BORDER_cameraTexture
#define SC_USE_CLAMP_TO_BORDER_cameraTexture 1
#endif
struct sc_Set2
{
texture2d<float> cameraTexture [[id(0)]];
sampler cameraTextureSmpSC [[id(1)]];
constant userUniformsObj* UserUniforms [[id(2)]];
};
struct sc_VertOut
{
sc_SysOut sc_sysOut;
float varLerp [[user(locn10)]];
float2 varLeftSampleCoord [[user(locn11)]];
float2 varRightSampleCoord [[user(locn12)]];
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
float3x3 leftSampleTransform=(*sc_set2.UserUniforms).cameraTextureTransform;
leftSampleTransform[0].x*=(*sc_set2.UserUniforms).leftSampleOffsetSize.z;
leftSampleTransform[1].y*=(*sc_set2.UserUniforms).leftSampleOffsetSize.w;
float3x3 rightSampleTransform=(*sc_set2.UserUniforms).cameraTextureTransform;
rightSampleTransform[0].x*=(*sc_set2.UserUniforms).rightSampleOffsetSize.z;
rightSampleTransform[1].y*=(*sc_set2.UserUniforms).rightSampleOffsetSize.w;
float2 rangedTexCoord=(v.texture0*float2(2.0))-float2(1.0);
float3 leftSampleCoord=float3(rangedTexCoord,1.0)*leftSampleTransform;
float3 rightSampleCoord=float3(rangedTexCoord,1.0)*rightSampleTransform;
sc_vertOut.varLerp=1.0-v.texture0.x;
sc_vertOut.varLeftSampleCoord=((leftSampleCoord.xy+(*sc_set2.UserUniforms).leftSampleOffsetSize.xy)*0.5)+float2(0.5);
sc_vertOut.varRightSampleCoord=((rightSampleCoord.xy+(*sc_set2.UserUniforms).rightSampleOffsetSize.xy)*0.5)+float2(0.5);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 cameraTextureSize;
float4 cameraTextureDims;
float4 cameraTextureView;
float3x3 cameraTextureTransform;
float4 cameraTextureUvMinMax;
float4 cameraTextureBorderColor;
float4 leftSampleOffsetSize;
float4 rightSampleOffsetSize;
};
#ifndef cameraTextureHasSwappedViews
#define cameraTextureHasSwappedViews 0
#elif cameraTextureHasSwappedViews==1
#undef cameraTextureHasSwappedViews
#define cameraTextureHasSwappedViews 1
#endif
#ifndef cameraTextureLayout
#define cameraTextureLayout 0
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_cameraTexture
#define SC_SOFTWARE_WRAP_MODE_U_cameraTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_cameraTexture
#define SC_SOFTWARE_WRAP_MODE_V_cameraTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_cameraTexture
#define SC_USE_UV_MIN_MAX_cameraTexture 0
#elif SC_USE_UV_MIN_MAX_cameraTexture==1
#undef SC_USE_UV_MIN_MAX_cameraTexture
#define SC_USE_UV_MIN_MAX_cameraTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_cameraTexture
#define SC_USE_CLAMP_TO_BORDER_cameraTexture 0
#elif SC_USE_CLAMP_TO_BORDER_cameraTexture==1
#undef SC_USE_CLAMP_TO_BORDER_cameraTexture
#define SC_USE_CLAMP_TO_BORDER_cameraTexture 1
#endif
#ifndef cameraTextureUV
#define cameraTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_cameraTexture
#define SC_USE_UV_TRANSFORM_cameraTexture 0
#elif SC_USE_UV_TRANSFORM_cameraTexture==1
#undef SC_USE_UV_TRANSFORM_cameraTexture
#define SC_USE_UV_TRANSFORM_cameraTexture 1
#endif
struct sc_Set2
{
texture2d<float> cameraTexture [[id(0)]];
sampler cameraTextureSmpSC [[id(1)]];
constant userUniformsObj* UserUniforms [[id(2)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
float varLerp [[user(locn10)]];
float2 varLeftSampleCoord [[user(locn11)]];
float2 varRightSampleCoord [[user(locn12)]];
};
float2 cameraTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.cameraTextureDims.xy;
}
int cameraTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (cameraTextureHasSwappedViews)
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
float3 leftSample=float3(0.0);
float2 param=cameraTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=cameraTextureLayout;
int param_2=cameraTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.varLeftSampleCoord;
bool param_4=false;
float3x3 param_5=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_cameraTexture,SC_SOFTWARE_WRAP_MODE_V_cameraTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_cameraTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).cameraTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_cameraTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).cameraTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.cameraTexture,sc_set2.cameraTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 cameraTextureSample=l9_0;
leftSample=cameraTextureSample.xyz;
float3 rightSample=float3(0.0);
float2 param_12=cameraTextureGetDims2D((*sc_set2.UserUniforms));
int param_13=cameraTextureLayout;
int param_14=cameraTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_15=sc_fragIn.varRightSampleCoord;
bool param_16=false;
float3x3 param_17=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_cameraTexture,SC_SOFTWARE_WRAP_MODE_V_cameraTexture);
bool param_19=(int(SC_USE_UV_MIN_MAX_cameraTexture)!=0);
float4 param_20=(*sc_set2.UserUniforms).cameraTextureUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_cameraTexture)!=0);
float4 param_22=(*sc_set2.UserUniforms).cameraTextureBorderColor;
float param_23=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.cameraTexture,sc_set2.cameraTextureSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_3=l9_2;
float4 cameraTextureSample_1=l9_2;
rightSample=cameraTextureSample_1.xyz;
float3 lerpedColor=mix(leftSample,rightSample,float3(sc_fragIn.varLerp));
float4 param_24=float4(lerpedColor,1.0);
sc_writeFragData0(param_24,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

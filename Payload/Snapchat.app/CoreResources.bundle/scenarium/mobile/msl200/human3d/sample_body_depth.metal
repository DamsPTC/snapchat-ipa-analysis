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
#include "std2_texture.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler confidenceTextureSmpSC 2:2
//sampler sampler cropTextureSmpSC 2:3
//texture texture2D confidenceTexture 2:0:2:2
//texture texture2D cropTexture 2:1:2:3
//ubo float UserUniforms 2:4:320 {
//float4 cropTextureSize 0
//float4 cropTextureDims 16
//float4 cropTextureView 32
//float3x3 cropTextureTransform 48
//float4 cropTextureUvMinMax 96
//float4 cropTextureBorderColor 112
//float4 confidenceTextureSize 128
//float4 confidenceTextureDims 144
//float4 confidenceTextureView 160
//float3x3 confidenceTextureTransform 176
//float4 confidenceTextureUvMinMax 224
//float4 confidenceTextureBorderColor 240
//float3x3 screenToCropTransform 256
//float2 depthProjectionMatrixTerms 304
//float minimumConfidence 312
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 cropTextureSize;
float4 cropTextureDims;
float4 cropTextureView;
float3x3 cropTextureTransform;
float4 cropTextureUvMinMax;
float4 cropTextureBorderColor;
float4 confidenceTextureSize;
float4 confidenceTextureDims;
float4 confidenceTextureView;
float3x3 confidenceTextureTransform;
float4 confidenceTextureUvMinMax;
float4 confidenceTextureBorderColor;
float3x3 screenToCropTransform;
float2 depthProjectionMatrixTerms;
float minimumConfidence;
};
#ifndef cropTextureHasSwappedViews
#define cropTextureHasSwappedViews 0
#elif cropTextureHasSwappedViews==1
#undef cropTextureHasSwappedViews
#define cropTextureHasSwappedViews 1
#endif
#ifndef cropTextureLayout
#define cropTextureLayout 0
#endif
#ifndef confidenceTextureHasSwappedViews
#define confidenceTextureHasSwappedViews 0
#elif confidenceTextureHasSwappedViews==1
#undef confidenceTextureHasSwappedViews
#define confidenceTextureHasSwappedViews 1
#endif
#ifndef confidenceTextureLayout
#define confidenceTextureLayout 0
#endif
#ifndef cropTextureUV
#define cropTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_cropTexture
#define SC_USE_UV_TRANSFORM_cropTexture 0
#elif SC_USE_UV_TRANSFORM_cropTexture==1
#undef SC_USE_UV_TRANSFORM_cropTexture
#define SC_USE_UV_TRANSFORM_cropTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_cropTexture
#define SC_SOFTWARE_WRAP_MODE_U_cropTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_cropTexture
#define SC_SOFTWARE_WRAP_MODE_V_cropTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_cropTexture
#define SC_USE_UV_MIN_MAX_cropTexture 0
#elif SC_USE_UV_MIN_MAX_cropTexture==1
#undef SC_USE_UV_MIN_MAX_cropTexture
#define SC_USE_UV_MIN_MAX_cropTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_cropTexture
#define SC_USE_CLAMP_TO_BORDER_cropTexture 0
#elif SC_USE_CLAMP_TO_BORDER_cropTexture==1
#undef SC_USE_CLAMP_TO_BORDER_cropTexture
#define SC_USE_CLAMP_TO_BORDER_cropTexture 1
#endif
#ifndef confidenceTextureUV
#define confidenceTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_confidenceTexture
#define SC_USE_UV_TRANSFORM_confidenceTexture 0
#elif SC_USE_UV_TRANSFORM_confidenceTexture==1
#undef SC_USE_UV_TRANSFORM_confidenceTexture
#define SC_USE_UV_TRANSFORM_confidenceTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_confidenceTexture
#define SC_SOFTWARE_WRAP_MODE_U_confidenceTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_confidenceTexture
#define SC_SOFTWARE_WRAP_MODE_V_confidenceTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_confidenceTexture
#define SC_USE_UV_MIN_MAX_confidenceTexture 0
#elif SC_USE_UV_MIN_MAX_confidenceTexture==1
#undef SC_USE_UV_MIN_MAX_confidenceTexture
#define SC_USE_UV_MIN_MAX_confidenceTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_confidenceTexture
#define SC_USE_CLAMP_TO_BORDER_confidenceTexture 0
#elif SC_USE_CLAMP_TO_BORDER_confidenceTexture==1
#undef SC_USE_CLAMP_TO_BORDER_confidenceTexture
#define SC_USE_CLAMP_TO_BORDER_confidenceTexture 1
#endif
struct sc_Set2
{
texture2d<float> confidenceTexture [[id(0)]];
texture2d<float> cropTexture [[id(1)]];
sampler confidenceTextureSmpSC [[id(2)]];
sampler cropTextureSmpSC [[id(3)]];
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
float4 cropTextureSize;
float4 cropTextureDims;
float4 cropTextureView;
float3x3 cropTextureTransform;
float4 cropTextureUvMinMax;
float4 cropTextureBorderColor;
float4 confidenceTextureSize;
float4 confidenceTextureDims;
float4 confidenceTextureView;
float3x3 confidenceTextureTransform;
float4 confidenceTextureUvMinMax;
float4 confidenceTextureBorderColor;
float3x3 screenToCropTransform;
float2 depthProjectionMatrixTerms;
float minimumConfidence;
};
#ifndef cropTextureHasSwappedViews
#define cropTextureHasSwappedViews 0
#elif cropTextureHasSwappedViews==1
#undef cropTextureHasSwappedViews
#define cropTextureHasSwappedViews 1
#endif
#ifndef cropTextureLayout
#define cropTextureLayout 0
#endif
#ifndef confidenceTextureHasSwappedViews
#define confidenceTextureHasSwappedViews 0
#elif confidenceTextureHasSwappedViews==1
#undef confidenceTextureHasSwappedViews
#define confidenceTextureHasSwappedViews 1
#endif
#ifndef confidenceTextureLayout
#define confidenceTextureLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_confidenceTexture
#define SC_USE_UV_TRANSFORM_confidenceTexture 0
#elif SC_USE_UV_TRANSFORM_confidenceTexture==1
#undef SC_USE_UV_TRANSFORM_confidenceTexture
#define SC_USE_UV_TRANSFORM_confidenceTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_confidenceTexture
#define SC_SOFTWARE_WRAP_MODE_U_confidenceTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_confidenceTexture
#define SC_SOFTWARE_WRAP_MODE_V_confidenceTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_confidenceTexture
#define SC_USE_UV_MIN_MAX_confidenceTexture 0
#elif SC_USE_UV_MIN_MAX_confidenceTexture==1
#undef SC_USE_UV_MIN_MAX_confidenceTexture
#define SC_USE_UV_MIN_MAX_confidenceTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_confidenceTexture
#define SC_USE_CLAMP_TO_BORDER_confidenceTexture 0
#elif SC_USE_CLAMP_TO_BORDER_confidenceTexture==1
#undef SC_USE_CLAMP_TO_BORDER_confidenceTexture
#define SC_USE_CLAMP_TO_BORDER_confidenceTexture 1
#endif
#ifndef SC_USE_UV_TRANSFORM_cropTexture
#define SC_USE_UV_TRANSFORM_cropTexture 0
#elif SC_USE_UV_TRANSFORM_cropTexture==1
#undef SC_USE_UV_TRANSFORM_cropTexture
#define SC_USE_UV_TRANSFORM_cropTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_cropTexture
#define SC_SOFTWARE_WRAP_MODE_U_cropTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_cropTexture
#define SC_SOFTWARE_WRAP_MODE_V_cropTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_cropTexture
#define SC_USE_UV_MIN_MAX_cropTexture 0
#elif SC_USE_UV_MIN_MAX_cropTexture==1
#undef SC_USE_UV_MIN_MAX_cropTexture
#define SC_USE_UV_MIN_MAX_cropTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_cropTexture
#define SC_USE_CLAMP_TO_BORDER_cropTexture 0
#elif SC_USE_CLAMP_TO_BORDER_cropTexture==1
#undef SC_USE_CLAMP_TO_BORDER_cropTexture
#define SC_USE_CLAMP_TO_BORDER_cropTexture 1
#endif
#ifndef cropTextureUV
#define cropTextureUV 0
#endif
#ifndef confidenceTextureUV
#define confidenceTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> confidenceTexture [[id(0)]];
texture2d<float> cropTexture [[id(1)]];
sampler confidenceTextureSmpSC [[id(2)]];
sampler cropTextureSmpSC [[id(3)]];
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
float2 confidenceTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.confidenceTextureDims.xy;
}
int confidenceTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (confidenceTextureHasSwappedViews)
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
float2 cropTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.cropTextureDims.xy;
}
int cropTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (cropTextureHasSwappedViews)
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
float2 pos=float2(((*sc_set2.UserUniforms).screenToCropTransform*float3(sc_fragIn.sc_sysIn.varPackedTex.xy,1.0)).xy);
float fragDepth=1.0;
float l9_0=pos.x;
bool l9_1=0.0<=l9_0;
bool l9_2;
if (l9_1)
{
l9_2=pos.x<=1.0;
}
else
{
l9_2=l9_1;
}
bool l9_3;
if (l9_2)
{
l9_3=0.0<=pos.y;
}
else
{
l9_3=l9_2;
}
bool l9_4;
if (l9_3)
{
l9_4=pos.y<=1.0;
}
else
{
l9_4=l9_3;
}
if (l9_4)
{
float2 param=confidenceTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=confidenceTextureLayout;
int param_2=confidenceTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=pos;
bool param_4=(int(SC_USE_UV_TRANSFORM_confidenceTexture)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).confidenceTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_confidenceTexture,SC_SOFTWARE_WRAP_MODE_V_confidenceTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_confidenceTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).confidenceTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_confidenceTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).confidenceTextureBorderColor;
float param_11=0.0;
float4 l9_5=sc_SampleTextureBiasOrLevel(sc_set2.confidenceTexture,sc_set2.confidenceTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_6=l9_5;
float4 confidenceTextureSample=l9_5;
float confidence=confidenceTextureSample.x;
if (confidence>=(*sc_set2.UserUniforms).minimumConfidence)
{
float2 param_12=cropTextureGetDims2D((*sc_set2.UserUniforms));
int param_13=cropTextureLayout;
int param_14=cropTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_15=pos;
bool param_16=(int(SC_USE_UV_TRANSFORM_cropTexture)!=0);
float3x3 param_17=(*sc_set2.UserUniforms).cropTextureTransform;
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_cropTexture,SC_SOFTWARE_WRAP_MODE_V_cropTexture);
bool param_19=(int(SC_USE_UV_MIN_MAX_cropTexture)!=0);
float4 param_20=(*sc_set2.UserUniforms).cropTextureUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_cropTexture)!=0);
float4 param_22=(*sc_set2.UserUniforms).cropTextureBorderColor;
float param_23=0.0;
float4 l9_7=sc_SampleTextureBiasOrLevel(sc_set2.cropTexture,sc_set2.cropTextureSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_8=l9_7;
float4 cropTextureSample=l9_7;
float depth=cropTextureSample.x;
float param_24=depth;
float2 param_25=(*sc_set2.UserUniforms).depthProjectionMatrixTerms;
float l9_9=depthViewToScreenSpace(param_24,param_25);
fragDepth=l9_9;
}
}
float param_26=fragDepth;
sc_writeFragDepth(param_26,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

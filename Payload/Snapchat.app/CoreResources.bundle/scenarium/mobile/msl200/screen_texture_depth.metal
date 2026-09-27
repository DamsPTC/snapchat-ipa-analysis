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
//sampler sampler screenTextureSmpSC 2:1
//texture texture2D screenTexture 2:0:2:1
//ubo float UserUniforms 2:2:208 {
//float4 screenTextureSize 0
//float4 screenTextureDims 16
//float4 screenTextureView 32
//float3x3 screenTextureTransform 48
//float4 screenTextureUvMinMax 96
//float4 screenTextureBorderColor 112
//float2 screenTextureProjectionMatrixTerms 128
//float2 currentProjectionMatrixTerms 136
//float2 inputProjectionMatrixTerms 144
//float3x3 meshTransform 160
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 screenTextureSize;
float4 screenTextureDims;
float4 screenTextureView;
float3x3 screenTextureTransform;
float4 screenTextureUvMinMax;
float4 screenTextureBorderColor;
float2 screenTextureProjectionMatrixTerms;
float2 currentProjectionMatrixTerms;
float2 inputProjectionMatrixTerms;
float3x3 meshTransform;
};
#ifndef screenTextureHasSwappedViews
#define screenTextureHasSwappedViews 0
#elif screenTextureHasSwappedViews==1
#undef screenTextureHasSwappedViews
#define screenTextureHasSwappedViews 1
#endif
#ifndef screenTextureLayout
#define screenTextureLayout 0
#endif
#ifndef USE_MESH_TRANSFORM
#define USE_MESH_TRANSFORM 0
#elif USE_MESH_TRANSFORM==1
#undef USE_MESH_TRANSFORM
#define USE_MESH_TRANSFORM 1
#endif
#ifndef ONLY_VERTEX_ATTRIBUTE
#define ONLY_VERTEX_ATTRIBUTE 0
#elif ONLY_VERTEX_ATTRIBUTE==1
#undef ONLY_VERTEX_ATTRIBUTE
#define ONLY_VERTEX_ATTRIBUTE 1
#endif
#ifndef screenTextureUV
#define screenTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_screenTexture
#define SC_USE_UV_TRANSFORM_screenTexture 0
#elif SC_USE_UV_TRANSFORM_screenTexture==1
#undef SC_USE_UV_TRANSFORM_screenTexture
#define SC_USE_UV_TRANSFORM_screenTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_screenTexture
#define SC_SOFTWARE_WRAP_MODE_U_screenTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_screenTexture
#define SC_SOFTWARE_WRAP_MODE_V_screenTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_screenTexture
#define SC_USE_UV_MIN_MAX_screenTexture 0
#elif SC_USE_UV_MIN_MAX_screenTexture==1
#undef SC_USE_UV_MIN_MAX_screenTexture
#define SC_USE_UV_MIN_MAX_screenTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_screenTexture
#define SC_USE_CLAMP_TO_BORDER_screenTexture 0
#elif SC_USE_CLAMP_TO_BORDER_screenTexture==1
#undef SC_USE_CLAMP_TO_BORDER_screenTexture
#define SC_USE_CLAMP_TO_BORDER_screenTexture 1
#endif
struct sc_Set2
{
texture2d<float> screenTexture [[id(0)]];
sampler screenTextureSmpSC [[id(1)]];
constant userUniformsObj* UserUniforms [[id(2)]];
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
float4 unmodifiedPosition=v.position;
#if (USE_MESH_TRANSFORM)
{
v.position=float4((*sc_set2.UserUniforms).meshTransform*float3(v.position.xy,1.0),1.0);
}
#endif
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
#if (ONLY_VERTEX_ATTRIBUTE)
{
float2 l9_0=(unmodifiedPosition.xy+float2(1.0))*0.5;
sc_vertOut.sc_sysOut.varPackedTex=float4(l9_0.x,l9_0.y,sc_vertOut.sc_sysOut.varPackedTex.z,sc_vertOut.sc_sysOut.varPackedTex.w);
}
#endif
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 screenTextureSize;
float4 screenTextureDims;
float4 screenTextureView;
float3x3 screenTextureTransform;
float4 screenTextureUvMinMax;
float4 screenTextureBorderColor;
float2 screenTextureProjectionMatrixTerms;
float2 currentProjectionMatrixTerms;
float2 inputProjectionMatrixTerms;
float3x3 meshTransform;
};
#ifndef screenTextureHasSwappedViews
#define screenTextureHasSwappedViews 0
#elif screenTextureHasSwappedViews==1
#undef screenTextureHasSwappedViews
#define screenTextureHasSwappedViews 1
#endif
#ifndef screenTextureLayout
#define screenTextureLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_screenTexture
#define SC_USE_UV_TRANSFORM_screenTexture 0
#elif SC_USE_UV_TRANSFORM_screenTexture==1
#undef SC_USE_UV_TRANSFORM_screenTexture
#define SC_USE_UV_TRANSFORM_screenTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_screenTexture
#define SC_SOFTWARE_WRAP_MODE_U_screenTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_screenTexture
#define SC_SOFTWARE_WRAP_MODE_V_screenTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_screenTexture
#define SC_USE_UV_MIN_MAX_screenTexture 0
#elif SC_USE_UV_MIN_MAX_screenTexture==1
#undef SC_USE_UV_MIN_MAX_screenTexture
#define SC_USE_UV_MIN_MAX_screenTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_screenTexture
#define SC_USE_CLAMP_TO_BORDER_screenTexture 0
#elif SC_USE_CLAMP_TO_BORDER_screenTexture==1
#undef SC_USE_CLAMP_TO_BORDER_screenTexture
#define SC_USE_CLAMP_TO_BORDER_screenTexture 1
#endif
#ifndef USE_MESH_TRANSFORM
#define USE_MESH_TRANSFORM 0
#elif USE_MESH_TRANSFORM==1
#undef USE_MESH_TRANSFORM
#define USE_MESH_TRANSFORM 1
#endif
#ifndef ONLY_VERTEX_ATTRIBUTE
#define ONLY_VERTEX_ATTRIBUTE 0
#elif ONLY_VERTEX_ATTRIBUTE==1
#undef ONLY_VERTEX_ATTRIBUTE
#define ONLY_VERTEX_ATTRIBUTE 1
#endif
#ifndef screenTextureUV
#define screenTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> screenTexture [[id(0)]];
sampler screenTextureSmpSC [[id(1)]];
constant userUniformsObj* UserUniforms [[id(2)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
};
float2 screenTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.screenTextureDims.xy;
}
int screenTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (screenTextureHasSwappedViews)
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
float2 param=screenTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=screenTextureLayout;
int param_2=screenTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=(int(SC_USE_UV_TRANSFORM_screenTexture)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).screenTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_screenTexture,SC_SOFTWARE_WRAP_MODE_V_screenTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_screenTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).screenTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_screenTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).screenTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.screenTexture,sc_set2.screenTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float depth=l9_0.x;
float l9_2=depth;
bool l9_3=l9_2<1.0;
bool l9_4;
if (l9_3)
{
l9_4=any((*sc_set2.UserUniforms).inputProjectionMatrixTerms!=(*sc_set2.UserUniforms).currentProjectionMatrixTerms);
}
else
{
l9_4=l9_3;
}
if (l9_4)
{
float param_12=depth;
float2 param_13=(*sc_set2.UserUniforms).inputProjectionMatrixTerms;
float l9_5=depthScreenToViewSpace(param_12,param_13);
depth=l9_5;
float param_14=depth;
float2 param_15=(*sc_set2.UserUniforms).currentProjectionMatrixTerms;
float l9_6=depthViewToScreenSpace(param_14,param_15);
depth=l9_6;
}
float param_16=depth;
sc_writeFragDepth(param_16,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

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
//sampler sampler patchTextureSmpSC 2:1
//texture texture2D patchTexture 2:0:2:1
//ubo float UserUniforms 2:2:192 {
//float4 patchTextureSize 0
//float4 patchTextureDims 16
//float4 patchTextureView 32
//float3x3 patchTextureTransform 48
//float4 patchTextureUvMinMax 96
//float4 patchTextureBorderColor 112
//float4x4 modelView 128
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 patchTextureSize;
float4 patchTextureDims;
float4 patchTextureView;
float3x3 patchTextureTransform;
float4 patchTextureUvMinMax;
float4 patchTextureBorderColor;
float4x4 modelView;
};
#ifndef patchTextureHasSwappedViews
#define patchTextureHasSwappedViews 0
#elif patchTextureHasSwappedViews==1
#undef patchTextureHasSwappedViews
#define patchTextureHasSwappedViews 1
#endif
#ifndef patchTextureLayout
#define patchTextureLayout 0
#endif
#ifndef patchTextureUV
#define patchTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_patchTexture
#define SC_USE_UV_TRANSFORM_patchTexture 0
#elif SC_USE_UV_TRANSFORM_patchTexture==1
#undef SC_USE_UV_TRANSFORM_patchTexture
#define SC_USE_UV_TRANSFORM_patchTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_patchTexture
#define SC_SOFTWARE_WRAP_MODE_U_patchTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_patchTexture
#define SC_SOFTWARE_WRAP_MODE_V_patchTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_patchTexture
#define SC_USE_UV_MIN_MAX_patchTexture 0
#elif SC_USE_UV_MIN_MAX_patchTexture==1
#undef SC_USE_UV_MIN_MAX_patchTexture
#define SC_USE_UV_MIN_MAX_patchTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_patchTexture
#define SC_USE_CLAMP_TO_BORDER_patchTexture 0
#elif SC_USE_CLAMP_TO_BORDER_patchTexture==1
#undef SC_USE_CLAMP_TO_BORDER_patchTexture
#define SC_USE_CLAMP_TO_BORDER_patchTexture 1
#endif
struct sc_Set2
{
texture2d<float> patchTexture [[id(0)]];
sampler patchTextureSmpSC [[id(1)]];
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
v.position=(*sc_set2.UserUniforms).modelView*v.position;
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 patchTextureSize;
float4 patchTextureDims;
float4 patchTextureView;
float3x3 patchTextureTransform;
float4 patchTextureUvMinMax;
float4 patchTextureBorderColor;
float4x4 modelView;
};
#ifndef patchTextureHasSwappedViews
#define patchTextureHasSwappedViews 0
#elif patchTextureHasSwappedViews==1
#undef patchTextureHasSwappedViews
#define patchTextureHasSwappedViews 1
#endif
#ifndef patchTextureLayout
#define patchTextureLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_patchTexture
#define SC_USE_UV_TRANSFORM_patchTexture 0
#elif SC_USE_UV_TRANSFORM_patchTexture==1
#undef SC_USE_UV_TRANSFORM_patchTexture
#define SC_USE_UV_TRANSFORM_patchTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_patchTexture
#define SC_SOFTWARE_WRAP_MODE_U_patchTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_patchTexture
#define SC_SOFTWARE_WRAP_MODE_V_patchTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_patchTexture
#define SC_USE_UV_MIN_MAX_patchTexture 0
#elif SC_USE_UV_MIN_MAX_patchTexture==1
#undef SC_USE_UV_MIN_MAX_patchTexture
#define SC_USE_UV_MIN_MAX_patchTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_patchTexture
#define SC_USE_CLAMP_TO_BORDER_patchTexture 0
#elif SC_USE_CLAMP_TO_BORDER_patchTexture==1
#undef SC_USE_CLAMP_TO_BORDER_patchTexture
#define SC_USE_CLAMP_TO_BORDER_patchTexture 1
#endif
#ifndef patchTextureUV
#define patchTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> patchTexture [[id(0)]];
sampler patchTextureSmpSC [[id(1)]];
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
float2 patchTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.patchTextureDims.xy;
}
int patchTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (patchTextureHasSwappedViews)
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
float2 param=patchTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=patchTextureLayout;
int param_2=patchTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=(int(SC_USE_UV_TRANSFORM_patchTexture)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).patchTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_patchTexture,SC_SOFTWARE_WRAP_MODE_V_patchTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_patchTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).patchTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_patchTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).patchTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.patchTexture,sc_set2.patchTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 patchTextureSample=l9_0;
float4 param_12=float4(patchTextureSample.xyz,1.0);
sc_writeFragData0(param_12,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

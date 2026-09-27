#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE0 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "std2_vs.metal"
#include "std2_fs.metal"
#include "std2_texture.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler sc_OITDepthBoundsTextureSmpSC 2:1
//texture texture2D sc_OITDepthBoundsTexture 2:0:2:1
//ubo float UserUniforms 2:2:128 {
//float4 sc_OITDepthBoundsTextureSize 0
//float4 sc_OITDepthBoundsTextureDims 16
//float4 sc_OITDepthBoundsTextureView 32
//float3x3 sc_OITDepthBoundsTextureTransform 48
//float4 sc_OITDepthBoundsTextureUvMinMax 96
//float4 sc_OITDepthBoundsTextureBorderColor 112
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 sc_OITDepthBoundsTextureSize;
float4 sc_OITDepthBoundsTextureDims;
float4 sc_OITDepthBoundsTextureView;
float3x3 sc_OITDepthBoundsTextureTransform;
float4 sc_OITDepthBoundsTextureUvMinMax;
float4 sc_OITDepthBoundsTextureBorderColor;
};
#ifndef sc_OITDepthBoundsTextureHasSwappedViews
#define sc_OITDepthBoundsTextureHasSwappedViews 0
#elif sc_OITDepthBoundsTextureHasSwappedViews==1
#undef sc_OITDepthBoundsTextureHasSwappedViews
#define sc_OITDepthBoundsTextureHasSwappedViews 1
#endif
#ifndef sc_OITDepthBoundsTextureLayout
#define sc_OITDepthBoundsTextureLayout 0
#endif
#ifndef sc_DepthBoundsTextureSize
#define sc_DepthBoundsTextureSize 128
#endif
#ifndef sc_OITDepthBoundsTextureUV
#define sc_OITDepthBoundsTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_sc_OITDepthBoundsTexture
#define SC_USE_UV_TRANSFORM_sc_OITDepthBoundsTexture 0
#elif SC_USE_UV_TRANSFORM_sc_OITDepthBoundsTexture==1
#undef SC_USE_UV_TRANSFORM_sc_OITDepthBoundsTexture
#define SC_USE_UV_TRANSFORM_sc_OITDepthBoundsTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_sc_OITDepthBoundsTexture
#define SC_SOFTWARE_WRAP_MODE_U_sc_OITDepthBoundsTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_sc_OITDepthBoundsTexture
#define SC_SOFTWARE_WRAP_MODE_V_sc_OITDepthBoundsTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_sc_OITDepthBoundsTexture
#define SC_USE_UV_MIN_MAX_sc_OITDepthBoundsTexture 0
#elif SC_USE_UV_MIN_MAX_sc_OITDepthBoundsTexture==1
#undef SC_USE_UV_MIN_MAX_sc_OITDepthBoundsTexture
#define SC_USE_UV_MIN_MAX_sc_OITDepthBoundsTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_sc_OITDepthBoundsTexture
#define SC_USE_CLAMP_TO_BORDER_sc_OITDepthBoundsTexture 0
#elif SC_USE_CLAMP_TO_BORDER_sc_OITDepthBoundsTexture==1
#undef SC_USE_CLAMP_TO_BORDER_sc_OITDepthBoundsTexture
#define SC_USE_CLAMP_TO_BORDER_sc_OITDepthBoundsTexture 1
#endif
struct sc_Set2
{
texture2d<float> sc_OITDepthBoundsTexture [[id(0)]];
sampler sc_OITDepthBoundsTextureSmpSC [[id(1)]];
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
float2 l9_0=(v.position.xy*0.5)+float2(0.5);
sc_vertOut.sc_sysOut.varPackedTex=float4(l9_0.x,l9_0.y,sc_vertOut.sc_sysOut.varPackedTex.z,sc_vertOut.sc_sysOut.varPackedTex.w);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 sc_OITDepthBoundsTextureSize;
float4 sc_OITDepthBoundsTextureDims;
float4 sc_OITDepthBoundsTextureView;
float3x3 sc_OITDepthBoundsTextureTransform;
float4 sc_OITDepthBoundsTextureUvMinMax;
float4 sc_OITDepthBoundsTextureBorderColor;
};
#ifndef sc_OITDepthBoundsTextureHasSwappedViews
#define sc_OITDepthBoundsTextureHasSwappedViews 0
#elif sc_OITDepthBoundsTextureHasSwappedViews==1
#undef sc_OITDepthBoundsTextureHasSwappedViews
#define sc_OITDepthBoundsTextureHasSwappedViews 1
#endif
#ifndef sc_OITDepthBoundsTextureLayout
#define sc_OITDepthBoundsTextureLayout 0
#endif
#ifndef sc_DepthBoundsTextureSize
#define sc_DepthBoundsTextureSize 128
#endif
#ifndef SC_USE_UV_TRANSFORM_sc_OITDepthBoundsTexture
#define SC_USE_UV_TRANSFORM_sc_OITDepthBoundsTexture 0
#elif SC_USE_UV_TRANSFORM_sc_OITDepthBoundsTexture==1
#undef SC_USE_UV_TRANSFORM_sc_OITDepthBoundsTexture
#define SC_USE_UV_TRANSFORM_sc_OITDepthBoundsTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_sc_OITDepthBoundsTexture
#define SC_SOFTWARE_WRAP_MODE_U_sc_OITDepthBoundsTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_sc_OITDepthBoundsTexture
#define SC_SOFTWARE_WRAP_MODE_V_sc_OITDepthBoundsTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_sc_OITDepthBoundsTexture
#define SC_USE_UV_MIN_MAX_sc_OITDepthBoundsTexture 0
#elif SC_USE_UV_MIN_MAX_sc_OITDepthBoundsTexture==1
#undef SC_USE_UV_MIN_MAX_sc_OITDepthBoundsTexture
#define SC_USE_UV_MIN_MAX_sc_OITDepthBoundsTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_sc_OITDepthBoundsTexture
#define SC_USE_CLAMP_TO_BORDER_sc_OITDepthBoundsTexture 0
#elif SC_USE_CLAMP_TO_BORDER_sc_OITDepthBoundsTexture==1
#undef SC_USE_CLAMP_TO_BORDER_sc_OITDepthBoundsTexture
#define SC_USE_CLAMP_TO_BORDER_sc_OITDepthBoundsTexture 1
#endif
#ifndef sc_OITDepthBoundsTextureUV
#define sc_OITDepthBoundsTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> sc_OITDepthBoundsTexture [[id(0)]];
sampler sc_OITDepthBoundsTextureSmpSC [[id(1)]];
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
float2 sc_OITDepthBoundsTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.sc_OITDepthBoundsTextureDims.xy;
}
int sc_OITDepthBoundsTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (sc_OITDepthBoundsTextureHasSwappedViews)
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
float2 sampleDepthBounds(thread float2& depthBounds,thread const float2& screenUV,thread const float2& offset,constant userUniformsObj& UserUniforms,thread texture2d<float> sc_OITDepthBoundsTexture,thread sampler sc_OITDepthBoundsTextureSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 param=sc_OITDepthBoundsTextureGetDims2D(UserUniforms);
int param_1=sc_OITDepthBoundsTextureLayout;
int param_2=sc_OITDepthBoundsTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_3=screenUV+(offset/float2(float(sc_DepthBoundsTextureSize)));
bool param_4=(int(SC_USE_UV_TRANSFORM_sc_OITDepthBoundsTexture)!=0);
float3x3 param_5=UserUniforms.sc_OITDepthBoundsTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_sc_OITDepthBoundsTexture,SC_SOFTWARE_WRAP_MODE_V_sc_OITDepthBoundsTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_sc_OITDepthBoundsTexture)!=0);
float4 param_8=UserUniforms.sc_OITDepthBoundsTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_sc_OITDepthBoundsTexture)!=0);
float4 param_10=UserUniforms.sc_OITDepthBoundsTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_OITDepthBoundsTexture,sc_OITDepthBoundsTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 sc_OITDepthBoundsTextureSample=l9_0;
float2 oitDepthSample=sc_OITDepthBoundsTextureSample.xy;
depthBounds=float2(fast::max(depthBounds.x,oitDepthSample.x),fast::max(depthBounds.y,oitDepthSample.y));
return depthBounds;
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 depthBounds=float2(0.0);
float2 param=depthBounds;
float2 param_1=sc_fragIn.sc_sysIn.varPackedTex.xy;
float2 param_2=float2(0.0);
float2 l9_0=sampleDepthBounds(param,param_1,param_2,(*sc_set2.UserUniforms),sc_set2.sc_OITDepthBoundsTexture,sc_set2.sc_OITDepthBoundsTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
depthBounds=l9_0;
float2 param_3=depthBounds;
float2 param_4=sc_fragIn.sc_sysIn.varPackedTex.xy;
float2 param_5=float2(-1.0,0.0);
float2 l9_1=sampleDepthBounds(param_3,param_4,param_5,(*sc_set2.UserUniforms),sc_set2.sc_OITDepthBoundsTexture,sc_set2.sc_OITDepthBoundsTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
depthBounds=l9_1;
float2 param_6=depthBounds;
float2 param_7=sc_fragIn.sc_sysIn.varPackedTex.xy;
float2 param_8=float2(1.0,0.0);
float2 l9_2=sampleDepthBounds(param_6,param_7,param_8,(*sc_set2.UserUniforms),sc_set2.sc_OITDepthBoundsTexture,sc_set2.sc_OITDepthBoundsTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
depthBounds=l9_2;
float2 param_9=depthBounds;
float2 param_10=sc_fragIn.sc_sysIn.varPackedTex.xy;
float2 param_11=float2(0.0,-1.0);
float2 l9_3=sampleDepthBounds(param_9,param_10,param_11,(*sc_set2.UserUniforms),sc_set2.sc_OITDepthBoundsTexture,sc_set2.sc_OITDepthBoundsTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
depthBounds=l9_3;
float2 param_12=depthBounds;
float2 param_13=sc_fragIn.sc_sysIn.varPackedTex.xy;
float2 param_14=float2(0.0,1.0);
float2 l9_4=sampleDepthBounds(param_12,param_13,param_14,(*sc_set2.UserUniforms),sc_set2.sc_OITDepthBoundsTexture,sc_set2.sc_OITDepthBoundsTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
depthBounds=l9_4;
float4 param_15=float4(depthBounds.x,depthBounds.y,0.0,0.0);
sc_writeFragData0(param_15,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

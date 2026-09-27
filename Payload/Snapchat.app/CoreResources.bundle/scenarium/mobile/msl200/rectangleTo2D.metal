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
//sampler sampler rectTextureSmpSC 2:1
//texture texture2D rectTexture 2:0:2:1
//ubo float UserUniforms 2:2:128 {
//float4 rectTextureSize 0
//float4 rectTextureDims 16
//float4 rectTextureView 32
//float3x3 rectTextureTransform 48
//float4 rectTextureUvMinMax 96
//float4 rectTextureBorderColor 112
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 rectTextureSize;
float4 rectTextureDims;
float4 rectTextureView;
float3x3 rectTextureTransform;
float4 rectTextureUvMinMax;
float4 rectTextureBorderColor;
};
#ifndef rectTextureHasSwappedViews
#define rectTextureHasSwappedViews 0
#elif rectTextureHasSwappedViews==1
#undef rectTextureHasSwappedViews
#define rectTextureHasSwappedViews 1
#endif
#ifndef rectTextureLayout
#define rectTextureLayout 0
#endif
#ifndef ARGBTEX_SWIZZLE
#define ARGBTEX_SWIZZLE 0
#elif ARGBTEX_SWIZZLE==1
#undef ARGBTEX_SWIZZLE
#define ARGBTEX_SWIZZLE 1
#endif
#ifndef rectTextureUV
#define rectTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_rectTexture
#define SC_USE_UV_TRANSFORM_rectTexture 0
#elif SC_USE_UV_TRANSFORM_rectTexture==1
#undef SC_USE_UV_TRANSFORM_rectTexture
#define SC_USE_UV_TRANSFORM_rectTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_rectTexture
#define SC_SOFTWARE_WRAP_MODE_U_rectTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_rectTexture
#define SC_SOFTWARE_WRAP_MODE_V_rectTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_rectTexture
#define SC_USE_UV_MIN_MAX_rectTexture 0
#elif SC_USE_UV_MIN_MAX_rectTexture==1
#undef SC_USE_UV_MIN_MAX_rectTexture
#define SC_USE_UV_MIN_MAX_rectTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_rectTexture
#define SC_USE_CLAMP_TO_BORDER_rectTexture 0
#elif SC_USE_CLAMP_TO_BORDER_rectTexture==1
#undef SC_USE_CLAMP_TO_BORDER_rectTexture
#define SC_USE_CLAMP_TO_BORDER_rectTexture 1
#endif
struct sc_Set2
{
texture2d<float> rectTexture [[id(0)]];
sampler rectTextureSmpSC [[id(1)]];
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
v.texture0=v.texture0;
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 rectTextureSize;
float4 rectTextureDims;
float4 rectTextureView;
float3x3 rectTextureTransform;
float4 rectTextureUvMinMax;
float4 rectTextureBorderColor;
};
#ifndef rectTextureHasSwappedViews
#define rectTextureHasSwappedViews 0
#elif rectTextureHasSwappedViews==1
#undef rectTextureHasSwappedViews
#define rectTextureHasSwappedViews 1
#endif
#ifndef rectTextureLayout
#define rectTextureLayout 0
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_rectTexture
#define SC_SOFTWARE_WRAP_MODE_U_rectTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_rectTexture
#define SC_SOFTWARE_WRAP_MODE_V_rectTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_rectTexture
#define SC_USE_UV_MIN_MAX_rectTexture 0
#elif SC_USE_UV_MIN_MAX_rectTexture==1
#undef SC_USE_UV_MIN_MAX_rectTexture
#define SC_USE_UV_MIN_MAX_rectTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_rectTexture
#define SC_USE_CLAMP_TO_BORDER_rectTexture 0
#elif SC_USE_CLAMP_TO_BORDER_rectTexture==1
#undef SC_USE_CLAMP_TO_BORDER_rectTexture
#define SC_USE_CLAMP_TO_BORDER_rectTexture 1
#endif
#ifndef ARGBTEX_SWIZZLE
#define ARGBTEX_SWIZZLE 0
#elif ARGBTEX_SWIZZLE==1
#undef ARGBTEX_SWIZZLE
#define ARGBTEX_SWIZZLE 1
#endif
#ifndef rectTextureUV
#define rectTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_rectTexture
#define SC_USE_UV_TRANSFORM_rectTexture 0
#elif SC_USE_UV_TRANSFORM_rectTexture==1
#undef SC_USE_UV_TRANSFORM_rectTexture
#define SC_USE_UV_TRANSFORM_rectTexture 1
#endif
struct sc_Set2
{
texture2d<float> rectTexture [[id(0)]];
sampler rectTextureSmpSC [[id(1)]];
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
float2 rectTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.rectTextureDims.xy;
}
int rectTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (rectTextureHasSwappedViews)
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
float2 param=rectTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=rectTextureLayout;
int param_2=rectTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=false;
float3x3 param_5=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_rectTexture,SC_SOFTWARE_WRAP_MODE_V_rectTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_rectTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).rectTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_rectTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).rectTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.rectTexture,sc_set2.rectTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 rectTextureSample=l9_0;
#if (ARGBTEX_SWIZZLE)
{
rectTextureSample=rectTextureSample.yxwz;
}
#endif
float4 param_12=rectTextureSample;
sc_writeFragData0(param_12,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

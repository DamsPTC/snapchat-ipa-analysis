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
//sampler sampler depthTextureSmpSC 2:1
//texture texture2D depthTexture 2:0:2:1
//ubo float UserUniforms 2:2:144 {
//float4 depthTextureSize 0
//float4 depthTextureDims 16
//float4 depthTextureView 32
//float3x3 depthTextureTransform 48
//float4 depthTextureUvMinMax 96
//float4 depthTextureBorderColor 112
//float depthScale 128
//float depthToDisparityNumerator 132
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 depthTextureSize;
float4 depthTextureDims;
float4 depthTextureView;
float3x3 depthTextureTransform;
float4 depthTextureUvMinMax;
float4 depthTextureBorderColor;
float depthScale;
float depthToDisparityNumerator;
};
#ifndef depthTextureHasSwappedViews
#define depthTextureHasSwappedViews 0
#elif depthTextureHasSwappedViews==1
#undef depthTextureHasSwappedViews
#define depthTextureHasSwappedViews 1
#endif
#ifndef depthTextureLayout
#define depthTextureLayout 0
#endif
#ifndef PACKED_DISPARITY
#define PACKED_DISPARITY 0
#elif PACKED_DISPARITY==1
#undef PACKED_DISPARITY
#define PACKED_DISPARITY 1
#endif
#ifndef depthTextureUV
#define depthTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_depthTexture
#define SC_USE_UV_TRANSFORM_depthTexture 0
#elif SC_USE_UV_TRANSFORM_depthTexture==1
#undef SC_USE_UV_TRANSFORM_depthTexture
#define SC_USE_UV_TRANSFORM_depthTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_depthTexture
#define SC_SOFTWARE_WRAP_MODE_U_depthTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_depthTexture
#define SC_SOFTWARE_WRAP_MODE_V_depthTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_depthTexture
#define SC_USE_UV_MIN_MAX_depthTexture 0
#elif SC_USE_UV_MIN_MAX_depthTexture==1
#undef SC_USE_UV_MIN_MAX_depthTexture
#define SC_USE_UV_MIN_MAX_depthTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_depthTexture
#define SC_USE_CLAMP_TO_BORDER_depthTexture 0
#elif SC_USE_CLAMP_TO_BORDER_depthTexture==1
#undef SC_USE_CLAMP_TO_BORDER_depthTexture
#define SC_USE_CLAMP_TO_BORDER_depthTexture 1
#endif
struct sc_Set2
{
texture2d<float> depthTexture [[id(0)]];
sampler depthTextureSmpSC [[id(1)]];
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
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 depthTextureSize;
float4 depthTextureDims;
float4 depthTextureView;
float3x3 depthTextureTransform;
float4 depthTextureUvMinMax;
float4 depthTextureBorderColor;
float depthScale;
float depthToDisparityNumerator;
};
#ifndef depthTextureHasSwappedViews
#define depthTextureHasSwappedViews 0
#elif depthTextureHasSwappedViews==1
#undef depthTextureHasSwappedViews
#define depthTextureHasSwappedViews 1
#endif
#ifndef depthTextureLayout
#define depthTextureLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_depthTexture
#define SC_USE_UV_TRANSFORM_depthTexture 0
#elif SC_USE_UV_TRANSFORM_depthTexture==1
#undef SC_USE_UV_TRANSFORM_depthTexture
#define SC_USE_UV_TRANSFORM_depthTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_depthTexture
#define SC_SOFTWARE_WRAP_MODE_U_depthTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_depthTexture
#define SC_SOFTWARE_WRAP_MODE_V_depthTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_depthTexture
#define SC_USE_UV_MIN_MAX_depthTexture 0
#elif SC_USE_UV_MIN_MAX_depthTexture==1
#undef SC_USE_UV_MIN_MAX_depthTexture
#define SC_USE_UV_MIN_MAX_depthTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_depthTexture
#define SC_USE_CLAMP_TO_BORDER_depthTexture 0
#elif SC_USE_CLAMP_TO_BORDER_depthTexture==1
#undef SC_USE_CLAMP_TO_BORDER_depthTexture
#define SC_USE_CLAMP_TO_BORDER_depthTexture 1
#endif
#ifndef PACKED_DISPARITY
#define PACKED_DISPARITY 0
#elif PACKED_DISPARITY==1
#undef PACKED_DISPARITY
#define PACKED_DISPARITY 1
#endif
#ifndef depthTextureUV
#define depthTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> depthTexture [[id(0)]];
sampler depthTextureSmpSC [[id(1)]];
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
float2 depthTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.depthTextureDims.xy;
}
int depthTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (depthTextureHasSwappedViews)
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
float decode2(thread const float2& rg)
{
return dot(rg,float2(1.0,0.0039215689));
}
float disparityToDepth(thread const float& disparity,thread const float& numerator)
{
return numerator/(disparity+9.9999997e-06);
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param=depthTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=depthTextureLayout;
int param_2=depthTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=(int(SC_USE_UV_TRANSFORM_depthTexture)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).depthTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_depthTexture,SC_SOFTWARE_WRAP_MODE_V_depthTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_depthTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).depthTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_depthTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).depthTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.depthTexture,sc_set2.depthTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 depthTextureSample=l9_0;
float depth=0.0;
#if (PACKED_DISPARITY)
{
float2 disparityPacked=depthTextureSample.xy;
float2 param_12=disparityPacked;
float param_13=decode2(param_12);
float param_14=(*sc_set2.UserUniforms).depthToDisparityNumerator;
depth=disparityToDepth(param_13,param_14)*(*sc_set2.UserUniforms).depthScale;
}
#else
{
depth=depthTextureSample.x*(*sc_set2.UserUniforms).depthScale;
}
#endif
float fragDepth=0.0;
float l9_2=depth;
bool l9_3=!isinf(l9_2);
bool l9_4;
if (l9_3)
{
l9_4=!isnan(depth);
}
else
{
l9_4=l9_3;
}
if (l9_4)
{
float4 projSpace=(*sc_set0.LibraryUniforms).sc_ProjectionMatrixArray[sc_GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1)]*float4(0.0,0.0,-depth,1.0);
fragDepth=((0.5*projSpace.z)/projSpace.w)+0.5;
}
float param_15=fragDepth;
sc_writeFragDepth(param_15,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

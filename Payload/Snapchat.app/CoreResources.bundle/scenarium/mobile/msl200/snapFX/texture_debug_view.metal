#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "required2.metal"
#include "std2_vs.metal"
#include "std2_fs.metal"
#include "std2_texture.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler leftTextureSmpSC 2:2
//sampler sampler rightTextureSmpSC 2:3
//texture texture2D leftTexture 2:0:2:2
//texture texture2D rightTexture 2:1:2:3
//SG_REFLECTION_END

namespace SNAP_VS {
struct sc_VertOut
{
sc_SysOut sc_sysOut;
};
struct sc_VertIn
{
sc_SysAttributes sc_sysAttributes;
};
vertex sc_VertOut main_vert(sc_VertIn sc_vertIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],uint gl_InstanceIndex [[instance_id]],uint gl_VertexIndex [[vertex_id]])
{
sc_SysIn sc_sysIn;
sc_sysIn.sc_sysAttributes=sc_vertIn.sc_sysAttributes;
sc_sysIn.gl_VertexIndex=gl_VertexIndex;
sc_sysIn.gl_InstanceIndex=gl_InstanceIndex;
sc_VertOut sc_vertOut={};
sc_Vertex_t v=sc_LoadVertexAttributes(sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
v.position=float4(sc_sysIn.sc_sysAttributes.position.xy,0.0,1.0);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 leftTextureSize;
float4 leftTextureDims;
float4 leftTextureView;
float3x3 leftTextureTransform;
float4 leftTextureUvMinMax;
float4 leftTextureBorderColor;
float4 rightTextureSize;
float4 rightTextureDims;
float4 rightTextureView;
float3x3 rightTextureTransform;
float4 rightTextureUvMinMax;
float4 rightTextureBorderColor;
float depthRange;
int leftTextureIsDepthBuffer;
int rightTextureIsDepthBuffer;
int splitView;
};
#ifndef leftTextureHasSwappedViews
#define leftTextureHasSwappedViews 0
#elif leftTextureHasSwappedViews==1
#undef leftTextureHasSwappedViews
#define leftTextureHasSwappedViews 1
#endif
#ifndef leftTextureLayout
#define leftTextureLayout 0
#endif
#ifndef rightTextureHasSwappedViews
#define rightTextureHasSwappedViews 0
#elif rightTextureHasSwappedViews==1
#undef rightTextureHasSwappedViews
#define rightTextureHasSwappedViews 1
#endif
#ifndef rightTextureLayout
#define rightTextureLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_leftTexture
#define SC_USE_UV_TRANSFORM_leftTexture 0
#elif SC_USE_UV_TRANSFORM_leftTexture==1
#undef SC_USE_UV_TRANSFORM_leftTexture
#define SC_USE_UV_TRANSFORM_leftTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_leftTexture
#define SC_SOFTWARE_WRAP_MODE_U_leftTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_leftTexture
#define SC_SOFTWARE_WRAP_MODE_V_leftTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_leftTexture
#define SC_USE_UV_MIN_MAX_leftTexture 0
#elif SC_USE_UV_MIN_MAX_leftTexture==1
#undef SC_USE_UV_MIN_MAX_leftTexture
#define SC_USE_UV_MIN_MAX_leftTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_leftTexture
#define SC_USE_CLAMP_TO_BORDER_leftTexture 0
#elif SC_USE_CLAMP_TO_BORDER_leftTexture==1
#undef SC_USE_CLAMP_TO_BORDER_leftTexture
#define SC_USE_CLAMP_TO_BORDER_leftTexture 1
#endif
#ifndef SC_USE_UV_TRANSFORM_rightTexture
#define SC_USE_UV_TRANSFORM_rightTexture 0
#elif SC_USE_UV_TRANSFORM_rightTexture==1
#undef SC_USE_UV_TRANSFORM_rightTexture
#define SC_USE_UV_TRANSFORM_rightTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_rightTexture
#define SC_SOFTWARE_WRAP_MODE_U_rightTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_rightTexture
#define SC_SOFTWARE_WRAP_MODE_V_rightTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_rightTexture
#define SC_USE_UV_MIN_MAX_rightTexture 0
#elif SC_USE_UV_MIN_MAX_rightTexture==1
#undef SC_USE_UV_MIN_MAX_rightTexture
#define SC_USE_UV_MIN_MAX_rightTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_rightTexture
#define SC_USE_CLAMP_TO_BORDER_rightTexture 0
#elif SC_USE_CLAMP_TO_BORDER_rightTexture==1
#undef SC_USE_CLAMP_TO_BORDER_rightTexture
#define SC_USE_CLAMP_TO_BORDER_rightTexture 1
#endif
#ifndef leftTextureUV
#define leftTextureUV 0
#endif
#ifndef rightTextureUV
#define rightTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> leftTexture [[id(0)]];
texture2d<float> rightTexture [[id(1)]];
sampler leftTextureSmpSC [[id(2)]];
sampler rightTextureSmpSC [[id(3)]];
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
float2 leftTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.leftTextureDims.xy;
}
int leftTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (leftTextureHasSwappedViews)
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
float2 rightTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.rightTextureDims.xy;
}
int rightTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (rightTextureHasSwappedViews)
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
bool isDepthBuffer=false;
float2 uv=(sc_fragIn.sc_sysIn.varScreenPos.xy*0.5)+float2(0.5);
bool l9_0=!((*sc_set2.UserUniforms).splitView!=0);
bool l9_1;
if (!l9_0)
{
l9_1=uv.x<=0.49900001;
}
else
{
l9_1=l9_0;
}
float4 result;
if (l9_1)
{
float2 param=leftTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=leftTextureLayout;
int param_2=leftTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=uv;
bool param_4=(int(SC_USE_UV_TRANSFORM_leftTexture)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).leftTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_leftTexture,SC_SOFTWARE_WRAP_MODE_V_leftTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_leftTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).leftTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_leftTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).leftTextureBorderColor;
float param_11=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.leftTexture,sc_set2.leftTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_3=l9_2;
result=l9_2;
isDepthBuffer=(*sc_set2.UserUniforms).leftTextureIsDepthBuffer!=0;
}
else
{
if (uv.x>=0.50099999)
{
float2 param_12=rightTextureGetDims2D((*sc_set2.UserUniforms));
int param_13=rightTextureLayout;
int param_14=rightTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_15=uv;
bool param_16=(int(SC_USE_UV_TRANSFORM_rightTexture)!=0);
float3x3 param_17=(*sc_set2.UserUniforms).rightTextureTransform;
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_rightTexture,SC_SOFTWARE_WRAP_MODE_V_rightTexture);
bool param_19=(int(SC_USE_UV_MIN_MAX_rightTexture)!=0);
float4 param_20=(*sc_set2.UserUniforms).rightTextureUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_rightTexture)!=0);
float4 param_22=(*sc_set2.UserUniforms).rightTextureBorderColor;
float param_23=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(sc_set2.rightTexture,sc_set2.rightTextureSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_5=l9_4;
result=l9_4;
isDepthBuffer=(*sc_set2.UserUniforms).rightTextureIsDepthBuffer!=0;
}
else
{
result=float4(0.0,0.0,1.0,1.0);
}
}
if (isDepthBuffer)
{
float param_24=result.x;
float linearDepth=depthScreenToViewSpace(param_24,sc_fragIn.sc_sysIn,sc_set0,sc_set1)/(*sc_set2.UserUniforms).depthRange;
result=float4(linearDepth,linearDepth,linearDepth,1.0);
}
float4 param_25=result;
sc_writeFragData0(param_25,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

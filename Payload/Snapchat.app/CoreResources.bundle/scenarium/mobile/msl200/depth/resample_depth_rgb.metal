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
//sampler sampler depthTextureSmpSC 2:2
//sampler sampler mainTextureSmpSC 2:3
//texture texture2D depthTexture 2:0:2:2
//texture texture2D mainTexture 2:1:2:3
//ubo float UserUniforms 2:4:272 {
//float4 mainTextureSize 0
//float4 mainTextureDims 16
//float4 mainTextureView 32
//float3x3 mainTextureTransform 48
//float4 mainTextureUvMinMax 96
//float4 mainTextureBorderColor 112
//float4 depthTextureSize 128
//float4 depthTextureDims 144
//float4 depthTextureView 160
//float3x3 depthTextureTransform 176
//float4 depthTextureUvMinMax 224
//float4 depthTextureBorderColor 240
//float depthToDisparityNumerator 256
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 mainTextureSize;
float4 mainTextureDims;
float4 mainTextureView;
float3x3 mainTextureTransform;
float4 mainTextureUvMinMax;
float4 mainTextureBorderColor;
float4 depthTextureSize;
float4 depthTextureDims;
float4 depthTextureView;
float3x3 depthTextureTransform;
float4 depthTextureUvMinMax;
float4 depthTextureBorderColor;
float depthToDisparityNumerator;
};
#ifndef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 0
#elif mainTextureHasSwappedViews==1
#undef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 1
#endif
#ifndef mainTextureLayout
#define mainTextureLayout 0
#endif
#ifndef depthTextureHasSwappedViews
#define depthTextureHasSwappedViews 0
#elif depthTextureHasSwappedViews==1
#undef depthTextureHasSwappedViews
#define depthTextureHasSwappedViews 1
#endif
#ifndef depthTextureLayout
#define depthTextureLayout 0
#endif
#ifndef CAMEOS_MATTING
#define CAMEOS_MATTING 0
#elif CAMEOS_MATTING==1
#undef CAMEOS_MATTING
#define CAMEOS_MATTING 1
#endif
#ifndef BY_Y
#define BY_Y 0
#elif BY_Y==1
#undef BY_Y
#define BY_Y 1
#endif
#ifndef RY_GY
#define RY_GY 0
#elif RY_GY==1
#undef RY_GY
#define RY_GY 1
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
texture2d<float> mainTexture [[id(1)]];
sampler depthTextureSmpSC [[id(2)]];
sampler mainTextureSmpSC [[id(3)]];
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
float4 mainTextureSize;
float4 mainTextureDims;
float4 mainTextureView;
float3x3 mainTextureTransform;
float4 mainTextureUvMinMax;
float4 mainTextureBorderColor;
float4 depthTextureSize;
float4 depthTextureDims;
float4 depthTextureView;
float3x3 depthTextureTransform;
float4 depthTextureUvMinMax;
float4 depthTextureBorderColor;
float depthToDisparityNumerator;
};
#ifndef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 0
#elif mainTextureHasSwappedViews==1
#undef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 1
#endif
#ifndef mainTextureLayout
#define mainTextureLayout 0
#endif
#ifndef depthTextureHasSwappedViews
#define depthTextureHasSwappedViews 0
#elif depthTextureHasSwappedViews==1
#undef depthTextureHasSwappedViews
#define depthTextureHasSwappedViews 1
#endif
#ifndef depthTextureLayout
#define depthTextureLayout 0
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
#ifndef CAMEOS_MATTING
#define CAMEOS_MATTING 0
#elif CAMEOS_MATTING==1
#undef CAMEOS_MATTING
#define CAMEOS_MATTING 1
#endif
#ifndef BY_Y
#define BY_Y 0
#elif BY_Y==1
#undef BY_Y
#define BY_Y 1
#endif
#ifndef RY_GY
#define RY_GY 0
#elif RY_GY==1
#undef RY_GY
#define RY_GY 1
#endif
#ifndef mainTextureUV
#define mainTextureUV 0
#endif
#ifndef depthTextureUV
#define depthTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> depthTexture [[id(0)]];
texture2d<float> mainTexture [[id(1)]];
sampler depthTextureSmpSC [[id(2)]];
sampler mainTextureSmpSC [[id(3)]];
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
float depthToDisparity(thread const float& depth,thread const float& numerator)
{
return fast::clamp(numerator/(depth+9.9999997e-06),0.0,0.99998999);
}
float2 encode2(thread const float& v)
{
float2 enc=fract(float2(1.0,255.0)*v);
enc.x-=(enc.y/255.0);
return enc;
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param=mainTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=mainTextureLayout;
int param_2=mainTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).mainTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).mainTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.mainTexture,sc_set2.mainTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float3 lr_x=l9_0.xyz;
float2 param_12=depthTextureGetDims2D((*sc_set2.UserUniforms));
int param_13=depthTextureLayout;
int param_14=depthTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_15=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_16=(int(SC_USE_UV_TRANSFORM_depthTexture)!=0);
float3x3 param_17=(*sc_set2.UserUniforms).depthTextureTransform;
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_depthTexture,SC_SOFTWARE_WRAP_MODE_V_depthTexture);
bool param_19=(int(SC_USE_UV_MIN_MAX_depthTexture)!=0);
float4 param_20=(*sc_set2.UserUniforms).depthTextureUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_depthTexture)!=0);
float4 param_22=(*sc_set2.UserUniforms).depthTextureBorderColor;
float param_23=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.depthTexture,sc_set2.depthTextureSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_3=l9_2;
float depth=l9_2.x;
float l9_4;
#if (CAMEOS_MATTING)
{
l9_4=fast::clamp(depth,0.0,0.99998999);
}
#else
{
float param_24=depth;
float param_25=(*sc_set2.UserUniforms).depthToDisparityNumerator;
l9_4=depthToDisparity(param_24,param_25);
}
#endif
float lr_y=l9_4;
float4 result=float4(1.0,0.0,1.0,1.0);
#if (BY_Y)
{
float param_26=lr_x.z*lr_y;
float param_27=lr_y;
result=float4(encode2(param_26),encode2(param_27));
}
#else
{
#if (RY_GY)
{
float param_28=lr_x.x*lr_y;
float param_29=lr_x.y*lr_y;
result=float4(encode2(param_28),encode2(param_29));
}
#endif
}
#endif
float4 param_30=result;
sc_writeFragData0(param_30,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

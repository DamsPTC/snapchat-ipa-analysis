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
//sampler sampler screenTextureSmpSC 2:1
//texture texture2D screenTexture 2:0:2:1
//ubo float UserUniforms 2:2:192 {
//float3x3 meshTransform 0
//float screenTextureBias 48
//float4 screenTextureSize 64
//float4 screenTextureDims 80
//float4 screenTextureView 96
//float3x3 screenTextureTransform 112
//float4 screenTextureUvMinMax 160
//float4 screenTextureBorderColor 176
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float3x3 meshTransform;
float screenTextureBias;
float4 screenTextureSize;
float4 screenTextureDims;
float4 screenTextureView;
float3x3 screenTextureTransform;
float4 screenTextureUvMinMax;
float4 screenTextureBorderColor;
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
#ifndef USE_MIP_BIAS
#define USE_MIP_BIAS 0
#elif USE_MIP_BIAS==1
#undef USE_MIP_BIAS
#define USE_MIP_BIAS 1
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
float2 texture0=(v.position.xy+float2(1.0))*0.5;
v.texture0=float2(((*sc_set2.UserUniforms).screenTextureTransform*float3(texture0,1.0)).xy);
float2 l9_0=float2(((*sc_set2.UserUniforms).meshTransform*float3(sc_sysIn.sc_sysAttributes.position.xy,1.0)).xy);
v.position=float4(l9_0.x,l9_0.y,v.position.z,v.position.w);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float3x3 meshTransform;
float screenTextureBias;
float4 screenTextureSize;
float4 screenTextureDims;
float4 screenTextureView;
float3x3 screenTextureTransform;
float4 screenTextureUvMinMax;
float4 screenTextureBorderColor;
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
#ifndef SC_SOFTWARE_WRAP_MODE_U_screenTexture
#define SC_SOFTWARE_WRAP_MODE_U_screenTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_screenTexture
#define SC_SOFTWARE_WRAP_MODE_V_screenTexture -1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_screenTexture
#define SC_USE_CLAMP_TO_BORDER_screenTexture 0
#elif SC_USE_CLAMP_TO_BORDER_screenTexture==1
#undef SC_USE_CLAMP_TO_BORDER_screenTexture
#define SC_USE_CLAMP_TO_BORDER_screenTexture 1
#endif
#ifndef USE_MIP_BIAS
#define USE_MIP_BIAS 0
#elif USE_MIP_BIAS==1
#undef USE_MIP_BIAS
#define USE_MIP_BIAS 1
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
#ifndef SC_USE_UV_MIN_MAX_screenTexture
#define SC_USE_UV_MIN_MAX_screenTexture 0
#elif SC_USE_UV_MIN_MAX_screenTexture==1
#undef SC_USE_UV_MIN_MAX_screenTexture
#define SC_USE_UV_MIN_MAX_screenTexture 1
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
float2 screenTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.screenTextureDims.xy;
}
float4 screenTextureSampleViewIndexBias(thread const float2& uv,thread const int& viewIndex,thread const float& bias0,constant userUniformsObj& UserUniforms,thread texture2d<float> screenTexture,thread sampler screenTextureSmpSC)
{
float2 param=screenTextureGetDims2D(UserUniforms);
float2 param_1=uv;
int param_2=screenTextureLayout;
int param_3=viewIndex;
float param_4=bias0;
float4 result=sc_SampleView(screenTexture,screenTextureSmpSC,param,param_1,param_2,param_3,param_4);
return result;
}
float4 screenTextureSampleViewBias(thread const float2& uv,thread const float& bias0,constant userUniformsObj& UserUniforms,thread texture2d<float> screenTexture,thread sampler screenTextureSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 param=uv;
int param_1=screenTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float param_2=bias0;
return screenTextureSampleViewIndexBias(param,param_1,param_2,UserUniforms,screenTexture,screenTextureSmpSC);
}
float4 screenTextureSampleViewIndex(thread const float2& uv,thread const int& viewIndex,constant userUniformsObj& UserUniforms,thread texture2d<float> screenTexture,thread sampler screenTextureSmpSC)
{
float2 param=uv;
int param_1=viewIndex;
float param_2=0.0;
return screenTextureSampleViewIndexBias(param,param_1,param_2,UserUniforms,screenTexture,screenTextureSmpSC);
}
float4 screenTextureSampleView(thread const float2& uv,constant userUniformsObj& UserUniforms,thread texture2d<float> screenTexture,thread sampler screenTextureSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 param=uv;
int param_1=screenTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
return screenTextureSampleViewIndex(param,param_1,UserUniforms,screenTexture,screenTextureSmpSC);
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float clampToBorderFactor=1.0;
float2 uv=sc_fragIn.sc_sysIn.varPackedTex.xy;
float param=uv.x;
int param_1=SC_SOFTWARE_WRAP_MODE_U_screenTexture;
sc_SoftwareWrapEarly(param,param_1);
uv.x=param;
float param_2=uv.y;
int param_3=SC_SOFTWARE_WRAP_MODE_V_screenTexture;
sc_SoftwareWrapEarly(param_2,param_3);
uv.y=param_2;
float param_4=uv.x;
int param_5=SC_SOFTWARE_WRAP_MODE_U_screenTexture;
bool param_6=(int(SC_USE_CLAMP_TO_BORDER_screenTexture)!=0);
float param_7=clampToBorderFactor;
sc_SoftwareWrapLate(param_4,param_5,param_6,param_7);
uv.x=param_4;
clampToBorderFactor=param_7;
float param_8=uv.y;
int param_9=SC_SOFTWARE_WRAP_MODE_V_screenTexture;
bool param_10=(int(SC_USE_CLAMP_TO_BORDER_screenTexture)!=0);
float param_11=clampToBorderFactor;
sc_SoftwareWrapLate(param_8,param_9,param_10,param_11);
uv.y=param_8;
clampToBorderFactor=param_11;
float4 l9_0;
#if (USE_MIP_BIAS)
{
float2 param_12=uv;
float param_13=(*sc_set2.UserUniforms).screenTextureBias;
l9_0=screenTextureSampleViewBias(param_12,param_13,(*sc_set2.UserUniforms),sc_set2.screenTexture,sc_set2.screenTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
}
#else
{
float2 param_14=uv;
l9_0=screenTextureSampleView(param_14,(*sc_set2.UserUniforms),sc_set2.screenTexture,sc_set2.screenTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
}
#endif
float4 screenTextureColor=l9_0;
#if (SC_USE_CLAMP_TO_BORDER_screenTexture)
{
screenTextureColor=mix((*sc_set2.UserUniforms).screenTextureBorderColor,screenTextureColor,float4(clampToBorderFactor));
}
#endif
float4 param_15=screenTextureColor;
sc_writeFragData0(param_15,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

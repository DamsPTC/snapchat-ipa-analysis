#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#include "std2.metal"
#include "std2_vs.metal"
#include "std2_fs.metal"
#include "std2_shadows.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler mainTextureSmpSC 2:2
//sampler sampler maskTextureSmpSC 2:3
//texture texture2D mainTexture 2:0:2:2
//texture texture2D maskTexture 2:1:2:3
//ubo float UserUniforms 2:4:272 {
//float4 mainTextureSize 0
//float4 mainTextureDims 16
//float4 mainTextureView 32
//float3x3 mainTextureTransform 48
//float4 mainTextureUvMinMax 96
//float4 mainTextureBorderColor 112
//float4 maskTextureSize 128
//float4 maskTextureDims 144
//float4 maskTextureView 160
//float3x3 maskTextureTransform 176
//float4 maskTextureUvMinMax 224
//float4 maskTextureBorderColor 240
//float4 mainColor 256
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
float4 maskTextureSize;
float4 maskTextureDims;
float4 maskTextureView;
float3x3 maskTextureTransform;
float4 maskTextureUvMinMax;
float4 maskTextureBorderColor;
float4 mainColor;
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
#ifndef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 0
#elif maskTextureHasSwappedViews==1
#undef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 1
#endif
#ifndef maskTextureLayout
#define maskTextureLayout 0
#endif
#ifndef ENABLESHADOWS
#define ENABLESHADOWS 0
#elif ENABLESHADOWS==1
#undef ENABLESHADOWS
#define ENABLESHADOWS 1
#endif
#ifndef NOTEXTURE
#define NOTEXTURE 0
#elif NOTEXTURE==1
#undef NOTEXTURE
#define NOTEXTURE 1
#endif
#ifndef NOMASK
#define NOMASK 0
#elif NOMASK==1
#undef NOMASK
#define NOMASK 1
#endif
#ifndef EMOCHECKERS
#define EMOCHECKERS 0
#elif EMOCHECKERS==1
#undef EMOCHECKERS
#define EMOCHECKERS 1
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
#ifndef maskTextureUV
#define maskTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_maskTexture
#define SC_USE_UV_TRANSFORM_maskTexture 0
#elif SC_USE_UV_TRANSFORM_maskTexture==1
#undef SC_USE_UV_TRANSFORM_maskTexture
#define SC_USE_UV_TRANSFORM_maskTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_maskTexture
#define SC_SOFTWARE_WRAP_MODE_U_maskTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_maskTexture
#define SC_SOFTWARE_WRAP_MODE_V_maskTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_maskTexture
#define SC_USE_UV_MIN_MAX_maskTexture 0
#elif SC_USE_UV_MIN_MAX_maskTexture==1
#undef SC_USE_UV_MIN_MAX_maskTexture
#define SC_USE_UV_MIN_MAX_maskTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_maskTexture
#define SC_USE_CLAMP_TO_BORDER_maskTexture 0
#elif SC_USE_CLAMP_TO_BORDER_maskTexture==1
#undef SC_USE_CLAMP_TO_BORDER_maskTexture
#define SC_USE_CLAMP_TO_BORDER_maskTexture 1
#endif
struct sc_Set2
{
texture2d<float> mainTexture [[id(0)]];
texture2d<float> maskTexture [[id(1)]];
sampler mainTextureSmpSC [[id(2)]];
sampler maskTextureSmpSC [[id(3)]];
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
float4 maskTextureSize;
float4 maskTextureDims;
float4 maskTextureView;
float3x3 maskTextureTransform;
float4 maskTextureUvMinMax;
float4 maskTextureBorderColor;
float4 mainColor;
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
#ifndef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 0
#elif maskTextureHasSwappedViews==1
#undef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 1
#endif
#ifndef maskTextureLayout
#define maskTextureLayout 0
#endif
#ifndef EMOCHECKERS
#define EMOCHECKERS 0
#elif EMOCHECKERS==1
#undef EMOCHECKERS
#define EMOCHECKERS 1
#endif
#ifndef NOTEXTURE
#define NOTEXTURE 0
#elif NOTEXTURE==1
#undef NOTEXTURE
#define NOTEXTURE 1
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
#ifndef NOMASK
#define NOMASK 0
#elif NOMASK==1
#undef NOMASK
#define NOMASK 1
#endif
#ifndef SC_USE_UV_TRANSFORM_maskTexture
#define SC_USE_UV_TRANSFORM_maskTexture 0
#elif SC_USE_UV_TRANSFORM_maskTexture==1
#undef SC_USE_UV_TRANSFORM_maskTexture
#define SC_USE_UV_TRANSFORM_maskTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_maskTexture
#define SC_SOFTWARE_WRAP_MODE_U_maskTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_maskTexture
#define SC_SOFTWARE_WRAP_MODE_V_maskTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_maskTexture
#define SC_USE_UV_MIN_MAX_maskTexture 0
#elif SC_USE_UV_MIN_MAX_maskTexture==1
#undef SC_USE_UV_MIN_MAX_maskTexture
#define SC_USE_UV_MIN_MAX_maskTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_maskTexture
#define SC_USE_CLAMP_TO_BORDER_maskTexture 0
#elif SC_USE_CLAMP_TO_BORDER_maskTexture==1
#undef SC_USE_CLAMP_TO_BORDER_maskTexture
#define SC_USE_CLAMP_TO_BORDER_maskTexture 1
#endif
#ifndef ENABLESHADOWS
#define ENABLESHADOWS 0
#elif ENABLESHADOWS==1
#undef ENABLESHADOWS
#define ENABLESHADOWS 1
#endif
#ifndef mainTextureUV
#define mainTextureUV 0
#endif
#ifndef maskTextureUV
#define maskTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> mainTexture [[id(0)]];
texture2d<float> maskTexture [[id(1)]];
sampler mainTextureSmpSC [[id(2)]];
sampler maskTextureSmpSC [[id(3)]];
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
float2 maskTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.maskTextureDims.xy;
}
int maskTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (maskTextureHasSwappedViews)
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
float4 color=float4(0.0);
#if (EMOCHECKERS)
{
float r=abs(dot(step(float2(0.5),fract(sc_fragIn.sc_sysIn.varPackedTex.xy*2.0)),float2(1.0))-1.0);
color=float4(r,0.0,r,1.0);
}
#else
{
color=(*sc_set2.UserUniforms).mainColor;
#if (!NOTEXTURE)
{
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
float4 mainTextureSample=l9_0;
color*=mainTextureSample;
}
#endif
#if (!NOMASK)
{
float2 param_12=maskTextureGetDims2D((*sc_set2.UserUniforms));
int param_13=maskTextureLayout;
int param_14=maskTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_15=sc_fragIn.sc_sysIn.varPackedTex.zw;
bool param_16=(int(SC_USE_UV_TRANSFORM_maskTexture)!=0);
float3x3 param_17=(*sc_set2.UserUniforms).maskTextureTransform;
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_maskTexture,SC_SOFTWARE_WRAP_MODE_V_maskTexture);
bool param_19=(int(SC_USE_UV_MIN_MAX_maskTexture)!=0);
float4 param_20=(*sc_set2.UserUniforms).maskTextureUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_maskTexture)!=0);
float4 param_22=(*sc_set2.UserUniforms).maskTextureBorderColor;
float param_23=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.maskTexture,sc_set2.maskTextureSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_3=l9_2;
float4 maskTextureSample=l9_2;
color.w*=maskTextureSample.x;
}
#endif
}
#endif
#if (ENABLESHADOWS)
{
#if (sc_ProjectiveShadowsReceiver)
{
float3 l9_4=color.xyz*evaluateShadow(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
color=float4(l9_4.x,l9_4.y,l9_4.z,color.w);
}
#endif
#if (sc_ProjectiveShadowsCaster)
{
float4 param_24=color;
color=evaluateShadowCasterColor(param_24,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
}
#endif
}
#endif
float4 param_25=color;
sc_writeFragData0(param_25,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

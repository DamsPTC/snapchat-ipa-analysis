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
//sampler sampler inputTextureSmpSC 2:3
//sampler sampler inputTextureWarpSmpSC 2:4
//sampler sampler screenTextureSmpSC 2:5
//texture texture2D inputTexture 2:0:2:3
//texture texture2D inputTextureWarp 2:1:2:4
//texture texture2D screenTexture 2:2:2:5
//ubo float UserUniforms 2:6:512 {
//float4 screenTextureSize 0
//float4 screenTextureDims 16
//float4 screenTextureView 32
//float3x3 screenTextureTransform 48
//float4 screenTextureUvMinMax 96
//float4 screenTextureBorderColor 112
//float screenTextureLOD 128
//float3x3 meshTransform 144
//float3x3 meshTransformR 192
//float4 inputTextureSize 240
//float4 inputTextureDims 256
//float4 inputTextureView 272
//float3x3 inputTextureTransform 288
//float4 inputTextureUvMinMax 336
//float4 inputTextureBorderColor 352
//float4 inputTextureWarpSize 368
//float4 inputTextureWarpDims 384
//float4 inputTextureWarpView 400
//float3x3 inputTextureWarpTransform 416
//float4 inputTextureWarpUvMinMax 464
//float4 inputTextureWarpBorderColor 480
//float2 inputDenorm 496
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
float screenTextureLOD;
float3x3 meshTransform;
float3x3 meshTransformR;
float4 inputTextureSize;
float4 inputTextureDims;
float4 inputTextureView;
float3x3 inputTextureTransform;
float4 inputTextureUvMinMax;
float4 inputTextureBorderColor;
float4 inputTextureWarpSize;
float4 inputTextureWarpDims;
float4 inputTextureWarpView;
float3x3 inputTextureWarpTransform;
float4 inputTextureWarpUvMinMax;
float4 inputTextureWarpBorderColor;
float2 inputDenorm;
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
#ifndef inputTextureHasSwappedViews
#define inputTextureHasSwappedViews 0
#elif inputTextureHasSwappedViews==1
#undef inputTextureHasSwappedViews
#define inputTextureHasSwappedViews 1
#endif
#ifndef inputTextureLayout
#define inputTextureLayout 0
#endif
#ifndef inputTextureWarpHasSwappedViews
#define inputTextureWarpHasSwappedViews 0
#elif inputTextureWarpHasSwappedViews==1
#undef inputTextureWarpHasSwappedViews
#define inputTextureWarpHasSwappedViews 1
#endif
#ifndef inputTextureWarpLayout
#define inputTextureWarpLayout 0
#endif
#ifndef ENABLE_WARP
#define ENABLE_WARP 0
#elif ENABLE_WARP==1
#undef ENABLE_WARP
#define ENABLE_WARP 1
#endif
#ifndef USE_FLOAT_WARP
#define USE_FLOAT_WARP 0
#elif USE_FLOAT_WARP==1
#undef USE_FLOAT_WARP
#define USE_FLOAT_WARP 1
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
#ifndef inputTextureUV
#define inputTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_inputTexture
#define SC_USE_UV_TRANSFORM_inputTexture 0
#elif SC_USE_UV_TRANSFORM_inputTexture==1
#undef SC_USE_UV_TRANSFORM_inputTexture
#define SC_USE_UV_TRANSFORM_inputTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_inputTexture
#define SC_SOFTWARE_WRAP_MODE_U_inputTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_inputTexture
#define SC_SOFTWARE_WRAP_MODE_V_inputTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_inputTexture
#define SC_USE_UV_MIN_MAX_inputTexture 0
#elif SC_USE_UV_MIN_MAX_inputTexture==1
#undef SC_USE_UV_MIN_MAX_inputTexture
#define SC_USE_UV_MIN_MAX_inputTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_inputTexture
#define SC_USE_CLAMP_TO_BORDER_inputTexture 0
#elif SC_USE_CLAMP_TO_BORDER_inputTexture==1
#undef SC_USE_CLAMP_TO_BORDER_inputTexture
#define SC_USE_CLAMP_TO_BORDER_inputTexture 1
#endif
#ifndef inputTextureWarpUV
#define inputTextureWarpUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_inputTextureWarp
#define SC_USE_UV_TRANSFORM_inputTextureWarp 0
#elif SC_USE_UV_TRANSFORM_inputTextureWarp==1
#undef SC_USE_UV_TRANSFORM_inputTextureWarp
#define SC_USE_UV_TRANSFORM_inputTextureWarp 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_inputTextureWarp
#define SC_SOFTWARE_WRAP_MODE_U_inputTextureWarp -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_inputTextureWarp
#define SC_SOFTWARE_WRAP_MODE_V_inputTextureWarp -1
#endif
#ifndef SC_USE_UV_MIN_MAX_inputTextureWarp
#define SC_USE_UV_MIN_MAX_inputTextureWarp 0
#elif SC_USE_UV_MIN_MAX_inputTextureWarp==1
#undef SC_USE_UV_MIN_MAX_inputTextureWarp
#define SC_USE_UV_MIN_MAX_inputTextureWarp 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_inputTextureWarp
#define SC_USE_CLAMP_TO_BORDER_inputTextureWarp 0
#elif SC_USE_CLAMP_TO_BORDER_inputTextureWarp==1
#undef SC_USE_CLAMP_TO_BORDER_inputTextureWarp
#define SC_USE_CLAMP_TO_BORDER_inputTextureWarp 1
#endif
struct sc_Set2
{
texture2d<float> inputTexture [[id(0)]];
texture2d<float> inputTextureWarp [[id(1)]];
texture2d<float> screenTexture [[id(2)]];
sampler inputTextureSmpSC [[id(3)]];
sampler inputTextureWarpSmpSC [[id(4)]];
sampler screenTextureSmpSC [[id(5)]];
constant userUniformsObj* UserUniforms [[id(6)]];
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
float3 texPos=float3((v.position.xy*0.5)+float2(0.5),1.0);
float2 l9_0=float2(((*sc_set2.UserUniforms).inputTextureTransform*texPos).xy);
sc_vertOut.sc_sysOut.varPackedTex=float4(l9_0.x,l9_0.y,sc_vertOut.sc_sysOut.varPackedTex.z,sc_vertOut.sc_sysOut.varPackedTex.w);
float2 l9_1=float2(((*sc_set2.UserUniforms).meshTransform*float3(v.position.xy,1.0)).xy);
v.position=float4(l9_1.x,l9_1.y,v.position.z,v.position.w);
v.position=float4(v.position.x,v.position.y,float2(0.0,1.0).x,float2(0.0,1.0).y);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
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
float screenTextureLOD;
float3x3 meshTransform;
float3x3 meshTransformR;
float4 inputTextureSize;
float4 inputTextureDims;
float4 inputTextureView;
float3x3 inputTextureTransform;
float4 inputTextureUvMinMax;
float4 inputTextureBorderColor;
float4 inputTextureWarpSize;
float4 inputTextureWarpDims;
float4 inputTextureWarpView;
float3x3 inputTextureWarpTransform;
float4 inputTextureWarpUvMinMax;
float4 inputTextureWarpBorderColor;
float2 inputDenorm;
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
#ifndef inputTextureHasSwappedViews
#define inputTextureHasSwappedViews 0
#elif inputTextureHasSwappedViews==1
#undef inputTextureHasSwappedViews
#define inputTextureHasSwappedViews 1
#endif
#ifndef inputTextureLayout
#define inputTextureLayout 0
#endif
#ifndef inputTextureWarpHasSwappedViews
#define inputTextureWarpHasSwappedViews 0
#elif inputTextureWarpHasSwappedViews==1
#undef inputTextureWarpHasSwappedViews
#define inputTextureWarpHasSwappedViews 1
#endif
#ifndef inputTextureWarpLayout
#define inputTextureWarpLayout 0
#endif
#ifndef ENABLE_WARP
#define ENABLE_WARP 0
#elif ENABLE_WARP==1
#undef ENABLE_WARP
#define ENABLE_WARP 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_inputTextureWarp
#define SC_SOFTWARE_WRAP_MODE_U_inputTextureWarp -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_inputTextureWarp
#define SC_SOFTWARE_WRAP_MODE_V_inputTextureWarp -1
#endif
#ifndef SC_USE_UV_MIN_MAX_inputTextureWarp
#define SC_USE_UV_MIN_MAX_inputTextureWarp 0
#elif SC_USE_UV_MIN_MAX_inputTextureWarp==1
#undef SC_USE_UV_MIN_MAX_inputTextureWarp
#define SC_USE_UV_MIN_MAX_inputTextureWarp 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_inputTextureWarp
#define SC_USE_CLAMP_TO_BORDER_inputTextureWarp 0
#elif SC_USE_CLAMP_TO_BORDER_inputTextureWarp==1
#undef SC_USE_CLAMP_TO_BORDER_inputTextureWarp
#define SC_USE_CLAMP_TO_BORDER_inputTextureWarp 1
#endif
#ifndef USE_FLOAT_WARP
#define USE_FLOAT_WARP 0
#elif USE_FLOAT_WARP==1
#undef USE_FLOAT_WARP
#define USE_FLOAT_WARP 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_inputTexture
#define SC_SOFTWARE_WRAP_MODE_U_inputTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_inputTexture
#define SC_SOFTWARE_WRAP_MODE_V_inputTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_inputTexture
#define SC_USE_UV_MIN_MAX_inputTexture 0
#elif SC_USE_UV_MIN_MAX_inputTexture==1
#undef SC_USE_UV_MIN_MAX_inputTexture
#define SC_USE_UV_MIN_MAX_inputTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_inputTexture
#define SC_USE_CLAMP_TO_BORDER_inputTexture 0
#elif SC_USE_CLAMP_TO_BORDER_inputTexture==1
#undef SC_USE_CLAMP_TO_BORDER_inputTexture
#define SC_USE_CLAMP_TO_BORDER_inputTexture 1
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
#ifndef screenTextureUV
#define screenTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_screenTexture
#define SC_USE_UV_TRANSFORM_screenTexture 0
#elif SC_USE_UV_TRANSFORM_screenTexture==1
#undef SC_USE_UV_TRANSFORM_screenTexture
#define SC_USE_UV_TRANSFORM_screenTexture 1
#endif
#ifndef inputTextureUV
#define inputTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_inputTexture
#define SC_USE_UV_TRANSFORM_inputTexture 0
#elif SC_USE_UV_TRANSFORM_inputTexture==1
#undef SC_USE_UV_TRANSFORM_inputTexture
#define SC_USE_UV_TRANSFORM_inputTexture 1
#endif
#ifndef inputTextureWarpUV
#define inputTextureWarpUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_inputTextureWarp
#define SC_USE_UV_TRANSFORM_inputTextureWarp 0
#elif SC_USE_UV_TRANSFORM_inputTextureWarp==1
#undef SC_USE_UV_TRANSFORM_inputTextureWarp
#define SC_USE_UV_TRANSFORM_inputTextureWarp 1
#endif
struct sc_Set2
{
texture2d<float> inputTexture [[id(0)]];
texture2d<float> inputTextureWarp [[id(1)]];
texture2d<float> screenTexture [[id(2)]];
sampler inputTextureSmpSC [[id(3)]];
sampler inputTextureWarpSmpSC [[id(4)]];
sampler screenTextureSmpSC [[id(5)]];
constant userUniformsObj* UserUniforms [[id(6)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
};
float2 inputTextureWarpGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.inputTextureWarpDims.xy;
}
int inputTextureWarpGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (inputTextureWarpHasSwappedViews)
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
float2 inputTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.inputTextureDims.xy;
}
int inputTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (inputTextureHasSwappedViews)
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
float2 texCoords=float2(0.0);
#if (ENABLE_WARP)
{
float2 param=inputTextureWarpGetDims2D((*sc_set2.UserUniforms));
int param_1=inputTextureWarpLayout;
int param_2=inputTextureWarpGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=false;
float3x3 param_5=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_inputTextureWarp,SC_SOFTWARE_WRAP_MODE_V_inputTextureWarp);
bool param_7=(int(SC_USE_UV_MIN_MAX_inputTextureWarp)!=0);
float4 param_8=(*sc_set2.UserUniforms).inputTextureWarpUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_inputTextureWarp)!=0);
float4 param_10=(*sc_set2.UserUniforms).inputTextureWarpBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.inputTextureWarp,sc_set2.inputTextureWarpSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 inputTextureWarpSample=l9_0;
float4 texWarpColor=inputTextureWarpSample;
float2 warp=float2(0.0);
#if (USE_FLOAT_WARP)
{
warp=texWarpColor.xy/float2(2.0);
}
#else
{
warp=(texWarpColor.xy-float2(0.5))/float2(4.0);
}
#endif
texCoords=sc_fragIn.sc_sysIn.varPackedTex.xy+warp;
}
#else
{
texCoords=sc_fragIn.sc_sysIn.varPackedTex.xy;
}
#endif
float2 param_12=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_13=inputTextureLayout;
int param_14=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_15=texCoords;
bool param_16=false;
float3x3 param_17=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_19=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_20=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_22=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_23=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_3=l9_2;
float4 inputTextureSample=l9_2;
float4 infColor=(inputTextureSample-float4((*sc_set2.UserUniforms).inputDenorm.y))*(*sc_set2.UserUniforms).inputDenorm.x;
float2 scrCoords=((*sc_set2.UserUniforms).meshTransformR*float3(texCoords,1.0)).xy;
float2 param_24=screenTextureGetDims2D((*sc_set2.UserUniforms));
int param_25=screenTextureLayout;
int param_26=screenTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_27=scrCoords;
bool param_28=false;
float3x3 param_29=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_30=int2(SC_SOFTWARE_WRAP_MODE_U_screenTexture,SC_SOFTWARE_WRAP_MODE_V_screenTexture);
bool param_31=(int(SC_USE_UV_MIN_MAX_screenTexture)!=0);
float4 param_32=(*sc_set2.UserUniforms).screenTextureUvMinMax;
bool param_33=(int(SC_USE_CLAMP_TO_BORDER_screenTexture)!=0);
float4 param_34=(*sc_set2.UserUniforms).screenTextureBorderColor;
float param_35=(*sc_set2.UserUniforms).screenTextureLOD;
float4 l9_4=sc_SampleTextureBiasOrLevel(sc_set2.screenTexture,sc_set2.screenTextureSmpSC,param_24,param_25,param_26,param_27,param_28,param_29,param_30,param_31,param_32,param_33,param_34,param_35);
float4 l9_5=l9_4;
float4 screenTextureSample=l9_4;
float4 screenTextureColor=screenTextureSample;
float4 param_36=float4((screenTextureColor.xyz*(1.0-infColor.w))+infColor.xyz,1.0);
sc_writeFragData0(param_36,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#include "std2.metal"
#include "std2_vs.metal"
#include "std2_fs.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler alphaTextureSmpSC 2:2
//sampler sampler assetTextureSmpSC 2:3
//texture texture2D alphaTexture 2:0:2:2
//texture texture2D assetTexture 2:1:2:3
//ubo float UserUniforms 2:4:320 {
//float4 assetTextureSize 0
//float4 assetTextureDims 16
//float4 assetTextureView 32
//float3x3 assetTextureTransform 48
//float4 assetTextureUvMinMax 96
//float4 assetTextureBorderColor 112
//float4 alphaTextureSize 128
//float4 alphaTextureDims 144
//float4 alphaTextureView 160
//float3x3 alphaTextureTransform 176
//float4 alphaTextureUvMinMax 224
//float4 alphaTextureBorderColor 240
//int alphaChannel 256
//float3 bodyMedian 272
//float3 deviationRatio 288
//float3 faceMedian 304
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 assetTextureSize;
float4 assetTextureDims;
float4 assetTextureView;
float3x3 assetTextureTransform;
float4 assetTextureUvMinMax;
float4 assetTextureBorderColor;
float4 alphaTextureSize;
float4 alphaTextureDims;
float4 alphaTextureView;
float3x3 alphaTextureTransform;
float4 alphaTextureUvMinMax;
float4 alphaTextureBorderColor;
int alphaChannel;
float3 bodyMedian;
float3 deviationRatio;
float3 faceMedian;
};
#ifndef assetTextureHasSwappedViews
#define assetTextureHasSwappedViews 0
#elif assetTextureHasSwappedViews==1
#undef assetTextureHasSwappedViews
#define assetTextureHasSwappedViews 1
#endif
#ifndef assetTextureLayout
#define assetTextureLayout 0
#endif
#ifndef alphaTextureHasSwappedViews
#define alphaTextureHasSwappedViews 0
#elif alphaTextureHasSwappedViews==1
#undef alphaTextureHasSwappedViews
#define alphaTextureHasSwappedViews 1
#endif
#ifndef alphaTextureLayout
#define alphaTextureLayout 0
#endif
#ifndef assetTextureUV
#define assetTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_assetTexture
#define SC_USE_UV_TRANSFORM_assetTexture 0
#elif SC_USE_UV_TRANSFORM_assetTexture==1
#undef SC_USE_UV_TRANSFORM_assetTexture
#define SC_USE_UV_TRANSFORM_assetTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_assetTexture
#define SC_SOFTWARE_WRAP_MODE_U_assetTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_assetTexture
#define SC_SOFTWARE_WRAP_MODE_V_assetTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_assetTexture
#define SC_USE_UV_MIN_MAX_assetTexture 0
#elif SC_USE_UV_MIN_MAX_assetTexture==1
#undef SC_USE_UV_MIN_MAX_assetTexture
#define SC_USE_UV_MIN_MAX_assetTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_assetTexture
#define SC_USE_CLAMP_TO_BORDER_assetTexture 0
#elif SC_USE_CLAMP_TO_BORDER_assetTexture==1
#undef SC_USE_CLAMP_TO_BORDER_assetTexture
#define SC_USE_CLAMP_TO_BORDER_assetTexture 1
#endif
#ifndef alphaTextureUV
#define alphaTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_alphaTexture
#define SC_USE_UV_TRANSFORM_alphaTexture 0
#elif SC_USE_UV_TRANSFORM_alphaTexture==1
#undef SC_USE_UV_TRANSFORM_alphaTexture
#define SC_USE_UV_TRANSFORM_alphaTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_alphaTexture
#define SC_SOFTWARE_WRAP_MODE_U_alphaTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_alphaTexture
#define SC_SOFTWARE_WRAP_MODE_V_alphaTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_alphaTexture
#define SC_USE_UV_MIN_MAX_alphaTexture 0
#elif SC_USE_UV_MIN_MAX_alphaTexture==1
#undef SC_USE_UV_MIN_MAX_alphaTexture
#define SC_USE_UV_MIN_MAX_alphaTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_alphaTexture
#define SC_USE_CLAMP_TO_BORDER_alphaTexture 0
#elif SC_USE_CLAMP_TO_BORDER_alphaTexture==1
#undef SC_USE_CLAMP_TO_BORDER_alphaTexture
#define SC_USE_CLAMP_TO_BORDER_alphaTexture 1
#endif
struct sc_Set2
{
texture2d<float> alphaTexture [[id(0)]];
texture2d<float> assetTexture [[id(1)]];
sampler alphaTextureSmpSC [[id(2)]];
sampler assetTextureSmpSC [[id(3)]];
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
float4 assetTextureSize;
float4 assetTextureDims;
float4 assetTextureView;
float3x3 assetTextureTransform;
float4 assetTextureUvMinMax;
float4 assetTextureBorderColor;
float4 alphaTextureSize;
float4 alphaTextureDims;
float4 alphaTextureView;
float3x3 alphaTextureTransform;
float4 alphaTextureUvMinMax;
float4 alphaTextureBorderColor;
int alphaChannel;
float3 bodyMedian;
float3 deviationRatio;
float3 faceMedian;
};
#ifndef assetTextureHasSwappedViews
#define assetTextureHasSwappedViews 0
#elif assetTextureHasSwappedViews==1
#undef assetTextureHasSwappedViews
#define assetTextureHasSwappedViews 1
#endif
#ifndef assetTextureLayout
#define assetTextureLayout 0
#endif
#ifndef alphaTextureHasSwappedViews
#define alphaTextureHasSwappedViews 0
#elif alphaTextureHasSwappedViews==1
#undef alphaTextureHasSwappedViews
#define alphaTextureHasSwappedViews 1
#endif
#ifndef alphaTextureLayout
#define alphaTextureLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_assetTexture
#define SC_USE_UV_TRANSFORM_assetTexture 0
#elif SC_USE_UV_TRANSFORM_assetTexture==1
#undef SC_USE_UV_TRANSFORM_assetTexture
#define SC_USE_UV_TRANSFORM_assetTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_assetTexture
#define SC_SOFTWARE_WRAP_MODE_U_assetTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_assetTexture
#define SC_SOFTWARE_WRAP_MODE_V_assetTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_assetTexture
#define SC_USE_UV_MIN_MAX_assetTexture 0
#elif SC_USE_UV_MIN_MAX_assetTexture==1
#undef SC_USE_UV_MIN_MAX_assetTexture
#define SC_USE_UV_MIN_MAX_assetTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_assetTexture
#define SC_USE_CLAMP_TO_BORDER_assetTexture 0
#elif SC_USE_CLAMP_TO_BORDER_assetTexture==1
#undef SC_USE_CLAMP_TO_BORDER_assetTexture
#define SC_USE_CLAMP_TO_BORDER_assetTexture 1
#endif
#ifndef SC_USE_UV_TRANSFORM_alphaTexture
#define SC_USE_UV_TRANSFORM_alphaTexture 0
#elif SC_USE_UV_TRANSFORM_alphaTexture==1
#undef SC_USE_UV_TRANSFORM_alphaTexture
#define SC_USE_UV_TRANSFORM_alphaTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_alphaTexture
#define SC_SOFTWARE_WRAP_MODE_U_alphaTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_alphaTexture
#define SC_SOFTWARE_WRAP_MODE_V_alphaTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_alphaTexture
#define SC_USE_UV_MIN_MAX_alphaTexture 0
#elif SC_USE_UV_MIN_MAX_alphaTexture==1
#undef SC_USE_UV_MIN_MAX_alphaTexture
#define SC_USE_UV_MIN_MAX_alphaTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_alphaTexture
#define SC_USE_CLAMP_TO_BORDER_alphaTexture 0
#elif SC_USE_CLAMP_TO_BORDER_alphaTexture==1
#undef SC_USE_CLAMP_TO_BORDER_alphaTexture
#define SC_USE_CLAMP_TO_BORDER_alphaTexture 1
#endif
#ifndef assetTextureUV
#define assetTextureUV 0
#endif
#ifndef alphaTextureUV
#define alphaTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> alphaTexture [[id(0)]];
texture2d<float> assetTexture [[id(1)]];
sampler alphaTextureSmpSC [[id(2)]];
sampler assetTextureSmpSC [[id(3)]];
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
float2 assetTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.assetTextureDims.xy;
}
int assetTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (assetTextureHasSwappedViews)
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
float2 alphaTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.alphaTextureDims.xy;
}
int alphaTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (alphaTextureHasSwappedViews)
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
float3 rgb2srgb(thread const float3& rgb)
{
return pow((rgb+float3(0.055))*0.94786727,float3(2.4000001));
}
float3 rgb2lab(thread float3& rgb)
{
float3 param=rgb;
rgb=rgb2srgb(param);
float3 xyz=float3x3(float3(0.43395299,0.212671,0.017758001),float3(0.376219,0.71516001,0.109477),float3(0.18982799,0.072168998,0.87276602))*rgb;
float3 f=pow(xyz,float3(0.33333334));
float L=(116.0*f.y)-16.0;
float a=500.0*(f.x-f.y);
float b=200.0*(f.y-f.z);
return float3(L/100.0,(a+128.0)/255.0,(b+128.0)/255.0);
}
float3 srgb2rgb(thread const float3& srgb)
{
return (pow(srgb,float3(0.41666666))*1.0549999)-float3(0.055);
}
float3 lab2rgb(thread const float3& lab)
{
float L=lab.x*100.0;
float a=(lab.y*255.0)-128.0;
float b=(lab.z*255.0)-128.0;
float3 f;
f.y=(L+16.0)/116.0;
f.x=(a/500.0)+f.y;
f.z=(b/(-200.0))+f.y;
float3 xyz=pow(f,float3(3.0));
float3 param=float3x3(float3(3.0799351,-0.92123401,0.052889999),float3(-1.5371521,1.87599,-0.204041),float3(-0.54278302,0.045244001,1.151152))*xyz;
return srgb2rgb(param);
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
float2 param=assetTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=assetTextureLayout;
int param_2=assetTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=(int(SC_USE_UV_TRANSFORM_assetTexture)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).assetTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_assetTexture,SC_SOFTWARE_WRAP_MODE_V_assetTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_assetTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).assetTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_assetTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).assetTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.assetTexture,sc_set2.assetTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float3 assetColor=l9_0.xyz;
float2 param_12=alphaTextureGetDims2D((*sc_set2.UserUniforms));
int param_13=alphaTextureLayout;
int param_14=alphaTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_15=sc_fragIn.sc_sysIn.varPackedTex.zw;
bool param_16=(int(SC_USE_UV_TRANSFORM_alphaTexture)!=0);
float3x3 param_17=(*sc_set2.UserUniforms).alphaTextureTransform;
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_alphaTexture,SC_SOFTWARE_WRAP_MODE_V_alphaTexture);
bool param_19=(int(SC_USE_UV_MIN_MAX_alphaTexture)!=0);
float4 param_20=(*sc_set2.UserUniforms).alphaTextureUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_alphaTexture)!=0);
float4 param_22=(*sc_set2.UserUniforms).alphaTextureBorderColor;
float param_23=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.alphaTexture,sc_set2.alphaTextureSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_3=l9_2;
float alpha=l9_2[(*sc_set2.UserUniforms).alphaChannel];
float3 param_24=assetColor;
float3 l9_4=rgb2lab(param_24);
float3 lab=l9_4;
lab=mix(lab,((lab-(*sc_set2.UserUniforms).bodyMedian)*(*sc_set2.UserUniforms).deviationRatio)+(*sc_set2.UserUniforms).faceMedian,float3(alpha));
float3 param_25=lab;
float4 param_26=float4(lab2rgb(param_25),1.0);
sc_writeFragData0(param_26,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

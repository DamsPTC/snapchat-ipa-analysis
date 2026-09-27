#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE0 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "std2.metal"
#include "std2_vs.metal"
#include "std2_fs.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler inputTextureSmpSC 2:1
//texture texture2D inputTexture 2:0:2:1
//ubo float UserUniforms 2:2:160 {
//float4 inputTextureSize 0
//float4 inputTextureDims 16
//float4 inputTextureView 32
//float3x3 inputTextureTransform 48
//float4 inputTextureUvMinMax 96
//float4 inputTextureBorderColor 112
//float stddev 128
//float rgbRatio 132
//float4 seeds 144
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 inputTextureSize;
float4 inputTextureDims;
float4 inputTextureView;
float3x3 inputTextureTransform;
float4 inputTextureUvMinMax;
float4 inputTextureBorderColor;
float stddev;
float rgbRatio;
float4 seeds;
};
#ifndef inputTextureHasSwappedViews
#define inputTextureHasSwappedViews 0
#elif inputTextureHasSwappedViews==1
#undef inputTextureHasSwappedViews
#define inputTextureHasSwappedViews 1
#endif
#ifndef inputTextureLayout
#define inputTextureLayout 0
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
struct sc_Set2
{
texture2d<float> inputTexture [[id(0)]];
sampler inputTextureSmpSC [[id(1)]];
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
float2 l9_0=((v.position.xy/float2(v.position.w))*0.5)+float2(0.5);
sc_vertOut.sc_sysOut.varPackedTex=float4(l9_0.x,l9_0.y,sc_vertOut.sc_sysOut.varPackedTex.z,sc_vertOut.sc_sysOut.varPackedTex.w);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 inputTextureSize;
float4 inputTextureDims;
float4 inputTextureView;
float3x3 inputTextureTransform;
float4 inputTextureUvMinMax;
float4 inputTextureBorderColor;
float stddev;
float rgbRatio;
float4 seeds;
};
#ifndef inputTextureHasSwappedViews
#define inputTextureHasSwappedViews 0
#elif inputTextureHasSwappedViews==1
#undef inputTextureHasSwappedViews
#define inputTextureHasSwappedViews 1
#endif
#ifndef inputTextureLayout
#define inputTextureLayout 0
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
#ifndef inputTextureUV
#define inputTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> inputTexture [[id(0)]];
sampler inputTextureSmpSC [[id(1)]];
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
float4 sampleInputTexture(thread const float2& uv,thread const float& mipBias,constant userUniformsObj& UserUniforms,thread texture2d<float> inputTexture,thread sampler inputTextureSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 param=inputTextureGetDims2D(UserUniforms);
int param_1=inputTextureLayout;
int param_2=inputTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_3=uv;
bool param_4=(int(SC_USE_UV_TRANSFORM_inputTexture)!=0);
float3x3 param_5=UserUniforms.inputTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_8=UserUniforms.inputTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_10=UserUniforms.inputTextureBorderColor;
float param_11=mipBias;
float4 l9_0=sc_SampleTextureBiasOrLevel(inputTexture,inputTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 inputTextureSample=l9_0;
return inputTextureSample;
}
float srgbToLinear(thread const float& x)
{
float l9_0;
#if (SC_DEVICE_CLASS>=2)
{
l9_0=pow(x,2.2);
}
#else
{
l9_0=x*x;
}
#endif
return l9_0;
}
float3 srgbToLinear(thread const float3& color)
{
float param=color.x;
float param_1=color.y;
float param_2=color.z;
return float3(srgbToLinear(param),srgbToLinear(param_1),srgbToLinear(param_2));
}
float rand(thread const float2& uv)
{
return fract(sin(dot(uv,float2(12.9898,78.233002)))*43758.547);
}
float2 boxMuller(thread const float2& uv,thread const float2& seed)
{
float2 param=uv+float2(seed.x);
float u=fast::max(rand(param),1e-06);
float2 param_1=uv+float2(seed.y);
float v=rand(param_1);
return float2(cos(6.2831855*v),sin(6.2831855*v))*sqrt((-2.0)*log(u));
}
float linearToSrgb(thread const float& x)
{
float l9_0;
#if (SC_DEVICE_CLASS>=2)
{
l9_0=pow(x,0.45454547);
}
#else
{
l9_0=sqrt(x);
}
#endif
return l9_0;
}
float3 linearToSrgb(thread const float3& color)
{
float param=color.x;
float param_1=color.y;
float param_2=color.z;
return float3(linearToSrgb(param),linearToSrgb(param_1),linearToSrgb(param_2));
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param=sc_fragIn.sc_sysIn.varPackedTex.xy;
float param_1=0.0;
float4 inputCol=sampleInputTexture(param,param_1,(*sc_set2.UserUniforms),sc_set2.inputTexture,sc_set2.inputTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_2=sc_fragIn.sc_sysIn.varPackedTex.xy;
float param_3=5.0;
float4 inputColHiMip=sampleInputTexture(param_2,param_3,(*sc_set2.UserUniforms),sc_set2.inputTexture,sc_set2.inputTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float3 param_4=inputCol.xyz;
float3 linearInputCol=srgbToLinear(param_4);
float2 sz=fwidth(sc_fragIn.sc_sysIn.varPackedTex.xy);
float2 newPosition=floor(sc_fragIn.sc_sysIn.varPackedTex.xy/(sz*2.0))*sz;
float2 param_5=newPosition;
float2 param_6=(*sc_set2.UserUniforms).seeds.xy;
float2 param_7=newPosition;
float2 param_8=(*sc_set2.UserUniforms).seeds.zw;
float4 _noise=float4(boxMuller(param_5,param_6),boxMuller(param_7,param_8))*(*sc_set2.UserUniforms).stddev;
float3 noiseCol=(_noise.xyz*(*sc_set2.UserUniforms).rgbRatio)+float3(_noise.w*(1.0-(*sc_set2.UserUniforms).rgbRatio));
float3 param_9=inputColHiMip.xyz;
noiseCol*=sqrt(1.0-fast::max(dot(srgbToLinear(param_9),float3(0.29899999,0.58700001,0.114)),0.0));
float3 param_10=fast::clamp(linearInputCol+noiseCol,float3(0.0),float3(1.0));
noiseCol=linearToSrgb(param_10);
float4 param_11=float4(noiseCol,inputCol.w);
sc_writeFragData0(param_11,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

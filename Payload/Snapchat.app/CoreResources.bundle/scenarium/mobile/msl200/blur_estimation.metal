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
//sampler sampler inputTextureSmpSC 2:3
//sampler sampler maskTextureSmpSC 2:4
//sampler sampler originalTextureSmpSC 2:5
//texture texture2D inputTexture 2:0:2:3
//texture texture2D maskTexture 2:1:2:4
//texture texture2D originalTexture 2:2:2:5
//ubo float UserUniforms 2:6:432 {
//float4 originalTextureSize 0
//float4 originalTextureDims 16
//float4 originalTextureView 32
//float3x3 originalTextureTransform 48
//float4 originalTextureUvMinMax 96
//float4 originalTextureBorderColor 112
//float4 inputTextureSize 128
//float4 inputTextureDims 144
//float4 inputTextureView 160
//float3x3 inputTextureTransform 176
//float4 inputTextureUvMinMax 224
//float4 inputTextureBorderColor 240
//float4 maskTextureSize 256
//float4 maskTextureDims 272
//float4 maskTextureView 288
//float3x3 maskTextureTransform 304
//float4 maskTextureUvMinMax 352
//float4 maskTextureBorderColor 368
//float2 blurDir 384
//float3 offset 400
//float4 weight 416
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 originalTextureSize;
float4 originalTextureDims;
float4 originalTextureView;
float3x3 originalTextureTransform;
float4 originalTextureUvMinMax;
float4 originalTextureBorderColor;
float4 inputTextureSize;
float4 inputTextureDims;
float4 inputTextureView;
float3x3 inputTextureTransform;
float4 inputTextureUvMinMax;
float4 inputTextureBorderColor;
float4 maskTextureSize;
float4 maskTextureDims;
float4 maskTextureView;
float3x3 maskTextureTransform;
float4 maskTextureUvMinMax;
float4 maskTextureBorderColor;
float2 blurDir;
float3 offset;
float4 weight;
};
#ifndef originalTextureHasSwappedViews
#define originalTextureHasSwappedViews 0
#elif originalTextureHasSwappedViews==1
#undef originalTextureHasSwappedViews
#define originalTextureHasSwappedViews 1
#endif
#ifndef originalTextureLayout
#define originalTextureLayout 0
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
#ifndef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 0
#elif maskTextureHasSwappedViews==1
#undef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 1
#endif
#ifndef maskTextureLayout
#define maskTextureLayout 0
#endif
#ifndef KERNEL_SIZE
#define KERNEL_SIZE 13
#endif
#ifndef BLUR_ESTIMATION_FIRST_PASS
#define BLUR_ESTIMATION_FIRST_PASS 0
#elif BLUR_ESTIMATION_FIRST_PASS==1
#undef BLUR_ESTIMATION_FIRST_PASS
#define BLUR_ESTIMATION_FIRST_PASS 1
#endif
#ifndef originalTextureUV
#define originalTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_originalTexture
#define SC_USE_UV_TRANSFORM_originalTexture 0
#elif SC_USE_UV_TRANSFORM_originalTexture==1
#undef SC_USE_UV_TRANSFORM_originalTexture
#define SC_USE_UV_TRANSFORM_originalTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_originalTexture
#define SC_SOFTWARE_WRAP_MODE_U_originalTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_originalTexture
#define SC_SOFTWARE_WRAP_MODE_V_originalTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_originalTexture
#define SC_USE_UV_MIN_MAX_originalTexture 0
#elif SC_USE_UV_MIN_MAX_originalTexture==1
#undef SC_USE_UV_MIN_MAX_originalTexture
#define SC_USE_UV_MIN_MAX_originalTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_originalTexture
#define SC_USE_CLAMP_TO_BORDER_originalTexture 0
#elif SC_USE_CLAMP_TO_BORDER_originalTexture==1
#undef SC_USE_CLAMP_TO_BORDER_originalTexture
#define SC_USE_CLAMP_TO_BORDER_originalTexture 1
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
texture2d<float> inputTexture [[id(0)]];
texture2d<float> maskTexture [[id(1)]];
texture2d<float> originalTexture [[id(2)]];
sampler inputTextureSmpSC [[id(3)]];
sampler maskTextureSmpSC [[id(4)]];
sampler originalTextureSmpSC [[id(5)]];
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
void setBlurCoordinates(thread const float2& texCoords,constant userUniformsObj& UserUniforms,thread float2 (&blurCoordinates)[(KERNEL_SIZE/2)+1])
{
float2 texStep=UserUniforms.inputTextureSize.zw*UserUniforms.blurDir;
blurCoordinates[0]=texCoords;
blurCoordinates[1]=texCoords+(texStep*UserUniforms.offset.x);
blurCoordinates[2]=texCoords-(texStep*UserUniforms.offset.x);
blurCoordinates[3]=texCoords+(texStep*UserUniforms.offset.y);
blurCoordinates[4]=texCoords-(texStep*UserUniforms.offset.y);
blurCoordinates[5]=texCoords+(texStep*UserUniforms.offset.z);
blurCoordinates[6]=texCoords-(texStep*UserUniforms.offset.z);
}
vertex sc_VertOut main_vert(sc_VertIn sc_vertIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],uint gl_InstanceIndex [[instance_id]],uint gl_VertexIndex [[vertex_id]])
{
sc_SysIn sc_sysIn;
sc_sysIn.sc_sysAttributes=sc_vertIn.sc_sysAttributes;
sc_sysIn.gl_VertexIndex=gl_VertexIndex;
sc_sysIn.gl_InstanceIndex=gl_InstanceIndex;
sc_VertOut sc_vertOut={};
float2 blurCoordinates[(KERNEL_SIZE/2)+1]={};
sc_Vertex_t v=sc_LoadVertexAttributes(sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
float2 l9_0=((v.position.xy/float2(v.position.w))*0.5)+float2(0.5);
sc_vertOut.sc_sysOut.varPackedTex=float4(l9_0.x,l9_0.y,sc_vertOut.sc_sysOut.varPackedTex.z,sc_vertOut.sc_sysOut.varPackedTex.w);
float2 param=sc_vertOut.sc_sysOut.varPackedTex.xy;
setBlurCoordinates(param,(*sc_set2.UserUniforms),blurCoordinates);
sc_Vertex_t param_1=v;
sc_ProcessVertex(param_1,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 originalTextureSize;
float4 originalTextureDims;
float4 originalTextureView;
float3x3 originalTextureTransform;
float4 originalTextureUvMinMax;
float4 originalTextureBorderColor;
float4 inputTextureSize;
float4 inputTextureDims;
float4 inputTextureView;
float3x3 inputTextureTransform;
float4 inputTextureUvMinMax;
float4 inputTextureBorderColor;
float4 maskTextureSize;
float4 maskTextureDims;
float4 maskTextureView;
float3x3 maskTextureTransform;
float4 maskTextureUvMinMax;
float4 maskTextureBorderColor;
float2 blurDir;
float3 offset;
float4 weight;
};
#ifndef originalTextureHasSwappedViews
#define originalTextureHasSwappedViews 0
#elif originalTextureHasSwappedViews==1
#undef originalTextureHasSwappedViews
#define originalTextureHasSwappedViews 1
#endif
#ifndef originalTextureLayout
#define originalTextureLayout 0
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
#ifndef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 0
#elif maskTextureHasSwappedViews==1
#undef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 1
#endif
#ifndef maskTextureLayout
#define maskTextureLayout 0
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
#ifndef KERNEL_SIZE
#define KERNEL_SIZE 13
#endif
#ifndef BLUR_ESTIMATION_FIRST_PASS
#define BLUR_ESTIMATION_FIRST_PASS 0
#elif BLUR_ESTIMATION_FIRST_PASS==1
#undef BLUR_ESTIMATION_FIRST_PASS
#define BLUR_ESTIMATION_FIRST_PASS 1
#endif
#ifndef SC_USE_UV_TRANSFORM_originalTexture
#define SC_USE_UV_TRANSFORM_originalTexture 0
#elif SC_USE_UV_TRANSFORM_originalTexture==1
#undef SC_USE_UV_TRANSFORM_originalTexture
#define SC_USE_UV_TRANSFORM_originalTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_originalTexture
#define SC_SOFTWARE_WRAP_MODE_U_originalTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_originalTexture
#define SC_SOFTWARE_WRAP_MODE_V_originalTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_originalTexture
#define SC_USE_UV_MIN_MAX_originalTexture 0
#elif SC_USE_UV_MIN_MAX_originalTexture==1
#undef SC_USE_UV_MIN_MAX_originalTexture
#define SC_USE_UV_MIN_MAX_originalTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_originalTexture
#define SC_USE_CLAMP_TO_BORDER_originalTexture 0
#elif SC_USE_CLAMP_TO_BORDER_originalTexture==1
#undef SC_USE_CLAMP_TO_BORDER_originalTexture
#define SC_USE_CLAMP_TO_BORDER_originalTexture 1
#endif
#ifndef originalTextureUV
#define originalTextureUV 0
#endif
#ifndef inputTextureUV
#define inputTextureUV 0
#endif
#ifndef maskTextureUV
#define maskTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> inputTexture [[id(0)]];
texture2d<float> maskTexture [[id(1)]];
texture2d<float> originalTexture [[id(2)]];
sampler inputTextureSmpSC [[id(3)]];
sampler maskTextureSmpSC [[id(4)]];
sampler originalTextureSmpSC [[id(5)]];
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
float4 sampleInputTexture(thread const float2& uv,constant userUniformsObj& UserUniforms,thread texture2d<float> inputTexture,thread sampler inputTextureSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
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
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(inputTexture,inputTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 inputTextureSample=l9_0;
return inputTextureSample;
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
float sampleMaskTexture(thread const float2& uv,constant userUniformsObj& UserUniforms,thread texture2d<float> maskTexture,thread sampler maskTextureSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 param=maskTextureGetDims2D(UserUniforms);
int param_1=maskTextureLayout;
int param_2=maskTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_3=uv;
bool param_4=(int(SC_USE_UV_TRANSFORM_maskTexture)!=0);
float3x3 param_5=UserUniforms.maskTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_maskTexture,SC_SOFTWARE_WRAP_MODE_V_maskTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_maskTexture)!=0);
float4 param_8=UserUniforms.maskTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_maskTexture)!=0);
float4 param_10=UserUniforms.maskTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(maskTexture,maskTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 maskTextureSample=l9_0;
return maskTextureSample.x;
}
float2 originalTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.originalTextureDims.xy;
}
int originalTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (originalTextureHasSwappedViews)
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
float2 blurCoordinates[(KERNEL_SIZE/2)+1]={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param=blurCoordinates[0];
float4 blurredColor=sampleInputTexture(param,(*sc_set2.UserUniforms),sc_set2.inputTexture,sc_set2.inputTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1)*(*sc_set2.UserUniforms).weight.x;
float2 param_1=blurCoordinates[1];
float2 param_2=blurCoordinates[2];
blurredColor+=((sampleInputTexture(param_1,(*sc_set2.UserUniforms),sc_set2.inputTexture,sc_set2.inputTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1)+sampleInputTexture(param_2,(*sc_set2.UserUniforms),sc_set2.inputTexture,sc_set2.inputTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1))*(*sc_set2.UserUniforms).weight.y);
float2 param_3=blurCoordinates[3];
float2 param_4=blurCoordinates[4];
blurredColor+=((sampleInputTexture(param_3,(*sc_set2.UserUniforms),sc_set2.inputTexture,sc_set2.inputTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1)+sampleInputTexture(param_4,(*sc_set2.UserUniforms),sc_set2.inputTexture,sc_set2.inputTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1))*(*sc_set2.UserUniforms).weight.z);
float2 param_5=blurCoordinates[5];
float2 param_6=blurCoordinates[6];
blurredColor+=((sampleInputTexture(param_5,(*sc_set2.UserUniforms),sc_set2.inputTexture,sc_set2.inputTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1)+sampleInputTexture(param_6,(*sc_set2.UserUniforms),sc_set2.inputTexture,sc_set2.inputTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1))*(*sc_set2.UserUniforms).weight.w);
float2 param_7=blurCoordinates[0];
float blurredMask=(*sc_set2.UserUniforms).weight.x*sampleMaskTexture(param_7,(*sc_set2.UserUniforms),sc_set2.maskTexture,sc_set2.maskTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_8=blurCoordinates[1];
float2 param_9=blurCoordinates[2];
blurredMask+=((*sc_set2.UserUniforms).weight.y*(sampleMaskTexture(param_8,(*sc_set2.UserUniforms),sc_set2.maskTexture,sc_set2.maskTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1)+sampleMaskTexture(param_9,(*sc_set2.UserUniforms),sc_set2.maskTexture,sc_set2.maskTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1)));
float2 param_10=blurCoordinates[3];
float2 param_11=blurCoordinates[4];
blurredMask+=((*sc_set2.UserUniforms).weight.z*(sampleMaskTexture(param_10,(*sc_set2.UserUniforms),sc_set2.maskTexture,sc_set2.maskTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1)+sampleMaskTexture(param_11,(*sc_set2.UserUniforms),sc_set2.maskTexture,sc_set2.maskTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1)));
float2 param_12=blurCoordinates[5];
float2 param_13=blurCoordinates[6];
blurredMask+=((*sc_set2.UserUniforms).weight.w*(sampleMaskTexture(param_12,(*sc_set2.UserUniforms),sc_set2.maskTexture,sc_set2.maskTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1)+sampleMaskTexture(param_13,(*sc_set2.UserUniforms),sc_set2.maskTexture,sc_set2.maskTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1)));
#if (BLUR_ESTIMATION_FIRST_PASS)
{
float4 param_14=blurredColor;
sc_writeFragData0(param_14,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
float4 param_15=float4(blurredMask);
sc_writeFragData1(param_15,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
}
#else
{
float2 param_16=originalTextureGetDims2D((*sc_set2.UserUniforms));
int param_17=originalTextureLayout;
int param_18=originalTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_19=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_20=(int(SC_USE_UV_TRANSFORM_originalTexture)!=0);
float3x3 param_21=(*sc_set2.UserUniforms).originalTextureTransform;
int2 param_22=int2(SC_SOFTWARE_WRAP_MODE_U_originalTexture,SC_SOFTWARE_WRAP_MODE_V_originalTexture);
bool param_23=(int(SC_USE_UV_MIN_MAX_originalTexture)!=0);
float4 param_24=(*sc_set2.UserUniforms).originalTextureUvMinMax;
bool param_25=(int(SC_USE_CLAMP_TO_BORDER_originalTexture)!=0);
float4 param_26=(*sc_set2.UserUniforms).originalTextureBorderColor;
float param_27=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.originalTexture,sc_set2.originalTextureSmpSC,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23,param_24,param_25,param_26,param_27);
float4 l9_1=l9_0;
float4 originalTextureSample=l9_0;
float4 param_28=mix(originalTextureSample,blurredColor,float4(blurredMask));
sc_writeFragData0(param_28,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
}
#endif
return sc_fragOut;
}
} // FRAGMENT SHADER

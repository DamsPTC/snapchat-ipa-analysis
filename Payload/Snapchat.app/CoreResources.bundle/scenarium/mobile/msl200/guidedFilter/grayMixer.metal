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
//sampler sampler texAbSmpSC 2:2
//sampler sampler texMainSmpSC 2:3
//texture texture2D texAb 2:0:2:2
//texture texture2D texMain 2:1:2:3
//ubo float UserUniforms 2:4:272 {
//float4 texAbSize 0
//float4 texAbDims 16
//float4 texAbView 32
//float3x3 texAbTransform 48
//float4 texAbUvMinMax 96
//float4 texAbBorderColor 112
//float4 texMainSize 128
//float4 texMainDims 144
//float4 texMainView 160
//float3x3 texMainTransform 176
//float4 texMainUvMinMax 224
//float4 texMainBorderColor 240
//float epsilonSq 256
//float maskScaleMultiplier 260
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 texAbSize;
float4 texAbDims;
float4 texAbView;
float3x3 texAbTransform;
float4 texAbUvMinMax;
float4 texAbBorderColor;
float4 texMainSize;
float4 texMainDims;
float4 texMainView;
float3x3 texMainTransform;
float4 texMainUvMinMax;
float4 texMainBorderColor;
float epsilonSq;
float maskScaleMultiplier;
};
#ifndef texAbHasSwappedViews
#define texAbHasSwappedViews 0
#elif texAbHasSwappedViews==1
#undef texAbHasSwappedViews
#define texAbHasSwappedViews 1
#endif
#ifndef texAbLayout
#define texAbLayout 0
#endif
#ifndef texMainHasSwappedViews
#define texMainHasSwappedViews 0
#elif texMainHasSwappedViews==1
#undef texMainHasSwappedViews
#define texMainHasSwappedViews 1
#endif
#ifndef texMainLayout
#define texMainLayout 0
#endif
#ifndef MASK_PROCESSING_MULTIPLICATION
#define MASK_PROCESSING_MULTIPLICATION 0
#elif MASK_PROCESSING_MULTIPLICATION==1
#undef MASK_PROCESSING_MULTIPLICATION
#define MASK_PROCESSING_MULTIPLICATION 1
#endif
#ifndef MASK_PROCESSING_SMOOTH_STEP
#define MASK_PROCESSING_SMOOTH_STEP 0
#elif MASK_PROCESSING_SMOOTH_STEP==1
#undef MASK_PROCESSING_SMOOTH_STEP
#define MASK_PROCESSING_SMOOTH_STEP 1
#endif
#ifndef MASK_PROCESSING_SCALE
#define MASK_PROCESSING_SCALE 0
#elif MASK_PROCESSING_SCALE==1
#undef MASK_PROCESSING_SCALE
#define MASK_PROCESSING_SCALE 1
#endif
#ifndef texAbUV
#define texAbUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_texAb
#define SC_USE_UV_TRANSFORM_texAb 0
#elif SC_USE_UV_TRANSFORM_texAb==1
#undef SC_USE_UV_TRANSFORM_texAb
#define SC_USE_UV_TRANSFORM_texAb 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_texAb
#define SC_SOFTWARE_WRAP_MODE_U_texAb -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_texAb
#define SC_SOFTWARE_WRAP_MODE_V_texAb -1
#endif
#ifndef SC_USE_UV_MIN_MAX_texAb
#define SC_USE_UV_MIN_MAX_texAb 0
#elif SC_USE_UV_MIN_MAX_texAb==1
#undef SC_USE_UV_MIN_MAX_texAb
#define SC_USE_UV_MIN_MAX_texAb 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_texAb
#define SC_USE_CLAMP_TO_BORDER_texAb 0
#elif SC_USE_CLAMP_TO_BORDER_texAb==1
#undef SC_USE_CLAMP_TO_BORDER_texAb
#define SC_USE_CLAMP_TO_BORDER_texAb 1
#endif
#ifndef texMainUV
#define texMainUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_texMain
#define SC_USE_UV_TRANSFORM_texMain 0
#elif SC_USE_UV_TRANSFORM_texMain==1
#undef SC_USE_UV_TRANSFORM_texMain
#define SC_USE_UV_TRANSFORM_texMain 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_texMain
#define SC_SOFTWARE_WRAP_MODE_U_texMain -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_texMain
#define SC_SOFTWARE_WRAP_MODE_V_texMain -1
#endif
#ifndef SC_USE_UV_MIN_MAX_texMain
#define SC_USE_UV_MIN_MAX_texMain 0
#elif SC_USE_UV_MIN_MAX_texMain==1
#undef SC_USE_UV_MIN_MAX_texMain
#define SC_USE_UV_MIN_MAX_texMain 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_texMain
#define SC_USE_CLAMP_TO_BORDER_texMain 0
#elif SC_USE_CLAMP_TO_BORDER_texMain==1
#undef SC_USE_CLAMP_TO_BORDER_texMain
#define SC_USE_CLAMP_TO_BORDER_texMain 1
#endif
struct sc_Set2
{
texture2d<float> texAb [[id(0)]];
texture2d<float> texMain [[id(1)]];
sampler texAbSmpSC [[id(2)]];
sampler texMainSmpSC [[id(3)]];
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
float2 texpos=(v.position.xy*0.5)+float2(0.5);
texpos.y=1.0-texpos.y;
sc_vertOut.sc_sysOut.varPackedTex=float4(texpos.x,texpos.y,sc_vertOut.sc_sysOut.varPackedTex.z,sc_vertOut.sc_sysOut.varPackedTex.w);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 texAbSize;
float4 texAbDims;
float4 texAbView;
float3x3 texAbTransform;
float4 texAbUvMinMax;
float4 texAbBorderColor;
float4 texMainSize;
float4 texMainDims;
float4 texMainView;
float3x3 texMainTransform;
float4 texMainUvMinMax;
float4 texMainBorderColor;
float epsilonSq;
float maskScaleMultiplier;
};
#ifndef texAbHasSwappedViews
#define texAbHasSwappedViews 0
#elif texAbHasSwappedViews==1
#undef texAbHasSwappedViews
#define texAbHasSwappedViews 1
#endif
#ifndef texAbLayout
#define texAbLayout 0
#endif
#ifndef texMainHasSwappedViews
#define texMainHasSwappedViews 0
#elif texMainHasSwappedViews==1
#undef texMainHasSwappedViews
#define texMainHasSwappedViews 1
#endif
#ifndef texMainLayout
#define texMainLayout 0
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_texAb
#define SC_SOFTWARE_WRAP_MODE_U_texAb -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_texAb
#define SC_SOFTWARE_WRAP_MODE_V_texAb -1
#endif
#ifndef SC_USE_UV_MIN_MAX_texAb
#define SC_USE_UV_MIN_MAX_texAb 0
#elif SC_USE_UV_MIN_MAX_texAb==1
#undef SC_USE_UV_MIN_MAX_texAb
#define SC_USE_UV_MIN_MAX_texAb 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_texAb
#define SC_USE_CLAMP_TO_BORDER_texAb 0
#elif SC_USE_CLAMP_TO_BORDER_texAb==1
#undef SC_USE_CLAMP_TO_BORDER_texAb
#define SC_USE_CLAMP_TO_BORDER_texAb 1
#endif
#ifndef SC_USE_UV_TRANSFORM_texMain
#define SC_USE_UV_TRANSFORM_texMain 0
#elif SC_USE_UV_TRANSFORM_texMain==1
#undef SC_USE_UV_TRANSFORM_texMain
#define SC_USE_UV_TRANSFORM_texMain 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_texMain
#define SC_SOFTWARE_WRAP_MODE_U_texMain -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_texMain
#define SC_SOFTWARE_WRAP_MODE_V_texMain -1
#endif
#ifndef SC_USE_UV_MIN_MAX_texMain
#define SC_USE_UV_MIN_MAX_texMain 0
#elif SC_USE_UV_MIN_MAX_texMain==1
#undef SC_USE_UV_MIN_MAX_texMain
#define SC_USE_UV_MIN_MAX_texMain 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_texMain
#define SC_USE_CLAMP_TO_BORDER_texMain 0
#elif SC_USE_CLAMP_TO_BORDER_texMain==1
#undef SC_USE_CLAMP_TO_BORDER_texMain
#define SC_USE_CLAMP_TO_BORDER_texMain 1
#endif
#ifndef MASK_PROCESSING_MULTIPLICATION
#define MASK_PROCESSING_MULTIPLICATION 0
#elif MASK_PROCESSING_MULTIPLICATION==1
#undef MASK_PROCESSING_MULTIPLICATION
#define MASK_PROCESSING_MULTIPLICATION 1
#endif
#ifndef MASK_PROCESSING_SMOOTH_STEP
#define MASK_PROCESSING_SMOOTH_STEP 0
#elif MASK_PROCESSING_SMOOTH_STEP==1
#undef MASK_PROCESSING_SMOOTH_STEP
#define MASK_PROCESSING_SMOOTH_STEP 1
#endif
#ifndef MASK_PROCESSING_SCALE
#define MASK_PROCESSING_SCALE 0
#elif MASK_PROCESSING_SCALE==1
#undef MASK_PROCESSING_SCALE
#define MASK_PROCESSING_SCALE 1
#endif
#ifndef texAbUV
#define texAbUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_texAb
#define SC_USE_UV_TRANSFORM_texAb 0
#elif SC_USE_UV_TRANSFORM_texAb==1
#undef SC_USE_UV_TRANSFORM_texAb
#define SC_USE_UV_TRANSFORM_texAb 1
#endif
#ifndef texMainUV
#define texMainUV 0
#endif
struct sc_Set2
{
texture2d<float> texAb [[id(0)]];
texture2d<float> texMain [[id(1)]];
sampler texAbSmpSC [[id(2)]];
sampler texMainSmpSC [[id(3)]];
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
float2 texAbGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.texAbDims.xy;
}
int texAbGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (texAbHasSwappedViews)
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
float2 texMainGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.texMainDims.xy;
}
int texMainGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (texMainHasSwappedViews)
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
float grayscale(thread const float3& color)
{
return dot(color,float3(0.21259999,0.71520001,0.0722));
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param=texAbGetDims2D((*sc_set2.UserUniforms));
int param_1=texAbLayout;
int param_2=texAbGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=false;
float3x3 param_5=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_texAb,SC_SOFTWARE_WRAP_MODE_V_texAb);
bool param_7=(int(SC_USE_UV_MIN_MAX_texAb)!=0);
float4 param_8=(*sc_set2.UserUniforms).texAbUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_texAb)!=0);
float4 param_10=(*sc_set2.UserUniforms).texAbBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.texAb,sc_set2.texAbSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 texAbSample=l9_0;
float2 param_12=sc_fragIn.sc_sysIn.varPackedTex.xy;
float2 param_13=texMainGetDims2D((*sc_set2.UserUniforms));
int param_14=texMainLayout;
int param_15=texMainGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_16=sc_PlatformFlipV(param_12);
bool param_17=(int(SC_USE_UV_TRANSFORM_texMain)!=0);
float3x3 param_18=(*sc_set2.UserUniforms).texMainTransform;
int2 param_19=int2(SC_SOFTWARE_WRAP_MODE_U_texMain,SC_SOFTWARE_WRAP_MODE_V_texMain);
bool param_20=(int(SC_USE_UV_MIN_MAX_texMain)!=0);
float4 param_21=(*sc_set2.UserUniforms).texMainUvMinMax;
bool param_22=(int(SC_USE_CLAMP_TO_BORDER_texMain)!=0);
float4 param_23=(*sc_set2.UserUniforms).texMainBorderColor;
float param_24=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.texMain,sc_set2.texMainSmpSC,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23,param_24);
float4 l9_3=l9_2;
float4 texMainSample=l9_2;
float3 param_25=texMainSample.xyz;
float hr_x=grayscale(param_25);
float4 box=texAbSample;
float2 cov_var=box.zw-(box.xx*box.yx);
float A=cov_var.x/(cov_var.y+(*sc_set2.UserUniforms).epsilonSq);
float mask=(A*(hr_x-box.x))+box.y;
#if (MASK_PROCESSING_MULTIPLICATION)
{
mask*=mask;
}
#else
{
#if (MASK_PROCESSING_SMOOTH_STEP)
{
mask=smoothstep(0.15700001,0.50199997,mask);
}
#else
{
#if (MASK_PROCESSING_SCALE)
{
mask*=(*sc_set2.UserUniforms).maskScaleMultiplier;
}
#endif
}
#endif
}
#endif
float4 param_26=float4(mask,mask,mask,1.0);
sc_writeFragData0(param_26,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "required2.metal"
#include "std2_vs.metal"
#include "std2_fs.metal"
#include "std2_texture.metal"
#include "ssao_common.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler ambientOcclusionSmpSC 2:1
//texture texture2D ambientOcclusion 2:0:2:1
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
float4 ambientOcclusionSize;
float4 ambientOcclusionDims;
float4 ambientOcclusionView;
float3x3 ambientOcclusionTransform;
float4 ambientOcclusionUvMinMax;
float4 ambientOcclusionBorderColor;
float sampleCount;
float farPlaneOverBlurThreshold;
float kernel0[16];
float2 axis;
};
#ifndef ambientOcclusionHasSwappedViews
#define ambientOcclusionHasSwappedViews 0
#elif ambientOcclusionHasSwappedViews==1
#undef ambientOcclusionHasSwappedViews
#define ambientOcclusionHasSwappedViews 1
#endif
#ifndef ambientOcclusionLayout
#define ambientOcclusionLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_ambientOcclusion
#define SC_USE_UV_TRANSFORM_ambientOcclusion 0
#elif SC_USE_UV_TRANSFORM_ambientOcclusion==1
#undef SC_USE_UV_TRANSFORM_ambientOcclusion
#define SC_USE_UV_TRANSFORM_ambientOcclusion 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_ambientOcclusion
#define SC_SOFTWARE_WRAP_MODE_U_ambientOcclusion -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_ambientOcclusion
#define SC_SOFTWARE_WRAP_MODE_V_ambientOcclusion -1
#endif
#ifndef SC_USE_UV_MIN_MAX_ambientOcclusion
#define SC_USE_UV_MIN_MAX_ambientOcclusion 0
#elif SC_USE_UV_MIN_MAX_ambientOcclusion==1
#undef SC_USE_UV_MIN_MAX_ambientOcclusion
#define SC_USE_UV_MIN_MAX_ambientOcclusion 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_ambientOcclusion
#define SC_USE_CLAMP_TO_BORDER_ambientOcclusion 0
#elif SC_USE_CLAMP_TO_BORDER_ambientOcclusion==1
#undef SC_USE_CLAMP_TO_BORDER_ambientOcclusion
#define SC_USE_CLAMP_TO_BORDER_ambientOcclusion 1
#endif
#ifndef ambientOcclusionUV
#define ambientOcclusionUV 0
#endif
struct sc_Set2
{
texture2d<float> ambientOcclusion [[id(0)]];
sampler ambientOcclusionSmpSC [[id(1)]];
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
float2 ambientOcclusionGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.ambientOcclusionDims.xy;
}
int ambientOcclusionGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (ambientOcclusionHasSwappedViews)
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
float unpackNormalizedDepth(thread const float2& data)
{
return (data.x*256.0)+(data.y*0.00390625);
}
void tap(thread const float2& uv,thread const float& centerDepth,thread const float& kernelWeight,thread float& sum,thread float& totalWeight,constant userUniformsObj& UserUniforms,thread texture2d<float> ambientOcclusion,thread sampler ambientOcclusionSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 param=ambientOcclusionGetDims2D(UserUniforms);
int param_1=ambientOcclusionLayout;
int param_2=ambientOcclusionGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_3=uv;
bool param_4=(int(SC_USE_UV_TRANSFORM_ambientOcclusion)!=0);
float3x3 param_5=UserUniforms.ambientOcclusionTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_ambientOcclusion,SC_SOFTWARE_WRAP_MODE_V_ambientOcclusion);
bool param_7=(int(SC_USE_UV_MIN_MAX_ambientOcclusion)!=0);
float4 param_8=UserUniforms.ambientOcclusionUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_ambientOcclusion)!=0);
float4 param_10=UserUniforms.ambientOcclusionBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(ambientOcclusion,ambientOcclusionSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 ambientOcclusionSample=l9_0;
float3 data=ambientOcclusionSample.xyz;
float2 param_12=data.yz;
float sampleDepth=unpackNormalizedDepth(param_12);
float normalizedDifference=(sampleDepth-centerDepth)*UserUniforms.farPlaneOverBlurThreshold;
float depthBasedWeight=fast::max(0.0,1.0-(normalizedDifference*normalizedDifference));
float weight=kernelWeight*depthBasedWeight;
sum+=(data.x*weight);
totalWeight+=weight;
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 uv=(sc_fragIn.sc_sysIn.varScreenPos.xy*0.5)+float2(0.5);
float2 param=ambientOcclusionGetDims2D((*sc_set2.UserUniforms));
int param_1=ambientOcclusionLayout;
int param_2=ambientOcclusionGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=uv;
bool param_4=(int(SC_USE_UV_TRANSFORM_ambientOcclusion)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).ambientOcclusionTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_ambientOcclusion,SC_SOFTWARE_WRAP_MODE_V_ambientOcclusion);
bool param_7=(int(SC_USE_UV_MIN_MAX_ambientOcclusion)!=0);
float4 param_8=(*sc_set2.UserUniforms).ambientOcclusionUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_ambientOcclusion)!=0);
float4 param_10=(*sc_set2.UserUniforms).ambientOcclusionBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.ambientOcclusion,sc_set2.ambientOcclusionSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 ambientOcclusionSample=l9_0;
float3 data=ambientOcclusionSample.xyz;
float ao;
if ((data.y*data.z)==1.0)
{
ao=1.0;
}
else
{
float2 param_12=data.yz;
float centerDepth=unpackNormalizedDepth(param_12);
float totalWeight=(*sc_set2.UserUniforms).kernel0[0];
float sum=data.x*totalWeight;
float2 offset=(*sc_set2.UserUniforms).axis;
int iSampleCount=int((*sc_set2.UserUniforms).sampleCount);
int i=1;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (i<iSampleCount)
{
float kernelWeight=(*sc_set2.UserUniforms).kernel0[i];
float2 param_13=uv+offset;
float param_14=centerDepth;
float param_15=kernelWeight;
float param_16=sum;
float param_17=totalWeight;
tap(param_13,param_14,param_15,param_16,param_17,(*sc_set2.UserUniforms),sc_set2.ambientOcclusion,sc_set2.ambientOcclusionSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
sum=param_16;
totalWeight=param_17;
float2 param_18=uv-offset;
float param_19=centerDepth;
float param_20=kernelWeight;
float param_21=sum;
float param_22=totalWeight;
tap(param_18,param_19,param_20,param_21,param_22,(*sc_set2.UserUniforms),sc_set2.ambientOcclusion,sc_set2.ambientOcclusionSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
sum=param_21;
totalWeight=param_22;
offset+=(*sc_set2.UserUniforms).axis;
i++;
continue;
}
else
{
break;
}
}
ao=sum*(1.0/totalWeight);
ao+=((interleavedGradientNoise(sc_fragIn.sc_sysIn,sc_set0,sc_set1)-0.5)/255.0);
}
float3 result=float3(ao,data.y,data.z);
float4 param_23=float4(result,1.0);
sc_writeFragData0(param_23,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

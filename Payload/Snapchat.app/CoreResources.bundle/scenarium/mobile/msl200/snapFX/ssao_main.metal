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
//sampler sampler depthBufferSmpSC 2:1
//texture texture2D depthBuffer 2:0:2:1
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
float4 depthBufferSize;
float4 depthBufferDims;
float4 depthBufferView;
float3x3 depthBufferTransform;
float4 depthBufferUvMinMax;
float4 depthBufferBorderColor;
float intensity;
float power;
float2 sampleCount;
float spiralTurns;
float2 tapRotationCosSin;
float projectionScaleRadiusInPixels;
float invRadiusSquared;
float minHorizonAngleSineSquared;
float maxLevel;
float selfOcclusionBias;
float peakFalloffSquared;
float invFarPlane;
};
#ifndef depthBufferHasSwappedViews
#define depthBufferHasSwappedViews 0
#elif depthBufferHasSwappedViews==1
#undef depthBufferHasSwappedViews
#define depthBufferHasSwappedViews 1
#endif
#ifndef depthBufferLayout
#define depthBufferLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_depthBuffer
#define SC_USE_UV_TRANSFORM_depthBuffer 0
#elif SC_USE_UV_TRANSFORM_depthBuffer==1
#undef SC_USE_UV_TRANSFORM_depthBuffer
#define SC_USE_UV_TRANSFORM_depthBuffer 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_depthBuffer
#define SC_SOFTWARE_WRAP_MODE_U_depthBuffer -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_depthBuffer
#define SC_SOFTWARE_WRAP_MODE_V_depthBuffer -1
#endif
#ifndef SC_USE_UV_MIN_MAX_depthBuffer
#define SC_USE_UV_MIN_MAX_depthBuffer 0
#elif SC_USE_UV_MIN_MAX_depthBuffer==1
#undef SC_USE_UV_MIN_MAX_depthBuffer
#define SC_USE_UV_MIN_MAX_depthBuffer 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_depthBuffer
#define SC_USE_CLAMP_TO_BORDER_depthBuffer 0
#elif SC_USE_CLAMP_TO_BORDER_depthBuffer==1
#undef SC_USE_CLAMP_TO_BORDER_depthBuffer
#define SC_USE_CLAMP_TO_BORDER_depthBuffer 1
#endif
#ifndef depthBufferUV
#define depthBufferUV 0
#endif
struct sc_Set2
{
texture2d<float> depthBuffer [[id(0)]];
sampler depthBufferSmpSC [[id(1)]];
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
float2 depthBufferGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.depthBufferDims.xy;
}
int depthBufferGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (depthBufferHasSwappedViews)
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
float sampleLinearDepth(thread const float2& uv,constant userUniformsObj& UserUniforms,thread texture2d<float> depthBuffer,thread sampler depthBufferSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 param=depthBufferGetDims2D(UserUniforms);
int param_1=depthBufferLayout;
int param_2=depthBufferGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_3=uv;
bool param_4=(int(SC_USE_UV_TRANSFORM_depthBuffer)!=0);
float3x3 param_5=UserUniforms.depthBufferTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_depthBuffer,SC_SOFTWARE_WRAP_MODE_V_depthBuffer);
bool param_7=(int(SC_USE_UV_MIN_MAX_depthBuffer)!=0);
float4 param_8=UserUniforms.depthBufferUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_depthBuffer)!=0);
float4 param_10=UserUniforms.depthBufferBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(depthBuffer,depthBufferSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float depth=l9_0.x;
float param_12=depth;
return depthScreenToViewSpace(param_12,sc_sysIn,sc_set0,sc_set1);
}
float3 computeViewSpacePositionFromDepth(thread const float2& uv,constant userUniformsObj& UserUniforms,thread texture2d<float> depthBuffer,thread sampler depthBufferSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 invProjectionFactors=float2((*sc_set0.LibraryUniforms).sc_ProjectionMatrixInverseArray[sc_GetStereoViewIndex(sc_sysIn,sc_set0,sc_set1)][0].x,(*sc_set0.LibraryUniforms).sc_ProjectionMatrixInverseArray[sc_GetStereoViewIndex(sc_sysIn,sc_set0,sc_set1)][1].y);
float2 param=uv;
float linearDepth=sampleLinearDepth(param,UserUniforms,depthBuffer,depthBufferSmpSC,sc_sysIn,sc_set0,sc_set1);
return float3(((float2(0.5)-uv)*invProjectionFactors)*linearDepth,linearDepth);
}
float3 faceNormal(thread const float3& dpdx,thread const float3& dpdy)
{
return normalize(cross(dpdx,dpdy));
}
float3 computeViewSpaceNormalFromDepth(float2 uv,float3 viewPos,constant userUniformsObj& UserUniforms,thread texture2d<float> depthBuffer,thread sampler depthBufferSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 texelOffset=float2(1.0)/UserUniforms.depthBufferDims.xy;
float2 param=uv+float2(texelOffset.x,0.0);
float3 viewPosNextTexelX=computeViewSpacePositionFromDepth(param,UserUniforms,depthBuffer,depthBufferSmpSC,sc_sysIn,sc_set0,sc_set1);
float2 param_1=uv+float2(0.0,texelOffset.y);
float3 viewPosNextTexelY=computeViewSpacePositionFromDepth(param_1,UserUniforms,depthBuffer,depthBufferSmpSC,sc_sysIn,sc_set0,sc_set1);
float3 param_2=viewPosNextTexelX-viewPos;
float3 param_3=viewPosNextTexelY-viewPos;
return faceNormal(param_2,param_3);
}
float scalableAmbientObscurance(thread const float2& uv,thread const float3& viewPos,thread const float3& normal,constant userUniformsObj& UserUniforms,thread texture2d<float> depthBuffer,thread sampler depthBufferSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float _noise=interleavedGradientNoise(sc_sysIn,sc_set0,sc_set1);
float startTapAngle=15.079645*_noise;
float2 tapPos=float2(cos(startTapAngle),sin(startTapAngle));
float2x2 tapRotation=float2x2(float2(UserUniforms.tapRotationCosSin.x,UserUniforms.tapRotationCosSin.y),float2(-UserUniforms.tapRotationCosSin.y,UserUniforms.tapRotationCosSin.x));
float projectedRadiusInPixels=(-UserUniforms.projectionScaleRadiusInPixels)/viewPos.z;
float obscurance=0.0;
float i=0.0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (i<UserUniforms.sampleCount.x)
{
float normalizedSpiralRadius=((i+_noise)+0.5)*UserUniforms.sampleCount.y;
float radiusInPixels=fast::max(1.0,(normalizedSpiralRadius*normalizedSpiralRadius)*projectedRadiusInPixels);
float2 sampleUV=uv+(float2(tapPos*radiusInPixels)*(float2(1.0)/UserUniforms.depthBufferDims.xy));
float2 param=sampleUV;
float3 tapViewPos=computeViewSpacePositionFromDepth(param,UserUniforms,depthBuffer,depthBufferSmpSC,sc_sysIn,sc_set0,sc_set1);
float3 vector=tapViewPos-viewPos;
float distSquared=dot(vector,vector);
float distCosNormal=dot(vector,normal);
float falloff=fast::max(0.0,1.0-(distSquared*UserUniforms.invRadiusSquared));
falloff*=falloff;
float sampleOcclusion=fast::max(0.0,distCosNormal+(viewPos.z*UserUniforms.selfOcclusionBias))/(distSquared+UserUniforms.peakFalloffSquared);
obscurance+=(falloff*sampleOcclusion);
tapPos=tapRotation*tapPos;
i+=1.0;
continue;
}
else
{
break;
}
}
return sqrt(obscurance*UserUniforms.intensity);
}
float2 packDepth(thread float& normalizedDepth)
{
normalizedDepth=fast::clamp(normalizedDepth,0.0,1.0);
float quantized=floor(256.0*normalizedDepth);
float hiBits=quantized*0.00390625;
float loBits=(256.0*normalizedDepth)-quantized;
return float2(hiBits,loBits);
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 uv=(sc_fragIn.sc_sysIn.varScreenPos.xy*0.5)+float2(0.5);
float2 param=uv;
float3 viewPos=computeViewSpacePositionFromDepth(param,(*sc_set2.UserUniforms),sc_set2.depthBuffer,sc_set2.depthBufferSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float3 normal=computeViewSpaceNormalFromDepth(uv,viewPos,(*sc_set2.UserUniforms),sc_set2.depthBuffer,sc_set2.depthBufferSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float occlusion=0.0;
if ((*sc_set2.UserUniforms).intensity>0.0)
{
float2 param_1=uv;
float3 param_2=viewPos;
float3 param_3=normal;
occlusion=scalableAmbientObscurance(param_1,param_2,param_3,(*sc_set2.UserUniforms),sc_set2.depthBuffer,sc_set2.depthBufferSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
}
float aoVisibility=pow(fast::clamp(1.0-occlusion,0.0,1.0),(*sc_set2.UserUniforms).power);
float param_4=(-viewPos.z)*(*sc_set2.UserUniforms).invFarPlane;
float2 l9_0=packDepth(param_4);
float3 result=float3(aoVisibility,l9_0);
float4 param_5=float4(result,1.0);
sc_writeFragData0(param_5,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

#pragma once
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "required2.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//SG_REFLECTION_END

namespace SNAP_VS {
struct sc_HairVertex
{
float4 position;
float3 normal;
float3 tangent;
float2 texture0;
float4 debugColor;
int strandId;
};
float rand_arg2f(thread const float2& co)
{
return fract(sin(dot(co,float2(12.9898,78.233002)))*43758.547);
}
sc_HairVertex sc_GenerateHairVertexInViewspace(thread const sc_Vertex_t& v,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
sc_HairVertex hv;
#if (!sc_HairFallbackMode)
{
float instanceId=float(sc_GetLocalInstanceID(sc_sysIn,sc_sysOut,sc_set0,sc_set1));
float strandInstanceCount=(1.0+(*sc_set0.LibraryUniforms).clumpInstanceCount)+(*sc_set0.LibraryUniforms).hairstyleInstanceCount;
float instanceCount=(*sc_set0.LibraryUniforms).sc_StrandDataMapTextureSize.y*strandInstanceCount;
float basicStrandIndex=floor((instanceId/strandInstanceCount)+9.9999997e-05);
float basicStrandInstanceId=basicStrandIndex*strandInstanceCount;
float relativeInstanceId=instanceId-basicStrandInstanceId;
float l9_0=relativeInstanceId;
bool l9_1=l9_0>0.0;
bool l9_2;
if (l9_1)
{
l9_2=relativeInstanceId<=(*sc_set0.LibraryUniforms).clumpInstanceCount;
}
else
{
l9_2=l9_1;
}
bool isSingleInterpolationStrand=l9_2;
bool isMultiInterpolationStrand=(relativeInstanceId>(*sc_set0.LibraryUniforms).clumpInstanceCount)&&(relativeInstanceId<strandInstanceCount);
bool isBasicStrand=(!isSingleInterpolationStrand)&&(!isMultiInterpolationStrand);
float2 uvAbsoluteMax=float2((*sc_set0.LibraryUniforms).sc_StrandDataMapTextureSize.x-1.0,(*sc_set0.LibraryUniforms).sc_StrandDataMapTextureSize.y-1.0);
float2 uvOffsetX=float2(1.0/uvAbsoluteMax.x,0.0);
float2 randomTerms=float2(instanceId/instanceCount,(instanceCount-instanceId)/instanceCount);
float3 randomOffset=float3(0.0);
float2 param=randomTerms.xx;
randomOffset.x=(rand_arg2f(param)*2.0)-1.0;
float2 param_1=float2(randomOffset.x,randomTerms.x);
randomOffset.y=(rand_arg2f(param_1)*2.0)-1.0;
float2 param_2=float2(randomOffset.x,randomOffset.y);
randomOffset.z=(rand_arg2f(param_2)*2.0)-1.0;
float2 uv=float2(v.position.y/uvAbsoluteMax.x,basicStrandIndex/uvAbsoluteMax.y);
bool pointIsNotLast=v.position.y<uvAbsoluteMax.x;
bool pointIsNotFirst=v.position.y>0.0;
float3 pointWorldPosition=sc_set0.sc_StrandDataMapTexture.sample(sc_set0.sc_StrandDataMapTextureSmpSC,uv,level(0.0)).xyz;
float3 l9_3;
if (pointIsNotLast)
{
l9_3=sc_set0.sc_StrandDataMapTexture.sample(sc_set0.sc_StrandDataMapTextureSmpSC,(uv+uvOffsetX),level(0.0)).xyz;
}
else
{
l9_3=pointWorldPosition;
}
float3 pointWorldPositionNext=l9_3;
float3 l9_4;
if (pointIsNotFirst)
{
l9_4=sc_set0.sc_StrandDataMapTexture.sample(sc_set0.sc_StrandDataMapTextureSmpSC,(uv-uvOffsetX),level(0.0)).xyz;
}
else
{
l9_4=pointWorldPosition;
}
float3 pointWorldPositionPrevious=l9_4;
float3 strandPointOffset=float3(0.0);
float3 strandPointOffsetNext=float3(0.0);
float3 strandPointOffsetPrevious=float3(0.0);
float2 neighbourIndices=float2(-1.0);
if (isMultiInterpolationStrand)
{
neighbourIndices.x=sc_set0.sc_StrandDataMapTexture.sample(sc_set0.sc_StrandDataMapTextureSmpSC,float2(0.0,uv.y),level(0.0)).w;
neighbourIndices.y=sc_set0.sc_StrandDataMapTexture.sample(sc_set0.sc_StrandDataMapTextureSmpSC,float2(uvOffsetX.x,uv.y),level(0.0)).w;
float l9_5=neighbourIndices.x;
bool l9_6=l9_5<0.0;
bool l9_7;
if (l9_6)
{
l9_7=neighbourIndices.y<0.0;
}
else
{
l9_7=l9_6;
}
if (l9_7)
{
isSingleInterpolationStrand=true;
isMultiInterpolationStrand=false;
}
}
if (isMultiInterpolationStrand)
{
float3 pointWorldPositionInterpolated=pointWorldPosition;
float3 pointWorldPositionInterpolatedNext=pointWorldPositionNext;
float3 pointWorldPositionInterpolatedPrevious=pointWorldPositionPrevious;
if (neighbourIndices.x>=0.0)
{
float2 uv1=float2(uv.x,neighbourIndices.x/uvAbsoluteMax.y);
float3 pointWorldPosition1=sc_set0.sc_StrandDataMapTexture.sample(sc_set0.sc_StrandDataMapTextureSmpSC,uv1,level(0.0)).xyz;
float2 param_3=randomTerms;
float lerpTerm1=rand_arg2f(param_3);
pointWorldPositionInterpolated=mix(pointWorldPositionInterpolated,pointWorldPosition1,float3(lerpTerm1));
if (pointIsNotLast)
{
float3 pointWorldPositionNext1=sc_set0.sc_StrandDataMapTexture.sample(sc_set0.sc_StrandDataMapTextureSmpSC,(uv1+uvOffsetX),level(0.0)).xyz;
pointWorldPositionInterpolatedNext=mix(pointWorldPositionInterpolatedNext,pointWorldPositionNext1,float3(lerpTerm1));
}
if (pointIsNotFirst)
{
float3 pointWorldPositionPrevious1=sc_set0.sc_StrandDataMapTexture.sample(sc_set0.sc_StrandDataMapTextureSmpSC,(uv1-uvOffsetX),level(0.0)).xyz;
pointWorldPositionInterpolatedPrevious=mix(pointWorldPositionInterpolatedPrevious,pointWorldPositionPrevious1,float3(lerpTerm1));
}
}
if (neighbourIndices.y>=0.0)
{
float2 uv2=float2(uv.x,neighbourIndices.y/uvAbsoluteMax.y);
float3 pointWorldPosition2=sc_set0.sc_StrandDataMapTexture.sample(sc_set0.sc_StrandDataMapTextureSmpSC,uv2,level(0.0)).xyz;
float2 param_4=randomTerms.xx;
float lerpTerm2=rand_arg2f(param_4);
pointWorldPositionInterpolated=mix(pointWorldPositionInterpolated,pointWorldPosition2,float3(lerpTerm2));
if (pointIsNotLast)
{
float3 pointWorldPositionNext2=sc_set0.sc_StrandDataMapTexture.sample(sc_set0.sc_StrandDataMapTextureSmpSC,(uv2+uvOffsetX),level(0.0)).xyz;
pointWorldPositionInterpolatedNext=mix(pointWorldPositionInterpolatedNext,pointWorldPositionNext2,float3(lerpTerm2));
}
if (pointIsNotFirst)
{
float3 pointWorldPositionPrevious2=sc_set0.sc_StrandDataMapTexture.sample(sc_set0.sc_StrandDataMapTextureSmpSC,(uv2-uvOffsetX),level(0.0)).xyz;
pointWorldPositionInterpolatedPrevious=mix(pointWorldPositionInterpolatedPrevious,pointWorldPositionPrevious2,float3(lerpTerm2));
}
}
float3 noiseOffset=randomOffset*(*sc_set0.LibraryUniforms).hairstyleNoise;
strandPointOffset=pointWorldPositionInterpolated-pointWorldPosition;
strandPointOffset+=noiseOffset;
strandPointOffsetNext=pointWorldPositionInterpolatedNext-pointWorldPositionNext;
strandPointOffsetNext+=noiseOffset;
strandPointOffsetPrevious=pointWorldPositionInterpolatedPrevious-pointWorldPositionPrevious;
strandPointOffsetPrevious+=noiseOffset;
}
else
{
if (isSingleInterpolationStrand)
{
float l9_8;
if ((*sc_set0.LibraryUniforms).clumpTipScale<0.0)
{
l9_8=(*sc_set0.LibraryUniforms).clumpRadius*(*sc_set0.LibraryUniforms).clumpTipScale;
}
else
{
l9_8=(*sc_set0.LibraryUniforms).clumpTipScale;
}
float clumpTipScaleTerm=l9_8;
strandPointOffset=randomOffset*((*sc_set0.LibraryUniforms).clumpRadius+(uv.x*clumpTipScaleTerm));
strandPointOffsetNext=randomOffset*((*sc_set0.LibraryUniforms).clumpRadius+((uv.x+uvOffsetX.x)*clumpTipScaleTerm));
strandPointOffsetPrevious=randomOffset*((*sc_set0.LibraryUniforms).clumpRadius+((uv.x-uvOffsetX.x)*clumpTipScaleTerm));
}
}
pointWorldPosition+=strandPointOffset;
float4 pointViewPosition=(*sc_set0.LibraryUniforms).sc_ViewMatrixArray[sc_GetStereoViewIndex(sc_sysIn,sc_sysOut,sc_set0,sc_set1)]*float4(pointWorldPosition,1.0);
float3 smoothedTangent=float3(0.0);
if (pointIsNotLast)
{
float4 pointViewPositionNext=(*sc_set0.LibraryUniforms).sc_ViewMatrixArray[sc_GetStereoViewIndex(sc_sysIn,sc_sysOut,sc_set0,sc_set1)]*float4(pointWorldPositionNext+strandPointOffsetNext,1.0);
smoothedTangent=normalize(pointViewPositionNext.xyz-pointViewPosition.xyz);
}
if (pointIsNotFirst)
{
float4 pointViewPositionPrevious=(*sc_set0.LibraryUniforms).sc_ViewMatrixArray[sc_GetStereoViewIndex(sc_sysIn,sc_sysOut,sc_set0,sc_set1)]*float4(pointWorldPositionPrevious+strandPointOffsetPrevious,1.0);
smoothedTangent+=normalize(pointViewPosition.xyz-pointViewPositionPrevious.xyz);
}
float l9_9=v.position.y;
bool l9_10=l9_9>0.0;
bool l9_11;
if (l9_10)
{
l9_11=v.position.y<uvAbsoluteMax.x;
}
else
{
l9_11=l9_10;
}
if (l9_11)
{
smoothedTangent*=0.5;
}
hv.tangent=smoothedTangent;
float3 smoothedBinormal=float3(smoothedTangent.y,-smoothedTangent.x,smoothedTangent.z);
hv.normal=normalize(cross(smoothedTangent,smoothedBinormal));
float2 l9_12=pointViewPosition.xy+(((smoothedBinormal.xy*v.position.x)*(*sc_set0.LibraryUniforms).strandWidth)*(1.0-(uv.x*(*sc_set0.LibraryUniforms).strandTaper)));
pointViewPosition=float4(l9_12.x,l9_12.y,pointViewPosition.z,pointViewPosition.w);
hv.position=pointViewPosition;
hv.texture0=float2(((-v.position.x)*0.5)+0.5,1.0-uv.x);
hv.strandId=sc_GetLocalInstanceID(sc_sysIn,sc_sysOut,sc_set0,sc_set1);
hv.debugColor=float4(0.0);
#if (sc_HairDebugMode)
{
if (isBasicStrand)
{
hv.debugColor=float4(0.0,1.0,0.0,1.0);
}
else
{
if (isSingleInterpolationStrand)
{
hv.debugColor=float4(0.0,0.0,1.0,1.0);
}
else
{
if (isMultiInterpolationStrand)
{
hv.debugColor=float4(1.0,0.0,0.0,1.0);
}
}
}
}
#endif
}
#else
{
float4 pointViewPosition_1=(*sc_set0.LibraryUniforms).sc_ModelViewMatrixArray[sc_GetStereoViewIndex(sc_sysIn,sc_sysOut,sc_set0,sc_set1)]*float4(v.position.x,v.position.y,v.position.z,1.0);
float4 pointViewPositionNext_1=(*sc_set0.LibraryUniforms).sc_ModelViewMatrixArray[sc_GetStereoViewIndex(sc_sysIn,sc_sysOut,sc_set0,sc_set1)]*float4(sc_sysIn.sc_sysAttributes.positionNext.x,sc_sysIn.sc_sysAttributes.positionNext.y,sc_sysIn.sc_sysAttributes.positionNext.z,1.0);
float4 pointViewPositionPrevious_1=(*sc_set0.LibraryUniforms).sc_ModelViewMatrixArray[sc_GetStereoViewIndex(sc_sysIn,sc_sysOut,sc_set0,sc_set1)]*float4(sc_sysIn.sc_sysAttributes.positionPrevious.x,sc_sysIn.sc_sysAttributes.positionPrevious.y,sc_sysIn.sc_sysAttributes.positionPrevious.z,1.0);
float3 smoothedTangent_1=float3(0.0);
float strandPointNormalizedDistance=sc_sysIn.sc_sysAttributes.strandProperties.y;
if (strandPointNormalizedDistance<1.0)
{
smoothedTangent_1+=normalize(pointViewPositionNext_1.xyz-pointViewPosition_1.xyz);
}
if (strandPointNormalizedDistance>0.0)
{
smoothedTangent_1+=normalize(pointViewPosition_1.xyz-pointViewPositionPrevious_1.xyz);
}
if ((strandPointNormalizedDistance>0.0)&&(strandPointNormalizedDistance<1.0))
{
smoothedTangent_1*=0.5;
}
hv.tangent=smoothedTangent_1;
float binormalSign=sc_sysIn.sc_sysAttributes.strandProperties.x;
float2 smoothedBinormal_1=float2(smoothedTangent_1.y,-smoothedTangent_1.x);
float2 l9_13=pointViewPosition_1.xy+(((smoothedBinormal_1*binormalSign)*(*sc_set0.LibraryUniforms).strandWidth)*(1.0-((1.0-sc_sysIn.sc_sysAttributes.texture0.y)*(*sc_set0.LibraryUniforms).strandTaper)));
pointViewPosition_1=float4(l9_13.x,l9_13.y,pointViewPosition_1.z,pointViewPosition_1.w);
hv.position=pointViewPosition_1;
hv.texture0=v.texture0;
hv.strandId=int(sc_sysIn.sc_sysAttributes.strandProperties.w);
#if (sc_HairDebugMode)
{
float strandType=sc_sysIn.sc_sysAttributes.strandProperties.z;
hv.debugColor=float4(float(strandType==2.0),float(strandType==0.0),float(strandType==1.0),1.0);
}
#else
{
hv.debugColor=float4(0.0);
}
#endif
}
#endif
return hv;
}
} // VERTEX SHADER


namespace SNAP_FS {
float rand_arg2f(thread const float2& co)
{
return fract(sin(dot(co,float2(12.9898,78.233002)))*43758.547);
}
} // FRAGMENT SHADER

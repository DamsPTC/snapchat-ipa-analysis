#pragma once
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "std2_shadows.metal"
//SG_REFLECTION_BEGIN(100)
//SG_REFLECTION_END

namespace SNAP_VS {
struct sc_Vertex_t
{
float4 position;
float3 normal;
float3 tangent;
float2 texture0;
float2 texture1;
};
int sc_GetLocalInstanceID(thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
return sc_sysIn.gl_InstanceIndex;
}
void sc_SetClipDistancePlatform(thread const float& dstClipDistance)
{
}
void sc_SetClipDistance(thread const float& dstClipDistance,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
#if (sc_StereoRendering_IsClipDistanceEnabled==1)
{
float param=dstClipDistance;
sc_SetClipDistancePlatform(param);
}
#else
{
sc_sysOut.varClipDistance=dstClipDistance;
}
#endif
}
void sc_SetClipDistance(thread const float4& clipPosition,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
#if (sc_StereoRenderingMode==1)
{
float dstClipDistance=dot(clipPosition,(*sc_set0.LibraryUniforms).sc_StereoClipPlanes[sc_sysIn.gl_InstanceIndex%2]);
float param=dstClipDistance;
sc_SetClipDistance(param,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
}
#endif
}
void sc_SetClipPosition(thread const float4& clipPosition,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
#if (sc_StereoRenderingMode>0)
{
sc_sysOut.varStereoViewID=sc_sysIn.gl_InstanceIndex%2;
}
#endif
float4 param=clipPosition;
sc_SetClipDistance(param,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
float4 param_1=float4(clipPosition.x,-clipPosition.y,(clipPosition.z*0.5)+(clipPosition.w*0.5),clipPosition.w);
sc_SetGlPosition(param_1,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
}
float4x3 sc_GetBoneMatrix(thread const int& index,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int j=3*index;
float4 m0=(*sc_set0.LibraryUniforms).sc_BoneMatrices[j+0];
float4 m1=(*sc_set0.LibraryUniforms).sc_BoneMatrices[j+1];
float4 m2=(*sc_set0.LibraryUniforms).sc_BoneMatrices[j+2];
return float4x3(float3(m0.x,m1.x,m2.x),float3(m0.y,m1.y,m2.y),float3(m0.z,m1.z,m2.z),float3(m0.w,m1.w,m2.w));
}
float3x3 sc_GetNormalMatrix(thread const int& index,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float3x3 normalMatrix;
#if ((!STD_DISABLE_VERTEX_NORMAL)||(!STD_DISABLE_VERTEX_TANGENT))
{
normalMatrix=(*sc_set0.LibraryUniforms).sc_SkinBonesNormalMatrices[index];
}
#endif
return normalMatrix;
}
float3 skinVertexPosition(thread const int& i,thread const float4& v,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float3 result;
#if (sc_SkinBonesCount>0)
{
int param=i;
result=sc_GetBoneMatrix(param,sc_sysIn,sc_sysOut,sc_set0,sc_set1)*v;
}
#else
{
result=v.xyz;
}
#endif
return result;
}
float4 sc_GetBoneWeights(thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 weights=float4(0.0);
#if (sc_SkinBonesCount>0)
{
weights=float4(1.0,fract(sc_sysIn.sc_sysAttributes.boneData.yzw));
weights.x-=dot(weights.yzw,float3(1.0));
}
#endif
return weights;
}
int sc_GetBoneIndex(thread const int& index,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int boneIndex=0;
#if (sc_SkinBonesCount>0)
{
boneIndex=int(sc_sysIn.sc_sysAttributes.boneData[index]);
}
#endif
return boneIndex;
}
void sc_SkinVertex(thread sc_Vertex_t& v,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
#if (sc_SkinBonesCount>0)
{
float4 weights=sc_GetBoneWeights(sc_sysIn,sc_sysOut,sc_set0,sc_set1);
int param=0;
int index0=sc_GetBoneIndex(param,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
int param_1=1;
int index1=sc_GetBoneIndex(param_1,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
int param_2=2;
int index2=sc_GetBoneIndex(param_2,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
int param_3=3;
int index3=sc_GetBoneIndex(param_3,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
int param_4=index0;
float4 param_5=v.position;
int param_6=index1;
float4 param_7=v.position;
int param_8=index2;
float4 param_9=v.position;
int param_10=index3;
float4 param_11=v.position;
float3 l9_0=(((skinVertexPosition(param_4,param_5,sc_sysIn,sc_sysOut,sc_set0,sc_set1)*weights.x)+(skinVertexPosition(param_6,param_7,sc_sysIn,sc_sysOut,sc_set0,sc_set1)*weights.y))+(skinVertexPosition(param_8,param_9,sc_sysIn,sc_sysOut,sc_set0,sc_set1)*weights.z))+(skinVertexPosition(param_10,param_11,sc_sysIn,sc_sysOut,sc_set0,sc_set1)*weights.w);
v.position=float4(l9_0.x,l9_0.y,l9_0.z,v.position.w);
int param_12=index0;
float3x3 normalMatrix0=sc_GetNormalMatrix(param_12,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
int param_13=index1;
float3x3 normalMatrix1=sc_GetNormalMatrix(param_13,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
int param_14=index2;
float3x3 normalMatrix2=sc_GetNormalMatrix(param_14,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
int param_15=index3;
float3x3 normalMatrix3=sc_GetNormalMatrix(param_15,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
#if (!STD_DISABLE_VERTEX_NORMAL)
{
v.normal=((((normalMatrix0*v.normal)*weights.x)+((normalMatrix1*v.normal)*weights.y))+((normalMatrix2*v.normal)*weights.z))+((normalMatrix3*v.normal)*weights.w);
}
#endif
#if (!STD_DISABLE_VERTEX_TANGENT)
{
v.tangent=((((normalMatrix0*v.tangent)*weights.x)+((normalMatrix1*v.tangent)*weights.y))+((normalMatrix2*v.tangent)*weights.z))+((normalMatrix3*v.tangent)*weights.w);
}
#endif
}
#endif
}
void blendTargetShape(thread sc_Vertex_t& v,thread const float3& position,thread const float& weight)
{
float3 l9_0=v.position.xyz+(position*weight);
v.position=float4(l9_0.x,l9_0.y,l9_0.z,v.position.w);
}
void blendTargetShapeWithNormal(thread sc_Vertex_t& v,thread const float3& position,thread const float3& normal,thread const float& weight)
{
sc_Vertex_t param=v;
float3 param_1=position;
float param_2=weight;
blendTargetShape(param,param_1,param_2);
v=param;
v.normal+=(normal*weight);
}
void sc_BlendVertex(thread sc_Vertex_t& v,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
#if (sc_VertexBlending)
{
#if (sc_VertexBlendingUseNormals)
{
sc_Vertex_t param=v;
float3 param_1=sc_sysIn.sc_sysAttributes.blendShape0Pos;
float3 param_2=sc_sysIn.sc_sysAttributes.blendShape0Normal;
float param_3=(*sc_set0.LibraryUniforms).weights0.x;
blendTargetShapeWithNormal(param,param_1,param_2,param_3);
v=param;
sc_Vertex_t param_4=v;
float3 param_5=sc_sysIn.sc_sysAttributes.blendShape1Pos;
float3 param_6=sc_sysIn.sc_sysAttributes.blendShape1Normal;
float param_7=(*sc_set0.LibraryUniforms).weights0.y;
blendTargetShapeWithNormal(param_4,param_5,param_6,param_7);
v=param_4;
sc_Vertex_t param_8=v;
float3 param_9=sc_sysIn.sc_sysAttributes.blendShape2Pos;
float3 param_10=sc_sysIn.sc_sysAttributes.blendShape2Normal;
float param_11=(*sc_set0.LibraryUniforms).weights0.z;
blendTargetShapeWithNormal(param_8,param_9,param_10,param_11);
v=param_8;
}
#else
{
sc_Vertex_t param_12=v;
float3 param_13=sc_sysIn.sc_sysAttributes.blendShape0Pos;
float param_14=(*sc_set0.LibraryUniforms).weights0.x;
blendTargetShape(param_12,param_13,param_14);
v=param_12;
sc_Vertex_t param_15=v;
float3 param_16=sc_sysIn.sc_sysAttributes.blendShape1Pos;
float param_17=(*sc_set0.LibraryUniforms).weights0.y;
blendTargetShape(param_15,param_16,param_17);
v=param_15;
sc_Vertex_t param_18=v;
float3 param_19=sc_sysIn.sc_sysAttributes.blendShape2Pos;
float param_20=(*sc_set0.LibraryUniforms).weights0.z;
blendTargetShape(param_18,param_19,param_20);
v=param_18;
sc_Vertex_t param_21=v;
float3 param_22=sc_sysIn.sc_sysAttributes.blendShape3Pos;
float param_23=(*sc_set0.LibraryUniforms).weights0.w;
blendTargetShape(param_21,param_22,param_23);
v=param_21;
sc_Vertex_t param_24=v;
float3 param_25=sc_sysIn.sc_sysAttributes.blendShape4Pos;
float param_26=(*sc_set0.LibraryUniforms).weights1.x;
blendTargetShape(param_24,param_25,param_26);
v=param_24;
sc_Vertex_t param_27=v;
float3 param_28=sc_sysIn.sc_sysAttributes.blendShape5Pos;
float param_29=(*sc_set0.LibraryUniforms).weights1.y;
blendTargetShape(param_27,param_28,param_29);
v=param_27;
}
#endif
}
#endif
}
float4 sc_ApplyScreenSpaceInstancedClippedShift(thread float4& screenPosition,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
#if (sc_StereoRenderingMode==1)
{
float viewIndex=float(sc_GetStereoViewIndex(sc_sysIn,sc_sysOut,sc_set0,sc_set1));
screenPosition.y=(screenPosition.y*0.5)+(0.5-viewIndex);
}
#endif
return screenPosition;
}
float4 sc_ObjectToScreen(thread float4& objectPosition,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 result;
#if (sc_RenderingSpace==3)
{
float4 param=objectPosition;
float4 l9_0=sc_ApplyScreenSpaceInstancedClippedShift(param,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
result=l9_0;
}
#else
{
#if (sc_RenderingSpace==2)
{
result=(*sc_set0.LibraryUniforms).sc_ViewProjectionMatrixArray[sc_GetStereoViewIndex(sc_sysIn,sc_sysOut,sc_set0,sc_set1)]*objectPosition;
}
#else
{
#if (sc_RenderingSpace==1)
{
result=(*sc_set0.LibraryUniforms).sc_ModelViewProjectionMatrixArray[sc_GetStereoViewIndex(sc_sysIn,sc_sysOut,sc_set0,sc_set1)]*objectPosition;
}
#else
{
#if (sc_RenderingSpace==4)
{
objectPosition=((*sc_set0.LibraryUniforms).sc_ModelViewMatrixArray[sc_GetStereoViewIndex(sc_sysIn,sc_sysOut,sc_set0,sc_set1)]*objectPosition)*float4(1.0/(*sc_set0.LibraryUniforms).sc_Camera.aspect,1.0,1.0,1.0);
float4 param_1=objectPosition;
float4 l9_1=sc_ApplyScreenSpaceInstancedClippedShift(param_1,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
result=l9_1;
}
#else
{
result=objectPosition;
}
#endif
}
#endif
}
#endif
}
#endif
return result;
}
float4 sc_ObjectToView(thread const float4& objectPosition,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 result;
#if (sc_RenderingSpace==3)
{
result=(*sc_set0.LibraryUniforms).sc_ProjectionMatrixInverseArray[sc_GetStereoViewIndex(sc_sysIn,sc_sysOut,sc_set0,sc_set1)]*objectPosition;
}
#else
{
#if (sc_RenderingSpace==2)
{
result=(*sc_set0.LibraryUniforms).sc_ViewMatrixArray[sc_GetStereoViewIndex(sc_sysIn,sc_sysOut,sc_set0,sc_set1)]*objectPosition;
}
#else
{
#if (sc_RenderingSpace==1)
{
result=(*sc_set0.LibraryUniforms).sc_ModelViewMatrixArray[sc_GetStereoViewIndex(sc_sysIn,sc_sysOut,sc_set0,sc_set1)]*objectPosition;
}
#else
{
result=objectPosition;
}
#endif
}
#endif
}
#endif
return result;
}
sc_Vertex_t sc_LoadVertexAttributes(thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
sc_Vertex_t v;
v.position=sc_sysIn.sc_sysAttributes.position;
#if (sc_IsEditor&&SC_DISABLE_FRUSTUM_CULLING)
{
v.position.x+=(*sc_set0.LibraryUniforms).sc_DisableFrustumCullingMarker;
}
#endif
#if (!STD_DISABLE_VERTEX_NORMAL)
{
v.normal=sc_sysIn.sc_sysAttributes.normal;
}
#endif
#if (!STD_DISABLE_VERTEX_TANGENT)
{
v.tangent=sc_sysIn.sc_sysAttributes.tangent.xyz;
}
#endif
#if (!STD_DISABLE_VERTEX_TEXTURE0)
{
v.texture0=sc_sysIn.sc_sysAttributes.texture0;
}
#endif
#if (!STD_DISABLE_VERTEX_TEXTURE1)
{
v.texture1=sc_sysIn.sc_sysAttributes.texture1;
}
#endif
return v;
}
float4 applyDepthAlgorithm(thread float4& screenPosition,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
#if (sc_DepthBufferMode==1)
{
float fCoefficient=2.0/log2((*sc_set0.LibraryUniforms).sc_Camera.clipPlanes.y+1.0);
screenPosition.z=((log2(fast::max((*sc_set0.LibraryUniforms).sc_Camera.clipPlanes.x,1.0+screenPosition.w))*fCoefficient)-1.0)*screenPosition.w;
}
#endif
return screenPosition;
}
void sc_ProcessVertex(thread sc_Vertex_t& v,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
sc_Vertex_t param=v;
sc_BlendVertex(param,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
v=param;
sc_Vertex_t param_1=v;
sc_SkinVertex(param_1,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
v=param_1;
float4 param_2=v.position;
float4 l9_0=sc_ObjectToScreen(param_2,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
float4 screenPosition=l9_0;
#if ((sc_RenderingSpace==3)||(sc_RenderingSpace==4))
{
sc_sysOut.varPos=screenPosition.xyz;
#if (!STD_DISABLE_VERTEX_NORMAL)
{
sc_sysOut.varNormal=normalize(v.normal);
}
#endif
#if (!STD_DISABLE_VERTEX_TANGENT)
{
float3 l9_1=normalize(v.tangent);
sc_sysOut.varTangent=float4(l9_1.x,l9_1.y,l9_1.z,sc_sysOut.varTangent.w);
}
#endif
}
#else
{
#if (sc_RenderingSpace==2)
{
sc_sysOut.varPos=v.position.xyz;
#if (!STD_DISABLE_VERTEX_NORMAL)
{
sc_sysOut.varNormal=normalize(v.normal);
}
#endif
#if (!STD_DISABLE_VERTEX_TANGENT)
{
float3 l9_2=normalize(v.tangent);
sc_sysOut.varTangent=float4(l9_2.x,l9_2.y,l9_2.z,sc_sysOut.varTangent.w);
}
#endif
}
#else
{
#if (sc_RenderingSpace==1)
{
sc_sysOut.varPos=((*sc_set0.LibraryUniforms).sc_ModelMatrix*v.position).xyz;
#if (!STD_DISABLE_VERTEX_NORMAL)
{
sc_sysOut.varNormal=normalize((*sc_set0.LibraryUniforms).sc_NormalMatrix*v.normal);
}
#endif
#if (!STD_DISABLE_VERTEX_TANGENT)
{
float3 l9_3=normalize((*sc_set0.LibraryUniforms).sc_NormalMatrix*v.tangent);
sc_sysOut.varTangent=float4(l9_3.x,l9_3.y,l9_3.z,sc_sysOut.varTangent.w);
}
#endif
}
#endif
}
#endif
}
#endif
#if (!STD_DISABLE_VERTEX_TANGENT)
{
sc_sysOut.varTangent.w=sc_sysIn.sc_sysAttributes.tangent.w;
}
#endif
#if (!STD_DISABLE_VERTEX_TEXTURE0)
{
sc_sysOut.varPackedTex=float4(v.texture0.x,v.texture0.y,sc_sysOut.varPackedTex.z,sc_sysOut.varPackedTex.w);
}
#endif
#if (!STD_DISABLE_VERTEX_TEXTURE1)
{
sc_sysOut.varPackedTex=float4(sc_sysOut.varPackedTex.x,sc_sysOut.varPackedTex.y,v.texture1.x,v.texture1.y);
}
#endif
sc_sysOut.varScreenPos=screenPosition;
float2 globalScreenCoords=((screenPosition.xy/float2(screenPosition.w))*0.5)+float2(0.5);
float2 param_3=globalScreenCoords;
sc_sysOut.varScreenTexturePos=sc_ScreenCoordsGlobalToView(param_3,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
#if (sc_ProjectiveShadowsReceiver)
{
float4 param_4=v.position;
sc_sysOut.varShadowTex=getProjectedTexCoords(param_4,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
}
#endif
#if ((sc_OITDepthGatherPass||sc_OITCompositingPass)||sc_OITDepthBoundsPass)
{
float4 param_5=v.position;
sc_sysOut.varViewSpaceDepth=-sc_ObjectToView(param_5,sc_sysIn,sc_sysOut,sc_set0,sc_set1).z;
}
#endif
float4 param_6=screenPosition;
float4 l9_4=applyDepthAlgorithm(param_6,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
screenPosition=l9_4;
#if (sc_TAAEnabled)
{
float2 l9_5=screenPosition.xy+((*sc_set0.LibraryUniforms).sc_TAAJitterOffset*screenPosition.w);
screenPosition=float4(l9_5.x,l9_5.y,screenPosition.z,screenPosition.w);
}
#endif
float4 clipPosition=screenPosition*1.0;
float4 param_7=clipPosition;
sc_SetClipPosition(param_7,sc_sysIn,sc_sysOut,sc_set0,sc_set1);
}
} // VERTEX SHADER


namespace SNAP_FS {
} // FRAGMENT SHADER

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "std2.metal"
#include "std2_fs.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler baseTexSmpSC 2:2
//sampler sampler prevTexSmpSC 2:3
//texture texture2D baseTex 2:0:2:2
//texture texture2D prevTex 2:1:2:3
//ubo float UserUniforms 2:4:432 {
//float4x4 script_modelMatrix 0
//float4x4 script_viewProjectionMatrix 64
//float3 uniSphereCenter 128
//float3 uniCameraPos 144
//float4 baseTexSize 160
//float4 baseTexDims 176
//float4 baseTexView 192
//float3x3 baseTexTransform 208
//float4 baseTexUvMinMax 256
//float4 baseTexBorderColor 272
//float4 prevTexSize 288
//float4 prevTexDims 304
//float4 prevTexView 320
//float3x3 prevTexTransform 336
//float4 prevTexUvMinMax 384
//float4 prevTexBorderColor 400
//float stopCapture 416
//float blendInFactor 420
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4x4 script_modelMatrix;
float4x4 script_viewProjectionMatrix;
float3 uniSphereCenter;
float3 uniCameraPos;
float4 baseTexSize;
float4 baseTexDims;
float4 baseTexView;
float3x3 baseTexTransform;
float4 baseTexUvMinMax;
float4 baseTexBorderColor;
float4 prevTexSize;
float4 prevTexDims;
float4 prevTexView;
float3x3 prevTexTransform;
float4 prevTexUvMinMax;
float4 prevTexBorderColor;
float stopCapture;
float blendInFactor;
};
#ifndef baseTexHasSwappedViews
#define baseTexHasSwappedViews 0
#elif baseTexHasSwappedViews==1
#undef baseTexHasSwappedViews
#define baseTexHasSwappedViews 1
#endif
#ifndef baseTexLayout
#define baseTexLayout 0
#endif
#ifndef prevTexHasSwappedViews
#define prevTexHasSwappedViews 0
#elif prevTexHasSwappedViews==1
#undef prevTexHasSwappedViews
#define prevTexHasSwappedViews 1
#endif
#ifndef prevTexLayout
#define prevTexLayout 0
#endif
#ifndef baseTexUV
#define baseTexUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 0
#elif SC_USE_UV_TRANSFORM_baseTex==1
#undef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_baseTex
#define SC_SOFTWARE_WRAP_MODE_U_baseTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_baseTex
#define SC_SOFTWARE_WRAP_MODE_V_baseTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 0
#elif SC_USE_UV_MIN_MAX_baseTex==1
#undef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 0
#elif SC_USE_CLAMP_TO_BORDER_baseTex==1
#undef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 1
#endif
#ifndef prevTexUV
#define prevTexUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_prevTex
#define SC_USE_UV_TRANSFORM_prevTex 0
#elif SC_USE_UV_TRANSFORM_prevTex==1
#undef SC_USE_UV_TRANSFORM_prevTex
#define SC_USE_UV_TRANSFORM_prevTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_prevTex
#define SC_SOFTWARE_WRAP_MODE_U_prevTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_prevTex
#define SC_SOFTWARE_WRAP_MODE_V_prevTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_prevTex
#define SC_USE_UV_MIN_MAX_prevTex 0
#elif SC_USE_UV_MIN_MAX_prevTex==1
#undef SC_USE_UV_MIN_MAX_prevTex
#define SC_USE_UV_MIN_MAX_prevTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_prevTex
#define SC_USE_CLAMP_TO_BORDER_prevTex 0
#elif SC_USE_CLAMP_TO_BORDER_prevTex==1
#undef SC_USE_CLAMP_TO_BORDER_prevTex
#define SC_USE_CLAMP_TO_BORDER_prevTex 1
#endif
struct sc_Set2
{
texture2d<float> baseTex [[id(0)]];
texture2d<float> prevTex [[id(1)]];
sampler baseTexSmpSC [[id(2)]];
sampler prevTexSmpSC [[id(3)]];
constant userUniformsObj* UserUniforms [[id(4)]];
};
struct sc_VertOut
{
sc_SysOut sc_sysOut;
float3 varCustomPos [[user(locn10)]];
float3 varCustomNormal [[user(locn11)]];
float2 varCustomTex0 [[user(locn12)]];
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
float4x4 rotationMatrix=float4x4(float4(1.0,0.0,0.0,0.0),float4(0.0,1.0,0.0,0.0),float4(0.0,0.0,1.0,0.0),float4(0.0,0.0,0.0,1.0));
rotationMatrix[0]=float4(0.0,0.0,1.0,0.0);
rotationMatrix[1]=float4(0.0,-1.0,0.0,0.0);
rotationMatrix[2]=float4(-1.0,0.0,0.0,0.0);
float4 newPosition=rotationMatrix*v.position;
float4x4 scaleMatrix=float4x4(float4(12.0,0.0,0.0,0.0),float4(0.0,12.0,0.0,0.0),float4(0.0,0.0,12.0,0.0),float4(0.0,0.0,0.0,12.0));
scaleMatrix[3].w=1.0;
newPosition=scaleMatrix*newPosition;
sc_vertOut.varCustomPos=((*sc_set2.UserUniforms).script_modelMatrix*newPosition).xyz;
float3 normal=normalize(sc_sysIn.sc_sysAttributes.position.xyz);
sc_vertOut.varCustomNormal=normalize((((*sc_set2.UserUniforms).script_modelMatrix*rotationMatrix)*float4(normal,0.0)).xyz);
float2 modifiedTexCoords=v.texture0*1.002;
sc_vertOut.varCustomTex0=float2(((*sc_set2.UserUniforms).prevTexTransform*float3(modifiedTexCoords,1.0)).xy);
v.position=float4((modifiedTexCoords*2.0)-float2(1.0),0.0,1.0);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct twoPoints
{
float3 p1;
float3 p2;
};
struct userUniformsObj
{
float4x4 script_modelMatrix;
float4x4 script_viewProjectionMatrix;
float3 uniSphereCenter;
float3 uniCameraPos;
float4 baseTexSize;
float4 baseTexDims;
float4 baseTexView;
float3x3 baseTexTransform;
float4 baseTexUvMinMax;
float4 baseTexBorderColor;
float4 prevTexSize;
float4 prevTexDims;
float4 prevTexView;
float3x3 prevTexTransform;
float4 prevTexUvMinMax;
float4 prevTexBorderColor;
float stopCapture;
float blendInFactor;
};
#ifndef baseTexHasSwappedViews
#define baseTexHasSwappedViews 0
#elif baseTexHasSwappedViews==1
#undef baseTexHasSwappedViews
#define baseTexHasSwappedViews 1
#endif
#ifndef baseTexLayout
#define baseTexLayout 0
#endif
#ifndef prevTexHasSwappedViews
#define prevTexHasSwappedViews 0
#elif prevTexHasSwappedViews==1
#undef prevTexHasSwappedViews
#define prevTexHasSwappedViews 1
#endif
#ifndef prevTexLayout
#define prevTexLayout 0
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_baseTex
#define SC_SOFTWARE_WRAP_MODE_U_baseTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_baseTex
#define SC_SOFTWARE_WRAP_MODE_V_baseTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 0
#elif SC_USE_UV_MIN_MAX_baseTex==1
#undef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 0
#elif SC_USE_CLAMP_TO_BORDER_baseTex==1
#undef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 1
#endif
#ifndef SC_USE_UV_TRANSFORM_prevTex
#define SC_USE_UV_TRANSFORM_prevTex 0
#elif SC_USE_UV_TRANSFORM_prevTex==1
#undef SC_USE_UV_TRANSFORM_prevTex
#define SC_USE_UV_TRANSFORM_prevTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_prevTex
#define SC_SOFTWARE_WRAP_MODE_U_prevTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_prevTex
#define SC_SOFTWARE_WRAP_MODE_V_prevTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_prevTex
#define SC_USE_UV_MIN_MAX_prevTex 0
#elif SC_USE_UV_MIN_MAX_prevTex==1
#undef SC_USE_UV_MIN_MAX_prevTex
#define SC_USE_UV_MIN_MAX_prevTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_prevTex
#define SC_USE_CLAMP_TO_BORDER_prevTex 0
#elif SC_USE_CLAMP_TO_BORDER_prevTex==1
#undef SC_USE_CLAMP_TO_BORDER_prevTex
#define SC_USE_CLAMP_TO_BORDER_prevTex 1
#endif
#ifndef baseTexUV
#define baseTexUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 0
#elif SC_USE_UV_TRANSFORM_baseTex==1
#undef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 1
#endif
#ifndef prevTexUV
#define prevTexUV 0
#endif
struct sc_Set2
{
texture2d<float> baseTex [[id(0)]];
texture2d<float> prevTex [[id(1)]];
sampler baseTexSmpSC [[id(2)]];
sampler prevTexSmpSC [[id(3)]];
constant userUniformsObj* UserUniforms [[id(4)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
float3 varCustomPos [[user(locn10)]];
float3 varCustomNormal [[user(locn11)]];
float2 varCustomTex0 [[user(locn12)]];
};
float ensureIsNotZero(thread const float& num)
{
float add0=1.0-fast::max(abs(sign(num)),0.99900001);
return num+add0;
}
void getLineSphereIntersection(thread const float3& p1,thread const float3& p2,thread const float3& shpereCenter,thread const float& sphereRadius,thread twoPoints& intersections)
{
float3 d=p2-p1;
float a=dot(d,d);
float b=2.0*dot(d,p1-shpereCenter);
float c=((dot(shpereCenter,shpereCenter)+dot(p1,p1))-(2.0*dot(shpereCenter,p1)))-(sphereRadius*sphereRadius);
float disc=(b*b)-((4.0*a)*c);
float sqrtdisc=sqrt(disc);
float param=2.0*a;
float divisor=ensureIsNotZero(param);
float u=((-b)-sqrtdisc)/divisor;
intersections.p1=p1+((p2-p1)*u);
u=((-b)+sqrtdisc)/divisor;
intersections.p2=p1+((p2-p1)*u);
}
float2 baseTexGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.baseTexDims.xy;
}
int baseTexGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (baseTexHasSwappedViews)
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
float2 calculateEnvmapScreenToCube(thread float3& V)
{
V.y=-V.y;
V.z=abs(V.z);
float3 vAbs=abs(V);
float l9_0=vAbs.z;
float l9_1=vAbs.x;
bool l9_2=l9_0>=l9_1;
bool l9_3;
if (l9_2)
{
l9_3=vAbs.z>=vAbs.y;
}
else
{
l9_3=l9_2;
}
float2 uv;
if (l9_3)
{
float ma=0.5/vAbs.z;
uv=float2(V.x,V.y)*ma;
uv=(uv*0.5)+float2(0.5);
}
else
{
if (vAbs.y>=vAbs.x)
{
float ma_1=0.5/vAbs.y;
uv=float2(V.x,-V.z)*ma_1;
uv.x*=mix(0.5,1.0,1.0-(abs(uv.y)*2.0));
uv.x+=0.5;
uv.y*=0.5;
uv.y=abs(uv.y);
if (V.y>0.0)
{
uv.y=1.0-uv.y;
}
}
else
{
float ma_2=0.5/vAbs.x;
float l9_4;
if (V.x<0.0)
{
l9_4=V.z;
}
else
{
l9_4=-V.z;
}
uv=float2(l9_4,V.y)*ma_2;
uv.y*=mix(0.5,1.0,1.0-(abs(uv.x)*2.0));
uv.y+=0.5;
uv.x*=0.5;
uv.x=abs(uv.x);
if (V.x>0.0)
{
uv.x=1.0-uv.x;
}
}
}
return uv;
}
float2 prevTexGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.prevTexDims.xy;
}
int prevTexGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (prevTexHasSwappedViews)
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
float3 captureDirection=sc_fragIn.varCustomNormal;
float groundPointY=0.0;
float param=captureDirection.y;
float nCoeffToReachGround=(sc_fragIn.varCustomPos.y-groundPointY)/ensureIsNotZero(param);
float3 nGroundIntersection=sc_fragIn.varCustomPos+((captureDirection*nCoeffToReachGround)*(-1.0));
float groundIntersectionFlag1=step(nCoeffToReachGround,0.0);
nGroundIntersection=mix(float3(0.0,0.0,10000.0),nGroundIntersection,float3(groundIntersectionFlag1));
float sphereRadius=fast::max(length((*sc_set2.UserUniforms).uniCameraPos-(*sc_set2.UserUniforms).uniSphereCenter),100.0);
float3 param_1=sc_fragIn.varCustomPos;
float3 param_2=sc_fragIn.varCustomPos+captureDirection;
float3 param_3=(*sc_set2.UserUniforms).uniSphereCenter;
float param_4=sphereRadius;
twoPoints sphereIntersections;
twoPoints param_5=sphereIntersections;
getLineSphereIntersection(param_1,param_2,param_3,param_4,param_5);
sphereIntersections=param_5;
float3 stepIntersection=step(float3(0.0),(sphereIntersections.p1-sc_fragIn.varCustomPos)/captureDirection);
float mixIntersections=fast::min(stepIntersection.x,stepIntersection.y);
mixIntersections=fast::min(mixIntersections,stepIntersection.z);
float3 sphereIntersectionPoint=mix(sphereIntersections.p2,sphereIntersections.p1,float3(mixIntersections));
float maxNCoeffToReachGround=(-1.0)*sphereRadius;
float groundIntersectionFlag2=step(maxNCoeffToReachGround,nCoeffToReachGround);
float groundIntersectionCommonFlag=groundIntersectionFlag1*groundIntersectionFlag2;
float3 virtualSetupIntersectionPoint=mix(sphereIntersectionPoint,nGroundIntersection,float3(groundIntersectionCommonFlag));
float4 screenPosition=(*sc_set2.UserUniforms).script_viewProjectionMatrix*float4(virtualSetupIntersectionPoint,1.0);
float isInsideNDC=step(abs(screenPosition.z/screenPosition.w),1.0);
float param_6=screenPosition.w;
float2 texCoord=((screenPosition.xy/float2(ensureIsNotZero(param_6)))*0.5)+float2(0.5);
texCoord=float2(((*sc_set2.UserUniforms).baseTexTransform*float3(texCoord,1.0)).xy);
float4 finColor=float4(0.0);
float2 param_7=baseTexGetDims2D((*sc_set2.UserUniforms));
int param_8=baseTexLayout;
int param_9=baseTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_10=texCoord;
bool param_11=false;
float3x3 param_12=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_13=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex);
bool param_14=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
float4 param_15=(*sc_set2.UserUniforms).baseTexUvMinMax;
bool param_16=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
float4 param_17=(*sc_set2.UserUniforms).baseTexBorderColor;
float param_18=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.baseTex,sc_set2.baseTexSmpSC,param_7,param_8,param_9,param_10,param_11,param_12,param_13,param_14,param_15,param_16,param_17,param_18);
float4 l9_1=l9_0;
float4 baseTexSample=l9_0;
finColor=baseTexSample;
texCoord=abs(fast::clamp(texCoord,float2(0.0),float2(1.0))-float2(0.5));
float alphaVal0=fast::max(texCoord.x,texCoord.y)*2.0;
alphaVal0=1.0-(alphaVal0*alphaVal0);
alphaVal0*=(*sc_set2.UserUniforms).blendInFactor;
finColor.w=alphaVal0*isInsideNDC;
float4 cameraCubeColor=float4(0.0);
float3 param_19=-sc_fragIn.varCustomNormal;
float2 l9_2=calculateEnvmapScreenToCube(param_19);
float2 cubeCoord=l9_2;
cubeCoord=float2(((*sc_set2.UserUniforms).baseTexTransform*float3(cubeCoord,1.0)).xy);
cubeCoord=fast::clamp(cubeCoord,float2(0.0020000001),float2(0.99800003));
float2 param_20=baseTexGetDims2D((*sc_set2.UserUniforms));
int param_21=baseTexLayout;
int param_22=baseTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_23=cubeCoord;
bool param_24=false;
float3x3 param_25=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_26=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex);
bool param_27=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
float4 param_28=(*sc_set2.UserUniforms).baseTexUvMinMax;
bool param_29=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
float4 param_30=(*sc_set2.UserUniforms).baseTexBorderColor;
float param_31=0.0;
float4 l9_3=sc_SampleTextureBiasOrLevel(sc_set2.baseTex,sc_set2.baseTexSmpSC,param_20,param_21,param_22,param_23,param_24,param_25,param_26,param_27,param_28,param_29,param_30,param_31);
float4 l9_4=l9_3;
float4 baseTexSample_1=l9_3;
cameraCubeColor=baseTexSample_1;
cameraCubeColor.w=1.0;
finColor=mix(cameraCubeColor,finColor,float4((*sc_set2.UserUniforms).stopCapture));
alphaVal0=finColor.w;
float4 prevColor=float4(0.0);
float2 param_32=prevTexGetDims2D((*sc_set2.UserUniforms));
int param_33=prevTexLayout;
int param_34=prevTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_35=sc_fragIn.varCustomTex0;
bool param_36=(int(SC_USE_UV_TRANSFORM_prevTex)!=0);
float3x3 param_37=(*sc_set2.UserUniforms).prevTexTransform;
int2 param_38=int2(SC_SOFTWARE_WRAP_MODE_U_prevTex,SC_SOFTWARE_WRAP_MODE_V_prevTex);
bool param_39=(int(SC_USE_UV_MIN_MAX_prevTex)!=0);
float4 param_40=(*sc_set2.UserUniforms).prevTexUvMinMax;
bool param_41=(int(SC_USE_CLAMP_TO_BORDER_prevTex)!=0);
float4 param_42=(*sc_set2.UserUniforms).prevTexBorderColor;
float param_43=0.0;
float4 l9_5=sc_SampleTextureBiasOrLevel(sc_set2.prevTex,sc_set2.prevTexSmpSC,param_32,param_33,param_34,param_35,param_36,param_37,param_38,param_39,param_40,param_41,param_42,param_43);
float4 l9_6=l9_5;
float4 prevTexSample=l9_5;
prevColor=prevTexSample;
finColor=mix(prevColor,finColor,float4(alphaVal0));
float4 param_44=finColor;
sc_writeFragData0(param_44,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_TANGENT 1
#include "required2.metal"
#include "std2_fs.metal"
#include "std2_texture.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler baseTexSmpSC 2:2
//sampler sampler borderTexSmpSC 2:3
//texture texture2D baseTex 2:0:2:2
//texture texture2D borderTex 2:1:2:3
//ubo float UserUniforms 2:4:416 {
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
//float4 borderTexSize 288
//float4 borderTexDims 304
//float4 borderTexView 320
//float3x3 borderTexTransform 336
//float4 borderTexUvMinMax 384
//float4 borderTexBorderColor 400
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
float4 borderTexSize;
float4 borderTexDims;
float4 borderTexView;
float3x3 borderTexTransform;
float4 borderTexUvMinMax;
float4 borderTexBorderColor;
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
#ifndef borderTexHasSwappedViews
#define borderTexHasSwappedViews 0
#elif borderTexHasSwappedViews==1
#undef borderTexHasSwappedViews
#define borderTexHasSwappedViews 1
#endif
#ifndef borderTexLayout
#define borderTexLayout 0
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
#ifndef borderTexUV
#define borderTexUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_borderTex
#define SC_USE_UV_TRANSFORM_borderTex 0
#elif SC_USE_UV_TRANSFORM_borderTex==1
#undef SC_USE_UV_TRANSFORM_borderTex
#define SC_USE_UV_TRANSFORM_borderTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_borderTex
#define SC_SOFTWARE_WRAP_MODE_U_borderTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_borderTex
#define SC_SOFTWARE_WRAP_MODE_V_borderTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_borderTex
#define SC_USE_UV_MIN_MAX_borderTex 0
#elif SC_USE_UV_MIN_MAX_borderTex==1
#undef SC_USE_UV_MIN_MAX_borderTex
#define SC_USE_UV_MIN_MAX_borderTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_borderTex
#define SC_USE_CLAMP_TO_BORDER_borderTex 0
#elif SC_USE_CLAMP_TO_BORDER_borderTex==1
#undef SC_USE_CLAMP_TO_BORDER_borderTex
#define SC_USE_CLAMP_TO_BORDER_borderTex 1
#endif
struct sc_Set2
{
texture2d<float> baseTex [[id(0)]];
texture2d<float> borderTex [[id(1)]];
sampler baseTexSmpSC [[id(2)]];
sampler borderTexSmpSC [[id(3)]];
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
v.position=float4(((sc_sysIn.sc_sysAttributes.texture0*1.002)*2.0)-float2(1.0),0.0,1.0);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
float4x4 rotationMatrix=float4x4(float4(1.0,0.0,0.0,0.0),float4(0.0,1.0,0.0,0.0),float4(0.0,0.0,1.0,0.0),float4(0.0,0.0,0.0,1.0));
rotationMatrix[0]=float4(0.0,0.0,1.0,0.0);
rotationMatrix[2]=float4(-1.0,0.0,0.0,0.0);
float4 newPosition=rotationMatrix*sc_sysIn.sc_sysAttributes.position;
float4x4 scaleMatrix=float4x4(float4(12.0,0.0,0.0,0.0),float4(0.0,12.0,0.0,0.0),float4(0.0,0.0,12.0,0.0),float4(0.0,0.0,0.0,12.0));
scaleMatrix[3].w=1.0;
newPosition=scaleMatrix*newPosition;
sc_vertOut.sc_sysOut.varPos=((*sc_set2.UserUniforms).script_modelMatrix*newPosition).xyz;
float3 normal=normalize(sc_sysIn.sc_sysAttributes.position.xyz);
sc_vertOut.sc_sysOut.varNormal=normalize((((*sc_set2.UserUniforms).script_modelMatrix*rotationMatrix)*float4(normal,0.0)).xyz);
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
float4 borderTexSize;
float4 borderTexDims;
float4 borderTexView;
float3x3 borderTexTransform;
float4 borderTexUvMinMax;
float4 borderTexBorderColor;
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
#ifndef borderTexHasSwappedViews
#define borderTexHasSwappedViews 0
#elif borderTexHasSwappedViews==1
#undef borderTexHasSwappedViews
#define borderTexHasSwappedViews 1
#endif
#ifndef borderTexLayout
#define borderTexLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_borderTex
#define SC_USE_UV_TRANSFORM_borderTex 0
#elif SC_USE_UV_TRANSFORM_borderTex==1
#undef SC_USE_UV_TRANSFORM_borderTex
#define SC_USE_UV_TRANSFORM_borderTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_borderTex
#define SC_SOFTWARE_WRAP_MODE_U_borderTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_borderTex
#define SC_SOFTWARE_WRAP_MODE_V_borderTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_borderTex
#define SC_USE_UV_MIN_MAX_borderTex 0
#elif SC_USE_UV_MIN_MAX_borderTex==1
#undef SC_USE_UV_MIN_MAX_borderTex
#define SC_USE_UV_MIN_MAX_borderTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_borderTex
#define SC_USE_CLAMP_TO_BORDER_borderTex 0
#elif SC_USE_CLAMP_TO_BORDER_borderTex==1
#undef SC_USE_CLAMP_TO_BORDER_borderTex
#define SC_USE_CLAMP_TO_BORDER_borderTex 1
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
#ifndef baseTexUV
#define baseTexUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 0
#elif SC_USE_UV_TRANSFORM_baseTex==1
#undef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 1
#endif
#ifndef borderTexUV
#define borderTexUV 0
#endif
struct sc_Set2
{
texture2d<float> baseTex [[id(0)]];
texture2d<float> borderTex [[id(1)]];
sampler baseTexSmpSC [[id(2)]];
sampler borderTexSmpSC [[id(3)]];
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
void easyLineSphereIntersection(thread const float3& lineDir,thread const float3& sphereCenter,thread const float& sphereRadius,thread twoPoints& intersections)
{
float3 nLineDir=normalize(lineDir);
nLineDir*=sphereRadius;
intersections.p1=sphereCenter+nLineDir;
intersections.p2=sphereCenter-nLineDir;
}
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
intersections.p1=float3(10000.0,10000.0,0.0);
intersections.p2=float3(10000.0,10000.0,0.0);
if (disc>=0.0)
{
float sqrtdisc=sqrt(disc);
float param=2.0*a;
float divisor=ensureIsNotZero(param);
float u=((-b)-sqrtdisc)/divisor;
intersections.p1=p1+((p2-p1)*u);
u=((-b)+sqrtdisc)/divisor;
intersections.p2=p1+((p2-p1)*u);
}
}
float2 borderTexGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.borderTexDims.xy;
}
int borderTexGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (borderTexHasSwappedViews)
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
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
float3 captureDirection=sc_fragIn.sc_sysIn.varNormal;
float smallSphereRadius=100.0;
float sphereRadius=fast::max(length((*sc_set2.UserUniforms).uniCameraPos-(*sc_set2.UserUniforms).uniSphereCenter),smallSphereRadius);
float3 param=captureDirection;
float3 param_1=(*sc_set2.UserUniforms).uniSphereCenter;
float param_2=sphereRadius;
twoPoints bigSphereIntersections;
twoPoints param_3=bigSphereIntersections;
easyLineSphereIntersection(param,param_1,param_2,param_3);
bigSphereIntersections=param_3;
float3 bigSphereIntersectionPoint=bigSphereIntersections.p1;
float3 virtualSetupIntersectionPoint=bigSphereIntersectionPoint;
float4 screenPosition=(*sc_set2.UserUniforms).script_viewProjectionMatrix*float4(virtualSetupIntersectionPoint,1.0);
float param_4=screenPosition.w;
screenPosition=(screenPosition/float4(ensureIsNotZero(param_4)))*sign(screenPosition.w);
float3 test=float3(abs(screenPosition.x),abs(screenPosition.y),abs(screenPosition.z));
float isInsideNDC=(step(test.x,1.0)*step(test.y,1.0))*step(test.z,1.0);
float2 texCoord=(screenPosition.xy*0.5)+float2(0.5);
float3 centerCameraPixelNormal=normalize((float3(0.0,0.0,-1.0)*sphereRadius)-(*sc_set2.UserUniforms).uniSphereCenter);
float3 param_5=(*sc_set2.UserUniforms).uniCameraPos;
float3 param_6=(*sc_set2.UserUniforms).uniCameraPos+float3(0.0,0.0,-1.0);
float3 param_7=(*sc_set2.UserUniforms).uniSphereCenter;
float param_8=sphereRadius;
twoPoints cameraForwardBigSphereInt;
twoPoints param_9=cameraForwardBigSphereInt;
getLineSphereIntersection(param_5,param_6,param_7,param_8,param_9);
cameraForwardBigSphereInt=param_9;
float chooseP1=step(cameraForwardBigSphereInt.p1.z,(*sc_set2.UserUniforms).uniSphereCenter.z);
float3 forwardBigSphereInt=mix(cameraForwardBigSphereInt.p2,cameraForwardBigSphereInt.p1,float3(chooseP1));
float2 borderTexCoord=float2(((*sc_set2.UserUniforms).borderTexTransform*float3(texCoord,1.0)).xy);
float2 fromCenter=borderTexCoord-float2(0.5);
fromCenter/=float2(fast::max(abs(fromCenter.x),abs(fromCenter.y))*2.0);
borderTexCoord=fromCenter+float2(0.5);
texCoord=fast::clamp(texCoord,float2(0.0020000001),float2(0.99800003));
float2 baseTexCoord=float2(((*sc_set2.UserUniforms).baseTexTransform*float3(texCoord,1.0)).xy);
float angleOfInterest=acos(dot(normalize(forwardBigSphereInt-(*sc_set2.UserUniforms).uniSphereCenter),normalize(virtualSetupIntersectionPoint-(*sc_set2.UserUniforms).uniSphereCenter)));
float MIPf=fast::min(log2(fast::max((angleOfInterest-0.78539002)/0.049090002,1.0)),8.0);
float2 param_10=borderTexGetDims2D((*sc_set2.UserUniforms));
int param_11=borderTexLayout;
int param_12=borderTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_13=borderTexCoord;
bool param_14=(int(SC_USE_UV_TRANSFORM_borderTex)!=0);
float3x3 param_15=(*sc_set2.UserUniforms).borderTexTransform;
int2 param_16=int2(SC_SOFTWARE_WRAP_MODE_U_borderTex,SC_SOFTWARE_WRAP_MODE_V_borderTex);
bool param_17=(int(SC_USE_UV_MIN_MAX_borderTex)!=0);
float4 param_18=(*sc_set2.UserUniforms).borderTexUvMinMax;
bool param_19=(int(SC_USE_CLAMP_TO_BORDER_borderTex)!=0);
float4 param_20=(*sc_set2.UserUniforms).borderTexBorderColor;
float param_21=MIPf;
float4 l9_0=sc_SampleTextureLevel(sc_set2.borderTex,sc_set2.borderTexSmpSC,param_10,param_11,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21);
float4 l9_1=l9_0;
float4 borderSample=l9_0;
float complimentaryAngle=fast::max(angleOfInterest-1.5707901,0.0);
float complimentaryMixAmount=0.5*smoothstep(0.0,1.5707901,complimentaryAngle);
float complimentaryMIPf=fast::min(log2(fast::max((2.3561699+(1.5707901-complimentaryAngle))/0.049090002,1.0)),8.0);
float2 complimentaryTexCoord=(-fromCenter)+float2(0.5);
float2 param_22=borderTexGetDims2D((*sc_set2.UserUniforms));
int param_23=borderTexLayout;
int param_24=borderTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_25=complimentaryTexCoord;
bool param_26=(int(SC_USE_UV_TRANSFORM_borderTex)!=0);
float3x3 param_27=(*sc_set2.UserUniforms).borderTexTransform;
int2 param_28=int2(SC_SOFTWARE_WRAP_MODE_U_borderTex,SC_SOFTWARE_WRAP_MODE_V_borderTex);
bool param_29=(int(SC_USE_UV_MIN_MAX_borderTex)!=0);
float4 param_30=(*sc_set2.UserUniforms).borderTexUvMinMax;
bool param_31=(int(SC_USE_CLAMP_TO_BORDER_borderTex)!=0);
float4 param_32=(*sc_set2.UserUniforms).borderTexBorderColor;
float param_33=complimentaryMIPf;
float4 l9_2=sc_SampleTextureLevel(sc_set2.borderTex,sc_set2.borderTexSmpSC,param_22,param_23,param_24,param_25,param_26,param_27,param_28,param_29,param_30,param_31,param_32,param_33);
float4 l9_3=l9_2;
float4 complimentarySample=l9_2;
complimentaryMixAmount*=2.0;
complimentaryMixAmount=sqrt(complimentaryMixAmount);
complimentaryMixAmount*=0.5;
borderSample=mix(borderSample,complimentarySample,float4(complimentaryMixAmount));
float2 param_34=baseTexGetDims2D((*sc_set2.UserUniforms));
int param_35=baseTexLayout;
int param_36=baseTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_37=baseTexCoord;
bool param_38=false;
float3x3 param_39=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_40=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex);
bool param_41=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
float4 param_42=(*sc_set2.UserUniforms).baseTexUvMinMax;
bool param_43=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
float4 param_44=(*sc_set2.UserUniforms).baseTexBorderColor;
float param_45=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(sc_set2.baseTex,sc_set2.baseTexSmpSC,param_34,param_35,param_36,param_37,param_38,param_39,param_40,param_41,param_42,param_43,param_44,param_45);
float4 l9_5=l9_4;
float4 baseTexSample=l9_4;
float4 finColor=mix(borderSample,baseTexSample,float4(isInsideNDC));
float4 param_46=finColor;
sc_writeFragData0(param_46,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

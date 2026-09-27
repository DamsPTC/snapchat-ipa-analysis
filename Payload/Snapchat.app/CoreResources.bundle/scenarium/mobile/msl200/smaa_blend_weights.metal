#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "std2.metal"
#include "std2_fs.metal"
#include "std2_texture.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler areaTexSmpSC 2:4
//sampler sampler edgesTexSmpSC 2:5
//sampler sampler inputTextureSmpSC 2:6
//sampler sampler searchTexSmpSC 2:7
//texture texture2D areaTex 2:0:2:4
//texture texture2D edgesTex 2:1:2:5
//texture texture2D inputTexture 2:2:2:6
//texture texture2D searchTex 2:3:2:7
//ubo float UserUniforms 2:8:512 {
//float4 inputTextureSize 0
//float4 inputTextureDims 16
//float4 inputTextureView 32
//float3x3 inputTextureTransform 48
//float4 inputTextureUvMinMax 96
//float4 inputTextureBorderColor 112
//float4 edgesTexSize 128
//float4 edgesTexDims 144
//float4 edgesTexView 160
//float3x3 edgesTexTransform 176
//float4 edgesTexUvMinMax 224
//float4 edgesTexBorderColor 240
//float4 areaTexSize 256
//float4 areaTexDims 272
//float4 areaTexView 288
//float3x3 areaTexTransform 304
//float4 areaTexUvMinMax 352
//float4 areaTexBorderColor 368
//float4 searchTexSize 384
//float4 searchTexDims 400
//float4 searchTexView 416
//float3x3 searchTexTransform 432
//float4 searchTexUvMinMax 480
//float4 searchTexBorderColor 496
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
float4 edgesTexSize;
float4 edgesTexDims;
float4 edgesTexView;
float3x3 edgesTexTransform;
float4 edgesTexUvMinMax;
float4 edgesTexBorderColor;
float4 areaTexSize;
float4 areaTexDims;
float4 areaTexView;
float3x3 areaTexTransform;
float4 areaTexUvMinMax;
float4 areaTexBorderColor;
float4 searchTexSize;
float4 searchTexDims;
float4 searchTexView;
float3x3 searchTexTransform;
float4 searchTexUvMinMax;
float4 searchTexBorderColor;
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
#ifndef edgesTexHasSwappedViews
#define edgesTexHasSwappedViews 0
#elif edgesTexHasSwappedViews==1
#undef edgesTexHasSwappedViews
#define edgesTexHasSwappedViews 1
#endif
#ifndef edgesTexLayout
#define edgesTexLayout 0
#endif
#ifndef areaTexHasSwappedViews
#define areaTexHasSwappedViews 0
#elif areaTexHasSwappedViews==1
#undef areaTexHasSwappedViews
#define areaTexHasSwappedViews 1
#endif
#ifndef areaTexLayout
#define areaTexLayout 0
#endif
#ifndef searchTexHasSwappedViews
#define searchTexHasSwappedViews 0
#elif searchTexHasSwappedViews==1
#undef searchTexHasSwappedViews
#define searchTexHasSwappedViews 1
#endif
#ifndef searchTexLayout
#define searchTexLayout 0
#endif
#ifndef SMAA_QUALITY
#define SMAA_QUALITY 0
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
#ifndef edgesTexUV
#define edgesTexUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_edgesTex
#define SC_USE_UV_TRANSFORM_edgesTex 0
#elif SC_USE_UV_TRANSFORM_edgesTex==1
#undef SC_USE_UV_TRANSFORM_edgesTex
#define SC_USE_UV_TRANSFORM_edgesTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_edgesTex
#define SC_SOFTWARE_WRAP_MODE_U_edgesTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_edgesTex
#define SC_SOFTWARE_WRAP_MODE_V_edgesTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_edgesTex
#define SC_USE_UV_MIN_MAX_edgesTex 0
#elif SC_USE_UV_MIN_MAX_edgesTex==1
#undef SC_USE_UV_MIN_MAX_edgesTex
#define SC_USE_UV_MIN_MAX_edgesTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_edgesTex
#define SC_USE_CLAMP_TO_BORDER_edgesTex 0
#elif SC_USE_CLAMP_TO_BORDER_edgesTex==1
#undef SC_USE_CLAMP_TO_BORDER_edgesTex
#define SC_USE_CLAMP_TO_BORDER_edgesTex 1
#endif
#ifndef areaTexUV
#define areaTexUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_areaTex
#define SC_USE_UV_TRANSFORM_areaTex 0
#elif SC_USE_UV_TRANSFORM_areaTex==1
#undef SC_USE_UV_TRANSFORM_areaTex
#define SC_USE_UV_TRANSFORM_areaTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_areaTex
#define SC_SOFTWARE_WRAP_MODE_U_areaTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_areaTex
#define SC_SOFTWARE_WRAP_MODE_V_areaTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_areaTex
#define SC_USE_UV_MIN_MAX_areaTex 0
#elif SC_USE_UV_MIN_MAX_areaTex==1
#undef SC_USE_UV_MIN_MAX_areaTex
#define SC_USE_UV_MIN_MAX_areaTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_areaTex
#define SC_USE_CLAMP_TO_BORDER_areaTex 0
#elif SC_USE_CLAMP_TO_BORDER_areaTex==1
#undef SC_USE_CLAMP_TO_BORDER_areaTex
#define SC_USE_CLAMP_TO_BORDER_areaTex 1
#endif
#ifndef searchTexUV
#define searchTexUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_searchTex
#define SC_USE_UV_TRANSFORM_searchTex 0
#elif SC_USE_UV_TRANSFORM_searchTex==1
#undef SC_USE_UV_TRANSFORM_searchTex
#define SC_USE_UV_TRANSFORM_searchTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_searchTex
#define SC_SOFTWARE_WRAP_MODE_U_searchTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_searchTex
#define SC_SOFTWARE_WRAP_MODE_V_searchTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_searchTex
#define SC_USE_UV_MIN_MAX_searchTex 0
#elif SC_USE_UV_MIN_MAX_searchTex==1
#undef SC_USE_UV_MIN_MAX_searchTex
#define SC_USE_UV_MIN_MAX_searchTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_searchTex
#define SC_USE_CLAMP_TO_BORDER_searchTex 0
#elif SC_USE_CLAMP_TO_BORDER_searchTex==1
#undef SC_USE_CLAMP_TO_BORDER_searchTex
#define SC_USE_CLAMP_TO_BORDER_searchTex 1
#endif
#ifndef DEBUG_MODE
#define DEBUG_MODE 0
#endif
#ifndef SMAA_AREATEX_MAX_DISTANCE
#define SMAA_AREATEX_MAX_DISTANCE 16
#endif
#ifndef SMAA_AREATEX_MAX_DISTANCE_DIAG
#define SMAA_AREATEX_MAX_DISTANCE_DIAG 20
#endif
struct sc_Set2
{
texture2d<float> areaTex [[id(0)]];
texture2d<float> edgesTex [[id(1)]];
texture2d<float> inputTexture [[id(2)]];
texture2d<float> searchTex [[id(3)]];
sampler areaTexSmpSC [[id(4)]];
sampler edgesTexSmpSC [[id(5)]];
sampler inputTextureSmpSC [[id(6)]];
sampler searchTexSmpSC [[id(7)]];
constant userUniformsObj* UserUniforms [[id(8)]];
};
struct sc_VertOut
{
sc_SysOut sc_sysOut;
float4 varOffset0 [[user(locn10)]];
float4 varOffset1 [[user(locn11)]];
float4 varOffset2 [[user(locn12)]];
float2 varPixCoord [[user(locn13)]];
};
struct sc_VertIn
{
sc_SysAttributes sc_sysAttributes;
};
int smaaMaxSearchSteps(thread const int& smaaQuality)
{
switch (smaaQuality)
{
case 0:
case 1:
{
return 0;
}
case 2:
case 3:
case 4:
{
return 25;
}
default:
{
return 0;
}
}
}
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
float2 l9_0=(v.position.xy*0.5)+float2(0.5);
sc_vertOut.sc_sysOut.varPackedTex=float4(l9_0.x,l9_0.y,sc_vertOut.sc_sysOut.varPackedTex.z,sc_vertOut.sc_sysOut.varPackedTex.w);
float4 smaaRTMetrics=float4(1.0/(*sc_set2.UserUniforms).inputTextureSize.x,1.0/(*sc_set2.UserUniforms).inputTextureSize.y,(*sc_set2.UserUniforms).inputTextureSize.x,(*sc_set2.UserUniforms).inputTextureSize.y);
sc_vertOut.varPixCoord=sc_vertOut.sc_sysOut.varPackedTex.xy*smaaRTMetrics.zw;
sc_vertOut.varOffset0=(smaaRTMetrics.xyxy*float4(-0.25,0.125,1.25,0.125))+sc_vertOut.sc_sysOut.varPackedTex.xyxy;
sc_vertOut.varOffset1=(smaaRTMetrics.xyxy*float4(-0.125,0.25,-0.125,-1.25))+sc_vertOut.sc_sysOut.varPackedTex.xyxy;
int param_1=SMAA_QUALITY;
sc_vertOut.varOffset2=((smaaRTMetrics.xxyy*float4(-2.0,2.0,2.0,-2.0))*float(smaaMaxSearchSteps(param_1)))+float4(sc_vertOut.varOffset0.xz,sc_vertOut.varOffset1.yw);
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
float4 edgesTexSize;
float4 edgesTexDims;
float4 edgesTexView;
float3x3 edgesTexTransform;
float4 edgesTexUvMinMax;
float4 edgesTexBorderColor;
float4 areaTexSize;
float4 areaTexDims;
float4 areaTexView;
float3x3 areaTexTransform;
float4 areaTexUvMinMax;
float4 areaTexBorderColor;
float4 searchTexSize;
float4 searchTexDims;
float4 searchTexView;
float3x3 searchTexTransform;
float4 searchTexUvMinMax;
float4 searchTexBorderColor;
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
#ifndef edgesTexHasSwappedViews
#define edgesTexHasSwappedViews 0
#elif edgesTexHasSwappedViews==1
#undef edgesTexHasSwappedViews
#define edgesTexHasSwappedViews 1
#endif
#ifndef edgesTexLayout
#define edgesTexLayout 0
#endif
#ifndef areaTexHasSwappedViews
#define areaTexHasSwappedViews 0
#elif areaTexHasSwappedViews==1
#undef areaTexHasSwappedViews
#define areaTexHasSwappedViews 1
#endif
#ifndef areaTexLayout
#define areaTexLayout 0
#endif
#ifndef searchTexHasSwappedViews
#define searchTexHasSwappedViews 0
#elif searchTexHasSwappedViews==1
#undef searchTexHasSwappedViews
#define searchTexHasSwappedViews 1
#endif
#ifndef searchTexLayout
#define searchTexLayout 0
#endif
#ifndef SMAA_QUALITY
#define SMAA_QUALITY 0
#endif
#ifndef SC_USE_UV_TRANSFORM_edgesTex
#define SC_USE_UV_TRANSFORM_edgesTex 0
#elif SC_USE_UV_TRANSFORM_edgesTex==1
#undef SC_USE_UV_TRANSFORM_edgesTex
#define SC_USE_UV_TRANSFORM_edgesTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_edgesTex
#define SC_SOFTWARE_WRAP_MODE_U_edgesTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_edgesTex
#define SC_SOFTWARE_WRAP_MODE_V_edgesTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_edgesTex
#define SC_USE_UV_MIN_MAX_edgesTex 0
#elif SC_USE_UV_MIN_MAX_edgesTex==1
#undef SC_USE_UV_MIN_MAX_edgesTex
#define SC_USE_UV_MIN_MAX_edgesTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_edgesTex
#define SC_USE_CLAMP_TO_BORDER_edgesTex 0
#elif SC_USE_CLAMP_TO_BORDER_edgesTex==1
#undef SC_USE_CLAMP_TO_BORDER_edgesTex
#define SC_USE_CLAMP_TO_BORDER_edgesTex 1
#endif
#ifndef SMAA_AREATEX_MAX_DISTANCE_DIAG
#define SMAA_AREATEX_MAX_DISTANCE_DIAG 20
#endif
#ifndef SC_USE_UV_TRANSFORM_areaTex
#define SC_USE_UV_TRANSFORM_areaTex 0
#elif SC_USE_UV_TRANSFORM_areaTex==1
#undef SC_USE_UV_TRANSFORM_areaTex
#define SC_USE_UV_TRANSFORM_areaTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_areaTex
#define SC_SOFTWARE_WRAP_MODE_U_areaTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_areaTex
#define SC_SOFTWARE_WRAP_MODE_V_areaTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_areaTex
#define SC_USE_UV_MIN_MAX_areaTex 0
#elif SC_USE_UV_MIN_MAX_areaTex==1
#undef SC_USE_UV_MIN_MAX_areaTex
#define SC_USE_UV_MIN_MAX_areaTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_areaTex
#define SC_USE_CLAMP_TO_BORDER_areaTex 0
#elif SC_USE_CLAMP_TO_BORDER_areaTex==1
#undef SC_USE_CLAMP_TO_BORDER_areaTex
#define SC_USE_CLAMP_TO_BORDER_areaTex 1
#endif
#ifndef SC_USE_UV_TRANSFORM_searchTex
#define SC_USE_UV_TRANSFORM_searchTex 0
#elif SC_USE_UV_TRANSFORM_searchTex==1
#undef SC_USE_UV_TRANSFORM_searchTex
#define SC_USE_UV_TRANSFORM_searchTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_searchTex
#define SC_SOFTWARE_WRAP_MODE_U_searchTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_searchTex
#define SC_SOFTWARE_WRAP_MODE_V_searchTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_searchTex
#define SC_USE_UV_MIN_MAX_searchTex 0
#elif SC_USE_UV_MIN_MAX_searchTex==1
#undef SC_USE_UV_MIN_MAX_searchTex
#define SC_USE_UV_MIN_MAX_searchTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_searchTex
#define SC_USE_CLAMP_TO_BORDER_searchTex 0
#elif SC_USE_CLAMP_TO_BORDER_searchTex==1
#undef SC_USE_CLAMP_TO_BORDER_searchTex
#define SC_USE_CLAMP_TO_BORDER_searchTex 1
#endif
#ifndef SMAA_AREATEX_MAX_DISTANCE
#define SMAA_AREATEX_MAX_DISTANCE 16
#endif
#ifndef DEBUG_MODE
#define DEBUG_MODE 0
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
#ifndef edgesTexUV
#define edgesTexUV 0
#endif
#ifndef areaTexUV
#define areaTexUV 0
#endif
#ifndef searchTexUV
#define searchTexUV 0
#endif
struct sc_Set2
{
texture2d<float> areaTex [[id(0)]];
texture2d<float> edgesTex [[id(1)]];
texture2d<float> inputTexture [[id(2)]];
texture2d<float> searchTex [[id(3)]];
sampler areaTexSmpSC [[id(4)]];
sampler edgesTexSmpSC [[id(5)]];
sampler inputTextureSmpSC [[id(6)]];
sampler searchTexSmpSC [[id(7)]];
constant userUniformsObj* UserUniforms [[id(8)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
float4 varOffset0 [[user(locn10)]];
float4 varOffset1 [[user(locn11)]];
float4 varOffset2 [[user(locn12)]];
float2 varPixCoord [[user(locn13)]];
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
float2 edgesTexGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.edgesTexDims.xy;
}
int edgesTexGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (edgesTexHasSwappedViews)
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
int smaaMaxSearchStepsDiag(thread const int& smaaQuality)
{
switch (smaaQuality)
{
case 0:
case 1:
{
return 0;
}
case 2:
{
return 8;
}
case 3:
case 4:
{
return 16;
}
default:
{
return 0;
}
}
}
float2 SMAASearchDiag1(thread const float2& texcoord,thread const float2& dir,thread float2& e,constant userUniformsObj& UserUniforms,thread texture2d<float> edgesTex,thread sampler edgesTexSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 coord=float4(texcoord,-1.0,1.0);
float4 smaaRTMetrics=float4(1.0/UserUniforms.inputTextureSize.x,1.0/UserUniforms.inputTextureSize.y,UserUniforms.inputTextureSize.x,UserUniforms.inputTextureSize.y);
float3 t=float3(smaaRTMetrics.xy,1.0);
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
float l9_0=coord.z;
int param=SMAA_QUALITY;
int l9_1=smaaMaxSearchStepsDiag(param);
bool l9_2=l9_0<float(l9_1-1);
bool l9_3;
if (l9_2)
{
l9_3=coord.w>0.89999998;
}
else
{
l9_3=l9_2;
}
if (l9_3)
{
float3 l9_4=(t*float3(dir,1.0))+coord.xyz;
coord=float4(l9_4.x,l9_4.y,l9_4.z,coord.w);
float2 param_1=edgesTexGetDims2D(UserUniforms);
int param_2=edgesTexLayout;
int param_3=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_4=coord.xy;
bool param_5=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_6=UserUniforms.edgesTexTransform;
int2 param_7=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_8=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_9=UserUniforms.edgesTexUvMinMax;
bool param_10=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_11=UserUniforms.edgesTexBorderColor;
float param_12=0.0;
float4 l9_5=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11,param_12);
float4 l9_6=l9_5;
float4 edgesTexSample=l9_5;
e=edgesTexSample.xy;
coord.w=dot(e,float2(0.5));
continue;
}
else
{
break;
}
}
return coord.zw;
}
float2 calcSampleOffset(thread const float2& coord,thread const float2& offset,thread const float2& metric)
{
return float2(coord+(metric*offset));
}
float4 SMAADecodeDiagBilinearAccess(thread float4& e)
{
float2 l9_0=e.xz*abs((e.xz*5.0)-float2(3.75));
e=float4(l9_0.x,e.y,l9_0.y,e.w);
return round(e);
}
void SMAAMovc(thread const float2& cond,thread float2& variable,thread const float2& value)
{
if (cond.x>0.0)
{
variable.x=value.x;
}
if (cond.y>0.0)
{
variable.y=value.y;
}
}
float2 areaTexGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.areaTexDims.xy;
}
int areaTexGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (areaTexHasSwappedViews)
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
float2 SMAAAreaDiag(thread const float2& dist,thread const float2& e,thread const float& offset,constant userUniformsObj& UserUniforms,thread texture2d<float> areaTex,thread sampler areaTexSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 texcoord=(float2(float(SMAA_AREATEX_MAX_DISTANCE_DIAG),float(SMAA_AREATEX_MAX_DISTANCE_DIAG))*e)+dist;
float2 SMAA_AREATEX_PIXEL_SIZE=float2(0.0062500001,0.0017857143);
float SMAA_AREATEX_SUBTEX_SIZE=0.14285715;
float4 smaaRTMetrics=float4(1.0/UserUniforms.inputTextureSize.x,1.0/UserUniforms.inputTextureSize.y,UserUniforms.inputTextureSize.x,UserUniforms.inputTextureSize.y);
texcoord=(SMAA_AREATEX_PIXEL_SIZE*texcoord)+(SMAA_AREATEX_PIXEL_SIZE*0.5);
texcoord.x+=0.5;
texcoord.y+=(SMAA_AREATEX_SUBTEX_SIZE*offset);
texcoord.y=1.0-texcoord.y;
float2 param=texcoord;
float2 param_1=float2(0.0);
float2 param_2=smaaRTMetrics.xy;
float2 param_3=areaTexGetDims2D(UserUniforms);
int param_4=areaTexLayout;
int param_5=areaTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_6=calcSampleOffset(param,param_1,param_2);
bool param_7=(int(SC_USE_UV_TRANSFORM_areaTex)!=0);
float3x3 param_8=UserUniforms.areaTexTransform;
int2 param_9=int2(SC_SOFTWARE_WRAP_MODE_U_areaTex,SC_SOFTWARE_WRAP_MODE_V_areaTex);
bool param_10=(int(SC_USE_UV_MIN_MAX_areaTex)!=0);
float4 param_11=UserUniforms.areaTexUvMinMax;
bool param_12=(int(SC_USE_CLAMP_TO_BORDER_areaTex)!=0);
float4 param_13=UserUniforms.areaTexBorderColor;
float param_14=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(areaTex,areaTexSmpSC,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11,param_12,param_13,param_14);
float4 l9_1=l9_0;
float4 areaTexSample=l9_0;
return areaTexSample.xy;
}
float2 SMAADecodeDiagBilinearAccess(thread float2& e)
{
e.x*=abs((5.0*e.x)-3.75);
return round(e);
}
float2 SMAASearchDiag2(thread const float2& texcoord,thread const float2& dir,thread float2& e,constant userUniformsObj& UserUniforms,thread texture2d<float> edgesTex,thread sampler edgesTexSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 coord=float4(texcoord,-1.0,1.0);
float4 smaaRTMetrics=float4(1.0/UserUniforms.inputTextureSize.x,1.0/UserUniforms.inputTextureSize.y,UserUniforms.inputTextureSize.x,UserUniforms.inputTextureSize.y);
coord.x+=(0.25*smaaRTMetrics.x);
float3 t=float3(smaaRTMetrics.xy,1.0);
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
float l9_0=coord.z;
int param=SMAA_QUALITY;
int l9_1=smaaMaxSearchStepsDiag(param);
bool l9_2=l9_0<float(l9_1-1);
bool l9_3;
if (l9_2)
{
l9_3=coord.w>0.89999998;
}
else
{
l9_3=l9_2;
}
if (l9_3)
{
float3 l9_4=(t*float3(dir,1.0))+coord.xyz;
coord=float4(l9_4.x,l9_4.y,l9_4.z,coord.w);
float2 param_1=edgesTexGetDims2D(UserUniforms);
int param_2=edgesTexLayout;
int param_3=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_4=coord.xy;
bool param_5=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_6=UserUniforms.edgesTexTransform;
int2 param_7=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_8=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_9=UserUniforms.edgesTexUvMinMax;
bool param_10=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_11=UserUniforms.edgesTexBorderColor;
float param_12=0.0;
float4 l9_5=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11,param_12);
float4 l9_6=l9_5;
float4 edgesTexSample=l9_5;
e=edgesTexSample.xy;
float2 param_13=e;
float2 l9_7=SMAADecodeDiagBilinearAccess(param_13);
e=l9_7;
coord.w=dot(e,float2(0.5));
continue;
}
else
{
break;
}
}
return coord.zw;
}
float2 SMAACalculateDiagWeights(thread const float2& texcoord,thread const float2& e,thread const float4& subsampleIndices,constant userUniformsObj& UserUniforms,thread texture2d<float> edgesTex,thread sampler edgesTexSmpSC,thread texture2d<float> areaTex,thread sampler areaTexSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 weights=float2(0.0);
float4 smaaRTMetrics=float4(1.0/UserUniforms.inputTextureSize.x,1.0/UserUniforms.inputTextureSize.y,UserUniforms.inputTextureSize.x,UserUniforms.inputTextureSize.y);
float4 d;
float2 end;
if (e.x>0.0)
{
float2 param=texcoord;
float2 param_1=float2(-1.0);
float2 param_2;
float2 l9_0=SMAASearchDiag1(param,param_1,param_2,UserUniforms,edgesTex,edgesTexSmpSC,sc_sysIn,sc_set0,sc_set1);
end=param_2;
d=float4(l9_0.x,d.y,l9_0.y,d.w);
d.x+=float(end.y>0.89999998);
}
else
{
d=float4(float2(0.0).x,d.y,float2(0.0).y,d.w);
}
float2 param_3=texcoord;
float2 param_4=float2(1.0);
float2 param_5;
float2 l9_1=SMAASearchDiag1(param_3,param_4,param_5,UserUniforms,edgesTex,edgesTexSmpSC,sc_sysIn,sc_set0,sc_set1);
end=param_5;
d=float4(d.x,l9_1.x,d.z,l9_1.y);
if ((d.x+d.y)>2.0)
{
float4 coords=(float4((-d.x)+0.25,-d.x,d.y,d.y+0.25)*smaaRTMetrics.xyxy)+texcoord.xyxy;
float2 param_6=coords.xy;
float2 param_7=float2(-1.0,0.0);
float2 param_8=smaaRTMetrics.xy;
float2 param_9=edgesTexGetDims2D(UserUniforms);
int param_10=edgesTexLayout;
int param_11=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_12=calcSampleOffset(param_6,param_7,param_8);
bool param_13=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_14=UserUniforms.edgesTexTransform;
int2 param_15=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_16=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_17=UserUniforms.edgesTexUvMinMax;
bool param_18=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_19=UserUniforms.edgesTexBorderColor;
float param_20=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param_9,param_10,param_11,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20);
float4 l9_3=l9_2;
float4 edgesTexSample=l9_2;
float4 c;
c=float4(edgesTexSample.xy.x,edgesTexSample.xy.y,c.z,c.w);
float2 param_21=coords.zw;
float2 param_22=float2(1.0,0.0);
float2 param_23=smaaRTMetrics.xy;
float2 param_24=edgesTexGetDims2D(UserUniforms);
int param_25=edgesTexLayout;
int param_26=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_27=calcSampleOffset(param_21,param_22,param_23);
bool param_28=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_29=UserUniforms.edgesTexTransform;
int2 param_30=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_31=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_32=UserUniforms.edgesTexUvMinMax;
bool param_33=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_34=UserUniforms.edgesTexBorderColor;
float param_35=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param_24,param_25,param_26,param_27,param_28,param_29,param_30,param_31,param_32,param_33,param_34,param_35);
float4 l9_5=l9_4;
float4 edgesTexSample_1=l9_4;
c=float4(c.x,c.y,edgesTexSample_1.xy.x,edgesTexSample_1.xy.y);
float4 param_36=c;
float4 l9_6=SMAADecodeDiagBilinearAccess(param_36);
c=float4(l9_6.y,l9_6.x,l9_6.w,l9_6.z);
float2 cc=(float2(2.0)*c.xz)+c.yw;
float2 param_37=float2(step(float2(0.89999998),d.zw));
float2 param_38=cc;
float2 param_39=float2(0.0);
SMAAMovc(param_37,param_38,param_39);
cc=param_38;
float2 param_40=d.xy;
float2 param_41=cc;
float param_42=subsampleIndices.z;
weights+=SMAAAreaDiag(param_40,param_41,param_42,UserUniforms,areaTex,areaTexSmpSC,sc_sysIn,sc_set0,sc_set1);
}
float rTexSample=0.0;
float2 param_43=texcoord;
float2 param_44=float2(1.0,0.0);
float2 param_45=smaaRTMetrics.xy;
float2 param_46=edgesTexGetDims2D(UserUniforms);
int param_47=edgesTexLayout;
int param_48=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_49=calcSampleOffset(param_43,param_44,param_45);
bool param_50=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_51=UserUniforms.edgesTexTransform;
int2 param_52=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_53=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_54=UserUniforms.edgesTexUvMinMax;
bool param_55=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_56=UserUniforms.edgesTexBorderColor;
float param_57=0.0;
float4 l9_7=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param_46,param_47,param_48,param_49,param_50,param_51,param_52,param_53,param_54,param_55,param_56,param_57);
float4 l9_8=l9_7;
float4 edgesTexSample_2=l9_7;
rTexSample=edgesTexSample_2.x;
float2 param_58=texcoord;
float2 param_59=float2(-1.0,1.0);
float2 param_60;
float2 l9_9=SMAASearchDiag2(param_58,param_59,param_60,UserUniforms,edgesTex,edgesTexSmpSC,sc_sysIn,sc_set0,sc_set1);
end=param_60;
d=float4(l9_9.x,d.y,l9_9.y,d.w);
if (rTexSample>0.0)
{
float2 param_61=texcoord;
float2 param_62=float2(1.0,-1.0);
float2 param_63;
float2 l9_10=SMAASearchDiag2(param_61,param_62,param_63,UserUniforms,edgesTex,edgesTexSmpSC,sc_sysIn,sc_set0,sc_set1);
end=param_63;
d=float4(d.x,l9_10.x,d.z,l9_10.y);
d.y+=float(end.y>0.89999998);
}
else
{
d=float4(d.x,float2(0.0).x,d.z,float2(0.0).y);
}
if ((d.x+d.y)>2.0)
{
float4 coords_1=(float4(-d.x,-d.x,d.y,d.y)*smaaRTMetrics.xyxy)+texcoord.xyxy;
float2 param_64=coords_1.xy;
float2 param_65=float2(-1.0,0.0);
float2 param_66=smaaRTMetrics.xy;
float2 param_67=edgesTexGetDims2D(UserUniforms);
int param_68=edgesTexLayout;
int param_69=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_70=calcSampleOffset(param_64,param_65,param_66);
bool param_71=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_72=UserUniforms.edgesTexTransform;
int2 param_73=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_74=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_75=UserUniforms.edgesTexUvMinMax;
bool param_76=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_77=UserUniforms.edgesTexBorderColor;
float param_78=0.0;
float4 l9_11=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param_67,param_68,param_69,param_70,param_71,param_72,param_73,param_74,param_75,param_76,param_77,param_78);
float4 l9_12=l9_11;
float4 edgesTexSample_3=l9_11;
float4 c_1;
c_1.x=edgesTexSample_3.y;
float2 param_79=coords_1.xy;
float2 param_80=float2(0.0,-1.0);
float2 param_81=smaaRTMetrics.xy;
float2 param_82=edgesTexGetDims2D(UserUniforms);
int param_83=edgesTexLayout;
int param_84=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_85=calcSampleOffset(param_79,param_80,param_81);
bool param_86=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_87=UserUniforms.edgesTexTransform;
int2 param_88=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_89=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_90=UserUniforms.edgesTexUvMinMax;
bool param_91=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_92=UserUniforms.edgesTexBorderColor;
float param_93=0.0;
float4 l9_13=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param_82,param_83,param_84,param_85,param_86,param_87,param_88,param_89,param_90,param_91,param_92,param_93);
float4 l9_14=l9_13;
float4 edgesTexSample_4=l9_13;
c_1.y=edgesTexSample_4.x;
float2 param_94=coords_1.zw;
float2 param_95=float2(1.0,0.0);
float2 param_96=smaaRTMetrics.xy;
float2 param_97=edgesTexGetDims2D(UserUniforms);
int param_98=edgesTexLayout;
int param_99=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_100=calcSampleOffset(param_94,param_95,param_96);
bool param_101=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_102=UserUniforms.edgesTexTransform;
int2 param_103=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_104=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_105=UserUniforms.edgesTexUvMinMax;
bool param_106=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_107=UserUniforms.edgesTexBorderColor;
float param_108=0.0;
float4 l9_15=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param_97,param_98,param_99,param_100,param_101,param_102,param_103,param_104,param_105,param_106,param_107,param_108);
float4 l9_16=l9_15;
float4 edgesTexSample_5=l9_15;
c_1=float4(c_1.x,c_1.y,edgesTexSample_5.yx.x,edgesTexSample_5.yx.y);
float2 cc_1=(float2(2.0)*c_1.xz)+c_1.yw;
float2 param_109=float2(step(float2(0.89999998),d.zw));
float2 param_110=cc_1;
float2 param_111=float2(0.0);
SMAAMovc(param_109,param_110,param_111);
cc_1=param_110;
float2 param_112=d.xy;
float2 param_113=cc_1;
float param_114=subsampleIndices.w;
weights+=SMAAAreaDiag(param_112,param_113,param_114,UserUniforms,areaTex,areaTexSmpSC,sc_sysIn,sc_set0,sc_set1).yx;
}
return weights;
}
bool smaaDisableDetection(thread const int& smaaQuality)
{
if (((smaaQuality==0)||(smaaQuality==1))||(smaaQuality==4))
{
return true;
}
return false;
}
float2 searchTexGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.searchTexDims.xy;
}
int searchTexGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (searchTexHasSwappedViews)
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
float SMAASearchLength(thread const float2& e,thread const float& offset,constant userUniformsObj& UserUniforms,thread texture2d<float> searchTex,thread sampler searchTexSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 SMAA_SEARCHTEX_SIZE=float2(66.0,33.0);
float2 SMAA_SEARCHTEX_PACKED_SIZE=float2(64.0,16.0);
float4 smaaRTMetrics=float4(1.0/UserUniforms.inputTextureSize.x,1.0/UserUniforms.inputTextureSize.y,UserUniforms.inputTextureSize.x,UserUniforms.inputTextureSize.y);
float2 scale=SMAA_SEARCHTEX_SIZE*float2(0.5,-1.0);
float2 bias0=SMAA_SEARCHTEX_SIZE*float2(offset,1.0);
scale+=float2(-1.0,1.0);
bias0+=float2(0.5,-0.5);
scale*=(float2(1.0)/SMAA_SEARCHTEX_PACKED_SIZE);
bias0*=(float2(1.0)/SMAA_SEARCHTEX_PACKED_SIZE);
float2 lookup=(scale*e)+bias0;
lookup.y=1.0-lookup.y;
float2 param=lookup;
float2 param_1=float2(0.0);
float2 param_2=smaaRTMetrics.xy;
float2 param_3=searchTexGetDims2D(UserUniforms);
int param_4=searchTexLayout;
int param_5=searchTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_6=calcSampleOffset(param,param_1,param_2);
bool param_7=(int(SC_USE_UV_TRANSFORM_searchTex)!=0);
float3x3 param_8=UserUniforms.searchTexTransform;
int2 param_9=int2(SC_SOFTWARE_WRAP_MODE_U_searchTex,SC_SOFTWARE_WRAP_MODE_V_searchTex);
bool param_10=(int(SC_USE_UV_MIN_MAX_searchTex)!=0);
float4 param_11=UserUniforms.searchTexUvMinMax;
bool param_12=(int(SC_USE_CLAMP_TO_BORDER_searchTex)!=0);
float4 param_13=UserUniforms.searchTexBorderColor;
float param_14=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(searchTex,searchTexSmpSC,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11,param_12,param_13,param_14);
float4 l9_1=l9_0;
float4 searchTexSample=l9_0;
return searchTexSample.x;
}
float SMAASearchXLeft(thread float2& texcoord,thread const float& end,constant userUniformsObj& UserUniforms,thread texture2d<float> edgesTex,thread sampler edgesTexSmpSC,thread texture2d<float> searchTex,thread sampler searchTexSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 e=float2(0.0,1.0);
float4 smaaRTMetrics=float4(1.0/UserUniforms.inputTextureSize.x,1.0/UserUniforms.inputTextureSize.y,UserUniforms.inputTextureSize.x,UserUniforms.inputTextureSize.y);
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
float l9_0=texcoord.x;
float l9_1=end;
bool l9_2=l9_0>l9_1;
bool l9_3;
if (l9_2)
{
l9_3=e.y>0.82810003;
}
else
{
l9_3=l9_2;
}
bool l9_4;
if (l9_3)
{
l9_4=e.x==0.0;
}
else
{
l9_4=l9_3;
}
if (l9_4)
{
float2 param=edgesTexGetDims2D(UserUniforms);
int param_1=edgesTexLayout;
int param_2=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_3=texcoord;
bool param_4=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_5=UserUniforms.edgesTexTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_7=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_8=UserUniforms.edgesTexUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_10=UserUniforms.edgesTexBorderColor;
float param_11=0.0;
float4 l9_5=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_6=l9_5;
float4 edgesTexSample=l9_5;
e=edgesTexSample.xy;
texcoord=(float2(-2.0,-0.0)*smaaRTMetrics.xy)+texcoord;
continue;
}
else
{
break;
}
}
float2 param_12=e;
float param_13=0.0;
float offset=((-2.007874)*SMAASearchLength(param_12,param_13,UserUniforms,searchTex,searchTexSmpSC,sc_sysIn,sc_set0,sc_set1))+3.25;
return (smaaRTMetrics.x*offset)+texcoord.x;
}
float SMAASearchXRight(thread float2& texcoord,thread const float& end,constant userUniformsObj& UserUniforms,thread texture2d<float> edgesTex,thread sampler edgesTexSmpSC,thread texture2d<float> searchTex,thread sampler searchTexSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 e=float2(0.0,1.0);
float4 smaaRTMetrics=float4(1.0/UserUniforms.inputTextureSize.x,1.0/UserUniforms.inputTextureSize.y,UserUniforms.inputTextureSize.x,UserUniforms.inputTextureSize.y);
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
float l9_0=texcoord.x;
float l9_1=end;
bool l9_2=l9_0<l9_1;
bool l9_3;
if (l9_2)
{
l9_3=e.y>0.82810003;
}
else
{
l9_3=l9_2;
}
bool l9_4;
if (l9_3)
{
l9_4=e.x==0.0;
}
else
{
l9_4=l9_3;
}
if (l9_4)
{
float2 param=edgesTexGetDims2D(UserUniforms);
int param_1=edgesTexLayout;
int param_2=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_3=texcoord;
bool param_4=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_5=UserUniforms.edgesTexTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_7=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_8=UserUniforms.edgesTexUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_10=UserUniforms.edgesTexBorderColor;
float param_11=0.0;
float4 l9_5=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_6=l9_5;
float4 edgesTexSample=l9_5;
e=edgesTexSample.xy;
texcoord=(float2(2.0,0.0)*smaaRTMetrics.xy)+texcoord;
continue;
}
else
{
break;
}
}
float2 param_12=e;
float param_13=0.5;
float offset=((-2.007874)*SMAASearchLength(param_12,param_13,UserUniforms,searchTex,searchTexSmpSC,sc_sysIn,sc_set0,sc_set1))+3.25;
return ((-smaaRTMetrics.x)*offset)+texcoord.x;
}
float2 SMAAArea(thread const float2& dist,thread const float& e1,thread const float& e2,thread const float& offset,constant userUniformsObj& UserUniforms,thread texture2d<float> areaTex,thread sampler areaTexSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 texcoord=(float2(float(SMAA_AREATEX_MAX_DISTANCE),float(SMAA_AREATEX_MAX_DISTANCE))*round(float2(e1,e2)*4.0))+dist;
float2 SMAA_AREATEX_PIXEL_SIZE=float2(0.0062500001,0.0017857143);
float SMAA_AREATEX_SUBTEX_SIZE=0.14285715;
float4 smaaRTMetrics=float4(1.0/UserUniforms.inputTextureSize.x,1.0/UserUniforms.inputTextureSize.y,UserUniforms.inputTextureSize.x,UserUniforms.inputTextureSize.y);
texcoord=(SMAA_AREATEX_PIXEL_SIZE*texcoord)+(SMAA_AREATEX_PIXEL_SIZE*0.5);
texcoord.y=(SMAA_AREATEX_SUBTEX_SIZE*offset)+texcoord.y;
texcoord.y=1.0-texcoord.y;
float2 param=texcoord;
float2 param_1=float2(0.0);
float2 param_2=smaaRTMetrics.xy;
float2 param_3=areaTexGetDims2D(UserUniforms);
int param_4=areaTexLayout;
int param_5=areaTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_6=calcSampleOffset(param,param_1,param_2);
bool param_7=(int(SC_USE_UV_TRANSFORM_areaTex)!=0);
float3x3 param_8=UserUniforms.areaTexTransform;
int2 param_9=int2(SC_SOFTWARE_WRAP_MODE_U_areaTex,SC_SOFTWARE_WRAP_MODE_V_areaTex);
bool param_10=(int(SC_USE_UV_MIN_MAX_areaTex)!=0);
float4 param_11=UserUniforms.areaTexUvMinMax;
bool param_12=(int(SC_USE_CLAMP_TO_BORDER_areaTex)!=0);
float4 param_13=UserUniforms.areaTexBorderColor;
float param_14=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(areaTex,areaTexSmpSC,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11,param_12,param_13,param_14);
float4 l9_1=l9_0;
float4 areaTexSample=l9_0;
return areaTexSample.xy;
}
int smaaMaxSearchSteps(thread const int& smaaQuality)
{
switch (smaaQuality)
{
case 0:
case 1:
{
return 0;
}
case 2:
case 3:
case 4:
{
return 25;
}
default:
{
return 0;
}
}
}
float4 DebugColor(thread const float4& weights,thread const float& e1,thread const float& e2,thread const float2& dist)
{
#if ((DEBUG_MODE==1)||(DEBUG_MODE==2))
{
float debugCross=0.0;
#if (DEBUG_MODE==1)
{
debugCross=e1*4.0;
}
#else
{
debugCross=e2*4.0;
}
#endif
if (debugCross<0.5)
{
return float4(1.0,0.0,0.0,1.0);
}
else
{
if (debugCross<1.5)
{
return float4(0.0,1.0,0.0,1.0);
}
else
{
if (debugCross<3.5)
{
return float4(0.0,0.0,1.0,1.0);
}
else
{
if (debugCross<4.5)
{
return float4(1.0,1.0,0.0,1.0);
}
else
{
return float4(0.5,0.5,0.5,1.0);
}
}
}
}
}
#endif
#if (DEBUG_MODE==3)
{
if (dist.x==0.0)
{
return float4(1.0,0.0,0.0,1.0);
}
int param=SMAA_QUALITY;
return float4(dist.x/float(smaaMaxSearchSteps(param)));
}
#else
{
#if (DEBUG_MODE==4)
{
if (dist.y==0.0)
{
return float4(1.0,0.0,0.0,1.0);
}
int param_1=SMAA_QUALITY;
return float4(dist.y/float(smaaMaxSearchSteps(param_1)));
}
#endif
}
#endif
return weights;
}
int smaaCornerRounding(thread const int& smaaQuality)
{
switch (smaaQuality)
{
case 0:
case 1:
case 2:
{
return 0;
}
case 3:
case 4:
{
return 15;
}
default:
{
return 0;
}
}
}
void SMAADetectHorizontalCornerPattern(thread float2& weights,thread const float4& texcoord,thread const float2& d,constant userUniformsObj& UserUniforms,thread texture2d<float> edgesTex,thread sampler edgesTexSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int param=SMAA_QUALITY;
if (!smaaDisableDetection(param))
{
int param_1=SMAA_QUALITY;
float SMAA_CORNER_ROUNDING_NORM=float(smaaCornerRounding(param_1))/100.0;
float2 leftRight=step(d,d.yx);
float2 rounding=leftRight*(1.0-SMAA_CORNER_ROUNDING_NORM);
float4 smaaRTMetrics=float4(1.0/UserUniforms.inputTextureSize.x,1.0/UserUniforms.inputTextureSize.y,UserUniforms.inputTextureSize.x,UserUniforms.inputTextureSize.y);
rounding/=float2(leftRight.x+leftRight.y);
float2 factor=float2(1.0);
float2 param_2=texcoord.xy;
float2 param_3=float2(0.0,-1.0);
float2 param_4=smaaRTMetrics.xy;
float2 param_5=edgesTexGetDims2D(UserUniforms);
int param_6=edgesTexLayout;
int param_7=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_8=calcSampleOffset(param_2,param_3,param_4);
bool param_9=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_10=UserUniforms.edgesTexTransform;
int2 param_11=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_12=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_13=UserUniforms.edgesTexUvMinMax;
bool param_14=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_15=UserUniforms.edgesTexBorderColor;
float param_16=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param_5,param_6,param_7,param_8,param_9,param_10,param_11,param_12,param_13,param_14,param_15,param_16);
float4 l9_1=l9_0;
float4 edgesTexSample=l9_0;
factor.x-=(rounding.x*edgesTexSample.x);
float2 param_17=texcoord.zw;
float2 param_18=float2(0.0,-1.0);
float2 param_19=smaaRTMetrics.xy;
float2 param_20=edgesTexGetDims2D(UserUniforms);
int param_21=edgesTexLayout;
int param_22=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_23=calcSampleOffset(param_17,param_18,param_19);
bool param_24=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_25=UserUniforms.edgesTexTransform;
int2 param_26=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_27=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_28=UserUniforms.edgesTexUvMinMax;
bool param_29=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_30=UserUniforms.edgesTexBorderColor;
float param_31=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param_20,param_21,param_22,param_23,param_24,param_25,param_26,param_27,param_28,param_29,param_30,param_31);
float4 l9_3=l9_2;
float4 edgesTexSample_1=l9_2;
factor.x-=(rounding.y*edgesTexSample_1.x);
float2 param_32=texcoord.xy;
float2 param_33=float2(0.0,2.0);
float2 param_34=smaaRTMetrics.xy;
float2 param_35=edgesTexGetDims2D(UserUniforms);
int param_36=edgesTexLayout;
int param_37=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_38=calcSampleOffset(param_32,param_33,param_34);
bool param_39=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_40=UserUniforms.edgesTexTransform;
int2 param_41=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_42=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_43=UserUniforms.edgesTexUvMinMax;
bool param_44=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_45=UserUniforms.edgesTexBorderColor;
float param_46=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param_35,param_36,param_37,param_38,param_39,param_40,param_41,param_42,param_43,param_44,param_45,param_46);
float4 l9_5=l9_4;
float4 edgesTexSample_2=l9_4;
factor.y-=(rounding.x*edgesTexSample_2.x);
float2 param_47=texcoord.zw;
float2 param_48=float2(1.0,2.0);
float2 param_49=smaaRTMetrics.xy;
float2 param_50=edgesTexGetDims2D(UserUniforms);
int param_51=edgesTexLayout;
int param_52=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_53=calcSampleOffset(param_47,param_48,param_49);
bool param_54=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_55=UserUniforms.edgesTexTransform;
int2 param_56=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_57=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_58=UserUniforms.edgesTexUvMinMax;
bool param_59=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_60=UserUniforms.edgesTexBorderColor;
float param_61=0.0;
float4 l9_6=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param_50,param_51,param_52,param_53,param_54,param_55,param_56,param_57,param_58,param_59,param_60,param_61);
float4 l9_7=l9_6;
float4 edgesTexSample_3=l9_6;
factor.y-=(rounding.y*edgesTexSample_3.x);
weights*=fast::clamp(factor,float2(0.0),float2(1.0));
}
}
float SMAASearchYUp(thread float2& texcoord,thread const float& end,constant userUniformsObj& UserUniforms,thread texture2d<float> edgesTex,thread sampler edgesTexSmpSC,thread texture2d<float> searchTex,thread sampler searchTexSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 e=float2(1.0,0.0);
float4 smaaRTMetrics=float4(1.0/UserUniforms.inputTextureSize.x,1.0/UserUniforms.inputTextureSize.y,UserUniforms.inputTextureSize.x,UserUniforms.inputTextureSize.y);
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
float l9_0=texcoord.y;
float l9_1=end;
bool l9_2=l9_0<l9_1;
bool l9_3;
if (l9_2)
{
l9_3=e.x>0.82810003;
}
else
{
l9_3=l9_2;
}
bool l9_4;
if (l9_3)
{
l9_4=e.y==0.0;
}
else
{
l9_4=l9_3;
}
if (l9_4)
{
float2 param=edgesTexGetDims2D(UserUniforms);
int param_1=edgesTexLayout;
int param_2=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_3=texcoord;
bool param_4=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_5=UserUniforms.edgesTexTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_7=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_8=UserUniforms.edgesTexUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_10=UserUniforms.edgesTexBorderColor;
float param_11=0.0;
float4 l9_5=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_6=l9_5;
float4 edgesTexSample=l9_5;
e=edgesTexSample.xy;
texcoord=(float2(0.0,2.0)*smaaRTMetrics.xy)+texcoord;
continue;
}
else
{
break;
}
}
float2 param_12=e.yx;
float param_13=0.0;
float offset=-(((-2.007874)*SMAASearchLength(param_12,param_13,UserUniforms,searchTex,searchTexSmpSC,sc_sysIn,sc_set0,sc_set1))+3.25);
return (smaaRTMetrics.y*offset)+texcoord.y;
}
float SMAASearchYDown(thread float2& texcoord,thread const float& end,constant userUniformsObj& UserUniforms,thread texture2d<float> edgesTex,thread sampler edgesTexSmpSC,thread texture2d<float> searchTex,thread sampler searchTexSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 smaaRTMetrics=float4(1.0/UserUniforms.inputTextureSize.x,1.0/UserUniforms.inputTextureSize.y,UserUniforms.inputTextureSize.x,UserUniforms.inputTextureSize.y);
float2 e=float2(1.0,0.0);
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
float l9_0=texcoord.y;
float l9_1=end;
bool l9_2=l9_0>l9_1;
bool l9_3;
if (l9_2)
{
l9_3=e.x>0.82810003;
}
else
{
l9_3=l9_2;
}
bool l9_4;
if (l9_3)
{
l9_4=e.y==0.0;
}
else
{
l9_4=l9_3;
}
if (l9_4)
{
float2 param=edgesTexGetDims2D(UserUniforms);
int param_1=edgesTexLayout;
int param_2=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_3=texcoord;
bool param_4=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_5=UserUniforms.edgesTexTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_7=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_8=UserUniforms.edgesTexUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_10=UserUniforms.edgesTexBorderColor;
float param_11=0.0;
float4 l9_5=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_6=l9_5;
float4 edgesTexSample=l9_5;
e=edgesTexSample.xy;
texcoord=(float2(-0.0,-2.0)*smaaRTMetrics.xy)+texcoord;
continue;
}
else
{
break;
}
}
float2 param_12=e.yx;
float param_13=0.5;
float offset=-(((-2.007874)*SMAASearchLength(param_12,param_13,UserUniforms,searchTex,searchTexSmpSC,sc_sysIn,sc_set0,sc_set1))+3.25);
return ((-smaaRTMetrics.y)*offset)+texcoord.y;
}
void SMAADetectVerticalCornerPattern(thread float2& weights,thread const float4& texcoord,thread const float2& d,constant userUniformsObj& UserUniforms,thread texture2d<float> edgesTex,thread sampler edgesTexSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int param=SMAA_QUALITY;
if (!smaaDisableDetection(param))
{
int param_1=SMAA_QUALITY;
float SMAA_CORNER_ROUNDING_NORM=float(smaaCornerRounding(param_1))/100.0;
float2 leftRight=step(d,d.yx);
float2 rounding=leftRight*(1.0-SMAA_CORNER_ROUNDING_NORM);
float4 smaaRTMetrics=float4(1.0/UserUniforms.inputTextureSize.x,1.0/UserUniforms.inputTextureSize.y,UserUniforms.inputTextureSize.x,UserUniforms.inputTextureSize.y);
rounding/=float2(leftRight.x+leftRight.y);
float2 factor=float2(1.0);
float2 param_2=texcoord.xy;
float2 param_3=float2(1.0,0.0);
float2 param_4=smaaRTMetrics.xy;
float2 param_5=edgesTexGetDims2D(UserUniforms);
int param_6=edgesTexLayout;
int param_7=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_8=calcSampleOffset(param_2,param_3,param_4);
bool param_9=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_10=UserUniforms.edgesTexTransform;
int2 param_11=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_12=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_13=UserUniforms.edgesTexUvMinMax;
bool param_14=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_15=UserUniforms.edgesTexBorderColor;
float param_16=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param_5,param_6,param_7,param_8,param_9,param_10,param_11,param_12,param_13,param_14,param_15,param_16);
float4 l9_1=l9_0;
float4 edgesTexSample=l9_0;
factor.x-=(rounding.x*edgesTexSample.y);
float2 param_17=texcoord.zw;
float2 param_18=float2(1.0,-1.0);
float2 param_19=smaaRTMetrics.xy;
float2 param_20=edgesTexGetDims2D(UserUniforms);
int param_21=edgesTexLayout;
int param_22=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_23=calcSampleOffset(param_17,param_18,param_19);
bool param_24=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_25=UserUniforms.edgesTexTransform;
int2 param_26=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_27=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_28=UserUniforms.edgesTexUvMinMax;
bool param_29=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_30=UserUniforms.edgesTexBorderColor;
float param_31=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param_20,param_21,param_22,param_23,param_24,param_25,param_26,param_27,param_28,param_29,param_30,param_31);
float4 l9_3=l9_2;
float4 edgesTexSample_1=l9_2;
factor.x-=(rounding.y*edgesTexSample_1.y);
float2 param_32=texcoord.xy;
float2 param_33=float2(2.0,0.0);
float2 param_34=smaaRTMetrics.xy;
float2 param_35=edgesTexGetDims2D(UserUniforms);
int param_36=edgesTexLayout;
int param_37=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_38=calcSampleOffset(param_32,param_33,param_34);
bool param_39=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_40=UserUniforms.edgesTexTransform;
int2 param_41=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_42=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_43=UserUniforms.edgesTexUvMinMax;
bool param_44=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_45=UserUniforms.edgesTexBorderColor;
float param_46=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param_35,param_36,param_37,param_38,param_39,param_40,param_41,param_42,param_43,param_44,param_45,param_46);
float4 l9_5=l9_4;
float4 edgesTexSample_2=l9_4;
factor.y-=(rounding.x*edgesTexSample_2.y);
float2 param_47=texcoord.zw;
float2 param_48=float2(-2.0,-1.0);
float2 param_49=smaaRTMetrics.xy;
float2 param_50=edgesTexGetDims2D(UserUniforms);
int param_51=edgesTexLayout;
int param_52=edgesTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_53=calcSampleOffset(param_47,param_48,param_49);
bool param_54=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_55=UserUniforms.edgesTexTransform;
int2 param_56=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_57=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_58=UserUniforms.edgesTexUvMinMax;
bool param_59=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_60=UserUniforms.edgesTexBorderColor;
float param_61=0.0;
float4 l9_6=sc_SampleTextureBiasOrLevel(edgesTex,edgesTexSmpSC,param_50,param_51,param_52,param_53,param_54,param_55,param_56,param_57,param_58,param_59,param_60,param_61);
float4 l9_7=l9_6;
float4 edgesTexSample_3=l9_6;
factor.y-=(rounding.y*edgesTexSample_3.y);
weights*=fast::clamp(factor,float2(0.0),float2(1.0));
}
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float4 weights=float4(0.0);
float4 subsampleIndices=float4(0.0);
float4 smaaRTMetrics=float4(1.0/(*sc_set2.UserUniforms).inputTextureSize.x,1.0/(*sc_set2.UserUniforms).inputTextureSize.y,(*sc_set2.UserUniforms).inputTextureSize.x,(*sc_set2.UserUniforms).inputTextureSize.y);
#if (DEBUG_MODE==5)
{
float2 param=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=inputTextureLayout;
int param_2=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=(int(SC_USE_UV_TRANSFORM_inputTexture)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).inputTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 inputTextureSample=l9_0;
float4 param_12=inputTextureSample;
sc_writeFragData0(param_12,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
#endif
float2 param_13=edgesTexGetDims2D((*sc_set2.UserUniforms));
int param_14=edgesTexLayout;
int param_15=edgesTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_16=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_17=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_18=(*sc_set2.UserUniforms).edgesTexTransform;
int2 param_19=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_20=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_21=(*sc_set2.UserUniforms).edgesTexUvMinMax;
bool param_22=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_23=(*sc_set2.UserUniforms).edgesTexBorderColor;
float param_24=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.edgesTex,sc_set2.edgesTexSmpSC,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23,param_24);
float4 l9_3=l9_2;
float4 edgesTexSample=l9_2;
float2 e=edgesTexSample.xy;
#if (DEBUG_MODE==6)
{
float2 param_25=edgesTexGetDims2D((*sc_set2.UserUniforms));
int param_26=edgesTexLayout;
int param_27=edgesTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_28=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_29=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_30=(*sc_set2.UserUniforms).edgesTexTransform;
int2 param_31=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_32=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_33=(*sc_set2.UserUniforms).edgesTexUvMinMax;
bool param_34=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_35=(*sc_set2.UserUniforms).edgesTexBorderColor;
float param_36=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(sc_set2.edgesTex,sc_set2.edgesTexSmpSC,param_25,param_26,param_27,param_28,param_29,param_30,param_31,param_32,param_33,param_34,param_35,param_36);
float4 l9_5=l9_4;
float4 edgesTexSample_1=l9_4;
float4 param_37=edgesTexSample_1;
sc_writeFragData0(param_37,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
#endif
if (e.y>0.0)
{
float2 param_38=sc_fragIn.sc_sysIn.varPackedTex.xy;
float2 param_39=e;
float4 param_40=subsampleIndices;
float2 l9_6=SMAACalculateDiagWeights(param_38,param_39,param_40,(*sc_set2.UserUniforms),sc_set2.edgesTex,sc_set2.edgesTexSmpSC,sc_set2.areaTex,sc_set2.areaTexSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
weights=float4(l9_6.x,l9_6.y,weights.z,weights.w);
float l9_7=weights.x;
float l9_8=weights.y;
bool l9_9=l9_7==(-l9_8);
bool l9_10;
if (!l9_9)
{
int param_41=SMAA_QUALITY;
l9_10=smaaDisableDetection(param_41);
}
else
{
l9_10=l9_9;
}
if (l9_10)
{
float2 param_42=sc_fragIn.varOffset0.xy;
float param_43=sc_fragIn.varOffset2.x;
float l9_11=SMAASearchXLeft(param_42,param_43,(*sc_set2.UserUniforms),sc_set2.edgesTex,sc_set2.edgesTexSmpSC,sc_set2.searchTex,sc_set2.searchTexSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float3 coords;
coords.x=l9_11;
coords.y=sc_fragIn.varOffset1.y;
float2 d;
d.x=coords.x;
float e1=0.0;
float2 param_44=edgesTexGetDims2D((*sc_set2.UserUniforms));
int param_45=edgesTexLayout;
int param_46=edgesTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_47=coords.xy;
bool param_48=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_49=(*sc_set2.UserUniforms).edgesTexTransform;
int2 param_50=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_51=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_52=(*sc_set2.UserUniforms).edgesTexUvMinMax;
bool param_53=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_54=(*sc_set2.UserUniforms).edgesTexBorderColor;
float param_55=0.0;
float4 l9_12=sc_SampleTextureBiasOrLevel(sc_set2.edgesTex,sc_set2.edgesTexSmpSC,param_44,param_45,param_46,param_47,param_48,param_49,param_50,param_51,param_52,param_53,param_54,param_55);
float4 l9_13=l9_12;
float4 edgesTexSample_2=l9_12;
e1=edgesTexSample_2.x;
float2 param_56=sc_fragIn.varOffset0.zw;
float param_57=sc_fragIn.varOffset2.y;
float l9_14=SMAASearchXRight(param_56,param_57,(*sc_set2.UserUniforms),sc_set2.edgesTex,sc_set2.edgesTexSmpSC,sc_set2.searchTex,sc_set2.searchTexSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
coords.z=l9_14;
d.y=coords.z;
d=abs(round((smaaRTMetrics.zz*d)-sc_fragIn.varPixCoord.xx));
float2 sqrt_d=sqrt(d);
float e2=0.0;
float2 param_58=coords.zy;
float2 param_59=float2(1.0,0.0);
float2 param_60=smaaRTMetrics.xy;
float2 param_61=edgesTexGetDims2D((*sc_set2.UserUniforms));
int param_62=edgesTexLayout;
int param_63=edgesTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_64=calcSampleOffset(param_58,param_59,param_60);
bool param_65=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_66=(*sc_set2.UserUniforms).edgesTexTransform;
int2 param_67=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_68=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_69=(*sc_set2.UserUniforms).edgesTexUvMinMax;
bool param_70=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_71=(*sc_set2.UserUniforms).edgesTexBorderColor;
float param_72=0.0;
float4 l9_15=sc_SampleTextureBiasOrLevel(sc_set2.edgesTex,sc_set2.edgesTexSmpSC,param_61,param_62,param_63,param_64,param_65,param_66,param_67,param_68,param_69,param_70,param_71,param_72);
float4 l9_16=l9_15;
float4 edgesTexSample_3=l9_15;
e2=edgesTexSample_3.x;
float2 param_73=sqrt_d;
float param_74=e1;
float param_75=e2;
float param_76=subsampleIndices.y;
float2 l9_17=SMAAArea(param_73,param_74,param_75,param_76,(*sc_set2.UserUniforms),sc_set2.areaTex,sc_set2.areaTexSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
weights=float4(l9_17.x,l9_17.y,weights.z,weights.w);
float4 param_77=weights;
float param_78=e1;
float param_79=e2;
float2 param_80=d;
weights=DebugColor(param_77,param_78,param_79,param_80);
coords.y=sc_fragIn.sc_sysIn.varPackedTex.y;
float2 param_81=weights.xy;
float4 param_82=coords.xyzy;
float2 param_83=d;
SMAADetectHorizontalCornerPattern(param_81,param_82,param_83,(*sc_set2.UserUniforms),sc_set2.edgesTex,sc_set2.edgesTexSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
weights=float4(param_81.x,param_81.y,weights.z,weights.w);
}
else
{
e.x=0.0;
}
}
if (e.x>0.0)
{
float2 param_84=sc_fragIn.varOffset1.xy;
float param_85=sc_fragIn.varOffset2.z;
float l9_18=SMAASearchYUp(param_84,param_85,(*sc_set2.UserUniforms),sc_set2.edgesTex,sc_set2.edgesTexSmpSC,sc_set2.searchTex,sc_set2.searchTexSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float3 coords_1;
coords_1.y=l9_18;
coords_1.x=sc_fragIn.varOffset0.x;
float2 d_1;
d_1.x=coords_1.y;
float e1_1=0.0;
float2 param_86=edgesTexGetDims2D((*sc_set2.UserUniforms));
int param_87=edgesTexLayout;
int param_88=edgesTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_89=coords_1.xy;
bool param_90=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_91=(*sc_set2.UserUniforms).edgesTexTransform;
int2 param_92=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_93=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_94=(*sc_set2.UserUniforms).edgesTexUvMinMax;
bool param_95=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_96=(*sc_set2.UserUniforms).edgesTexBorderColor;
float param_97=0.0;
float4 l9_19=sc_SampleTextureBiasOrLevel(sc_set2.edgesTex,sc_set2.edgesTexSmpSC,param_86,param_87,param_88,param_89,param_90,param_91,param_92,param_93,param_94,param_95,param_96,param_97);
float4 l9_20=l9_19;
float4 edgesTexSample_4=l9_19;
e1_1=edgesTexSample_4.y;
float2 param_98=sc_fragIn.varOffset1.zw;
float param_99=sc_fragIn.varOffset2.w;
float l9_21=SMAASearchYDown(param_98,param_99,(*sc_set2.UserUniforms),sc_set2.edgesTex,sc_set2.edgesTexSmpSC,sc_set2.searchTex,sc_set2.searchTexSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
coords_1.z=l9_21;
d_1.y=coords_1.z;
d_1=abs(round((smaaRTMetrics.ww*d_1)-sc_fragIn.varPixCoord.yy));
float2 sqrt_d_1=sqrt(d_1);
float e2_1=0.0;
float2 param_100=coords_1.xz;
float2 param_101=float2(0.0,-1.0);
float2 param_102=smaaRTMetrics.xy;
float2 param_103=edgesTexGetDims2D((*sc_set2.UserUniforms));
int param_104=edgesTexLayout;
int param_105=edgesTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_106=calcSampleOffset(param_100,param_101,param_102);
bool param_107=(int(SC_USE_UV_TRANSFORM_edgesTex)!=0);
float3x3 param_108=(*sc_set2.UserUniforms).edgesTexTransform;
int2 param_109=int2(SC_SOFTWARE_WRAP_MODE_U_edgesTex,SC_SOFTWARE_WRAP_MODE_V_edgesTex);
bool param_110=(int(SC_USE_UV_MIN_MAX_edgesTex)!=0);
float4 param_111=(*sc_set2.UserUniforms).edgesTexUvMinMax;
bool param_112=(int(SC_USE_CLAMP_TO_BORDER_edgesTex)!=0);
float4 param_113=(*sc_set2.UserUniforms).edgesTexBorderColor;
float param_114=0.0;
float4 l9_22=sc_SampleTextureBiasOrLevel(sc_set2.edgesTex,sc_set2.edgesTexSmpSC,param_103,param_104,param_105,param_106,param_107,param_108,param_109,param_110,param_111,param_112,param_113,param_114);
float4 l9_23=l9_22;
float4 edgesTexSample_5=l9_22;
e2_1=edgesTexSample_5.y;
float2 param_115=sqrt_d_1;
float param_116=e1_1;
float param_117=e2_1;
float param_118=subsampleIndices.x;
float2 l9_24=SMAAArea(param_115,param_116,param_117,param_118,(*sc_set2.UserUniforms),sc_set2.areaTex,sc_set2.areaTexSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
weights=float4(weights.x,weights.y,l9_24.x,l9_24.y);
float4 param_119=weights;
float param_120=e1_1;
float param_121=e2_1;
float2 param_122=d_1;
weights=DebugColor(param_119,param_120,param_121,param_122);
coords_1.x=sc_fragIn.sc_sysIn.varPackedTex.x;
float2 param_123=weights.zw;
float4 param_124=coords_1.xyxz;
float2 param_125=d_1;
SMAADetectVerticalCornerPattern(param_123,param_124,param_125,(*sc_set2.UserUniforms),sc_set2.edgesTex,sc_set2.edgesTexSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
weights=float4(weights.x,weights.y,param_123.x,param_123.y);
}
float4 param_126=weights;
sc_writeFragData0(param_126,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

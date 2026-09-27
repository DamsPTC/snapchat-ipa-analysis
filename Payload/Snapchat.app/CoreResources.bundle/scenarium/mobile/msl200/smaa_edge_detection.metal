#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE0 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "std2.metal"
#include "std2_texture.metal"
#include "std2_fs.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler inputTextureSmpSC 2:1
//texture texture2D inputTexture 2:0:2:1
//ubo float UserUniforms 2:2:128 {
//float4 inputTextureSize 0
//float4 inputTextureDims 16
//float4 inputTextureView 32
//float3x3 inputTextureTransform 48
//float4 inputTextureUvMinMax 96
//float4 inputTextureBorderColor 112
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
#ifndef SMAA_QUALITY
#define SMAA_QUALITY 0
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
float2 varTexCoords [[user(locn10)]];
float4 varOffset0 [[user(locn11)]];
float4 varOffset1 [[user(locn12)]];
float4 varOffset2 [[user(locn13)]];
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
sc_vertOut.varTexCoords=(v.position.xy*0.5)+float2(0.5);
float4 smaaRTMetrics=float4(1.0/(*sc_set2.UserUniforms).inputTextureSize.x,1.0/(*sc_set2.UserUniforms).inputTextureSize.y,(*sc_set2.UserUniforms).inputTextureSize.x,(*sc_set2.UserUniforms).inputTextureSize.y);
sc_vertOut.varOffset0=(smaaRTMetrics.xyxy*float4(-1.0,0.0,0.0,1.0))+sc_vertOut.varTexCoords.xyxy;
sc_vertOut.varOffset1=(smaaRTMetrics.xyxy*float4(1.0,0.0,0.0,-1.0))+sc_vertOut.varTexCoords.xyxy;
sc_vertOut.varOffset2=(smaaRTMetrics.xyxy*float4(-2.0,0.0,0.0,2.0))+sc_vertOut.varTexCoords.xyxy;
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
#ifndef SMAA_QUALITY
#define SMAA_QUALITY 0
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
float2 varTexCoords [[user(locn10)]];
float4 varOffset0 [[user(locn11)]];
float4 varOffset1 [[user(locn12)]];
float4 varOffset2 [[user(locn13)]];
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
float getThreshHold(thread const int& smaaQuality)
{
if (smaaQuality==0)
{
return 0.15000001;
}
else
{
if (smaaQuality==1)
{
return 0.1;
}
else
{
if (smaaQuality==2)
{
return 0.1;
}
else
{
if (smaaQuality==3)
{
return 0.050000001;
}
else
{
return 0.0;
}
}
}
}
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float3 weights=float3(0.21259999,0.71520001,0.0722);
float L=0.0;
float2 param=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=inputTextureLayout;
int param_2=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.varTexCoords;
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
L=dot(inputTextureSample.xyz,weights);
float Lleft=0.0;
float2 param_12=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_13=inputTextureLayout;
int param_14=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_15=sc_fragIn.varOffset0.xy;
bool param_16=(int(SC_USE_UV_TRANSFORM_inputTexture)!=0);
float3x3 param_17=(*sc_set2.UserUniforms).inputTextureTransform;
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_19=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_20=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_22=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_23=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_3=l9_2;
float4 inputTextureSample_1=l9_2;
Lleft=dot(inputTextureSample_1.xyz,weights);
float Ltop=0.0;
float2 param_24=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_25=inputTextureLayout;
int param_26=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_27=sc_fragIn.varOffset0.zw;
bool param_28=(int(SC_USE_UV_TRANSFORM_inputTexture)!=0);
float3x3 param_29=(*sc_set2.UserUniforms).inputTextureTransform;
int2 param_30=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_31=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_32=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_33=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_34=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_35=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param_24,param_25,param_26,param_27,param_28,param_29,param_30,param_31,param_32,param_33,param_34,param_35);
float4 l9_5=l9_4;
float4 inputTextureSample_2=l9_4;
Ltop=dot(inputTextureSample_2.xyz,weights);
float2 l9_6=abs(float2(L)-float2(Lleft,Ltop));
float4 delta;
delta=float4(l9_6.x,l9_6.y,delta.z,delta.w);
int param_36=SMAA_QUALITY;
float2 threshold=float2(getThreshHold(param_36));
float2 edges=step(threshold,delta.xy);
if (dot(edges,float2(1.0))==0.0)
{
float4 param_37=float4(0.0);
sc_writeFragData0(param_37,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
float Lright=0.0;
float2 param_38=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_39=inputTextureLayout;
int param_40=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_41=sc_fragIn.varOffset1.xy;
bool param_42=(int(SC_USE_UV_TRANSFORM_inputTexture)!=0);
float3x3 param_43=(*sc_set2.UserUniforms).inputTextureTransform;
int2 param_44=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_45=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_46=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_47=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_48=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_49=0.0;
float4 l9_7=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param_38,param_39,param_40,param_41,param_42,param_43,param_44,param_45,param_46,param_47,param_48,param_49);
float4 l9_8=l9_7;
float4 inputTextureSample_3=l9_7;
Lright=dot(inputTextureSample_3.xyz,weights);
float Lbottom=0.0;
float2 param_50=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_51=inputTextureLayout;
int param_52=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_53=sc_fragIn.varOffset1.zw;
bool param_54=(int(SC_USE_UV_TRANSFORM_inputTexture)!=0);
float3x3 param_55=(*sc_set2.UserUniforms).inputTextureTransform;
int2 param_56=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_57=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_58=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_59=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_60=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_61=0.0;
float4 l9_9=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param_50,param_51,param_52,param_53,param_54,param_55,param_56,param_57,param_58,param_59,param_60,param_61);
float4 l9_10=l9_9;
float4 inputTextureSample_4=l9_9;
Lbottom=dot(inputTextureSample_4.xyz,weights);
float2 l9_11=abs(float2(L)-float2(Lright,Lbottom));
delta=float4(delta.x,delta.y,l9_11.x,l9_11.y);
float2 maxDelta=fast::max(delta.xy,delta.zw);
float Lleftleft=0.0;
float2 param_62=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_63=inputTextureLayout;
int param_64=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_65=sc_fragIn.varOffset2.xy;
bool param_66=(int(SC_USE_UV_TRANSFORM_inputTexture)!=0);
float3x3 param_67=(*sc_set2.UserUniforms).inputTextureTransform;
int2 param_68=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_69=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_70=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_71=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_72=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_73=0.0;
float4 l9_12=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param_62,param_63,param_64,param_65,param_66,param_67,param_68,param_69,param_70,param_71,param_72,param_73);
float4 l9_13=l9_12;
float4 inputTextureSample_5=l9_12;
Lleftleft=dot(inputTextureSample_5.xyz,weights);
float Ltoptop=0.0;
float2 param_74=inputTextureGetDims2D((*sc_set2.UserUniforms));
int param_75=inputTextureLayout;
int param_76=inputTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_77=sc_fragIn.varOffset2.zw;
bool param_78=(int(SC_USE_UV_TRANSFORM_inputTexture)!=0);
float3x3 param_79=(*sc_set2.UserUniforms).inputTextureTransform;
int2 param_80=int2(SC_SOFTWARE_WRAP_MODE_U_inputTexture,SC_SOFTWARE_WRAP_MODE_V_inputTexture);
bool param_81=(int(SC_USE_UV_MIN_MAX_inputTexture)!=0);
float4 param_82=(*sc_set2.UserUniforms).inputTextureUvMinMax;
bool param_83=(int(SC_USE_CLAMP_TO_BORDER_inputTexture)!=0);
float4 param_84=(*sc_set2.UserUniforms).inputTextureBorderColor;
float param_85=0.0;
float4 l9_14=sc_SampleTextureBiasOrLevel(sc_set2.inputTexture,sc_set2.inputTextureSmpSC,param_74,param_75,param_76,param_77,param_78,param_79,param_80,param_81,param_82,param_83,param_84,param_85);
float4 l9_15=l9_14;
float4 inputTextureSample_6=l9_14;
Ltoptop=dot(inputTextureSample_6.xyz,weights);
float2 l9_16=abs(float2(Lleft,Ltop)-float2(Lleftleft,Ltoptop));
delta=float4(delta.x,delta.y,l9_16.x,l9_16.y);
maxDelta=fast::max(maxDelta,delta.zw);
float finalDelta=fast::max(maxDelta.x,maxDelta.y);
edges*=step(float2(finalDelta),delta.xy*2.0);
float4 param_86=float4(edges.x,edges.y,0.0,0.0);
sc_writeFragData0(param_86,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

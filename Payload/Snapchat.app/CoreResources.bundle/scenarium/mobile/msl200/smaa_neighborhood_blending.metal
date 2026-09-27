#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE0 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "std2.metal"
#include "std2_fs.metal"
#include "std2_texture.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler blendTexSmpSC 2:2
//sampler sampler inputTexSmpSC 2:3
//texture texture2D blendTex 2:0:2:2
//texture texture2D inputTex 2:1:2:3
//ubo float UserUniforms 2:4:272 {
//float4 blendTexSize 0
//float4 blendTexDims 16
//float4 blendTexView 32
//float3x3 blendTexTransform 48
//float4 blendTexUvMinMax 96
//float4 blendTexBorderColor 112
//float4 inputTexSize 128
//float4 inputTexDims 144
//float4 inputTexView 160
//float3x3 inputTexTransform 176
//float4 inputTexUvMinMax 224
//float4 inputTexBorderColor 240
//float2 inputRTSize 256
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 blendTexSize;
float4 blendTexDims;
float4 blendTexView;
float3x3 blendTexTransform;
float4 blendTexUvMinMax;
float4 blendTexBorderColor;
float4 inputTexSize;
float4 inputTexDims;
float4 inputTexView;
float3x3 inputTexTransform;
float4 inputTexUvMinMax;
float4 inputTexBorderColor;
float2 inputRTSize;
};
#ifndef blendTexHasSwappedViews
#define blendTexHasSwappedViews 0
#elif blendTexHasSwappedViews==1
#undef blendTexHasSwappedViews
#define blendTexHasSwappedViews 1
#endif
#ifndef blendTexLayout
#define blendTexLayout 0
#endif
#ifndef inputTexHasSwappedViews
#define inputTexHasSwappedViews 0
#elif inputTexHasSwappedViews==1
#undef inputTexHasSwappedViews
#define inputTexHasSwappedViews 1
#endif
#ifndef inputTexLayout
#define inputTexLayout 0
#endif
#ifndef SMAA_REPROJECTION
#define SMAA_REPROJECTION 0
#elif SMAA_REPROJECTION==1
#undef SMAA_REPROJECTION
#define SMAA_REPROJECTION 1
#endif
#ifndef blendTexUV
#define blendTexUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_blendTex
#define SC_USE_UV_TRANSFORM_blendTex 0
#elif SC_USE_UV_TRANSFORM_blendTex==1
#undef SC_USE_UV_TRANSFORM_blendTex
#define SC_USE_UV_TRANSFORM_blendTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_blendTex
#define SC_SOFTWARE_WRAP_MODE_U_blendTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_blendTex
#define SC_SOFTWARE_WRAP_MODE_V_blendTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_blendTex
#define SC_USE_UV_MIN_MAX_blendTex 0
#elif SC_USE_UV_MIN_MAX_blendTex==1
#undef SC_USE_UV_MIN_MAX_blendTex
#define SC_USE_UV_MIN_MAX_blendTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_blendTex
#define SC_USE_CLAMP_TO_BORDER_blendTex 0
#elif SC_USE_CLAMP_TO_BORDER_blendTex==1
#undef SC_USE_CLAMP_TO_BORDER_blendTex
#define SC_USE_CLAMP_TO_BORDER_blendTex 1
#endif
#ifndef inputTexUV
#define inputTexUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_inputTex
#define SC_USE_UV_TRANSFORM_inputTex 0
#elif SC_USE_UV_TRANSFORM_inputTex==1
#undef SC_USE_UV_TRANSFORM_inputTex
#define SC_USE_UV_TRANSFORM_inputTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_inputTex
#define SC_SOFTWARE_WRAP_MODE_U_inputTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_inputTex
#define SC_SOFTWARE_WRAP_MODE_V_inputTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_inputTex
#define SC_USE_UV_MIN_MAX_inputTex 0
#elif SC_USE_UV_MIN_MAX_inputTex==1
#undef SC_USE_UV_MIN_MAX_inputTex
#define SC_USE_UV_MIN_MAX_inputTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_inputTex
#define SC_USE_CLAMP_TO_BORDER_inputTex 0
#elif SC_USE_CLAMP_TO_BORDER_inputTex==1
#undef SC_USE_CLAMP_TO_BORDER_inputTex
#define SC_USE_CLAMP_TO_BORDER_inputTex 1
#endif
struct sc_Set2
{
texture2d<float> blendTex [[id(0)]];
texture2d<float> inputTex [[id(1)]];
sampler blendTexSmpSC [[id(2)]];
sampler inputTexSmpSC [[id(3)]];
constant userUniformsObj* UserUniforms [[id(4)]];
};
struct sc_VertOut
{
sc_SysOut sc_sysOut;
float4 smaaRTMetrics [[user(locn10)]];
float2 varTexCoords [[user(locn11)]];
float4 varOffset0 [[user(locn12)]];
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
sc_vertOut.smaaRTMetrics=float4(1.0/(*sc_set2.UserUniforms).inputRTSize.x,1.0/(*sc_set2.UserUniforms).inputRTSize.y,(*sc_set2.UserUniforms).inputRTSize.x,(*sc_set2.UserUniforms).inputRTSize.y);
sc_vertOut.varOffset0=(sc_vertOut.smaaRTMetrics.xyxy*float4(1.0,0.0,0.0,-1.0))+sc_vertOut.varTexCoords.xyxy;
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 blendTexSize;
float4 blendTexDims;
float4 blendTexView;
float3x3 blendTexTransform;
float4 blendTexUvMinMax;
float4 blendTexBorderColor;
float4 inputTexSize;
float4 inputTexDims;
float4 inputTexView;
float3x3 inputTexTransform;
float4 inputTexUvMinMax;
float4 inputTexBorderColor;
float2 inputRTSize;
};
#ifndef blendTexHasSwappedViews
#define blendTexHasSwappedViews 0
#elif blendTexHasSwappedViews==1
#undef blendTexHasSwappedViews
#define blendTexHasSwappedViews 1
#endif
#ifndef blendTexLayout
#define blendTexLayout 0
#endif
#ifndef inputTexHasSwappedViews
#define inputTexHasSwappedViews 0
#elif inputTexHasSwappedViews==1
#undef inputTexHasSwappedViews
#define inputTexHasSwappedViews 1
#endif
#ifndef inputTexLayout
#define inputTexLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_blendTex
#define SC_USE_UV_TRANSFORM_blendTex 0
#elif SC_USE_UV_TRANSFORM_blendTex==1
#undef SC_USE_UV_TRANSFORM_blendTex
#define SC_USE_UV_TRANSFORM_blendTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_blendTex
#define SC_SOFTWARE_WRAP_MODE_U_blendTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_blendTex
#define SC_SOFTWARE_WRAP_MODE_V_blendTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_blendTex
#define SC_USE_UV_MIN_MAX_blendTex 0
#elif SC_USE_UV_MIN_MAX_blendTex==1
#undef SC_USE_UV_MIN_MAX_blendTex
#define SC_USE_UV_MIN_MAX_blendTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_blendTex
#define SC_USE_CLAMP_TO_BORDER_blendTex 0
#elif SC_USE_CLAMP_TO_BORDER_blendTex==1
#undef SC_USE_CLAMP_TO_BORDER_blendTex
#define SC_USE_CLAMP_TO_BORDER_blendTex 1
#endif
#ifndef SC_USE_UV_TRANSFORM_inputTex
#define SC_USE_UV_TRANSFORM_inputTex 0
#elif SC_USE_UV_TRANSFORM_inputTex==1
#undef SC_USE_UV_TRANSFORM_inputTex
#define SC_USE_UV_TRANSFORM_inputTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_inputTex
#define SC_SOFTWARE_WRAP_MODE_U_inputTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_inputTex
#define SC_SOFTWARE_WRAP_MODE_V_inputTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_inputTex
#define SC_USE_UV_MIN_MAX_inputTex 0
#elif SC_USE_UV_MIN_MAX_inputTex==1
#undef SC_USE_UV_MIN_MAX_inputTex
#define SC_USE_UV_MIN_MAX_inputTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_inputTex
#define SC_USE_CLAMP_TO_BORDER_inputTex 0
#elif SC_USE_CLAMP_TO_BORDER_inputTex==1
#undef SC_USE_CLAMP_TO_BORDER_inputTex
#define SC_USE_CLAMP_TO_BORDER_inputTex 1
#endif
#ifndef SMAA_REPROJECTION
#define SMAA_REPROJECTION 0
#elif SMAA_REPROJECTION==1
#undef SMAA_REPROJECTION
#define SMAA_REPROJECTION 1
#endif
#ifndef blendTexUV
#define blendTexUV 0
#endif
#ifndef inputTexUV
#define inputTexUV 0
#endif
struct sc_Set2
{
texture2d<float> blendTex [[id(0)]];
texture2d<float> inputTex [[id(1)]];
sampler blendTexSmpSC [[id(2)]];
sampler inputTexSmpSC [[id(3)]];
constant userUniformsObj* UserUniforms [[id(4)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
float4 smaaRTMetrics [[user(locn10)]];
float2 varTexCoords [[user(locn11)]];
float4 varOffset0 [[user(locn12)]];
};
float2 blendTexGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.blendTexDims.xy;
}
int blendTexGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (blendTexHasSwappedViews)
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
float2 inputTexGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.inputTexDims.xy;
}
int inputTexGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (inputTexHasSwappedViews)
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
void SMAAMovc(thread const float4& cond,thread float4& variable,thread const float4& value)
{
float2 param=cond.xy;
float2 param_1=variable.xy;
float2 param_2=value.xy;
SMAAMovc(param,param_1,param_2);
variable=float4(param_1.x,param_1.y,variable.z,variable.w);
float2 param_3=cond.zw;
float2 param_4=variable.zw;
float2 param_5=value.zw;
SMAAMovc(param_3,param_4,param_5);
variable=float4(variable.x,variable.y,param_4.x,param_4.y);
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float4 a=float4(0.0);
float4 color=float4(0.0);
float2 param=blendTexGetDims2D((*sc_set2.UserUniforms));
int param_1=blendTexLayout;
int param_2=blendTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.varOffset0.xy;
bool param_4=(int(SC_USE_UV_TRANSFORM_blendTex)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).blendTexTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_blendTex,SC_SOFTWARE_WRAP_MODE_V_blendTex);
bool param_7=(int(SC_USE_UV_MIN_MAX_blendTex)!=0);
float4 param_8=(*sc_set2.UserUniforms).blendTexUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_blendTex)!=0);
float4 param_10=(*sc_set2.UserUniforms).blendTexBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.blendTex,sc_set2.blendTexSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 blendTexSample=l9_0;
a.x=blendTexSample.w;
float2 param_12=blendTexGetDims2D((*sc_set2.UserUniforms));
int param_13=blendTexLayout;
int param_14=blendTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_15=sc_fragIn.varOffset0.zw;
bool param_16=(int(SC_USE_UV_TRANSFORM_blendTex)!=0);
float3x3 param_17=(*sc_set2.UserUniforms).blendTexTransform;
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_blendTex,SC_SOFTWARE_WRAP_MODE_V_blendTex);
bool param_19=(int(SC_USE_UV_MIN_MAX_blendTex)!=0);
float4 param_20=(*sc_set2.UserUniforms).blendTexUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_blendTex)!=0);
float4 param_22=(*sc_set2.UserUniforms).blendTexBorderColor;
float param_23=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.blendTex,sc_set2.blendTexSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_3=l9_2;
float4 blendTexSample_1=l9_2;
a.y=blendTexSample_1.y;
float2 param_24=blendTexGetDims2D((*sc_set2.UserUniforms));
int param_25=blendTexLayout;
int param_26=blendTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_27=sc_fragIn.varTexCoords;
bool param_28=(int(SC_USE_UV_TRANSFORM_blendTex)!=0);
float3x3 param_29=(*sc_set2.UserUniforms).blendTexTransform;
int2 param_30=int2(SC_SOFTWARE_WRAP_MODE_U_blendTex,SC_SOFTWARE_WRAP_MODE_V_blendTex);
bool param_31=(int(SC_USE_UV_MIN_MAX_blendTex)!=0);
float4 param_32=(*sc_set2.UserUniforms).blendTexUvMinMax;
bool param_33=(int(SC_USE_CLAMP_TO_BORDER_blendTex)!=0);
float4 param_34=(*sc_set2.UserUniforms).blendTexBorderColor;
float param_35=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(sc_set2.blendTex,sc_set2.blendTexSmpSC,param_24,param_25,param_26,param_27,param_28,param_29,param_30,param_31,param_32,param_33,param_34,param_35);
float4 l9_5=l9_4;
float4 blendTexSample_2=l9_4;
a=float4(a.x,a.y,blendTexSample_2.xz.y,blendTexSample_2.xz.x);
if (dot(a,float4(1.0))<9.9999997e-06)
{
float2 param_36=inputTexGetDims2D((*sc_set2.UserUniforms));
int param_37=inputTexLayout;
int param_38=inputTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_39=sc_fragIn.varTexCoords;
bool param_40=(int(SC_USE_UV_TRANSFORM_inputTex)!=0);
float3x3 param_41=(*sc_set2.UserUniforms).inputTexTransform;
int2 param_42=int2(SC_SOFTWARE_WRAP_MODE_U_inputTex,SC_SOFTWARE_WRAP_MODE_V_inputTex);
bool param_43=(int(SC_USE_UV_MIN_MAX_inputTex)!=0);
float4 param_44=(*sc_set2.UserUniforms).inputTexUvMinMax;
bool param_45=(int(SC_USE_CLAMP_TO_BORDER_inputTex)!=0);
float4 param_46=(*sc_set2.UserUniforms).inputTexBorderColor;
float param_47=0.0;
float4 l9_6=sc_SampleTextureBiasOrLevel(sc_set2.inputTex,sc_set2.inputTexSmpSC,param_36,param_37,param_38,param_39,param_40,param_41,param_42,param_43,param_44,param_45,param_46,param_47);
float4 l9_7=l9_6;
float4 inputTexSample=l9_6;
#if (SMAA_REPROJECTION)
{
}
#endif
color=inputTexSample;
}
else
{
float h=float(fast::max(a.x,a.z)>fast::max(a.y,a.w));
float4 blendingOffset=float4(0.0,a.y,0.0,a.w);
float2 blendingWeight=a.yw;
float4 param_48=float4(h,h,h,h);
float4 param_49=blendingOffset;
float4 param_50=float4(a.x,0.0,a.z,0.0);
SMAAMovc(param_48,param_49,param_50);
blendingOffset=param_49;
float2 param_51=float2(h,h);
float2 param_52=blendingWeight;
float2 param_53=a.xz;
SMAAMovc(param_51,param_52,param_53);
blendingWeight=param_52;
blendingWeight/=float2(dot(blendingWeight,float2(1.0)));
float4 blendingCoord=(blendingOffset*float4(sc_fragIn.smaaRTMetrics.x,-sc_fragIn.smaaRTMetrics.y,-sc_fragIn.smaaRTMetrics.x,sc_fragIn.smaaRTMetrics.y))+sc_fragIn.varTexCoords.xyxy;
float2 param_54=inputTexGetDims2D((*sc_set2.UserUniforms));
int param_55=inputTexLayout;
int param_56=inputTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_57=blendingCoord.xy;
bool param_58=(int(SC_USE_UV_TRANSFORM_inputTex)!=0);
float3x3 param_59=(*sc_set2.UserUniforms).inputTexTransform;
int2 param_60=int2(SC_SOFTWARE_WRAP_MODE_U_inputTex,SC_SOFTWARE_WRAP_MODE_V_inputTex);
bool param_61=(int(SC_USE_UV_MIN_MAX_inputTex)!=0);
float4 param_62=(*sc_set2.UserUniforms).inputTexUvMinMax;
bool param_63=(int(SC_USE_CLAMP_TO_BORDER_inputTex)!=0);
float4 param_64=(*sc_set2.UserUniforms).inputTexBorderColor;
float param_65=0.0;
float4 l9_8=sc_SampleTextureBiasOrLevel(sc_set2.inputTex,sc_set2.inputTexSmpSC,param_54,param_55,param_56,param_57,param_58,param_59,param_60,param_61,param_62,param_63,param_64,param_65);
float4 l9_9=l9_8;
float4 inputTexSample_1=l9_8;
color=inputTexSample_1*blendingWeight.x;
float2 param_66=inputTexGetDims2D((*sc_set2.UserUniforms));
int param_67=inputTexLayout;
int param_68=inputTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_69=blendingCoord.zw;
bool param_70=(int(SC_USE_UV_TRANSFORM_inputTex)!=0);
float3x3 param_71=(*sc_set2.UserUniforms).inputTexTransform;
int2 param_72=int2(SC_SOFTWARE_WRAP_MODE_U_inputTex,SC_SOFTWARE_WRAP_MODE_V_inputTex);
bool param_73=(int(SC_USE_UV_MIN_MAX_inputTex)!=0);
float4 param_74=(*sc_set2.UserUniforms).inputTexUvMinMax;
bool param_75=(int(SC_USE_CLAMP_TO_BORDER_inputTex)!=0);
float4 param_76=(*sc_set2.UserUniforms).inputTexBorderColor;
float param_77=0.0;
float4 l9_10=sc_SampleTextureBiasOrLevel(sc_set2.inputTex,sc_set2.inputTexSmpSC,param_66,param_67,param_68,param_69,param_70,param_71,param_72,param_73,param_74,param_75,param_76,param_77);
float4 l9_11=l9_10;
float4 inputTexSample_2=l9_10;
color+=(inputTexSample_2*blendingWeight.y);
#if (SMAA_REPROJECTION)
{
}
#endif
}
float4 param_78=color;
sc_writeFragData0(param_78,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

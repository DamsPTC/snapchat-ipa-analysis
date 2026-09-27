#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "std2.metal"
#include "std2_vs.metal"
#include "std2_fs.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler mainTextureSmpSC 2:1
//texture texture2D mainTexture 2:0:2:1
//ubo float UserUniforms 2:2:128 {
//float4 mainTextureSize 0
//float4 mainTextureDims 16
//float4 mainTextureView 32
//float3x3 mainTextureTransform 48
//float4 mainTextureUvMinMax 96
//float4 mainTextureBorderColor 112
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 mainTextureSize;
float4 mainTextureDims;
float4 mainTextureView;
float3x3 mainTextureTransform;
float4 mainTextureUvMinMax;
float4 mainTextureBorderColor;
};
#ifndef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 0
#elif mainTextureHasSwappedViews==1
#undef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 1
#endif
#ifndef mainTextureLayout
#define mainTextureLayout 0
#endif
#ifndef DEPTH_BLUR
#define DEPTH_BLUR 0
#elif DEPTH_BLUR==1
#undef DEPTH_BLUR
#define DEPTH_BLUR 1
#endif
#ifndef mainTextureUV
#define mainTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_mainTexture
#define SC_USE_UV_TRANSFORM_mainTexture 0
#elif SC_USE_UV_TRANSFORM_mainTexture==1
#undef SC_USE_UV_TRANSFORM_mainTexture
#define SC_USE_UV_TRANSFORM_mainTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_mainTexture
#define SC_SOFTWARE_WRAP_MODE_U_mainTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_mainTexture
#define SC_SOFTWARE_WRAP_MODE_V_mainTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_mainTexture
#define SC_USE_UV_MIN_MAX_mainTexture 0
#elif SC_USE_UV_MIN_MAX_mainTexture==1
#undef SC_USE_UV_MIN_MAX_mainTexture
#define SC_USE_UV_MIN_MAX_mainTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_mainTexture
#define SC_USE_CLAMP_TO_BORDER_mainTexture 0
#elif SC_USE_CLAMP_TO_BORDER_mainTexture==1
#undef SC_USE_CLAMP_TO_BORDER_mainTexture
#define SC_USE_CLAMP_TO_BORDER_mainTexture 1
#endif
struct sc_Set2
{
texture2d<float> mainTexture [[id(0)]];
sampler mainTextureSmpSC [[id(1)]];
constant userUniformsObj* UserUniforms [[id(2)]];
};
struct sc_VertOut
{
sc_SysOut sc_sysOut;
float2 blurCoordinates_0 [[user(locn10)]];
float2 blurCoordinates_1 [[user(locn11)]];
float2 blurCoordinates_2 [[user(locn12)]];
float2 blurCoordinates_3 [[user(locn13)]];
float2 blurCoordinates_4 [[user(locn14)]];
float2 blurCoordinates_5 [[user(locn15)]];
float2 blurCoordinates_6 [[user(locn16)]];
float2 blurCoordinates_7 [[user(locn17)]];
float2 blurCoordinates_8 [[user(locn18)]];
};
struct sc_VertIn
{
sc_SysAttributes sc_sysAttributes;
};
void setBlurCoordinates(thread const float2& texCoords,thread const float4& size,thread float2 (&blurCoordinates)[9])
{
blurCoordinates[0]=texCoords+float2(0.0*size.z,0.0*size.w);
blurCoordinates[1]=texCoords+float2(1.182426*size.z,0.0*size.w);
blurCoordinates[2]=texCoords+float2(0.0*size.z,1.182426*size.w);
blurCoordinates[3]=texCoords+float2((-1.182426)*size.z,0.0*size.w);
blurCoordinates[4]=texCoords+float2(0.0*size.z,(-1.182426)*size.w);
blurCoordinates[5]=texCoords+float2(1.182426*size.z,1.182426*size.w);
blurCoordinates[6]=texCoords+float2((-1.182426)*size.z,1.182426*size.w);
blurCoordinates[7]=texCoords+float2((-1.182426)*size.z,(-1.182426)*size.w);
blurCoordinates[8]=texCoords+float2(1.182426*size.z,(-1.182426)*size.w);
}
vertex sc_VertOut main_vert(sc_VertIn sc_vertIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],uint gl_InstanceIndex [[instance_id]],uint gl_VertexIndex [[vertex_id]])
{
sc_SysIn sc_sysIn;
sc_sysIn.sc_sysAttributes=sc_vertIn.sc_sysAttributes;
sc_sysIn.gl_VertexIndex=gl_VertexIndex;
sc_sysIn.gl_InstanceIndex=gl_InstanceIndex;
sc_VertOut sc_vertOut={};
float2 blurCoordinates[9]={};
sc_Vertex_t v=sc_LoadVertexAttributes(sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
float2 param=v.texture0;
float4 param_1=(*sc_set2.UserUniforms).mainTextureSize;
setBlurCoordinates(param,param_1,blurCoordinates);
sc_Vertex_t param_2=v;
sc_ProcessVertex(param_2,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
sc_vertOut.blurCoordinates_0=blurCoordinates[0];
sc_vertOut.blurCoordinates_1=blurCoordinates[1];
sc_vertOut.blurCoordinates_2=blurCoordinates[2];
sc_vertOut.blurCoordinates_3=blurCoordinates[3];
sc_vertOut.blurCoordinates_4=blurCoordinates[4];
sc_vertOut.blurCoordinates_5=blurCoordinates[5];
sc_vertOut.blurCoordinates_6=blurCoordinates[6];
sc_vertOut.blurCoordinates_7=blurCoordinates[7];
sc_vertOut.blurCoordinates_8=blurCoordinates[8];
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 mainTextureSize;
float4 mainTextureDims;
float4 mainTextureView;
float3x3 mainTextureTransform;
float4 mainTextureUvMinMax;
float4 mainTextureBorderColor;
};
#ifndef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 0
#elif mainTextureHasSwappedViews==1
#undef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 1
#endif
#ifndef mainTextureLayout
#define mainTextureLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_mainTexture
#define SC_USE_UV_TRANSFORM_mainTexture 0
#elif SC_USE_UV_TRANSFORM_mainTexture==1
#undef SC_USE_UV_TRANSFORM_mainTexture
#define SC_USE_UV_TRANSFORM_mainTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_mainTexture
#define SC_SOFTWARE_WRAP_MODE_U_mainTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_mainTexture
#define SC_SOFTWARE_WRAP_MODE_V_mainTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_mainTexture
#define SC_USE_UV_MIN_MAX_mainTexture 0
#elif SC_USE_UV_MIN_MAX_mainTexture==1
#undef SC_USE_UV_MIN_MAX_mainTexture
#define SC_USE_UV_MIN_MAX_mainTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_mainTexture
#define SC_USE_CLAMP_TO_BORDER_mainTexture 0
#elif SC_USE_CLAMP_TO_BORDER_mainTexture==1
#undef SC_USE_CLAMP_TO_BORDER_mainTexture
#define SC_USE_CLAMP_TO_BORDER_mainTexture 1
#endif
#ifndef DEPTH_BLUR
#define DEPTH_BLUR 0
#elif DEPTH_BLUR==1
#undef DEPTH_BLUR
#define DEPTH_BLUR 1
#endif
#ifndef mainTextureUV
#define mainTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> mainTexture [[id(0)]];
sampler mainTextureSmpSC [[id(1)]];
constant userUniformsObj* UserUniforms [[id(2)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
float2 blurCoordinates_0 [[user(locn10)]];
float2 blurCoordinates_1 [[user(locn11)]];
float2 blurCoordinates_2 [[user(locn12)]];
float2 blurCoordinates_3 [[user(locn13)]];
float2 blurCoordinates_4 [[user(locn14)]];
float2 blurCoordinates_5 [[user(locn15)]];
float2 blurCoordinates_6 [[user(locn16)]];
float2 blurCoordinates_7 [[user(locn17)]];
float2 blurCoordinates_8 [[user(locn18)]];
};
float2 mainTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.mainTextureDims.xy;
}
int mainTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (mainTextureHasSwappedViews)
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
float decode2(thread const float2& rg)
{
return dot(rg,float2(1.0,0.0039215689));
}
float2 decodeSample(thread const float4& sampleValue)
{
float2 param=sampleValue.xy;
float2 param_1=sampleValue.zw;
return float2(decode2(param),decode2(param_1));
}
float2 blur_x_depth(constant userUniformsObj& UserUniforms,thread texture2d<float> mainTexture,thread sampler mainTextureSmpSC,thread float2 (&blurCoordinates)[9],thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 param=mainTextureGetDims2D(UserUniforms);
int param_1=mainTextureLayout;
int param_2=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_3=blurCoordinates[0];
bool param_4=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_5=UserUniforms.mainTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_8=UserUniforms.mainTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_10=UserUniforms.mainTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 param_12=l9_0;
float2 blurredColor=decodeSample(param_12)*0.162103;
float2 param_13=mainTextureGetDims2D(UserUniforms);
int param_14=mainTextureLayout;
int param_15=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_16=blurCoordinates[1];
bool param_17=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_18=UserUniforms.mainTextureTransform;
int2 param_19=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_20=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_21=UserUniforms.mainTextureUvMinMax;
bool param_22=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_23=UserUniforms.mainTextureBorderColor;
float param_24=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23,param_24);
float4 l9_3=l9_2;
float4 param_25=l9_2;
float2 param_26=mainTextureGetDims2D(UserUniforms);
int param_27=mainTextureLayout;
int param_28=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_29=blurCoordinates[2];
bool param_30=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_31=UserUniforms.mainTextureTransform;
int2 param_32=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_33=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_34=UserUniforms.mainTextureUvMinMax;
bool param_35=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_36=UserUniforms.mainTextureBorderColor;
float param_37=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_26,param_27,param_28,param_29,param_30,param_31,param_32,param_33,param_34,param_35,param_36,param_37);
float4 l9_5=l9_4;
float4 param_38=l9_4;
float2 param_39=mainTextureGetDims2D(UserUniforms);
int param_40=mainTextureLayout;
int param_41=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_42=blurCoordinates[3];
bool param_43=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_44=UserUniforms.mainTextureTransform;
int2 param_45=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_46=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_47=UserUniforms.mainTextureUvMinMax;
bool param_48=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_49=UserUniforms.mainTextureBorderColor;
float param_50=0.0;
float4 l9_6=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_39,param_40,param_41,param_42,param_43,param_44,param_45,param_46,param_47,param_48,param_49,param_50);
float4 l9_7=l9_6;
float4 param_51=l9_6;
float2 param_52=mainTextureGetDims2D(UserUniforms);
int param_53=mainTextureLayout;
int param_54=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_55=blurCoordinates[4];
bool param_56=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_57=UserUniforms.mainTextureTransform;
int2 param_58=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_59=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_60=UserUniforms.mainTextureUvMinMax;
bool param_61=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_62=UserUniforms.mainTextureBorderColor;
float param_63=0.0;
float4 l9_8=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_52,param_53,param_54,param_55,param_56,param_57,param_58,param_59,param_60,param_61,param_62,param_63);
float4 l9_9=l9_8;
float4 param_64=l9_8;
blurredColor+=((((decodeSample(param_25)+decodeSample(param_38))+decodeSample(param_51))+decodeSample(param_64))*0.120259);
float2 param_65=mainTextureGetDims2D(UserUniforms);
int param_66=mainTextureLayout;
int param_67=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_68=blurCoordinates[5];
bool param_69=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_70=UserUniforms.mainTextureTransform;
int2 param_71=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_72=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_73=UserUniforms.mainTextureUvMinMax;
bool param_74=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_75=UserUniforms.mainTextureBorderColor;
float param_76=0.0;
float4 l9_10=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_65,param_66,param_67,param_68,param_69,param_70,param_71,param_72,param_73,param_74,param_75,param_76);
float4 l9_11=l9_10;
float4 param_77=l9_10;
float2 param_78=mainTextureGetDims2D(UserUniforms);
int param_79=mainTextureLayout;
int param_80=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_81=blurCoordinates[6];
bool param_82=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_83=UserUniforms.mainTextureTransform;
int2 param_84=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_85=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_86=UserUniforms.mainTextureUvMinMax;
bool param_87=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_88=UserUniforms.mainTextureBorderColor;
float param_89=0.0;
float4 l9_12=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_78,param_79,param_80,param_81,param_82,param_83,param_84,param_85,param_86,param_87,param_88,param_89);
float4 l9_13=l9_12;
float4 param_90=l9_12;
float2 param_91=mainTextureGetDims2D(UserUniforms);
int param_92=mainTextureLayout;
int param_93=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_94=blurCoordinates[7];
bool param_95=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_96=UserUniforms.mainTextureTransform;
int2 param_97=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_98=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_99=UserUniforms.mainTextureUvMinMax;
bool param_100=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_101=UserUniforms.mainTextureBorderColor;
float param_102=0.0;
float4 l9_14=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_91,param_92,param_93,param_94,param_95,param_96,param_97,param_98,param_99,param_100,param_101,param_102);
float4 l9_15=l9_14;
float4 param_103=l9_14;
float2 param_104=mainTextureGetDims2D(UserUniforms);
int param_105=mainTextureLayout;
int param_106=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_107=blurCoordinates[8];
bool param_108=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_109=UserUniforms.mainTextureTransform;
int2 param_110=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_111=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_112=UserUniforms.mainTextureUvMinMax;
bool param_113=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_114=UserUniforms.mainTextureBorderColor;
float param_115=0.0;
float4 l9_16=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_104,param_105,param_106,param_107,param_108,param_109,param_110,param_111,param_112,param_113,param_114,param_115);
float4 l9_17=l9_16;
float4 param_116=l9_16;
blurredColor+=((((decodeSample(param_77)+decodeSample(param_90))+decodeSample(param_103))+decodeSample(param_116))*0.089216001);
return blurredColor;
}
float2 encode2(thread const float& v)
{
float2 enc=fract(float2(1.0,255.0)*v);
enc.x-=(enc.y/255.0);
return enc;
}
float4 blur_x(constant userUniformsObj& UserUniforms,thread texture2d<float> mainTexture,thread sampler mainTextureSmpSC,thread float2 (&blurCoordinates)[9],thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 param=mainTextureGetDims2D(UserUniforms);
int param_1=mainTextureLayout;
int param_2=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_3=blurCoordinates[0];
bool param_4=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_5=UserUniforms.mainTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_8=UserUniforms.mainTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_10=UserUniforms.mainTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 blurredColor=l9_0*0.162103;
float2 param_12=mainTextureGetDims2D(UserUniforms);
int param_13=mainTextureLayout;
int param_14=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_15=blurCoordinates[1];
bool param_16=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_17=UserUniforms.mainTextureTransform;
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_19=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_20=UserUniforms.mainTextureUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_22=UserUniforms.mainTextureBorderColor;
float param_23=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_3=l9_2;
float2 param_24=mainTextureGetDims2D(UserUniforms);
int param_25=mainTextureLayout;
int param_26=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_27=blurCoordinates[2];
bool param_28=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_29=UserUniforms.mainTextureTransform;
int2 param_30=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_31=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_32=UserUniforms.mainTextureUvMinMax;
bool param_33=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_34=UserUniforms.mainTextureBorderColor;
float param_35=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_24,param_25,param_26,param_27,param_28,param_29,param_30,param_31,param_32,param_33,param_34,param_35);
float4 l9_5=l9_4;
float2 param_36=mainTextureGetDims2D(UserUniforms);
int param_37=mainTextureLayout;
int param_38=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_39=blurCoordinates[3];
bool param_40=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_41=UserUniforms.mainTextureTransform;
int2 param_42=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_43=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_44=UserUniforms.mainTextureUvMinMax;
bool param_45=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_46=UserUniforms.mainTextureBorderColor;
float param_47=0.0;
float4 l9_6=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_36,param_37,param_38,param_39,param_40,param_41,param_42,param_43,param_44,param_45,param_46,param_47);
float4 l9_7=l9_6;
float2 param_48=mainTextureGetDims2D(UserUniforms);
int param_49=mainTextureLayout;
int param_50=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_51=blurCoordinates[4];
bool param_52=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_53=UserUniforms.mainTextureTransform;
int2 param_54=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_55=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_56=UserUniforms.mainTextureUvMinMax;
bool param_57=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_58=UserUniforms.mainTextureBorderColor;
float param_59=0.0;
float4 l9_8=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_48,param_49,param_50,param_51,param_52,param_53,param_54,param_55,param_56,param_57,param_58,param_59);
float4 l9_9=l9_8;
blurredColor+=((((l9_2+l9_4)+l9_6)+l9_8)*0.120259);
float2 param_60=mainTextureGetDims2D(UserUniforms);
int param_61=mainTextureLayout;
int param_62=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_63=blurCoordinates[5];
bool param_64=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_65=UserUniforms.mainTextureTransform;
int2 param_66=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_67=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_68=UserUniforms.mainTextureUvMinMax;
bool param_69=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_70=UserUniforms.mainTextureBorderColor;
float param_71=0.0;
float4 l9_10=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_60,param_61,param_62,param_63,param_64,param_65,param_66,param_67,param_68,param_69,param_70,param_71);
float4 l9_11=l9_10;
float2 param_72=mainTextureGetDims2D(UserUniforms);
int param_73=mainTextureLayout;
int param_74=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_75=blurCoordinates[6];
bool param_76=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_77=UserUniforms.mainTextureTransform;
int2 param_78=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_79=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_80=UserUniforms.mainTextureUvMinMax;
bool param_81=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_82=UserUniforms.mainTextureBorderColor;
float param_83=0.0;
float4 l9_12=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_72,param_73,param_74,param_75,param_76,param_77,param_78,param_79,param_80,param_81,param_82,param_83);
float4 l9_13=l9_12;
float2 param_84=mainTextureGetDims2D(UserUniforms);
int param_85=mainTextureLayout;
int param_86=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_87=blurCoordinates[7];
bool param_88=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_89=UserUniforms.mainTextureTransform;
int2 param_90=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_91=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_92=UserUniforms.mainTextureUvMinMax;
bool param_93=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_94=UserUniforms.mainTextureBorderColor;
float param_95=0.0;
float4 l9_14=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_84,param_85,param_86,param_87,param_88,param_89,param_90,param_91,param_92,param_93,param_94,param_95);
float4 l9_15=l9_14;
float2 param_96=mainTextureGetDims2D(UserUniforms);
int param_97=mainTextureLayout;
int param_98=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_99=blurCoordinates[8];
bool param_100=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_101=UserUniforms.mainTextureTransform;
int2 param_102=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_103=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_104=UserUniforms.mainTextureUvMinMax;
bool param_105=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_106=UserUniforms.mainTextureBorderColor;
float param_107=0.0;
float4 l9_16=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_96,param_97,param_98,param_99,param_100,param_101,param_102,param_103,param_104,param_105,param_106,param_107);
float4 l9_17=l9_16;
blurredColor+=((((l9_10+l9_12)+l9_14)+l9_16)*0.089216001);
return blurredColor;
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
float2 blurCoordinates[9]={};
blurCoordinates[0]=sc_fragIn.blurCoordinates_0;
blurCoordinates[1]=sc_fragIn.blurCoordinates_1;
blurCoordinates[2]=sc_fragIn.blurCoordinates_2;
blurCoordinates[3]=sc_fragIn.blurCoordinates_3;
blurCoordinates[4]=sc_fragIn.blurCoordinates_4;
blurCoordinates[5]=sc_fragIn.blurCoordinates_5;
blurCoordinates[6]=sc_fragIn.blurCoordinates_6;
blurCoordinates[7]=sc_fragIn.blurCoordinates_7;
blurCoordinates[8]=sc_fragIn.blurCoordinates_8;
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float4 result;
#if (DEPTH_BLUR)
{
float2 blurValue=blur_x_depth((*sc_set2.UserUniforms),sc_set2.mainTexture,sc_set2.mainTextureSmpSC,blurCoordinates,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float param=blurValue.x;
float param_1=blurValue.y;
result=float4(encode2(param),encode2(param_1));
}
#else
{
result=blur_x((*sc_set2.UserUniforms),sc_set2.mainTexture,sc_set2.mainTextureSmpSC,blurCoordinates,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
}
#endif
float4 param_2=result;
sc_writeFragData0(param_2,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

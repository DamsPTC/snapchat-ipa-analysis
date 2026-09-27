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
float2 blurCoordinates_9 [[user(locn19)]];
float2 blurCoordinates_10 [[user(locn20)]];
float2 blurCoordinates_11 [[user(locn21)]];
float2 blurCoordinates_12 [[user(locn22)]];
float2 blurCoordinates_13 [[user(locn23)]];
float2 blurCoordinates_14 [[user(locn24)]];
float2 blurCoordinates_15 [[user(locn25)]];
float2 blurCoordinates_16 [[user(locn26)]];
float2 blurCoordinates_17 [[user(locn27)]];
float2 blurCoordinates_18 [[user(locn28)]];
float2 blurCoordinates_19 [[user(locn29)]];
float2 blurCoordinates_20 [[user(locn30)]];
float2 blurCoordinates_21 [[user(locn31)]];
float2 blurCoordinates_22 [[user(locn32)]];
float2 blurCoordinates_23 [[user(locn33)]];
float2 blurCoordinates_24 [[user(locn34)]];
};
struct sc_VertIn
{
sc_SysAttributes sc_sysAttributes;
};
void setBlurCoordinates(thread const float2& texCoords,thread const float4& size,thread float2 (&blurCoordinates)[25])
{
blurCoordinates[0]=texCoords+float2((-10.0)*size.z,(-10.0)*size.w);
blurCoordinates[1]=texCoords+float2((-10.0)*size.z,(-5.0)*size.w);
blurCoordinates[2]=texCoords+float2((-10.0)*size.z,0.0*size.w);
blurCoordinates[3]=texCoords+float2((-10.0)*size.z,5.0*size.w);
blurCoordinates[4]=texCoords+float2((-10.0)*size.z,10.0*size.w);
blurCoordinates[5]=texCoords+float2((-5.0)*size.z,(-10.0)*size.w);
blurCoordinates[6]=texCoords+float2((-5.0)*size.z,(-5.0)*size.w);
blurCoordinates[7]=texCoords+float2((-5.0)*size.z,0.0*size.w);
blurCoordinates[8]=texCoords+float2((-5.0)*size.z,5.0*size.w);
blurCoordinates[9]=texCoords+float2((-5.0)*size.z,10.0*size.w);
blurCoordinates[10]=texCoords+float2(0.0*size.z,(-10.0)*size.w);
blurCoordinates[11]=texCoords+float2(0.0*size.z,(-5.0)*size.w);
blurCoordinates[12]=texCoords+float2(0.0*size.z,0.0*size.w);
blurCoordinates[13]=texCoords+float2(0.0*size.z,5.0*size.w);
blurCoordinates[14]=texCoords+float2(0.0*size.z,10.0*size.w);
blurCoordinates[15]=texCoords+float2(5.0*size.z,(-10.0)*size.w);
blurCoordinates[16]=texCoords+float2(5.0*size.z,(-5.0)*size.w);
blurCoordinates[17]=texCoords+float2(5.0*size.z,0.0*size.w);
blurCoordinates[18]=texCoords+float2(5.0*size.z,5.0*size.w);
blurCoordinates[19]=texCoords+float2(5.0*size.z,10.0*size.w);
blurCoordinates[20]=texCoords+float2(10.0*size.z,(-10.0)*size.w);
blurCoordinates[21]=texCoords+float2(10.0*size.z,(-5.0)*size.w);
blurCoordinates[22]=texCoords+float2(10.0*size.z,0.0*size.w);
blurCoordinates[23]=texCoords+float2(10.0*size.z,5.0*size.w);
blurCoordinates[24]=texCoords+float2(10.0*size.z,10.0*size.w);
}
vertex sc_VertOut main_vert(sc_VertIn sc_vertIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],uint gl_InstanceIndex [[instance_id]],uint gl_VertexIndex [[vertex_id]])
{
sc_SysIn sc_sysIn;
sc_sysIn.sc_sysAttributes=sc_vertIn.sc_sysAttributes;
sc_sysIn.gl_VertexIndex=gl_VertexIndex;
sc_sysIn.gl_InstanceIndex=gl_InstanceIndex;
sc_VertOut sc_vertOut={};
float2 blurCoordinates[25]={};
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
sc_vertOut.blurCoordinates_9=blurCoordinates[9];
sc_vertOut.blurCoordinates_10=blurCoordinates[10];
sc_vertOut.blurCoordinates_11=blurCoordinates[11];
sc_vertOut.blurCoordinates_12=blurCoordinates[12];
sc_vertOut.blurCoordinates_13=blurCoordinates[13];
sc_vertOut.blurCoordinates_14=blurCoordinates[14];
sc_vertOut.blurCoordinates_15=blurCoordinates[15];
sc_vertOut.blurCoordinates_16=blurCoordinates[16];
sc_vertOut.blurCoordinates_17=blurCoordinates[17];
sc_vertOut.blurCoordinates_18=blurCoordinates[18];
sc_vertOut.blurCoordinates_19=blurCoordinates[19];
sc_vertOut.blurCoordinates_20=blurCoordinates[20];
sc_vertOut.blurCoordinates_21=blurCoordinates[21];
sc_vertOut.blurCoordinates_22=blurCoordinates[22];
sc_vertOut.blurCoordinates_23=blurCoordinates[23];
sc_vertOut.blurCoordinates_24=blurCoordinates[24];
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
float2 blurCoordinates_9 [[user(locn19)]];
float2 blurCoordinates_10 [[user(locn20)]];
float2 blurCoordinates_11 [[user(locn21)]];
float2 blurCoordinates_12 [[user(locn22)]];
float2 blurCoordinates_13 [[user(locn23)]];
float2 blurCoordinates_14 [[user(locn24)]];
float2 blurCoordinates_15 [[user(locn25)]];
float2 blurCoordinates_16 [[user(locn26)]];
float2 blurCoordinates_17 [[user(locn27)]];
float2 blurCoordinates_18 [[user(locn28)]];
float2 blurCoordinates_19 [[user(locn29)]];
float2 blurCoordinates_20 [[user(locn30)]];
float2 blurCoordinates_21 [[user(locn31)]];
float2 blurCoordinates_22 [[user(locn32)]];
float2 blurCoordinates_23 [[user(locn33)]];
float2 blurCoordinates_24 [[user(locn34)]];
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
float2 blur_x_depth(constant userUniformsObj& UserUniforms,thread texture2d<float> mainTexture,thread sampler mainTextureSmpSC,thread float2 (&blurCoordinates)[25],thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
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
float2 blurredColor=decodeSample(param_12)/float2(25.0);
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
blurredColor+=(decodeSample(param_25)/float2(25.0));
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
blurredColor+=(decodeSample(param_38)/float2(25.0));
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
blurredColor+=(decodeSample(param_51)/float2(25.0));
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
blurredColor+=(decodeSample(param_64)/float2(25.0));
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
blurredColor+=(decodeSample(param_77)/float2(25.0));
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
blurredColor+=(decodeSample(param_90)/float2(25.0));
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
blurredColor+=(decodeSample(param_103)/float2(25.0));
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
blurredColor+=(decodeSample(param_116)/float2(25.0));
float2 param_117=mainTextureGetDims2D(UserUniforms);
int param_118=mainTextureLayout;
int param_119=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_120=blurCoordinates[9];
bool param_121=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_122=UserUniforms.mainTextureTransform;
int2 param_123=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_124=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_125=UserUniforms.mainTextureUvMinMax;
bool param_126=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_127=UserUniforms.mainTextureBorderColor;
float param_128=0.0;
float4 l9_18=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_117,param_118,param_119,param_120,param_121,param_122,param_123,param_124,param_125,param_126,param_127,param_128);
float4 l9_19=l9_18;
float4 param_129=l9_18;
blurredColor+=(decodeSample(param_129)/float2(25.0));
float2 param_130=mainTextureGetDims2D(UserUniforms);
int param_131=mainTextureLayout;
int param_132=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_133=blurCoordinates[10];
bool param_134=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_135=UserUniforms.mainTextureTransform;
int2 param_136=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_137=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_138=UserUniforms.mainTextureUvMinMax;
bool param_139=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_140=UserUniforms.mainTextureBorderColor;
float param_141=0.0;
float4 l9_20=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_130,param_131,param_132,param_133,param_134,param_135,param_136,param_137,param_138,param_139,param_140,param_141);
float4 l9_21=l9_20;
float4 param_142=l9_20;
blurredColor+=(decodeSample(param_142)/float2(25.0));
float2 param_143=mainTextureGetDims2D(UserUniforms);
int param_144=mainTextureLayout;
int param_145=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_146=blurCoordinates[11];
bool param_147=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_148=UserUniforms.mainTextureTransform;
int2 param_149=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_150=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_151=UserUniforms.mainTextureUvMinMax;
bool param_152=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_153=UserUniforms.mainTextureBorderColor;
float param_154=0.0;
float4 l9_22=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_143,param_144,param_145,param_146,param_147,param_148,param_149,param_150,param_151,param_152,param_153,param_154);
float4 l9_23=l9_22;
float4 param_155=l9_22;
blurredColor+=(decodeSample(param_155)/float2(25.0));
float2 param_156=mainTextureGetDims2D(UserUniforms);
int param_157=mainTextureLayout;
int param_158=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_159=blurCoordinates[12];
bool param_160=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_161=UserUniforms.mainTextureTransform;
int2 param_162=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_163=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_164=UserUniforms.mainTextureUvMinMax;
bool param_165=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_166=UserUniforms.mainTextureBorderColor;
float param_167=0.0;
float4 l9_24=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_156,param_157,param_158,param_159,param_160,param_161,param_162,param_163,param_164,param_165,param_166,param_167);
float4 l9_25=l9_24;
float4 param_168=l9_24;
blurredColor+=(decodeSample(param_168)/float2(25.0));
float2 param_169=mainTextureGetDims2D(UserUniforms);
int param_170=mainTextureLayout;
int param_171=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_172=blurCoordinates[13];
bool param_173=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_174=UserUniforms.mainTextureTransform;
int2 param_175=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_176=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_177=UserUniforms.mainTextureUvMinMax;
bool param_178=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_179=UserUniforms.mainTextureBorderColor;
float param_180=0.0;
float4 l9_26=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_169,param_170,param_171,param_172,param_173,param_174,param_175,param_176,param_177,param_178,param_179,param_180);
float4 l9_27=l9_26;
float4 param_181=l9_26;
blurredColor+=(decodeSample(param_181)/float2(25.0));
float2 param_182=mainTextureGetDims2D(UserUniforms);
int param_183=mainTextureLayout;
int param_184=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_185=blurCoordinates[14];
bool param_186=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_187=UserUniforms.mainTextureTransform;
int2 param_188=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_189=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_190=UserUniforms.mainTextureUvMinMax;
bool param_191=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_192=UserUniforms.mainTextureBorderColor;
float param_193=0.0;
float4 l9_28=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_182,param_183,param_184,param_185,param_186,param_187,param_188,param_189,param_190,param_191,param_192,param_193);
float4 l9_29=l9_28;
float4 param_194=l9_28;
blurredColor+=(decodeSample(param_194)/float2(25.0));
float2 param_195=mainTextureGetDims2D(UserUniforms);
int param_196=mainTextureLayout;
int param_197=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_198=blurCoordinates[15];
bool param_199=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_200=UserUniforms.mainTextureTransform;
int2 param_201=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_202=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_203=UserUniforms.mainTextureUvMinMax;
bool param_204=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_205=UserUniforms.mainTextureBorderColor;
float param_206=0.0;
float4 l9_30=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_195,param_196,param_197,param_198,param_199,param_200,param_201,param_202,param_203,param_204,param_205,param_206);
float4 l9_31=l9_30;
float4 param_207=l9_30;
blurredColor+=(decodeSample(param_207)/float2(25.0));
float2 param_208=mainTextureGetDims2D(UserUniforms);
int param_209=mainTextureLayout;
int param_210=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_211=blurCoordinates[16];
bool param_212=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_213=UserUniforms.mainTextureTransform;
int2 param_214=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_215=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_216=UserUniforms.mainTextureUvMinMax;
bool param_217=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_218=UserUniforms.mainTextureBorderColor;
float param_219=0.0;
float4 l9_32=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_208,param_209,param_210,param_211,param_212,param_213,param_214,param_215,param_216,param_217,param_218,param_219);
float4 l9_33=l9_32;
float4 param_220=l9_32;
blurredColor+=(decodeSample(param_220)/float2(25.0));
float2 param_221=mainTextureGetDims2D(UserUniforms);
int param_222=mainTextureLayout;
int param_223=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_224=blurCoordinates[17];
bool param_225=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_226=UserUniforms.mainTextureTransform;
int2 param_227=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_228=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_229=UserUniforms.mainTextureUvMinMax;
bool param_230=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_231=UserUniforms.mainTextureBorderColor;
float param_232=0.0;
float4 l9_34=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_221,param_222,param_223,param_224,param_225,param_226,param_227,param_228,param_229,param_230,param_231,param_232);
float4 l9_35=l9_34;
float4 param_233=l9_34;
blurredColor+=(decodeSample(param_233)/float2(25.0));
float2 param_234=mainTextureGetDims2D(UserUniforms);
int param_235=mainTextureLayout;
int param_236=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_237=blurCoordinates[18];
bool param_238=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_239=UserUniforms.mainTextureTransform;
int2 param_240=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_241=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_242=UserUniforms.mainTextureUvMinMax;
bool param_243=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_244=UserUniforms.mainTextureBorderColor;
float param_245=0.0;
float4 l9_36=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_234,param_235,param_236,param_237,param_238,param_239,param_240,param_241,param_242,param_243,param_244,param_245);
float4 l9_37=l9_36;
float4 param_246=l9_36;
blurredColor+=(decodeSample(param_246)/float2(25.0));
float2 param_247=mainTextureGetDims2D(UserUniforms);
int param_248=mainTextureLayout;
int param_249=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_250=blurCoordinates[19];
bool param_251=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_252=UserUniforms.mainTextureTransform;
int2 param_253=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_254=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_255=UserUniforms.mainTextureUvMinMax;
bool param_256=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_257=UserUniforms.mainTextureBorderColor;
float param_258=0.0;
float4 l9_38=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_247,param_248,param_249,param_250,param_251,param_252,param_253,param_254,param_255,param_256,param_257,param_258);
float4 l9_39=l9_38;
float4 param_259=l9_38;
blurredColor+=(decodeSample(param_259)/float2(25.0));
float2 param_260=mainTextureGetDims2D(UserUniforms);
int param_261=mainTextureLayout;
int param_262=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_263=blurCoordinates[20];
bool param_264=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_265=UserUniforms.mainTextureTransform;
int2 param_266=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_267=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_268=UserUniforms.mainTextureUvMinMax;
bool param_269=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_270=UserUniforms.mainTextureBorderColor;
float param_271=0.0;
float4 l9_40=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_260,param_261,param_262,param_263,param_264,param_265,param_266,param_267,param_268,param_269,param_270,param_271);
float4 l9_41=l9_40;
float4 param_272=l9_40;
blurredColor+=(decodeSample(param_272)/float2(25.0));
float2 param_273=mainTextureGetDims2D(UserUniforms);
int param_274=mainTextureLayout;
int param_275=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_276=blurCoordinates[21];
bool param_277=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_278=UserUniforms.mainTextureTransform;
int2 param_279=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_280=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_281=UserUniforms.mainTextureUvMinMax;
bool param_282=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_283=UserUniforms.mainTextureBorderColor;
float param_284=0.0;
float4 l9_42=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_273,param_274,param_275,param_276,param_277,param_278,param_279,param_280,param_281,param_282,param_283,param_284);
float4 l9_43=l9_42;
float4 param_285=l9_42;
blurredColor+=(decodeSample(param_285)/float2(25.0));
float2 param_286=mainTextureGetDims2D(UserUniforms);
int param_287=mainTextureLayout;
int param_288=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_289=blurCoordinates[22];
bool param_290=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_291=UserUniforms.mainTextureTransform;
int2 param_292=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_293=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_294=UserUniforms.mainTextureUvMinMax;
bool param_295=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_296=UserUniforms.mainTextureBorderColor;
float param_297=0.0;
float4 l9_44=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_286,param_287,param_288,param_289,param_290,param_291,param_292,param_293,param_294,param_295,param_296,param_297);
float4 l9_45=l9_44;
float4 param_298=l9_44;
blurredColor+=(decodeSample(param_298)/float2(25.0));
float2 param_299=mainTextureGetDims2D(UserUniforms);
int param_300=mainTextureLayout;
int param_301=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_302=blurCoordinates[23];
bool param_303=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_304=UserUniforms.mainTextureTransform;
int2 param_305=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_306=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_307=UserUniforms.mainTextureUvMinMax;
bool param_308=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_309=UserUniforms.mainTextureBorderColor;
float param_310=0.0;
float4 l9_46=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_299,param_300,param_301,param_302,param_303,param_304,param_305,param_306,param_307,param_308,param_309,param_310);
float4 l9_47=l9_46;
float4 param_311=l9_46;
blurredColor+=(decodeSample(param_311)/float2(25.0));
float2 param_312=mainTextureGetDims2D(UserUniforms);
int param_313=mainTextureLayout;
int param_314=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_315=blurCoordinates[24];
bool param_316=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_317=UserUniforms.mainTextureTransform;
int2 param_318=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_319=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_320=UserUniforms.mainTextureUvMinMax;
bool param_321=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_322=UserUniforms.mainTextureBorderColor;
float param_323=0.0;
float4 l9_48=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_312,param_313,param_314,param_315,param_316,param_317,param_318,param_319,param_320,param_321,param_322,param_323);
float4 l9_49=l9_48;
float4 param_324=l9_48;
blurredColor+=(decodeSample(param_324)/float2(25.0));
blurredColor=fast::clamp(blurredColor,float2(0.0),float2(0.99998999));
return blurredColor;
}
float2 encode2(thread const float& v)
{
float2 enc=fract(float2(1.0,255.0)*v);
enc.x-=(enc.y/255.0);
return enc;
}
float4 blur_x(constant userUniformsObj& UserUniforms,thread texture2d<float> mainTexture,thread sampler mainTextureSmpSC,thread float2 (&blurCoordinates)[25],thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
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
float4 blurredColor=l9_0/float4(25.0);
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
blurredColor+=(l9_2/float4(25.0));
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
blurredColor+=(l9_4/float4(25.0));
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
blurredColor+=(l9_6/float4(25.0));
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
blurredColor+=(l9_8/float4(25.0));
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
blurredColor+=(l9_10/float4(25.0));
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
blurredColor+=(l9_12/float4(25.0));
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
blurredColor+=(l9_14/float4(25.0));
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
blurredColor+=(l9_16/float4(25.0));
float2 param_108=mainTextureGetDims2D(UserUniforms);
int param_109=mainTextureLayout;
int param_110=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_111=blurCoordinates[9];
bool param_112=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_113=UserUniforms.mainTextureTransform;
int2 param_114=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_115=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_116=UserUniforms.mainTextureUvMinMax;
bool param_117=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_118=UserUniforms.mainTextureBorderColor;
float param_119=0.0;
float4 l9_18=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_108,param_109,param_110,param_111,param_112,param_113,param_114,param_115,param_116,param_117,param_118,param_119);
float4 l9_19=l9_18;
blurredColor+=(l9_18/float4(25.0));
float2 param_120=mainTextureGetDims2D(UserUniforms);
int param_121=mainTextureLayout;
int param_122=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_123=blurCoordinates[10];
bool param_124=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_125=UserUniforms.mainTextureTransform;
int2 param_126=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_127=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_128=UserUniforms.mainTextureUvMinMax;
bool param_129=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_130=UserUniforms.mainTextureBorderColor;
float param_131=0.0;
float4 l9_20=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_120,param_121,param_122,param_123,param_124,param_125,param_126,param_127,param_128,param_129,param_130,param_131);
float4 l9_21=l9_20;
blurredColor+=(l9_20/float4(25.0));
float2 param_132=mainTextureGetDims2D(UserUniforms);
int param_133=mainTextureLayout;
int param_134=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_135=blurCoordinates[11];
bool param_136=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_137=UserUniforms.mainTextureTransform;
int2 param_138=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_139=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_140=UserUniforms.mainTextureUvMinMax;
bool param_141=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_142=UserUniforms.mainTextureBorderColor;
float param_143=0.0;
float4 l9_22=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_132,param_133,param_134,param_135,param_136,param_137,param_138,param_139,param_140,param_141,param_142,param_143);
float4 l9_23=l9_22;
blurredColor+=(l9_22/float4(25.0));
float2 param_144=mainTextureGetDims2D(UserUniforms);
int param_145=mainTextureLayout;
int param_146=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_147=blurCoordinates[12];
bool param_148=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_149=UserUniforms.mainTextureTransform;
int2 param_150=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_151=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_152=UserUniforms.mainTextureUvMinMax;
bool param_153=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_154=UserUniforms.mainTextureBorderColor;
float param_155=0.0;
float4 l9_24=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_144,param_145,param_146,param_147,param_148,param_149,param_150,param_151,param_152,param_153,param_154,param_155);
float4 l9_25=l9_24;
blurredColor+=(l9_24/float4(25.0));
float2 param_156=mainTextureGetDims2D(UserUniforms);
int param_157=mainTextureLayout;
int param_158=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_159=blurCoordinates[13];
bool param_160=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_161=UserUniforms.mainTextureTransform;
int2 param_162=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_163=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_164=UserUniforms.mainTextureUvMinMax;
bool param_165=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_166=UserUniforms.mainTextureBorderColor;
float param_167=0.0;
float4 l9_26=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_156,param_157,param_158,param_159,param_160,param_161,param_162,param_163,param_164,param_165,param_166,param_167);
float4 l9_27=l9_26;
blurredColor+=(l9_26/float4(25.0));
float2 param_168=mainTextureGetDims2D(UserUniforms);
int param_169=mainTextureLayout;
int param_170=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_171=blurCoordinates[14];
bool param_172=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_173=UserUniforms.mainTextureTransform;
int2 param_174=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_175=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_176=UserUniforms.mainTextureUvMinMax;
bool param_177=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_178=UserUniforms.mainTextureBorderColor;
float param_179=0.0;
float4 l9_28=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_168,param_169,param_170,param_171,param_172,param_173,param_174,param_175,param_176,param_177,param_178,param_179);
float4 l9_29=l9_28;
blurredColor+=(l9_28/float4(25.0));
float2 param_180=mainTextureGetDims2D(UserUniforms);
int param_181=mainTextureLayout;
int param_182=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_183=blurCoordinates[15];
bool param_184=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_185=UserUniforms.mainTextureTransform;
int2 param_186=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_187=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_188=UserUniforms.mainTextureUvMinMax;
bool param_189=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_190=UserUniforms.mainTextureBorderColor;
float param_191=0.0;
float4 l9_30=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_180,param_181,param_182,param_183,param_184,param_185,param_186,param_187,param_188,param_189,param_190,param_191);
float4 l9_31=l9_30;
blurredColor+=(l9_30/float4(25.0));
float2 param_192=mainTextureGetDims2D(UserUniforms);
int param_193=mainTextureLayout;
int param_194=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_195=blurCoordinates[16];
bool param_196=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_197=UserUniforms.mainTextureTransform;
int2 param_198=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_199=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_200=UserUniforms.mainTextureUvMinMax;
bool param_201=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_202=UserUniforms.mainTextureBorderColor;
float param_203=0.0;
float4 l9_32=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_192,param_193,param_194,param_195,param_196,param_197,param_198,param_199,param_200,param_201,param_202,param_203);
float4 l9_33=l9_32;
blurredColor+=(l9_32/float4(25.0));
float2 param_204=mainTextureGetDims2D(UserUniforms);
int param_205=mainTextureLayout;
int param_206=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_207=blurCoordinates[17];
bool param_208=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_209=UserUniforms.mainTextureTransform;
int2 param_210=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_211=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_212=UserUniforms.mainTextureUvMinMax;
bool param_213=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_214=UserUniforms.mainTextureBorderColor;
float param_215=0.0;
float4 l9_34=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_204,param_205,param_206,param_207,param_208,param_209,param_210,param_211,param_212,param_213,param_214,param_215);
float4 l9_35=l9_34;
blurredColor+=(l9_34/float4(25.0));
float2 param_216=mainTextureGetDims2D(UserUniforms);
int param_217=mainTextureLayout;
int param_218=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_219=blurCoordinates[18];
bool param_220=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_221=UserUniforms.mainTextureTransform;
int2 param_222=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_223=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_224=UserUniforms.mainTextureUvMinMax;
bool param_225=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_226=UserUniforms.mainTextureBorderColor;
float param_227=0.0;
float4 l9_36=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_216,param_217,param_218,param_219,param_220,param_221,param_222,param_223,param_224,param_225,param_226,param_227);
float4 l9_37=l9_36;
blurredColor+=(l9_36/float4(25.0));
float2 param_228=mainTextureGetDims2D(UserUniforms);
int param_229=mainTextureLayout;
int param_230=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_231=blurCoordinates[19];
bool param_232=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_233=UserUniforms.mainTextureTransform;
int2 param_234=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_235=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_236=UserUniforms.mainTextureUvMinMax;
bool param_237=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_238=UserUniforms.mainTextureBorderColor;
float param_239=0.0;
float4 l9_38=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_228,param_229,param_230,param_231,param_232,param_233,param_234,param_235,param_236,param_237,param_238,param_239);
float4 l9_39=l9_38;
blurredColor+=(l9_38/float4(25.0));
float2 param_240=mainTextureGetDims2D(UserUniforms);
int param_241=mainTextureLayout;
int param_242=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_243=blurCoordinates[20];
bool param_244=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_245=UserUniforms.mainTextureTransform;
int2 param_246=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_247=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_248=UserUniforms.mainTextureUvMinMax;
bool param_249=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_250=UserUniforms.mainTextureBorderColor;
float param_251=0.0;
float4 l9_40=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_240,param_241,param_242,param_243,param_244,param_245,param_246,param_247,param_248,param_249,param_250,param_251);
float4 l9_41=l9_40;
blurredColor+=(l9_40/float4(25.0));
float2 param_252=mainTextureGetDims2D(UserUniforms);
int param_253=mainTextureLayout;
int param_254=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_255=blurCoordinates[21];
bool param_256=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_257=UserUniforms.mainTextureTransform;
int2 param_258=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_259=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_260=UserUniforms.mainTextureUvMinMax;
bool param_261=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_262=UserUniforms.mainTextureBorderColor;
float param_263=0.0;
float4 l9_42=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_252,param_253,param_254,param_255,param_256,param_257,param_258,param_259,param_260,param_261,param_262,param_263);
float4 l9_43=l9_42;
blurredColor+=(l9_42/float4(25.0));
float2 param_264=mainTextureGetDims2D(UserUniforms);
int param_265=mainTextureLayout;
int param_266=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_267=blurCoordinates[22];
bool param_268=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_269=UserUniforms.mainTextureTransform;
int2 param_270=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_271=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_272=UserUniforms.mainTextureUvMinMax;
bool param_273=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_274=UserUniforms.mainTextureBorderColor;
float param_275=0.0;
float4 l9_44=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_264,param_265,param_266,param_267,param_268,param_269,param_270,param_271,param_272,param_273,param_274,param_275);
float4 l9_45=l9_44;
blurredColor+=(l9_44/float4(25.0));
float2 param_276=mainTextureGetDims2D(UserUniforms);
int param_277=mainTextureLayout;
int param_278=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_279=blurCoordinates[23];
bool param_280=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_281=UserUniforms.mainTextureTransform;
int2 param_282=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_283=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_284=UserUniforms.mainTextureUvMinMax;
bool param_285=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_286=UserUniforms.mainTextureBorderColor;
float param_287=0.0;
float4 l9_46=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_276,param_277,param_278,param_279,param_280,param_281,param_282,param_283,param_284,param_285,param_286,param_287);
float4 l9_47=l9_46;
blurredColor+=(l9_46/float4(25.0));
float2 param_288=mainTextureGetDims2D(UserUniforms);
int param_289=mainTextureLayout;
int param_290=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_291=blurCoordinates[24];
bool param_292=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_293=UserUniforms.mainTextureTransform;
int2 param_294=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_295=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_296=UserUniforms.mainTextureUvMinMax;
bool param_297=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_298=UserUniforms.mainTextureBorderColor;
float param_299=0.0;
float4 l9_48=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_288,param_289,param_290,param_291,param_292,param_293,param_294,param_295,param_296,param_297,param_298,param_299);
float4 l9_49=l9_48;
blurredColor+=(l9_48/float4(25.0));
blurredColor=fast::clamp(blurredColor,float4(0.0),float4(0.99998999));
return blurredColor;
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
float2 blurCoordinates[25]={};
blurCoordinates[0]=sc_fragIn.blurCoordinates_0;
blurCoordinates[1]=sc_fragIn.blurCoordinates_1;
blurCoordinates[2]=sc_fragIn.blurCoordinates_2;
blurCoordinates[3]=sc_fragIn.blurCoordinates_3;
blurCoordinates[4]=sc_fragIn.blurCoordinates_4;
blurCoordinates[5]=sc_fragIn.blurCoordinates_5;
blurCoordinates[6]=sc_fragIn.blurCoordinates_6;
blurCoordinates[7]=sc_fragIn.blurCoordinates_7;
blurCoordinates[8]=sc_fragIn.blurCoordinates_8;
blurCoordinates[9]=sc_fragIn.blurCoordinates_9;
blurCoordinates[10]=sc_fragIn.blurCoordinates_10;
blurCoordinates[11]=sc_fragIn.blurCoordinates_11;
blurCoordinates[12]=sc_fragIn.blurCoordinates_12;
blurCoordinates[13]=sc_fragIn.blurCoordinates_13;
blurCoordinates[14]=sc_fragIn.blurCoordinates_14;
blurCoordinates[15]=sc_fragIn.blurCoordinates_15;
blurCoordinates[16]=sc_fragIn.blurCoordinates_16;
blurCoordinates[17]=sc_fragIn.blurCoordinates_17;
blurCoordinates[18]=sc_fragIn.blurCoordinates_18;
blurCoordinates[19]=sc_fragIn.blurCoordinates_19;
blurCoordinates[20]=sc_fragIn.blurCoordinates_20;
blurCoordinates[21]=sc_fragIn.blurCoordinates_21;
blurCoordinates[22]=sc_fragIn.blurCoordinates_22;
blurCoordinates[23]=sc_fragIn.blurCoordinates_23;
blurCoordinates[24]=sc_fragIn.blurCoordinates_24;
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

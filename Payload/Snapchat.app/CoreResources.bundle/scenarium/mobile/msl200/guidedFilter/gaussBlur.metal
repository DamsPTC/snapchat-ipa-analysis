#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE0 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "std2_vs.metal"
#include "std2_fs.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler texMainSmpSC 2:1
//texture texture2D texMain 2:0:2:1
//ubo float UserUniforms 2:2:144 {
//float4 texMainSize 0
//float4 texMainDims 16
//float4 texMainView 32
//float3x3 texMainTransform 48
//float4 texMainUvMinMax 96
//float4 texMainBorderColor 112
//float2 blurVector 128
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 texMainSize;
float4 texMainDims;
float4 texMainView;
float3x3 texMainTransform;
float4 texMainUvMinMax;
float4 texMainBorderColor;
float2 blurVector;
};
#ifndef texMainHasSwappedViews
#define texMainHasSwappedViews 0
#elif texMainHasSwappedViews==1
#undef texMainHasSwappedViews
#define texMainHasSwappedViews 1
#endif
#ifndef texMainLayout
#define texMainLayout 0
#endif
#ifndef texMainUV
#define texMainUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_texMain
#define SC_USE_UV_TRANSFORM_texMain 0
#elif SC_USE_UV_TRANSFORM_texMain==1
#undef SC_USE_UV_TRANSFORM_texMain
#define SC_USE_UV_TRANSFORM_texMain 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_texMain
#define SC_SOFTWARE_WRAP_MODE_U_texMain -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_texMain
#define SC_SOFTWARE_WRAP_MODE_V_texMain -1
#endif
#ifndef SC_USE_UV_MIN_MAX_texMain
#define SC_USE_UV_MIN_MAX_texMain 0
#elif SC_USE_UV_MIN_MAX_texMain==1
#undef SC_USE_UV_MIN_MAX_texMain
#define SC_USE_UV_MIN_MAX_texMain 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_texMain
#define SC_USE_CLAMP_TO_BORDER_texMain 0
#elif SC_USE_CLAMP_TO_BORDER_texMain==1
#undef SC_USE_CLAMP_TO_BORDER_texMain
#define SC_USE_CLAMP_TO_BORDER_texMain 1
#endif
struct sc_Set2
{
texture2d<float> texMain [[id(0)]];
sampler texMainSmpSC [[id(1)]];
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
float2 blurCoordinates[7]={};
sc_Vertex_t v=sc_LoadVertexAttributes(sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
float2 coordsTex=(v.position.xy*0.5)+float2(0.5);
float2 blurStep=(*sc_set2.UserUniforms).texMainSize.zw*(*sc_set2.UserUniforms).blurVector;
blurCoordinates[0]=coordsTex;
blurCoordinates[1]=coordsTex+(blurStep*1.4584301);
blurCoordinates[2]=coordsTex-(blurStep*1.4584301);
blurCoordinates[3]=coordsTex+(blurStep*3.403985);
blurCoordinates[4]=coordsTex-(blurStep*3.403985);
blurCoordinates[5]=coordsTex+(blurStep*5.3518062);
blurCoordinates[6]=coordsTex-(blurStep*5.3518062);
sc_vertOut.blurCoordinates_0=blurCoordinates[0];
sc_vertOut.blurCoordinates_1=blurCoordinates[1];
sc_vertOut.blurCoordinates_2=blurCoordinates[2];
sc_vertOut.blurCoordinates_3=blurCoordinates[3];
sc_vertOut.blurCoordinates_4=blurCoordinates[4];
sc_vertOut.blurCoordinates_5=blurCoordinates[5];
sc_vertOut.blurCoordinates_6=blurCoordinates[6];
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 texMainSize;
float4 texMainDims;
float4 texMainView;
float3x3 texMainTransform;
float4 texMainUvMinMax;
float4 texMainBorderColor;
float2 blurVector;
};
#ifndef texMainHasSwappedViews
#define texMainHasSwappedViews 0
#elif texMainHasSwappedViews==1
#undef texMainHasSwappedViews
#define texMainHasSwappedViews 1
#endif
#ifndef texMainLayout
#define texMainLayout 0
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_texMain
#define SC_SOFTWARE_WRAP_MODE_U_texMain -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_texMain
#define SC_SOFTWARE_WRAP_MODE_V_texMain -1
#endif
#ifndef SC_USE_UV_MIN_MAX_texMain
#define SC_USE_UV_MIN_MAX_texMain 0
#elif SC_USE_UV_MIN_MAX_texMain==1
#undef SC_USE_UV_MIN_MAX_texMain
#define SC_USE_UV_MIN_MAX_texMain 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_texMain
#define SC_USE_CLAMP_TO_BORDER_texMain 0
#elif SC_USE_CLAMP_TO_BORDER_texMain==1
#undef SC_USE_CLAMP_TO_BORDER_texMain
#define SC_USE_CLAMP_TO_BORDER_texMain 1
#endif
#ifndef texMainUV
#define texMainUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_texMain
#define SC_USE_UV_TRANSFORM_texMain 0
#elif SC_USE_UV_TRANSFORM_texMain==1
#undef SC_USE_UV_TRANSFORM_texMain
#define SC_USE_UV_TRANSFORM_texMain 1
#endif
struct sc_Set2
{
texture2d<float> texMain [[id(0)]];
sampler texMainSmpSC [[id(1)]];
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
};
float2 texMainGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.texMainDims.xy;
}
int texMainGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (texMainHasSwappedViews)
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
float4 sampleMainTex(thread const float2& uv,constant userUniformsObj& UserUniforms,thread texture2d<float> texMain,thread sampler texMainSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 param=texMainGetDims2D(UserUniforms);
int param_1=texMainLayout;
int param_2=texMainGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_3=uv;
bool param_4=false;
float3x3 param_5=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_texMain,SC_SOFTWARE_WRAP_MODE_V_texMain);
bool param_7=(int(SC_USE_UV_MIN_MAX_texMain)!=0);
float4 param_8=UserUniforms.texMainUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_texMain)!=0);
float4 param_10=UserUniforms.texMainBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(texMain,texMainSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 texMainSample=l9_0;
return texMainSample;
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
float2 blurCoordinates[7]={};
blurCoordinates[0]=sc_fragIn.blurCoordinates_0;
blurCoordinates[1]=sc_fragIn.blurCoordinates_1;
blurCoordinates[2]=sc_fragIn.blurCoordinates_2;
blurCoordinates[3]=sc_fragIn.blurCoordinates_3;
blurCoordinates[4]=sc_fragIn.blurCoordinates_4;
blurCoordinates[5]=sc_fragIn.blurCoordinates_5;
blurCoordinates[6]=sc_fragIn.blurCoordinates_6;
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param=blurCoordinates[0];
float4 blurredColor=sampleMainTex(param,(*sc_set2.UserUniforms),sc_set2.texMain,sc_set2.texMainSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1)*0.137023;
float2 param_1=blurCoordinates[1];
float2 param_2=blurCoordinates[2];
blurredColor+=((sampleMainTex(param_1,(*sc_set2.UserUniforms),sc_set2.texMain,sc_set2.texMainSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1)+sampleMainTex(param_2,(*sc_set2.UserUniforms),sc_set2.texMain,sc_set2.texMainSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1))*0.239337);
float2 param_3=blurCoordinates[3];
float2 param_4=blurCoordinates[4];
blurredColor+=((sampleMainTex(param_3,(*sc_set2.UserUniforms),sc_set2.texMain,sc_set2.texMainSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1)+sampleMainTex(param_4,(*sc_set2.UserUniforms),sc_set2.texMain,sc_set2.texMainSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1))*0.13944);
float2 param_5=blurCoordinates[5];
float2 param_6=blurCoordinates[6];
blurredColor+=((sampleMainTex(param_5,(*sc_set2.UserUniforms),sc_set2.texMain,sc_set2.texMainSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1)+sampleMainTex(param_6,(*sc_set2.UserUniforms),sc_set2.texMain,sc_set2.texMainSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1))*0.052710999);
float4 param_7=blurredColor;
sc_writeFragData0(param_7,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

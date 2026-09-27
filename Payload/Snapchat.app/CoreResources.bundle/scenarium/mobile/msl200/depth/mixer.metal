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
//sampler sampler mainTextureSmpSC 2:6
//sampler sampler tex_BY_YSmpSC 2:7
//sampler sampler tex_RG_RB_GBSmpSC 2:8
//sampler sampler tex_RR_GG_BBSmpSC 2:9
//sampler sampler tex_RY_GYSmpSC 2:10
//sampler sampler tex_R_G_BSmpSC 2:11
//texture texture2D mainTexture 2:0:2:6
//texture texture2D tex_BY_Y 2:1:2:7
//texture texture2D tex_RG_RB_GB 2:2:2:8
//texture texture2D tex_RR_GG_BB 2:3:2:9
//texture texture2D tex_RY_GY 2:4:2:10
//texture texture2D tex_R_G_B 2:5:2:11
//ubo float UserUniforms 2:12:784 {
//float4 tex_RY_GYSize 0
//float4 tex_RY_GYDims 16
//float4 tex_RY_GYView 32
//float3x3 tex_RY_GYTransform 48
//float4 tex_RY_GYUvMinMax 96
//float4 tex_RY_GYBorderColor 112
//float4 tex_BY_YSize 128
//float4 tex_BY_YDims 144
//float4 tex_BY_YView 160
//float3x3 tex_BY_YTransform 176
//float4 tex_BY_YUvMinMax 224
//float4 tex_BY_YBorderColor 240
//float4 tex_R_G_BSize 256
//float4 tex_R_G_BDims 272
//float4 tex_R_G_BView 288
//float3x3 tex_R_G_BTransform 304
//float4 tex_R_G_BUvMinMax 352
//float4 tex_R_G_BBorderColor 368
//float4 tex_RR_GG_BBSize 384
//float4 tex_RR_GG_BBDims 400
//float4 tex_RR_GG_BBView 416
//float3x3 tex_RR_GG_BBTransform 432
//float4 tex_RR_GG_BBUvMinMax 480
//float4 tex_RR_GG_BBBorderColor 496
//float4 tex_RG_RB_GBSize 512
//float4 tex_RG_RB_GBDims 528
//float4 tex_RG_RB_GBView 544
//float3x3 tex_RG_RB_GBTransform 560
//float4 tex_RG_RB_GBUvMinMax 608
//float4 tex_RG_RB_GBBorderColor 624
//float4 mainTextureSize 640
//float4 mainTextureDims 656
//float4 mainTextureView 672
//float3x3 mainTextureTransform 688
//float4 mainTextureUvMinMax 736
//float4 mainTextureBorderColor 752
//float epsilon 768
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 tex_RY_GYSize;
float4 tex_RY_GYDims;
float4 tex_RY_GYView;
float3x3 tex_RY_GYTransform;
float4 tex_RY_GYUvMinMax;
float4 tex_RY_GYBorderColor;
float4 tex_BY_YSize;
float4 tex_BY_YDims;
float4 tex_BY_YView;
float3x3 tex_BY_YTransform;
float4 tex_BY_YUvMinMax;
float4 tex_BY_YBorderColor;
float4 tex_R_G_BSize;
float4 tex_R_G_BDims;
float4 tex_R_G_BView;
float3x3 tex_R_G_BTransform;
float4 tex_R_G_BUvMinMax;
float4 tex_R_G_BBorderColor;
float4 tex_RR_GG_BBSize;
float4 tex_RR_GG_BBDims;
float4 tex_RR_GG_BBView;
float3x3 tex_RR_GG_BBTransform;
float4 tex_RR_GG_BBUvMinMax;
float4 tex_RR_GG_BBBorderColor;
float4 tex_RG_RB_GBSize;
float4 tex_RG_RB_GBDims;
float4 tex_RG_RB_GBView;
float3x3 tex_RG_RB_GBTransform;
float4 tex_RG_RB_GBUvMinMax;
float4 tex_RG_RB_GBBorderColor;
float4 mainTextureSize;
float4 mainTextureDims;
float4 mainTextureView;
float3x3 mainTextureTransform;
float4 mainTextureUvMinMax;
float4 mainTextureBorderColor;
float epsilon;
};
#ifndef tex_RY_GYHasSwappedViews
#define tex_RY_GYHasSwappedViews 0
#elif tex_RY_GYHasSwappedViews==1
#undef tex_RY_GYHasSwappedViews
#define tex_RY_GYHasSwappedViews 1
#endif
#ifndef tex_RY_GYLayout
#define tex_RY_GYLayout 0
#endif
#ifndef tex_BY_YHasSwappedViews
#define tex_BY_YHasSwappedViews 0
#elif tex_BY_YHasSwappedViews==1
#undef tex_BY_YHasSwappedViews
#define tex_BY_YHasSwappedViews 1
#endif
#ifndef tex_BY_YLayout
#define tex_BY_YLayout 0
#endif
#ifndef tex_R_G_BHasSwappedViews
#define tex_R_G_BHasSwappedViews 0
#elif tex_R_G_BHasSwappedViews==1
#undef tex_R_G_BHasSwappedViews
#define tex_R_G_BHasSwappedViews 1
#endif
#ifndef tex_R_G_BLayout
#define tex_R_G_BLayout 0
#endif
#ifndef tex_RR_GG_BBHasSwappedViews
#define tex_RR_GG_BBHasSwappedViews 0
#elif tex_RR_GG_BBHasSwappedViews==1
#undef tex_RR_GG_BBHasSwappedViews
#define tex_RR_GG_BBHasSwappedViews 1
#endif
#ifndef tex_RR_GG_BBLayout
#define tex_RR_GG_BBLayout 0
#endif
#ifndef tex_RG_RB_GBHasSwappedViews
#define tex_RG_RB_GBHasSwappedViews 0
#elif tex_RG_RB_GBHasSwappedViews==1
#undef tex_RG_RB_GBHasSwappedViews
#define tex_RG_RB_GBHasSwappedViews 1
#endif
#ifndef tex_RG_RB_GBLayout
#define tex_RG_RB_GBLayout 0
#endif
#ifndef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 0
#elif mainTextureHasSwappedViews==1
#undef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 1
#endif
#ifndef mainTextureLayout
#define mainTextureLayout 0
#endif
#ifndef CAMEOS_MATTING
#define CAMEOS_MATTING 0
#elif CAMEOS_MATTING==1
#undef CAMEOS_MATTING
#define CAMEOS_MATTING 1
#endif
#ifndef tex_RY_GYUV
#define tex_RY_GYUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_tex_RY_GY
#define SC_USE_UV_TRANSFORM_tex_RY_GY 0
#elif SC_USE_UV_TRANSFORM_tex_RY_GY==1
#undef SC_USE_UV_TRANSFORM_tex_RY_GY
#define SC_USE_UV_TRANSFORM_tex_RY_GY 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_tex_RY_GY
#define SC_SOFTWARE_WRAP_MODE_U_tex_RY_GY -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_tex_RY_GY
#define SC_SOFTWARE_WRAP_MODE_V_tex_RY_GY -1
#endif
#ifndef SC_USE_UV_MIN_MAX_tex_RY_GY
#define SC_USE_UV_MIN_MAX_tex_RY_GY 0
#elif SC_USE_UV_MIN_MAX_tex_RY_GY==1
#undef SC_USE_UV_MIN_MAX_tex_RY_GY
#define SC_USE_UV_MIN_MAX_tex_RY_GY 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_tex_RY_GY
#define SC_USE_CLAMP_TO_BORDER_tex_RY_GY 0
#elif SC_USE_CLAMP_TO_BORDER_tex_RY_GY==1
#undef SC_USE_CLAMP_TO_BORDER_tex_RY_GY
#define SC_USE_CLAMP_TO_BORDER_tex_RY_GY 1
#endif
#ifndef tex_BY_YUV
#define tex_BY_YUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_tex_BY_Y
#define SC_USE_UV_TRANSFORM_tex_BY_Y 0
#elif SC_USE_UV_TRANSFORM_tex_BY_Y==1
#undef SC_USE_UV_TRANSFORM_tex_BY_Y
#define SC_USE_UV_TRANSFORM_tex_BY_Y 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_tex_BY_Y
#define SC_SOFTWARE_WRAP_MODE_U_tex_BY_Y -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_tex_BY_Y
#define SC_SOFTWARE_WRAP_MODE_V_tex_BY_Y -1
#endif
#ifndef SC_USE_UV_MIN_MAX_tex_BY_Y
#define SC_USE_UV_MIN_MAX_tex_BY_Y 0
#elif SC_USE_UV_MIN_MAX_tex_BY_Y==1
#undef SC_USE_UV_MIN_MAX_tex_BY_Y
#define SC_USE_UV_MIN_MAX_tex_BY_Y 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_tex_BY_Y
#define SC_USE_CLAMP_TO_BORDER_tex_BY_Y 0
#elif SC_USE_CLAMP_TO_BORDER_tex_BY_Y==1
#undef SC_USE_CLAMP_TO_BORDER_tex_BY_Y
#define SC_USE_CLAMP_TO_BORDER_tex_BY_Y 1
#endif
#ifndef tex_R_G_BUV
#define tex_R_G_BUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_tex_R_G_B
#define SC_USE_UV_TRANSFORM_tex_R_G_B 0
#elif SC_USE_UV_TRANSFORM_tex_R_G_B==1
#undef SC_USE_UV_TRANSFORM_tex_R_G_B
#define SC_USE_UV_TRANSFORM_tex_R_G_B 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_tex_R_G_B
#define SC_SOFTWARE_WRAP_MODE_U_tex_R_G_B -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_tex_R_G_B
#define SC_SOFTWARE_WRAP_MODE_V_tex_R_G_B -1
#endif
#ifndef SC_USE_UV_MIN_MAX_tex_R_G_B
#define SC_USE_UV_MIN_MAX_tex_R_G_B 0
#elif SC_USE_UV_MIN_MAX_tex_R_G_B==1
#undef SC_USE_UV_MIN_MAX_tex_R_G_B
#define SC_USE_UV_MIN_MAX_tex_R_G_B 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_tex_R_G_B
#define SC_USE_CLAMP_TO_BORDER_tex_R_G_B 0
#elif SC_USE_CLAMP_TO_BORDER_tex_R_G_B==1
#undef SC_USE_CLAMP_TO_BORDER_tex_R_G_B
#define SC_USE_CLAMP_TO_BORDER_tex_R_G_B 1
#endif
#ifndef tex_RR_GG_BBUV
#define tex_RR_GG_BBUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_tex_RR_GG_BB
#define SC_USE_UV_TRANSFORM_tex_RR_GG_BB 0
#elif SC_USE_UV_TRANSFORM_tex_RR_GG_BB==1
#undef SC_USE_UV_TRANSFORM_tex_RR_GG_BB
#define SC_USE_UV_TRANSFORM_tex_RR_GG_BB 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_tex_RR_GG_BB
#define SC_SOFTWARE_WRAP_MODE_U_tex_RR_GG_BB -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_tex_RR_GG_BB
#define SC_SOFTWARE_WRAP_MODE_V_tex_RR_GG_BB -1
#endif
#ifndef SC_USE_UV_MIN_MAX_tex_RR_GG_BB
#define SC_USE_UV_MIN_MAX_tex_RR_GG_BB 0
#elif SC_USE_UV_MIN_MAX_tex_RR_GG_BB==1
#undef SC_USE_UV_MIN_MAX_tex_RR_GG_BB
#define SC_USE_UV_MIN_MAX_tex_RR_GG_BB 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_tex_RR_GG_BB
#define SC_USE_CLAMP_TO_BORDER_tex_RR_GG_BB 0
#elif SC_USE_CLAMP_TO_BORDER_tex_RR_GG_BB==1
#undef SC_USE_CLAMP_TO_BORDER_tex_RR_GG_BB
#define SC_USE_CLAMP_TO_BORDER_tex_RR_GG_BB 1
#endif
#ifndef tex_RG_RB_GBUV
#define tex_RG_RB_GBUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_tex_RG_RB_GB
#define SC_USE_UV_TRANSFORM_tex_RG_RB_GB 0
#elif SC_USE_UV_TRANSFORM_tex_RG_RB_GB==1
#undef SC_USE_UV_TRANSFORM_tex_RG_RB_GB
#define SC_USE_UV_TRANSFORM_tex_RG_RB_GB 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_tex_RG_RB_GB
#define SC_SOFTWARE_WRAP_MODE_U_tex_RG_RB_GB -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_tex_RG_RB_GB
#define SC_SOFTWARE_WRAP_MODE_V_tex_RG_RB_GB -1
#endif
#ifndef SC_USE_UV_MIN_MAX_tex_RG_RB_GB
#define SC_USE_UV_MIN_MAX_tex_RG_RB_GB 0
#elif SC_USE_UV_MIN_MAX_tex_RG_RB_GB==1
#undef SC_USE_UV_MIN_MAX_tex_RG_RB_GB
#define SC_USE_UV_MIN_MAX_tex_RG_RB_GB 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_tex_RG_RB_GB
#define SC_USE_CLAMP_TO_BORDER_tex_RG_RB_GB 0
#elif SC_USE_CLAMP_TO_BORDER_tex_RG_RB_GB==1
#undef SC_USE_CLAMP_TO_BORDER_tex_RG_RB_GB
#define SC_USE_CLAMP_TO_BORDER_tex_RG_RB_GB 1
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
texture2d<float> tex_BY_Y [[id(1)]];
texture2d<float> tex_RG_RB_GB [[id(2)]];
texture2d<float> tex_RR_GG_BB [[id(3)]];
texture2d<float> tex_RY_GY [[id(4)]];
texture2d<float> tex_R_G_B [[id(5)]];
sampler mainTextureSmpSC [[id(6)]];
sampler tex_BY_YSmpSC [[id(7)]];
sampler tex_RG_RB_GBSmpSC [[id(8)]];
sampler tex_RR_GG_BBSmpSC [[id(9)]];
sampler tex_RY_GYSmpSC [[id(10)]];
sampler tex_R_G_BSmpSC [[id(11)]];
constant userUniformsObj* UserUniforms [[id(12)]];
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
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 tex_RY_GYSize;
float4 tex_RY_GYDims;
float4 tex_RY_GYView;
float3x3 tex_RY_GYTransform;
float4 tex_RY_GYUvMinMax;
float4 tex_RY_GYBorderColor;
float4 tex_BY_YSize;
float4 tex_BY_YDims;
float4 tex_BY_YView;
float3x3 tex_BY_YTransform;
float4 tex_BY_YUvMinMax;
float4 tex_BY_YBorderColor;
float4 tex_R_G_BSize;
float4 tex_R_G_BDims;
float4 tex_R_G_BView;
float3x3 tex_R_G_BTransform;
float4 tex_R_G_BUvMinMax;
float4 tex_R_G_BBorderColor;
float4 tex_RR_GG_BBSize;
float4 tex_RR_GG_BBDims;
float4 tex_RR_GG_BBView;
float3x3 tex_RR_GG_BBTransform;
float4 tex_RR_GG_BBUvMinMax;
float4 tex_RR_GG_BBBorderColor;
float4 tex_RG_RB_GBSize;
float4 tex_RG_RB_GBDims;
float4 tex_RG_RB_GBView;
float3x3 tex_RG_RB_GBTransform;
float4 tex_RG_RB_GBUvMinMax;
float4 tex_RG_RB_GBBorderColor;
float4 mainTextureSize;
float4 mainTextureDims;
float4 mainTextureView;
float3x3 mainTextureTransform;
float4 mainTextureUvMinMax;
float4 mainTextureBorderColor;
float epsilon;
};
#ifndef tex_RY_GYHasSwappedViews
#define tex_RY_GYHasSwappedViews 0
#elif tex_RY_GYHasSwappedViews==1
#undef tex_RY_GYHasSwappedViews
#define tex_RY_GYHasSwappedViews 1
#endif
#ifndef tex_RY_GYLayout
#define tex_RY_GYLayout 0
#endif
#ifndef tex_BY_YHasSwappedViews
#define tex_BY_YHasSwappedViews 0
#elif tex_BY_YHasSwappedViews==1
#undef tex_BY_YHasSwappedViews
#define tex_BY_YHasSwappedViews 1
#endif
#ifndef tex_BY_YLayout
#define tex_BY_YLayout 0
#endif
#ifndef tex_R_G_BHasSwappedViews
#define tex_R_G_BHasSwappedViews 0
#elif tex_R_G_BHasSwappedViews==1
#undef tex_R_G_BHasSwappedViews
#define tex_R_G_BHasSwappedViews 1
#endif
#ifndef tex_R_G_BLayout
#define tex_R_G_BLayout 0
#endif
#ifndef tex_RR_GG_BBHasSwappedViews
#define tex_RR_GG_BBHasSwappedViews 0
#elif tex_RR_GG_BBHasSwappedViews==1
#undef tex_RR_GG_BBHasSwappedViews
#define tex_RR_GG_BBHasSwappedViews 1
#endif
#ifndef tex_RR_GG_BBLayout
#define tex_RR_GG_BBLayout 0
#endif
#ifndef tex_RG_RB_GBHasSwappedViews
#define tex_RG_RB_GBHasSwappedViews 0
#elif tex_RG_RB_GBHasSwappedViews==1
#undef tex_RG_RB_GBHasSwappedViews
#define tex_RG_RB_GBHasSwappedViews 1
#endif
#ifndef tex_RG_RB_GBLayout
#define tex_RG_RB_GBLayout 0
#endif
#ifndef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 0
#elif mainTextureHasSwappedViews==1
#undef mainTextureHasSwappedViews
#define mainTextureHasSwappedViews 1
#endif
#ifndef mainTextureLayout
#define mainTextureLayout 0
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_tex_RY_GY
#define SC_SOFTWARE_WRAP_MODE_U_tex_RY_GY -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_tex_RY_GY
#define SC_SOFTWARE_WRAP_MODE_V_tex_RY_GY -1
#endif
#ifndef SC_USE_UV_MIN_MAX_tex_RY_GY
#define SC_USE_UV_MIN_MAX_tex_RY_GY 0
#elif SC_USE_UV_MIN_MAX_tex_RY_GY==1
#undef SC_USE_UV_MIN_MAX_tex_RY_GY
#define SC_USE_UV_MIN_MAX_tex_RY_GY 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_tex_RY_GY
#define SC_USE_CLAMP_TO_BORDER_tex_RY_GY 0
#elif SC_USE_CLAMP_TO_BORDER_tex_RY_GY==1
#undef SC_USE_CLAMP_TO_BORDER_tex_RY_GY
#define SC_USE_CLAMP_TO_BORDER_tex_RY_GY 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_tex_BY_Y
#define SC_SOFTWARE_WRAP_MODE_U_tex_BY_Y -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_tex_BY_Y
#define SC_SOFTWARE_WRAP_MODE_V_tex_BY_Y -1
#endif
#ifndef SC_USE_UV_MIN_MAX_tex_BY_Y
#define SC_USE_UV_MIN_MAX_tex_BY_Y 0
#elif SC_USE_UV_MIN_MAX_tex_BY_Y==1
#undef SC_USE_UV_MIN_MAX_tex_BY_Y
#define SC_USE_UV_MIN_MAX_tex_BY_Y 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_tex_BY_Y
#define SC_USE_CLAMP_TO_BORDER_tex_BY_Y 0
#elif SC_USE_CLAMP_TO_BORDER_tex_BY_Y==1
#undef SC_USE_CLAMP_TO_BORDER_tex_BY_Y
#define SC_USE_CLAMP_TO_BORDER_tex_BY_Y 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_tex_R_G_B
#define SC_SOFTWARE_WRAP_MODE_U_tex_R_G_B -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_tex_R_G_B
#define SC_SOFTWARE_WRAP_MODE_V_tex_R_G_B -1
#endif
#ifndef SC_USE_UV_MIN_MAX_tex_R_G_B
#define SC_USE_UV_MIN_MAX_tex_R_G_B 0
#elif SC_USE_UV_MIN_MAX_tex_R_G_B==1
#undef SC_USE_UV_MIN_MAX_tex_R_G_B
#define SC_USE_UV_MIN_MAX_tex_R_G_B 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_tex_R_G_B
#define SC_USE_CLAMP_TO_BORDER_tex_R_G_B 0
#elif SC_USE_CLAMP_TO_BORDER_tex_R_G_B==1
#undef SC_USE_CLAMP_TO_BORDER_tex_R_G_B
#define SC_USE_CLAMP_TO_BORDER_tex_R_G_B 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_tex_RR_GG_BB
#define SC_SOFTWARE_WRAP_MODE_U_tex_RR_GG_BB -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_tex_RR_GG_BB
#define SC_SOFTWARE_WRAP_MODE_V_tex_RR_GG_BB -1
#endif
#ifndef SC_USE_UV_MIN_MAX_tex_RR_GG_BB
#define SC_USE_UV_MIN_MAX_tex_RR_GG_BB 0
#elif SC_USE_UV_MIN_MAX_tex_RR_GG_BB==1
#undef SC_USE_UV_MIN_MAX_tex_RR_GG_BB
#define SC_USE_UV_MIN_MAX_tex_RR_GG_BB 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_tex_RR_GG_BB
#define SC_USE_CLAMP_TO_BORDER_tex_RR_GG_BB 0
#elif SC_USE_CLAMP_TO_BORDER_tex_RR_GG_BB==1
#undef SC_USE_CLAMP_TO_BORDER_tex_RR_GG_BB
#define SC_USE_CLAMP_TO_BORDER_tex_RR_GG_BB 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_tex_RG_RB_GB
#define SC_SOFTWARE_WRAP_MODE_U_tex_RG_RB_GB -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_tex_RG_RB_GB
#define SC_SOFTWARE_WRAP_MODE_V_tex_RG_RB_GB -1
#endif
#ifndef SC_USE_UV_MIN_MAX_tex_RG_RB_GB
#define SC_USE_UV_MIN_MAX_tex_RG_RB_GB 0
#elif SC_USE_UV_MIN_MAX_tex_RG_RB_GB==1
#undef SC_USE_UV_MIN_MAX_tex_RG_RB_GB
#define SC_USE_UV_MIN_MAX_tex_RG_RB_GB 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_tex_RG_RB_GB
#define SC_USE_CLAMP_TO_BORDER_tex_RG_RB_GB 0
#elif SC_USE_CLAMP_TO_BORDER_tex_RG_RB_GB==1
#undef SC_USE_CLAMP_TO_BORDER_tex_RG_RB_GB
#define SC_USE_CLAMP_TO_BORDER_tex_RG_RB_GB 1
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
#ifndef CAMEOS_MATTING
#define CAMEOS_MATTING 0
#elif CAMEOS_MATTING==1
#undef CAMEOS_MATTING
#define CAMEOS_MATTING 1
#endif
#ifndef tex_RY_GYUV
#define tex_RY_GYUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_tex_RY_GY
#define SC_USE_UV_TRANSFORM_tex_RY_GY 0
#elif SC_USE_UV_TRANSFORM_tex_RY_GY==1
#undef SC_USE_UV_TRANSFORM_tex_RY_GY
#define SC_USE_UV_TRANSFORM_tex_RY_GY 1
#endif
#ifndef tex_BY_YUV
#define tex_BY_YUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_tex_BY_Y
#define SC_USE_UV_TRANSFORM_tex_BY_Y 0
#elif SC_USE_UV_TRANSFORM_tex_BY_Y==1
#undef SC_USE_UV_TRANSFORM_tex_BY_Y
#define SC_USE_UV_TRANSFORM_tex_BY_Y 1
#endif
#ifndef tex_R_G_BUV
#define tex_R_G_BUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_tex_R_G_B
#define SC_USE_UV_TRANSFORM_tex_R_G_B 0
#elif SC_USE_UV_TRANSFORM_tex_R_G_B==1
#undef SC_USE_UV_TRANSFORM_tex_R_G_B
#define SC_USE_UV_TRANSFORM_tex_R_G_B 1
#endif
#ifndef tex_RR_GG_BBUV
#define tex_RR_GG_BBUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_tex_RR_GG_BB
#define SC_USE_UV_TRANSFORM_tex_RR_GG_BB 0
#elif SC_USE_UV_TRANSFORM_tex_RR_GG_BB==1
#undef SC_USE_UV_TRANSFORM_tex_RR_GG_BB
#define SC_USE_UV_TRANSFORM_tex_RR_GG_BB 1
#endif
#ifndef tex_RG_RB_GBUV
#define tex_RG_RB_GBUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_tex_RG_RB_GB
#define SC_USE_UV_TRANSFORM_tex_RG_RB_GB 0
#elif SC_USE_UV_TRANSFORM_tex_RG_RB_GB==1
#undef SC_USE_UV_TRANSFORM_tex_RG_RB_GB
#define SC_USE_UV_TRANSFORM_tex_RG_RB_GB 1
#endif
#ifndef mainTextureUV
#define mainTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> mainTexture [[id(0)]];
texture2d<float> tex_BY_Y [[id(1)]];
texture2d<float> tex_RG_RB_GB [[id(2)]];
texture2d<float> tex_RR_GG_BB [[id(3)]];
texture2d<float> tex_RY_GY [[id(4)]];
texture2d<float> tex_R_G_B [[id(5)]];
sampler mainTextureSmpSC [[id(6)]];
sampler tex_BY_YSmpSC [[id(7)]];
sampler tex_RG_RB_GBSmpSC [[id(8)]];
sampler tex_RR_GG_BBSmpSC [[id(9)]];
sampler tex_RY_GYSmpSC [[id(10)]];
sampler tex_R_G_BSmpSC [[id(11)]];
constant userUniformsObj* UserUniforms [[id(12)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
};
float2 tex_RY_GYGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.tex_RY_GYDims.xy;
}
int tex_RY_GYGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (tex_RY_GYHasSwappedViews)
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
float2 tex_BY_YGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.tex_BY_YDims.xy;
}
int tex_BY_YGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (tex_BY_YHasSwappedViews)
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
float2 tex_R_G_BGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.tex_R_G_BDims.xy;
}
int tex_R_G_BGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (tex_R_G_BHasSwappedViews)
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
float2 tex_RR_GG_BBGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.tex_RR_GG_BBDims.xy;
}
int tex_RR_GG_BBGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (tex_RR_GG_BBHasSwappedViews)
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
float2 tex_RG_RB_GBGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.tex_RG_RB_GBDims.xy;
}
int tex_RG_RB_GBGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (tex_RG_RB_GBHasSwappedViews)
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
float3 inverseSymMul(thread const float& m00,thread const float& m11,thread const float& m22,thread const float& m01,thread const float& m02,thread const float& m12,thread const float3& A)
{
float a00=(m22*m11)-(m12*m12);
float a01=(m02*m12)-(m22*m01);
float a02=(m01*m12)-(m02*m11);
float a11=(m22*m00)-(m02*m02);
float a12=(m01*m02)-(m00*m12);
float a22=(m00*m11)-(m01*m01);
float D=dot(float3(m00,m01,m02),float3(a00,a01,a02));
float3x3 Inv=float3x3(float3(a00,a01,a02),float3(a01,a11,a12),float3(a02,a12,a22));
return (Inv*A)/float3(D);
}
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
float2 encode2(thread const float& v)
{
float2 enc=fract(float2(1.0,255.0)*v);
enc.x-=(enc.y/255.0);
return enc;
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param=tex_RY_GYGetDims2D((*sc_set2.UserUniforms));
int param_1=tex_RY_GYLayout;
int param_2=tex_RY_GYGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=false;
float3x3 param_5=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_tex_RY_GY,SC_SOFTWARE_WRAP_MODE_V_tex_RY_GY);
bool param_7=(int(SC_USE_UV_MIN_MAX_tex_RY_GY)!=0);
float4 param_8=(*sc_set2.UserUniforms).tex_RY_GYUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_tex_RY_GY)!=0);
float4 param_10=(*sc_set2.UserUniforms).tex_RY_GYBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.tex_RY_GY,sc_set2.tex_RY_GYSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 tex_RY_GYSample=l9_0;
float2 param_12=tex_BY_YGetDims2D((*sc_set2.UserUniforms));
int param_13=tex_BY_YLayout;
int param_14=tex_BY_YGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_15=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_16=false;
float3x3 param_17=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_tex_BY_Y,SC_SOFTWARE_WRAP_MODE_V_tex_BY_Y);
bool param_19=(int(SC_USE_UV_MIN_MAX_tex_BY_Y)!=0);
float4 param_20=(*sc_set2.UserUniforms).tex_BY_YUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_tex_BY_Y)!=0);
float4 param_22=(*sc_set2.UserUniforms).tex_BY_YBorderColor;
float param_23=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.tex_BY_Y,sc_set2.tex_BY_YSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_3=l9_2;
float4 tex_BY_YSample=l9_2;
float4 param_24=tex_RY_GYSample;
float4 param_25=tex_BY_YSample;
float4 RY_GY_BY_Y=float4(decodeSample(param_24),decodeSample(param_25));
float2 param_26=tex_R_G_BGetDims2D((*sc_set2.UserUniforms));
int param_27=tex_R_G_BLayout;
int param_28=tex_R_G_BGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_29=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_30=false;
float3x3 param_31=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_32=int2(SC_SOFTWARE_WRAP_MODE_U_tex_R_G_B,SC_SOFTWARE_WRAP_MODE_V_tex_R_G_B);
bool param_33=(int(SC_USE_UV_MIN_MAX_tex_R_G_B)!=0);
float4 param_34=(*sc_set2.UserUniforms).tex_R_G_BUvMinMax;
bool param_35=(int(SC_USE_CLAMP_TO_BORDER_tex_R_G_B)!=0);
float4 param_36=(*sc_set2.UserUniforms).tex_R_G_BBorderColor;
float param_37=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(sc_set2.tex_R_G_B,sc_set2.tex_R_G_BSmpSC,param_26,param_27,param_28,param_29,param_30,param_31,param_32,param_33,param_34,param_35,param_36,param_37);
float4 l9_5=l9_4;
float4 tex_R_G_BSample=l9_4;
float3 R_G_B=tex_R_G_BSample.xyz;
float2 param_38=tex_RR_GG_BBGetDims2D((*sc_set2.UserUniforms));
int param_39=tex_RR_GG_BBLayout;
int param_40=tex_RR_GG_BBGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_41=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_42=false;
float3x3 param_43=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_44=int2(SC_SOFTWARE_WRAP_MODE_U_tex_RR_GG_BB,SC_SOFTWARE_WRAP_MODE_V_tex_RR_GG_BB);
bool param_45=(int(SC_USE_UV_MIN_MAX_tex_RR_GG_BB)!=0);
float4 param_46=(*sc_set2.UserUniforms).tex_RR_GG_BBUvMinMax;
bool param_47=(int(SC_USE_CLAMP_TO_BORDER_tex_RR_GG_BB)!=0);
float4 param_48=(*sc_set2.UserUniforms).tex_RR_GG_BBBorderColor;
float param_49=0.0;
float4 l9_6=sc_SampleTextureBiasOrLevel(sc_set2.tex_RR_GG_BB,sc_set2.tex_RR_GG_BBSmpSC,param_38,param_39,param_40,param_41,param_42,param_43,param_44,param_45,param_46,param_47,param_48,param_49);
float4 l9_7=l9_6;
float4 tex_RR_GG_BBSample=l9_6;
float3 RR_GG_BB=tex_RR_GG_BBSample.xyz;
float2 param_50=tex_RG_RB_GBGetDims2D((*sc_set2.UserUniforms));
int param_51=tex_RG_RB_GBLayout;
int param_52=tex_RG_RB_GBGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_53=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_54=false;
float3x3 param_55=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_56=int2(SC_SOFTWARE_WRAP_MODE_U_tex_RG_RB_GB,SC_SOFTWARE_WRAP_MODE_V_tex_RG_RB_GB);
bool param_57=(int(SC_USE_UV_MIN_MAX_tex_RG_RB_GB)!=0);
float4 param_58=(*sc_set2.UserUniforms).tex_RG_RB_GBUvMinMax;
bool param_59=(int(SC_USE_CLAMP_TO_BORDER_tex_RG_RB_GB)!=0);
float4 param_60=(*sc_set2.UserUniforms).tex_RG_RB_GBBorderColor;
float param_61=0.0;
float4 l9_8=sc_SampleTextureBiasOrLevel(sc_set2.tex_RG_RB_GB,sc_set2.tex_RG_RB_GBSmpSC,param_50,param_51,param_52,param_53,param_54,param_55,param_56,param_57,param_58,param_59,param_60,param_61);
float4 l9_9=l9_8;
float4 tex_RG_RB_GBSample=l9_8;
float3 RG_RB_GB=tex_RG_RB_GBSample.xyz;
float3 covd=abs(RR_GG_BB-(R_G_B*R_G_B))+float3((*sc_set2.UserUniforms).epsilon*(*sc_set2.UserUniforms).epsilon);
float3 covo=RG_RB_GB-(R_G_B.xxy*R_G_B.yzz);
float param_62=covd.x;
float param_63=covd.y;
float param_64=covd.z;
float param_65=covo.x;
float param_66=covo.y;
float param_67=covo.z;
float3 param_68=RY_GY_BY_Y.xyz-(R_G_B*RY_GY_BY_Y.w);
float3 A=inverseSymMul(param_62,param_63,param_64,param_65,param_66,param_67,param_68);
float b=RY_GY_BY_Y.w-dot(A,R_G_B);
float2 param_69=mainTextureGetDims2D((*sc_set2.UserUniforms));
int param_70=mainTextureLayout;
int param_71=mainTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_72=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_73=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_74=(*sc_set2.UserUniforms).mainTextureTransform;
int2 param_75=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_76=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_77=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool param_78=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_79=(*sc_set2.UserUniforms).mainTextureBorderColor;
float param_80=0.0;
float4 l9_10=sc_SampleTextureBiasOrLevel(sc_set2.mainTexture,sc_set2.mainTextureSmpSC,param_69,param_70,param_71,param_72,param_73,param_74,param_75,param_76,param_77,param_78,param_79,param_80);
float4 l9_11=l9_10;
float3 hr_RGB=l9_10.xyz;
float mask=dot(A,hr_RGB)+b;
float4 result;
#if (CAMEOS_MATTING)
{
result=float4(mask,0.0,0.0,1.0);
}
#else
{
float param_81=mask;
result=float4(encode2(param_81),0.0,1.0);
}
#endif
float4 param_82=result;
sc_writeFragData0(param_82,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

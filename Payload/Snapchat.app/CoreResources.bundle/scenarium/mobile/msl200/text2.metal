#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define SC_USE_USER_DEFINED_VS_MAIN 1;
#define STD_DISABLE_VERTEX_NORMAL 1;
#define STD_DISABLE_VERTEX_TANGENT 1;
#include "std2.metal"
#include "std2_fs.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//attribute float passIdentifierAttr 18
//attribute float sdfOffsetAttr 19
//sampler sampler backgroundFillTextureSmpSC 2:6
//sampler sampler colorTextureSmpSC 2:7
//sampler sampler mainFillTextureSmpSC 2:8
//sampler sampler mainTextureSmpSC 2:9
//sampler sampler outlineFillTextureSmpSC 2:10
//sampler sampler shadowFillTextureSmpSC 2:11
//texture texture2D backgroundFillTexture 2:0:2:6
//texture texture2D colorTexture 2:1:2:7
//texture texture2D mainFillTexture 2:2:2:8
//texture texture2D mainTexture 2:3:2:9
//texture texture2D outlineFillTexture 2:4:2:10
//texture texture2D shadowFillTexture 2:5:2:11
//ubo float UserUniforms 2:12:864 {
//float4 mainTextureSize 0
//float4 mainTextureDims 16
//float4 mainTextureView 32
//float3x3 mainTextureTransform 48
//float4 mainTextureUvMinMax 96
//float4 mainTextureBorderColor 112
//float4 colorTextureSize 128
//float4 colorTextureDims 144
//float4 colorTextureView 160
//float3x3 colorTextureTransform 176
//float4 colorTextureUvMinMax 224
//float4 colorTextureBorderColor 240
//float4 mainFillTextureSize 256
//float4 mainFillTextureDims 272
//float4 mainFillTextureView 288
//float3x3 mainFillTextureTransform 304
//float4 mainFillTextureUvMinMax 352
//float4 mainFillTextureBorderColor 368
//float4 shadowFillTextureSize 384
//float4 shadowFillTextureDims 400
//float4 shadowFillTextureView 416
//float3x3 shadowFillTextureTransform 432
//float4 shadowFillTextureUvMinMax 480
//float4 shadowFillTextureBorderColor 496
//float4 outlineFillTextureSize 512
//float4 outlineFillTextureDims 528
//float4 outlineFillTextureView 544
//float3x3 outlineFillTextureTransform 560
//float4 outlineFillTextureUvMinMax 608
//float4 outlineFillTextureBorderColor 624
//float4 backgroundFillTextureSize 640
//float4 backgroundFillTextureDims 656
//float4 backgroundFillTextureView 672
//float3x3 backgroundFillTextureTransform 688
//float4 backgroundFillTextureUvMinMax 736
//float4 backgroundFillTextureBorderColor 752
//float4 mainColor 768
//float4 shadowColor 784
//float4 outlineColor 800
//float4 backgroundColor 816
//float backgroundCornerRadius 832
//float2 backgroundSize 840
//float multisampleBlend 848
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
float4 colorTextureSize;
float4 colorTextureDims;
float4 colorTextureView;
float3x3 colorTextureTransform;
float4 colorTextureUvMinMax;
float4 colorTextureBorderColor;
float4 mainFillTextureSize;
float4 mainFillTextureDims;
float4 mainFillTextureView;
float3x3 mainFillTextureTransform;
float4 mainFillTextureUvMinMax;
float4 mainFillTextureBorderColor;
float4 shadowFillTextureSize;
float4 shadowFillTextureDims;
float4 shadowFillTextureView;
float3x3 shadowFillTextureTransform;
float4 shadowFillTextureUvMinMax;
float4 shadowFillTextureBorderColor;
float4 outlineFillTextureSize;
float4 outlineFillTextureDims;
float4 outlineFillTextureView;
float3x3 outlineFillTextureTransform;
float4 outlineFillTextureUvMinMax;
float4 outlineFillTextureBorderColor;
float4 backgroundFillTextureSize;
float4 backgroundFillTextureDims;
float4 backgroundFillTextureView;
float3x3 backgroundFillTextureTransform;
float4 backgroundFillTextureUvMinMax;
float4 backgroundFillTextureBorderColor;
float4 mainColor;
float4 shadowColor;
float4 outlineColor;
float4 backgroundColor;
float backgroundCornerRadius;
float2 backgroundSize;
float multisampleBlend;
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
#ifndef colorTextureHasSwappedViews
#define colorTextureHasSwappedViews 0
#elif colorTextureHasSwappedViews==1
#undef colorTextureHasSwappedViews
#define colorTextureHasSwappedViews 1
#endif
#ifndef colorTextureLayout
#define colorTextureLayout 0
#endif
#ifndef mainFillTextureHasSwappedViews
#define mainFillTextureHasSwappedViews 0
#elif mainFillTextureHasSwappedViews==1
#undef mainFillTextureHasSwappedViews
#define mainFillTextureHasSwappedViews 1
#endif
#ifndef mainFillTextureLayout
#define mainFillTextureLayout 0
#endif
#ifndef shadowFillTextureHasSwappedViews
#define shadowFillTextureHasSwappedViews 0
#elif shadowFillTextureHasSwappedViews==1
#undef shadowFillTextureHasSwappedViews
#define shadowFillTextureHasSwappedViews 1
#endif
#ifndef shadowFillTextureLayout
#define shadowFillTextureLayout 0
#endif
#ifndef outlineFillTextureHasSwappedViews
#define outlineFillTextureHasSwappedViews 0
#elif outlineFillTextureHasSwappedViews==1
#undef outlineFillTextureHasSwappedViews
#define outlineFillTextureHasSwappedViews 1
#endif
#ifndef outlineFillTextureLayout
#define outlineFillTextureLayout 0
#endif
#ifndef backgroundFillTextureHasSwappedViews
#define backgroundFillTextureHasSwappedViews 0
#elif backgroundFillTextureHasSwappedViews==1
#undef backgroundFillTextureHasSwappedViews
#define backgroundFillTextureHasSwappedViews 1
#endif
#ifndef backgroundFillTextureLayout
#define backgroundFillTextureLayout 0
#endif
#ifndef MAIN_FILL_COLOR
#define MAIN_FILL_COLOR 0
#elif MAIN_FILL_COLOR==1
#undef MAIN_FILL_COLOR
#define MAIN_FILL_COLOR 1
#endif
#ifndef MAIN_FILL_TEXTURE
#define MAIN_FILL_TEXTURE 0
#elif MAIN_FILL_TEXTURE==1
#undef MAIN_FILL_TEXTURE
#define MAIN_FILL_TEXTURE 1
#endif
#ifndef ENABLE_SHADOW
#define ENABLE_SHADOW 0
#elif ENABLE_SHADOW==1
#undef ENABLE_SHADOW
#define ENABLE_SHADOW 1
#endif
#ifndef SHADOW_FILL_COLOR
#define SHADOW_FILL_COLOR 0
#elif SHADOW_FILL_COLOR==1
#undef SHADOW_FILL_COLOR
#define SHADOW_FILL_COLOR 1
#endif
#ifndef SHADOW_FILL_TEXTURE
#define SHADOW_FILL_TEXTURE 0
#elif SHADOW_FILL_TEXTURE==1
#undef SHADOW_FILL_TEXTURE
#define SHADOW_FILL_TEXTURE 1
#endif
#ifndef ENABLE_OUTLINE
#define ENABLE_OUTLINE 0
#elif ENABLE_OUTLINE==1
#undef ENABLE_OUTLINE
#define ENABLE_OUTLINE 1
#endif
#ifndef ENABLE_SDF
#define ENABLE_SDF 0
#elif ENABLE_SDF==1
#undef ENABLE_SDF
#define ENABLE_SDF 1
#endif
#ifndef OUTLINE_FILL_COLOR
#define OUTLINE_FILL_COLOR 0
#elif OUTLINE_FILL_COLOR==1
#undef OUTLINE_FILL_COLOR
#define OUTLINE_FILL_COLOR 1
#endif
#ifndef OUTLINE_FILL_TEXTURE
#define OUTLINE_FILL_TEXTURE 0
#elif OUTLINE_FILL_TEXTURE==1
#undef OUTLINE_FILL_TEXTURE
#define OUTLINE_FILL_TEXTURE 1
#endif
#ifndef ENABLE_BACKGROUND
#define ENABLE_BACKGROUND 0
#elif ENABLE_BACKGROUND==1
#undef ENABLE_BACKGROUND
#define ENABLE_BACKGROUND 1
#endif
#ifndef BACKGROUND_FILL_COLOR
#define BACKGROUND_FILL_COLOR 0
#elif BACKGROUND_FILL_COLOR==1
#undef BACKGROUND_FILL_COLOR
#define BACKGROUND_FILL_COLOR 1
#endif
#ifndef BACKGROUND_FILL_TEXTURE
#define BACKGROUND_FILL_TEXTURE 0
#elif BACKGROUND_FILL_TEXTURE==1
#undef BACKGROUND_FILL_TEXTURE
#define BACKGROUND_FILL_TEXTURE 1
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
#ifndef colorTextureUV
#define colorTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_colorTexture
#define SC_USE_UV_TRANSFORM_colorTexture 0
#elif SC_USE_UV_TRANSFORM_colorTexture==1
#undef SC_USE_UV_TRANSFORM_colorTexture
#define SC_USE_UV_TRANSFORM_colorTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_colorTexture
#define SC_SOFTWARE_WRAP_MODE_U_colorTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_colorTexture
#define SC_SOFTWARE_WRAP_MODE_V_colorTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_colorTexture
#define SC_USE_UV_MIN_MAX_colorTexture 0
#elif SC_USE_UV_MIN_MAX_colorTexture==1
#undef SC_USE_UV_MIN_MAX_colorTexture
#define SC_USE_UV_MIN_MAX_colorTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_colorTexture
#define SC_USE_CLAMP_TO_BORDER_colorTexture 0
#elif SC_USE_CLAMP_TO_BORDER_colorTexture==1
#undef SC_USE_CLAMP_TO_BORDER_colorTexture
#define SC_USE_CLAMP_TO_BORDER_colorTexture 1
#endif
#ifndef mainFillTextureUV
#define mainFillTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_mainFillTexture
#define SC_USE_UV_TRANSFORM_mainFillTexture 0
#elif SC_USE_UV_TRANSFORM_mainFillTexture==1
#undef SC_USE_UV_TRANSFORM_mainFillTexture
#define SC_USE_UV_TRANSFORM_mainFillTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_mainFillTexture
#define SC_SOFTWARE_WRAP_MODE_U_mainFillTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_mainFillTexture
#define SC_SOFTWARE_WRAP_MODE_V_mainFillTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_mainFillTexture
#define SC_USE_UV_MIN_MAX_mainFillTexture 0
#elif SC_USE_UV_MIN_MAX_mainFillTexture==1
#undef SC_USE_UV_MIN_MAX_mainFillTexture
#define SC_USE_UV_MIN_MAX_mainFillTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_mainFillTexture
#define SC_USE_CLAMP_TO_BORDER_mainFillTexture 0
#elif SC_USE_CLAMP_TO_BORDER_mainFillTexture==1
#undef SC_USE_CLAMP_TO_BORDER_mainFillTexture
#define SC_USE_CLAMP_TO_BORDER_mainFillTexture 1
#endif
#ifndef shadowFillTextureUV
#define shadowFillTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_shadowFillTexture
#define SC_USE_UV_TRANSFORM_shadowFillTexture 0
#elif SC_USE_UV_TRANSFORM_shadowFillTexture==1
#undef SC_USE_UV_TRANSFORM_shadowFillTexture
#define SC_USE_UV_TRANSFORM_shadowFillTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_shadowFillTexture
#define SC_SOFTWARE_WRAP_MODE_U_shadowFillTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_shadowFillTexture
#define SC_SOFTWARE_WRAP_MODE_V_shadowFillTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_shadowFillTexture
#define SC_USE_UV_MIN_MAX_shadowFillTexture 0
#elif SC_USE_UV_MIN_MAX_shadowFillTexture==1
#undef SC_USE_UV_MIN_MAX_shadowFillTexture
#define SC_USE_UV_MIN_MAX_shadowFillTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_shadowFillTexture
#define SC_USE_CLAMP_TO_BORDER_shadowFillTexture 0
#elif SC_USE_CLAMP_TO_BORDER_shadowFillTexture==1
#undef SC_USE_CLAMP_TO_BORDER_shadowFillTexture
#define SC_USE_CLAMP_TO_BORDER_shadowFillTexture 1
#endif
#ifndef outlineFillTextureUV
#define outlineFillTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_outlineFillTexture
#define SC_USE_UV_TRANSFORM_outlineFillTexture 0
#elif SC_USE_UV_TRANSFORM_outlineFillTexture==1
#undef SC_USE_UV_TRANSFORM_outlineFillTexture
#define SC_USE_UV_TRANSFORM_outlineFillTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_outlineFillTexture
#define SC_SOFTWARE_WRAP_MODE_U_outlineFillTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_outlineFillTexture
#define SC_SOFTWARE_WRAP_MODE_V_outlineFillTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_outlineFillTexture
#define SC_USE_UV_MIN_MAX_outlineFillTexture 0
#elif SC_USE_UV_MIN_MAX_outlineFillTexture==1
#undef SC_USE_UV_MIN_MAX_outlineFillTexture
#define SC_USE_UV_MIN_MAX_outlineFillTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_outlineFillTexture
#define SC_USE_CLAMP_TO_BORDER_outlineFillTexture 0
#elif SC_USE_CLAMP_TO_BORDER_outlineFillTexture==1
#undef SC_USE_CLAMP_TO_BORDER_outlineFillTexture
#define SC_USE_CLAMP_TO_BORDER_outlineFillTexture 1
#endif
#ifndef backgroundFillTextureUV
#define backgroundFillTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_backgroundFillTexture
#define SC_USE_UV_TRANSFORM_backgroundFillTexture 0
#elif SC_USE_UV_TRANSFORM_backgroundFillTexture==1
#undef SC_USE_UV_TRANSFORM_backgroundFillTexture
#define SC_USE_UV_TRANSFORM_backgroundFillTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_backgroundFillTexture
#define SC_SOFTWARE_WRAP_MODE_U_backgroundFillTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_backgroundFillTexture
#define SC_SOFTWARE_WRAP_MODE_V_backgroundFillTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_backgroundFillTexture
#define SC_USE_UV_MIN_MAX_backgroundFillTexture 0
#elif SC_USE_UV_MIN_MAX_backgroundFillTexture==1
#undef SC_USE_UV_MIN_MAX_backgroundFillTexture
#define SC_USE_UV_MIN_MAX_backgroundFillTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_backgroundFillTexture
#define SC_USE_CLAMP_TO_BORDER_backgroundFillTexture 0
#elif SC_USE_CLAMP_TO_BORDER_backgroundFillTexture==1
#undef SC_USE_CLAMP_TO_BORDER_backgroundFillTexture
#define SC_USE_CLAMP_TO_BORDER_backgroundFillTexture 1
#endif
struct sc_Set2
{
texture2d<float> backgroundFillTexture [[id(0)]];
texture2d<float> colorTexture [[id(1)]];
texture2d<float> mainFillTexture [[id(2)]];
texture2d<float> mainTexture [[id(3)]];
texture2d<float> outlineFillTexture [[id(4)]];
texture2d<float> shadowFillTexture [[id(5)]];
sampler backgroundFillTextureSmpSC [[id(6)]];
sampler colorTextureSmpSC [[id(7)]];
sampler mainFillTextureSmpSC [[id(8)]];
sampler mainTextureSmpSC [[id(9)]];
sampler outlineFillTextureSmpSC [[id(10)]];
sampler shadowFillTextureSmpSC [[id(11)]];
constant userUniformsObj* UserUniforms [[id(12)]];
};
struct sc_VertOut
{
sc_SysOut sc_sysOut;
float varPassIdentifier [[user(locn10)]];
float varSdfOffset [[user(locn11)]];
};
struct sc_VertIn
{
sc_SysAttributes sc_sysAttributes;
float passIdentifierAttr [[attribute(18)]];
float sdfOffsetAttr [[attribute(19)]];
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
sc_vertOut.varPassIdentifier=sc_vertIn.passIdentifierAttr;
sc_vertOut.varSdfOffset=sc_vertIn.sdfOffsetAttr;
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
float4 colorTextureSize;
float4 colorTextureDims;
float4 colorTextureView;
float3x3 colorTextureTransform;
float4 colorTextureUvMinMax;
float4 colorTextureBorderColor;
float4 mainFillTextureSize;
float4 mainFillTextureDims;
float4 mainFillTextureView;
float3x3 mainFillTextureTransform;
float4 mainFillTextureUvMinMax;
float4 mainFillTextureBorderColor;
float4 shadowFillTextureSize;
float4 shadowFillTextureDims;
float4 shadowFillTextureView;
float3x3 shadowFillTextureTransform;
float4 shadowFillTextureUvMinMax;
float4 shadowFillTextureBorderColor;
float4 outlineFillTextureSize;
float4 outlineFillTextureDims;
float4 outlineFillTextureView;
float3x3 outlineFillTextureTransform;
float4 outlineFillTextureUvMinMax;
float4 outlineFillTextureBorderColor;
float4 backgroundFillTextureSize;
float4 backgroundFillTextureDims;
float4 backgroundFillTextureView;
float3x3 backgroundFillTextureTransform;
float4 backgroundFillTextureUvMinMax;
float4 backgroundFillTextureBorderColor;
float4 mainColor;
float4 shadowColor;
float4 outlineColor;
float4 backgroundColor;
float backgroundCornerRadius;
float2 backgroundSize;
float multisampleBlend;
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
#ifndef colorTextureHasSwappedViews
#define colorTextureHasSwappedViews 0
#elif colorTextureHasSwappedViews==1
#undef colorTextureHasSwappedViews
#define colorTextureHasSwappedViews 1
#endif
#ifndef colorTextureLayout
#define colorTextureLayout 0
#endif
#ifndef mainFillTextureHasSwappedViews
#define mainFillTextureHasSwappedViews 0
#elif mainFillTextureHasSwappedViews==1
#undef mainFillTextureHasSwappedViews
#define mainFillTextureHasSwappedViews 1
#endif
#ifndef mainFillTextureLayout
#define mainFillTextureLayout 0
#endif
#ifndef shadowFillTextureHasSwappedViews
#define shadowFillTextureHasSwappedViews 0
#elif shadowFillTextureHasSwappedViews==1
#undef shadowFillTextureHasSwappedViews
#define shadowFillTextureHasSwappedViews 1
#endif
#ifndef shadowFillTextureLayout
#define shadowFillTextureLayout 0
#endif
#ifndef outlineFillTextureHasSwappedViews
#define outlineFillTextureHasSwappedViews 0
#elif outlineFillTextureHasSwappedViews==1
#undef outlineFillTextureHasSwappedViews
#define outlineFillTextureHasSwappedViews 1
#endif
#ifndef outlineFillTextureLayout
#define outlineFillTextureLayout 0
#endif
#ifndef backgroundFillTextureHasSwappedViews
#define backgroundFillTextureHasSwappedViews 0
#elif backgroundFillTextureHasSwappedViews==1
#undef backgroundFillTextureHasSwappedViews
#define backgroundFillTextureHasSwappedViews 1
#endif
#ifndef backgroundFillTextureLayout
#define backgroundFillTextureLayout 0
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
#ifndef MAIN_FILL_COLOR
#define MAIN_FILL_COLOR 0
#elif MAIN_FILL_COLOR==1
#undef MAIN_FILL_COLOR
#define MAIN_FILL_COLOR 1
#endif
#ifndef MAIN_FILL_TEXTURE
#define MAIN_FILL_TEXTURE 0
#elif MAIN_FILL_TEXTURE==1
#undef MAIN_FILL_TEXTURE
#define MAIN_FILL_TEXTURE 1
#endif
#ifndef SC_USE_UV_TRANSFORM_mainFillTexture
#define SC_USE_UV_TRANSFORM_mainFillTexture 0
#elif SC_USE_UV_TRANSFORM_mainFillTexture==1
#undef SC_USE_UV_TRANSFORM_mainFillTexture
#define SC_USE_UV_TRANSFORM_mainFillTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_mainFillTexture
#define SC_SOFTWARE_WRAP_MODE_U_mainFillTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_mainFillTexture
#define SC_SOFTWARE_WRAP_MODE_V_mainFillTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_mainFillTexture
#define SC_USE_UV_MIN_MAX_mainFillTexture 0
#elif SC_USE_UV_MIN_MAX_mainFillTexture==1
#undef SC_USE_UV_MIN_MAX_mainFillTexture
#define SC_USE_UV_MIN_MAX_mainFillTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_mainFillTexture
#define SC_USE_CLAMP_TO_BORDER_mainFillTexture 0
#elif SC_USE_CLAMP_TO_BORDER_mainFillTexture==1
#undef SC_USE_CLAMP_TO_BORDER_mainFillTexture
#define SC_USE_CLAMP_TO_BORDER_mainFillTexture 1
#endif
#ifndef ENABLE_SHADOW
#define ENABLE_SHADOW 0
#elif ENABLE_SHADOW==1
#undef ENABLE_SHADOW
#define ENABLE_SHADOW 1
#endif
#ifndef SHADOW_FILL_COLOR
#define SHADOW_FILL_COLOR 0
#elif SHADOW_FILL_COLOR==1
#undef SHADOW_FILL_COLOR
#define SHADOW_FILL_COLOR 1
#endif
#ifndef SHADOW_FILL_TEXTURE
#define SHADOW_FILL_TEXTURE 0
#elif SHADOW_FILL_TEXTURE==1
#undef SHADOW_FILL_TEXTURE
#define SHADOW_FILL_TEXTURE 1
#endif
#ifndef SC_USE_UV_TRANSFORM_shadowFillTexture
#define SC_USE_UV_TRANSFORM_shadowFillTexture 0
#elif SC_USE_UV_TRANSFORM_shadowFillTexture==1
#undef SC_USE_UV_TRANSFORM_shadowFillTexture
#define SC_USE_UV_TRANSFORM_shadowFillTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_shadowFillTexture
#define SC_SOFTWARE_WRAP_MODE_U_shadowFillTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_shadowFillTexture
#define SC_SOFTWARE_WRAP_MODE_V_shadowFillTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_shadowFillTexture
#define SC_USE_UV_MIN_MAX_shadowFillTexture 0
#elif SC_USE_UV_MIN_MAX_shadowFillTexture==1
#undef SC_USE_UV_MIN_MAX_shadowFillTexture
#define SC_USE_UV_MIN_MAX_shadowFillTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_shadowFillTexture
#define SC_USE_CLAMP_TO_BORDER_shadowFillTexture 0
#elif SC_USE_CLAMP_TO_BORDER_shadowFillTexture==1
#undef SC_USE_CLAMP_TO_BORDER_shadowFillTexture
#define SC_USE_CLAMP_TO_BORDER_shadowFillTexture 1
#endif
#ifndef ENABLE_OUTLINE
#define ENABLE_OUTLINE 0
#elif ENABLE_OUTLINE==1
#undef ENABLE_OUTLINE
#define ENABLE_OUTLINE 1
#endif
#ifndef ENABLE_SDF
#define ENABLE_SDF 0
#elif ENABLE_SDF==1
#undef ENABLE_SDF
#define ENABLE_SDF 1
#endif
#ifndef OUTLINE_FILL_COLOR
#define OUTLINE_FILL_COLOR 0
#elif OUTLINE_FILL_COLOR==1
#undef OUTLINE_FILL_COLOR
#define OUTLINE_FILL_COLOR 1
#endif
#ifndef OUTLINE_FILL_TEXTURE
#define OUTLINE_FILL_TEXTURE 0
#elif OUTLINE_FILL_TEXTURE==1
#undef OUTLINE_FILL_TEXTURE
#define OUTLINE_FILL_TEXTURE 1
#endif
#ifndef SC_USE_UV_TRANSFORM_outlineFillTexture
#define SC_USE_UV_TRANSFORM_outlineFillTexture 0
#elif SC_USE_UV_TRANSFORM_outlineFillTexture==1
#undef SC_USE_UV_TRANSFORM_outlineFillTexture
#define SC_USE_UV_TRANSFORM_outlineFillTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_outlineFillTexture
#define SC_SOFTWARE_WRAP_MODE_U_outlineFillTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_outlineFillTexture
#define SC_SOFTWARE_WRAP_MODE_V_outlineFillTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_outlineFillTexture
#define SC_USE_UV_MIN_MAX_outlineFillTexture 0
#elif SC_USE_UV_MIN_MAX_outlineFillTexture==1
#undef SC_USE_UV_MIN_MAX_outlineFillTexture
#define SC_USE_UV_MIN_MAX_outlineFillTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_outlineFillTexture
#define SC_USE_CLAMP_TO_BORDER_outlineFillTexture 0
#elif SC_USE_CLAMP_TO_BORDER_outlineFillTexture==1
#undef SC_USE_CLAMP_TO_BORDER_outlineFillTexture
#define SC_USE_CLAMP_TO_BORDER_outlineFillTexture 1
#endif
#ifndef ENABLE_BACKGROUND
#define ENABLE_BACKGROUND 0
#elif ENABLE_BACKGROUND==1
#undef ENABLE_BACKGROUND
#define ENABLE_BACKGROUND 1
#endif
#ifndef BACKGROUND_FILL_COLOR
#define BACKGROUND_FILL_COLOR 0
#elif BACKGROUND_FILL_COLOR==1
#undef BACKGROUND_FILL_COLOR
#define BACKGROUND_FILL_COLOR 1
#endif
#ifndef BACKGROUND_FILL_TEXTURE
#define BACKGROUND_FILL_TEXTURE 0
#elif BACKGROUND_FILL_TEXTURE==1
#undef BACKGROUND_FILL_TEXTURE
#define BACKGROUND_FILL_TEXTURE 1
#endif
#ifndef SC_USE_UV_TRANSFORM_backgroundFillTexture
#define SC_USE_UV_TRANSFORM_backgroundFillTexture 0
#elif SC_USE_UV_TRANSFORM_backgroundFillTexture==1
#undef SC_USE_UV_TRANSFORM_backgroundFillTexture
#define SC_USE_UV_TRANSFORM_backgroundFillTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_backgroundFillTexture
#define SC_SOFTWARE_WRAP_MODE_U_backgroundFillTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_backgroundFillTexture
#define SC_SOFTWARE_WRAP_MODE_V_backgroundFillTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_backgroundFillTexture
#define SC_USE_UV_MIN_MAX_backgroundFillTexture 0
#elif SC_USE_UV_MIN_MAX_backgroundFillTexture==1
#undef SC_USE_UV_MIN_MAX_backgroundFillTexture
#define SC_USE_UV_MIN_MAX_backgroundFillTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_backgroundFillTexture
#define SC_USE_CLAMP_TO_BORDER_backgroundFillTexture 0
#elif SC_USE_CLAMP_TO_BORDER_backgroundFillTexture==1
#undef SC_USE_CLAMP_TO_BORDER_backgroundFillTexture
#define SC_USE_CLAMP_TO_BORDER_backgroundFillTexture 1
#endif
#ifndef SC_USE_UV_TRANSFORM_colorTexture
#define SC_USE_UV_TRANSFORM_colorTexture 0
#elif SC_USE_UV_TRANSFORM_colorTexture==1
#undef SC_USE_UV_TRANSFORM_colorTexture
#define SC_USE_UV_TRANSFORM_colorTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_colorTexture
#define SC_SOFTWARE_WRAP_MODE_U_colorTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_colorTexture
#define SC_SOFTWARE_WRAP_MODE_V_colorTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_colorTexture
#define SC_USE_UV_MIN_MAX_colorTexture 0
#elif SC_USE_UV_MIN_MAX_colorTexture==1
#undef SC_USE_UV_MIN_MAX_colorTexture
#define SC_USE_UV_MIN_MAX_colorTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_colorTexture
#define SC_USE_CLAMP_TO_BORDER_colorTexture 0
#elif SC_USE_CLAMP_TO_BORDER_colorTexture==1
#undef SC_USE_CLAMP_TO_BORDER_colorTexture
#define SC_USE_CLAMP_TO_BORDER_colorTexture 1
#endif
#ifndef mainTextureUV
#define mainTextureUV 0
#endif
#ifndef colorTextureUV
#define colorTextureUV 0
#endif
#ifndef mainFillTextureUV
#define mainFillTextureUV 0
#endif
#ifndef shadowFillTextureUV
#define shadowFillTextureUV 0
#endif
#ifndef outlineFillTextureUV
#define outlineFillTextureUV 0
#endif
#ifndef backgroundFillTextureUV
#define backgroundFillTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> backgroundFillTexture [[id(0)]];
texture2d<float> colorTexture [[id(1)]];
texture2d<float> mainFillTexture [[id(2)]];
texture2d<float> mainTexture [[id(3)]];
texture2d<float> outlineFillTexture [[id(4)]];
texture2d<float> shadowFillTexture [[id(5)]];
sampler backgroundFillTextureSmpSC [[id(6)]];
sampler colorTextureSmpSC [[id(7)]];
sampler mainFillTextureSmpSC [[id(8)]];
sampler mainTextureSmpSC [[id(9)]];
sampler outlineFillTextureSmpSC [[id(10)]];
sampler shadowFillTextureSmpSC [[id(11)]];
constant userUniformsObj* UserUniforms [[id(12)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
float varPassIdentifier [[user(locn10)]];
float varSdfOffset [[user(locn11)]];
};
bool isPass(thread const float& pass,thread const float& identifier)
{
float l9_0=identifier;
float l9_1=pass;
bool l9_2=l9_0>(l9_1-0.050000001);
bool l9_3;
if (l9_2)
{
l9_3=identifier<(pass+0.050000001);
}
else
{
l9_3=l9_2;
}
if (l9_3)
{
return true;
}
return false;
}
float2 mainFillTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.mainFillTextureDims.xy;
}
int mainFillTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (mainFillTextureHasSwappedViews)
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
float2 shadowFillTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.shadowFillTextureDims.xy;
}
int shadowFillTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (shadowFillTextureHasSwappedViews)
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
float2 outlineFillTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.outlineFillTextureDims.xy;
}
int outlineFillTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (outlineFillTextureHasSwappedViews)
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
float getCornerFade(thread const float2& corner,constant userUniformsObj& UserUniforms,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
if (length(abs(corner-sc_sysIn.varPackedTex.xy))>UserUniforms.backgroundCornerRadius)
{
return 1.0;
}
float2 squareCorner=abs(float2(corner.x-UserUniforms.backgroundCornerRadius,corner.y-UserUniforms.backgroundCornerRadius));
float radiusPercentage=length(abs(squareCorner-sc_sysIn.varPackedTex.xy))/UserUniforms.backgroundCornerRadius;
if (radiusPercentage<0.98000002)
{
return 1.0;
}
if (radiusPercentage>1.0)
{
return 0.0;
}
return smoothstep(1.0,0.98000002,radiusPercentage);
}
float2 backgroundFillTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.backgroundFillTextureDims.xy;
}
int backgroundFillTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (backgroundFillTextureHasSwappedViews)
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
float2 colorTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.colorTextureDims.xy;
}
int colorTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (colorTextureHasSwappedViews)
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
float calculateSdfOpacity(thread const float& _distance,thread const float& sdfEdge)
{
float w=fwidth(_distance);
return smoothstep(sdfEdge-w,sdfEdge+w,_distance);
}
float calculateSdfOpacityMultisampled(thread const float& dist,thread const float& sdfEdge,thread const float& multisampleBlend,constant userUniformsObj& UserUniforms,thread texture2d<float> mainTexture,thread sampler mainTextureSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float param=dist;
float param_1=sdfEdge;
float opacity=calculateSdfOpacity(param,param_1);
if (multisampleBlend>0.0)
{
float dscale=0.35355338;
float2 duv=(dfdx(sc_sysIn.varPackedTex.xy)+dfdy(sc_sysIn.varPackedTex.xy))*dscale;
float4 box=float4(sc_sysIn.varPackedTex.xy-duv,sc_sysIn.varPackedTex.xy+duv);
float multisampleOpacity=opacity;
float singleSampleOpacity=opacity;
float2 param_2=mainTextureGetDims2D(UserUniforms);
int param_3=mainTextureLayout;
int param_4=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_5=box.xw;
bool param_6=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_7=UserUniforms.mainTextureTransform;
int2 param_8=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_9=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_10=UserUniforms.mainTextureUvMinMax;
bool param_11=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_12=UserUniforms.mainTextureBorderColor;
float param_13=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11,param_12,param_13);
float4 l9_1=l9_0;
float4 mainTextureSample=l9_0;
float param_14=mainTextureSample.x;
float param_15=sdfEdge;
multisampleOpacity+=calculateSdfOpacity(param_14,param_15);
float2 param_16=mainTextureGetDims2D(UserUniforms);
int param_17=mainTextureLayout;
int param_18=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_19=box.xy;
bool param_20=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_21=UserUniforms.mainTextureTransform;
int2 param_22=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_23=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_24=UserUniforms.mainTextureUvMinMax;
bool param_25=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_26=UserUniforms.mainTextureBorderColor;
float param_27=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23,param_24,param_25,param_26,param_27);
float4 l9_3=l9_2;
float4 mainTextureSample_1=l9_2;
float param_28=mainTextureSample_1.x;
float param_29=sdfEdge;
multisampleOpacity+=calculateSdfOpacity(param_28,param_29);
float2 param_30=mainTextureGetDims2D(UserUniforms);
int param_31=mainTextureLayout;
int param_32=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_33=box.zy;
bool param_34=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_35=UserUniforms.mainTextureTransform;
int2 param_36=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_37=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_38=UserUniforms.mainTextureUvMinMax;
bool param_39=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_40=UserUniforms.mainTextureBorderColor;
float param_41=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_30,param_31,param_32,param_33,param_34,param_35,param_36,param_37,param_38,param_39,param_40,param_41);
float4 l9_5=l9_4;
float4 mainTextureSample_2=l9_4;
float param_42=mainTextureSample_2.x;
float param_43=sdfEdge;
multisampleOpacity+=calculateSdfOpacity(param_42,param_43);
float2 param_44=mainTextureGetDims2D(UserUniforms);
int param_45=mainTextureLayout;
int param_46=mainTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_47=box.zw;
bool param_48=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_49=UserUniforms.mainTextureTransform;
int2 param_50=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_51=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_52=UserUniforms.mainTextureUvMinMax;
bool param_53=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_54=UserUniforms.mainTextureBorderColor;
float param_55=0.0;
float4 l9_6=sc_SampleTextureBiasOrLevel(mainTexture,mainTextureSmpSC,param_44,param_45,param_46,param_47,param_48,param_49,param_50,param_51,param_52,param_53,param_54,param_55);
float4 l9_7=l9_6;
float4 mainTextureSample_3=l9_6;
float param_56=mainTextureSample_3.x;
float param_57=sdfEdge;
multisampleOpacity+=calculateSdfOpacity(param_56,param_57);
multisampleOpacity*=0.2;
opacity=mix(singleSampleOpacity,multisampleOpacity,multisampleBlend);
}
return opacity;
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float4 fillColor=float4(1.0);
float2 fillUv=sc_fragIn.sc_sysIn.varPackedTex.zw;
fillUv.x=fract(fillUv.x);
fillUv.y=fract(fillUv.y);
float sdfEdge=0.5;
float param=0.0;
float param_1=sc_fragIn.varPassIdentifier;
bool l9_0=isPass(param,param_1);
bool l9_1;
if (!l9_0)
{
float param_2=0.1;
float param_3=sc_fragIn.varPassIdentifier;
l9_1=isPass(param_2,param_3);
}
else
{
l9_1=l9_0;
}
if (l9_1)
{
#if (MAIN_FILL_COLOR)
{
fillColor=(*sc_set2.UserUniforms).mainColor;
}
#else
{
#if (MAIN_FILL_TEXTURE)
{
float2 param_4=mainFillTextureGetDims2D((*sc_set2.UserUniforms));
int param_5=mainFillTextureLayout;
int param_6=mainFillTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_7=fillUv;
bool param_8=(int(SC_USE_UV_TRANSFORM_mainFillTexture)!=0);
float3x3 param_9=(*sc_set2.UserUniforms).mainFillTextureTransform;
int2 param_10=int2(SC_SOFTWARE_WRAP_MODE_U_mainFillTexture,SC_SOFTWARE_WRAP_MODE_V_mainFillTexture);
bool param_11=(int(SC_USE_UV_MIN_MAX_mainFillTexture)!=0);
float4 param_12=(*sc_set2.UserUniforms).mainFillTextureUvMinMax;
bool param_13=(int(SC_USE_CLAMP_TO_BORDER_mainFillTexture)!=0);
float4 param_14=(*sc_set2.UserUniforms).mainFillTextureBorderColor;
float param_15=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.mainFillTexture,sc_set2.mainFillTextureSmpSC,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11,param_12,param_13,param_14,param_15);
float4 l9_3=l9_2;
float4 mainFillTextureSample=l9_2;
fillColor=mainFillTextureSample;
}
#endif
}
#endif
}
else
{
bool l9_4;
#if (ENABLE_SHADOW)
{
float param_16=0.2;
float param_17=sc_fragIn.varPassIdentifier;
l9_4=isPass(param_16,param_17);
}
#else
{
l9_4=(int(ENABLE_SHADOW)!=0);
}
#endif
if (l9_4)
{
#if (SHADOW_FILL_COLOR)
{
fillColor=(*sc_set2.UserUniforms).shadowColor;
}
#else
{
#if (SHADOW_FILL_TEXTURE)
{
float2 param_18=shadowFillTextureGetDims2D((*sc_set2.UserUniforms));
int param_19=shadowFillTextureLayout;
int param_20=shadowFillTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_21=fillUv;
bool param_22=(int(SC_USE_UV_TRANSFORM_shadowFillTexture)!=0);
float3x3 param_23=(*sc_set2.UserUniforms).shadowFillTextureTransform;
int2 param_24=int2(SC_SOFTWARE_WRAP_MODE_U_shadowFillTexture,SC_SOFTWARE_WRAP_MODE_V_shadowFillTexture);
bool param_25=(int(SC_USE_UV_MIN_MAX_shadowFillTexture)!=0);
float4 param_26=(*sc_set2.UserUniforms).shadowFillTextureUvMinMax;
bool param_27=(int(SC_USE_CLAMP_TO_BORDER_shadowFillTexture)!=0);
float4 param_28=(*sc_set2.UserUniforms).shadowFillTextureBorderColor;
float param_29=0.0;
float4 l9_5=sc_SampleTextureBiasOrLevel(sc_set2.shadowFillTexture,sc_set2.shadowFillTextureSmpSC,param_18,param_19,param_20,param_21,param_22,param_23,param_24,param_25,param_26,param_27,param_28,param_29);
float4 l9_6=l9_5;
float4 shadowFillTextureSample=l9_5;
fillColor=shadowFillTextureSample;
}
#endif
}
#endif
}
else
{
bool l9_7;
#if (ENABLE_OUTLINE)
{
float param_30=0.30000001;
float param_31=sc_fragIn.varPassIdentifier;
l9_7=isPass(param_30,param_31);
}
#else
{
l9_7=(int(ENABLE_OUTLINE)!=0);
}
#endif
if (l9_7)
{
#if (ENABLE_SDF)
{
sdfEdge-=sc_fragIn.varSdfOffset;
}
#endif
#if (OUTLINE_FILL_COLOR)
{
fillColor=(*sc_set2.UserUniforms).outlineColor;
}
#else
{
#if (OUTLINE_FILL_TEXTURE)
{
float2 param_32=outlineFillTextureGetDims2D((*sc_set2.UserUniforms));
int param_33=outlineFillTextureLayout;
int param_34=outlineFillTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_35=fillUv;
bool param_36=(int(SC_USE_UV_TRANSFORM_outlineFillTexture)!=0);
float3x3 param_37=(*sc_set2.UserUniforms).outlineFillTextureTransform;
int2 param_38=int2(SC_SOFTWARE_WRAP_MODE_U_outlineFillTexture,SC_SOFTWARE_WRAP_MODE_V_outlineFillTexture);
bool param_39=(int(SC_USE_UV_MIN_MAX_outlineFillTexture)!=0);
float4 param_40=(*sc_set2.UserUniforms).outlineFillTextureUvMinMax;
bool param_41=(int(SC_USE_CLAMP_TO_BORDER_outlineFillTexture)!=0);
float4 param_42=(*sc_set2.UserUniforms).outlineFillTextureBorderColor;
float param_43=0.0;
float4 l9_8=sc_SampleTextureBiasOrLevel(sc_set2.outlineFillTexture,sc_set2.outlineFillTextureSmpSC,param_32,param_33,param_34,param_35,param_36,param_37,param_38,param_39,param_40,param_41,param_42,param_43);
float4 l9_9=l9_8;
float4 outlineFillTextureSample=l9_8;
fillColor=outlineFillTextureSample;
}
#endif
}
#endif
}
else
{
bool l9_10;
#if (ENABLE_BACKGROUND)
{
float param_44=0.40000001;
float param_45=sc_fragIn.varPassIdentifier;
l9_10=isPass(param_44,param_45);
}
#else
{
l9_10=(int(ENABLE_BACKGROUND)!=0);
}
#endif
if (l9_10)
{
float cornerFade=1.0;
float2 param_46=float2(0.0);
cornerFade*=getCornerFade(param_46,(*sc_set2.UserUniforms),sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_47=float2((*sc_set2.UserUniforms).backgroundSize.x,0.0);
cornerFade*=getCornerFade(param_47,(*sc_set2.UserUniforms),sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_48=float2((*sc_set2.UserUniforms).backgroundSize.x,(*sc_set2.UserUniforms).backgroundSize.y);
cornerFade*=getCornerFade(param_48,(*sc_set2.UserUniforms),sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_49=float2(0.0,(*sc_set2.UserUniforms).backgroundSize.y);
cornerFade*=getCornerFade(param_49,(*sc_set2.UserUniforms),sc_fragIn.sc_sysIn,sc_set0,sc_set1);
if (cornerFade<0.0049999999)
{
discard_fragment();
}
#if (BACKGROUND_FILL_COLOR)
{
float4 param_50=float4((*sc_set2.UserUniforms).backgroundColor.xyz,(*sc_set2.UserUniforms).backgroundColor.w*cornerFade);
sc_writeFragData0(param_50,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
}
#else
{
#if (BACKGROUND_FILL_TEXTURE)
{
float2 param_51=backgroundFillTextureGetDims2D((*sc_set2.UserUniforms));
int param_52=backgroundFillTextureLayout;
int param_53=backgroundFillTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_54=fillUv;
bool param_55=(int(SC_USE_UV_TRANSFORM_backgroundFillTexture)!=0);
float3x3 param_56=(*sc_set2.UserUniforms).backgroundFillTextureTransform;
int2 param_57=int2(SC_SOFTWARE_WRAP_MODE_U_backgroundFillTexture,SC_SOFTWARE_WRAP_MODE_V_backgroundFillTexture);
bool param_58=(int(SC_USE_UV_MIN_MAX_backgroundFillTexture)!=0);
float4 param_59=(*sc_set2.UserUniforms).backgroundFillTextureUvMinMax;
bool param_60=(int(SC_USE_CLAMP_TO_BORDER_backgroundFillTexture)!=0);
float4 param_61=(*sc_set2.UserUniforms).backgroundFillTextureBorderColor;
float param_62=0.0;
float4 l9_11=sc_SampleTextureBiasOrLevel(sc_set2.backgroundFillTexture,sc_set2.backgroundFillTextureSmpSC,param_51,param_52,param_53,param_54,param_55,param_56,param_57,param_58,param_59,param_60,param_61,param_62);
float4 l9_12=l9_11;
float4 backgroundFillTextureSample=l9_11;
float4 param_63=float4(backgroundFillTextureSample.xyz,backgroundFillTextureSample.w*cornerFade);
sc_writeFragData0(param_63,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
}
#endif
}
#endif
return sc_fragOut;
}
}
}
}
float param_64=0.1;
float param_65=sc_fragIn.varPassIdentifier;
if (isPass(param_64,param_65))
{
float2 param_66=colorTextureGetDims2D((*sc_set2.UserUniforms));
int param_67=colorTextureLayout;
int param_68=colorTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_69=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_70=(int(SC_USE_UV_TRANSFORM_colorTexture)!=0);
float3x3 param_71=(*sc_set2.UserUniforms).colorTextureTransform;
int2 param_72=int2(SC_SOFTWARE_WRAP_MODE_U_colorTexture,SC_SOFTWARE_WRAP_MODE_V_colorTexture);
bool param_73=(int(SC_USE_UV_MIN_MAX_colorTexture)!=0);
float4 param_74=(*sc_set2.UserUniforms).colorTextureUvMinMax;
bool param_75=(int(SC_USE_CLAMP_TO_BORDER_colorTexture)!=0);
float4 param_76=(*sc_set2.UserUniforms).colorTextureBorderColor;
float param_77=0.0;
float4 l9_13=sc_SampleTextureBiasOrLevel(sc_set2.colorTexture,sc_set2.colorTextureSmpSC,param_66,param_67,param_68,param_69,param_70,param_71,param_72,param_73,param_74,param_75,param_76,param_77);
float4 l9_14=l9_13;
float4 colorTextureSample=l9_13;
float preMultipliedAlpha=colorTextureSample.w*fillColor.w;
float4 param_78=float4(colorTextureSample.xyz*preMultipliedAlpha,preMultipliedAlpha);
sc_writeFragData0(param_78,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
}
else
{
#if (ENABLE_SDF)
{
float2 param_79=mainTextureGetDims2D((*sc_set2.UserUniforms));
int param_80=mainTextureLayout;
int param_81=mainTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_82=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_83=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_84=(*sc_set2.UserUniforms).mainTextureTransform;
int2 param_85=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_86=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_87=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool param_88=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_89=(*sc_set2.UserUniforms).mainTextureBorderColor;
float param_90=0.0;
float4 l9_15=sc_SampleTextureBiasOrLevel(sc_set2.mainTexture,sc_set2.mainTextureSmpSC,param_79,param_80,param_81,param_82,param_83,param_84,param_85,param_86,param_87,param_88,param_89,param_90);
float4 l9_16=l9_15;
float4 mainTextureSample=l9_15;
float param_91=mainTextureSample.x;
float param_92=sdfEdge;
float param_93=(*sc_set2.UserUniforms).multisampleBlend;
float sdfOpacity=calculateSdfOpacityMultisampled(param_91,param_92,param_93,(*sc_set2.UserUniforms),sc_set2.mainTexture,sc_set2.mainTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float preMultipliedAlpha_1=fillColor.w*sdfOpacity;
float4 param_94=float4(fillColor.xyz*preMultipliedAlpha_1,preMultipliedAlpha_1);
sc_writeFragData0(param_94,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
}
#else
{
float2 param_95=mainTextureGetDims2D((*sc_set2.UserUniforms));
int param_96=mainTextureLayout;
int param_97=mainTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_98=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_99=(int(SC_USE_UV_TRANSFORM_mainTexture)!=0);
float3x3 param_100=(*sc_set2.UserUniforms).mainTextureTransform;
int2 param_101=int2(SC_SOFTWARE_WRAP_MODE_U_mainTexture,SC_SOFTWARE_WRAP_MODE_V_mainTexture);
bool param_102=(int(SC_USE_UV_MIN_MAX_mainTexture)!=0);
float4 param_103=(*sc_set2.UserUniforms).mainTextureUvMinMax;
bool param_104=(int(SC_USE_CLAMP_TO_BORDER_mainTexture)!=0);
float4 param_105=(*sc_set2.UserUniforms).mainTextureBorderColor;
float param_106=0.0;
float4 l9_17=sc_SampleTextureBiasOrLevel(sc_set2.mainTexture,sc_set2.mainTextureSmpSC,param_95,param_96,param_97,param_98,param_99,param_100,param_101,param_102,param_103,param_104,param_105,param_106);
float4 l9_18=l9_17;
float4 mainTextureSample_1=l9_17;
float preMultipliedAlpha_2=mainTextureSample_1.x*fillColor.w;
float4 param_107=float4(fillColor.xyz*preMultipliedAlpha_2,preMultipliedAlpha_2);
sc_writeFragData0(param_107,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
}
#endif
}
return sc_fragOut;
}
} // FRAGMENT SHADER

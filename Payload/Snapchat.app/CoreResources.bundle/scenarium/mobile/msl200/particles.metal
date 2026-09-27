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
#include "std2_texture.metal"
//SG_REFLECTION_BEGIN(100)
//attribute vec4 color 18
//attribute vec2 inputTextureCoordinate0 19
//attribute vec2 inputTextureCoordinate1 20
//attribute vec2 inputTextureCoordinate2 21
//attribute vec2 inputTextureCoordinate3 22
//sampler sampler particlesTexture0SmpSC 2:4
//sampler sampler particlesTexture1SmpSC 2:5
//sampler sampler particlesTexture2SmpSC 2:6
//sampler sampler particlesTexture3SmpSC 2:7
//texture texture2D particlesTexture0 2:0:2:4
//texture texture2D particlesTexture1 2:1:2:5
//texture texture2D particlesTexture2 2:2:2:6
//texture texture2D particlesTexture3 2:3:2:7
//ubo float UserUniforms 2:8:512 {
//float4 particlesTexture0Size 0
//float4 particlesTexture0Dims 16
//float4 particlesTexture0View 32
//float3x3 particlesTexture0Transform 48
//float4 particlesTexture0UvMinMax 96
//float4 particlesTexture0BorderColor 112
//float4 particlesTexture1Size 128
//float4 particlesTexture1Dims 144
//float4 particlesTexture1View 160
//float3x3 particlesTexture1Transform 176
//float4 particlesTexture1UvMinMax 224
//float4 particlesTexture1BorderColor 240
//float4 particlesTexture2Size 256
//float4 particlesTexture2Dims 272
//float4 particlesTexture2View 288
//float3x3 particlesTexture2Transform 304
//float4 particlesTexture2UvMinMax 352
//float4 particlesTexture2BorderColor 368
//float4 particlesTexture3Size 384
//float4 particlesTexture3Dims 400
//float4 particlesTexture3View 416
//float3x3 particlesTexture3Transform 432
//float4 particlesTexture3UvMinMax 480
//float4 particlesTexture3BorderColor 496
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 particlesTexture0Size;
float4 particlesTexture0Dims;
float4 particlesTexture0View;
float3x3 particlesTexture0Transform;
float4 particlesTexture0UvMinMax;
float4 particlesTexture0BorderColor;
float4 particlesTexture1Size;
float4 particlesTexture1Dims;
float4 particlesTexture1View;
float3x3 particlesTexture1Transform;
float4 particlesTexture1UvMinMax;
float4 particlesTexture1BorderColor;
float4 particlesTexture2Size;
float4 particlesTexture2Dims;
float4 particlesTexture2View;
float3x3 particlesTexture2Transform;
float4 particlesTexture2UvMinMax;
float4 particlesTexture2BorderColor;
float4 particlesTexture3Size;
float4 particlesTexture3Dims;
float4 particlesTexture3View;
float3x3 particlesTexture3Transform;
float4 particlesTexture3UvMinMax;
float4 particlesTexture3BorderColor;
};
#ifndef particlesTexture0HasSwappedViews
#define particlesTexture0HasSwappedViews 0
#elif particlesTexture0HasSwappedViews==1
#undef particlesTexture0HasSwappedViews
#define particlesTexture0HasSwappedViews 1
#endif
#ifndef particlesTexture0Layout
#define particlesTexture0Layout 0
#endif
#ifndef particlesTexture1HasSwappedViews
#define particlesTexture1HasSwappedViews 0
#elif particlesTexture1HasSwappedViews==1
#undef particlesTexture1HasSwappedViews
#define particlesTexture1HasSwappedViews 1
#endif
#ifndef particlesTexture1Layout
#define particlesTexture1Layout 0
#endif
#ifndef particlesTexture2HasSwappedViews
#define particlesTexture2HasSwappedViews 0
#elif particlesTexture2HasSwappedViews==1
#undef particlesTexture2HasSwappedViews
#define particlesTexture2HasSwappedViews 1
#endif
#ifndef particlesTexture2Layout
#define particlesTexture2Layout 0
#endif
#ifndef particlesTexture3HasSwappedViews
#define particlesTexture3HasSwappedViews 0
#elif particlesTexture3HasSwappedViews==1
#undef particlesTexture3HasSwappedViews
#define particlesTexture3HasSwappedViews 1
#endif
#ifndef particlesTexture3Layout
#define particlesTexture3Layout 0
#endif
#ifndef NUM_COLORS
#define NUM_COLORS 0
#endif
#ifndef NUM_TEXTURES
#define NUM_TEXTURES 0
#endif
#ifndef ALPHATEST
#define ALPHATEST 0
#elif ALPHATEST==1
#undef ALPHATEST
#define ALPHATEST 1
#endif
#ifndef NUM_STAGES
#define NUM_STAGES 0
#endif
#ifndef STAGE0_RGB_OP
#define STAGE0_RGB_OP 0
#endif
#ifndef STAGE0_ALPHA_OP
#define STAGE0_ALPHA_OP 0
#endif
#ifndef STAGE0_RGB_ARG1
#define STAGE0_RGB_ARG1 0
#endif
#ifndef STAGE0_ALPHA_ARG1
#define STAGE0_ALPHA_ARG1 0
#endif
#ifndef STAGE0_RGB_ARG2
#define STAGE0_RGB_ARG2 0
#endif
#ifndef STAGE0_ALPHA_ARG2
#define STAGE0_ALPHA_ARG2 0
#endif
#ifndef STAGE1_RGB_OP
#define STAGE1_RGB_OP 0
#endif
#ifndef STAGE1_ALPHA_OP
#define STAGE1_ALPHA_OP 0
#endif
#ifndef STAGE1_RGB_ARG1
#define STAGE1_RGB_ARG1 0
#endif
#ifndef STAGE1_ALPHA_ARG1
#define STAGE1_ALPHA_ARG1 0
#endif
#ifndef STAGE1_RGB_ARG2
#define STAGE1_RGB_ARG2 0
#endif
#ifndef STAGE1_ALPHA_ARG2
#define STAGE1_ALPHA_ARG2 0
#endif
#ifndef STAGE2_RGB_OP
#define STAGE2_RGB_OP 0
#endif
#ifndef STAGE2_ALPHA_OP
#define STAGE2_ALPHA_OP 0
#endif
#ifndef STAGE2_RGB_ARG1
#define STAGE2_RGB_ARG1 0
#endif
#ifndef STAGE2_ALPHA_ARG1
#define STAGE2_ALPHA_ARG1 0
#endif
#ifndef STAGE2_RGB_ARG2
#define STAGE2_RGB_ARG2 0
#endif
#ifndef STAGE2_ALPHA_ARG2
#define STAGE2_ALPHA_ARG2 0
#endif
#ifndef STAGE3_RGB_OP
#define STAGE3_RGB_OP 0
#endif
#ifndef STAGE3_ALPHA_OP
#define STAGE3_ALPHA_OP 0
#endif
#ifndef STAGE3_RGB_ARG1
#define STAGE3_RGB_ARG1 0
#endif
#ifndef STAGE3_ALPHA_ARG1
#define STAGE3_ALPHA_ARG1 0
#endif
#ifndef STAGE3_RGB_ARG2
#define STAGE3_RGB_ARG2 0
#endif
#ifndef STAGE3_ALPHA_ARG2
#define STAGE3_ALPHA_ARG2 0
#endif
#ifndef particlesTexture0UV
#define particlesTexture0UV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_particlesTexture0
#define SC_USE_UV_TRANSFORM_particlesTexture0 0
#elif SC_USE_UV_TRANSFORM_particlesTexture0==1
#undef SC_USE_UV_TRANSFORM_particlesTexture0
#define SC_USE_UV_TRANSFORM_particlesTexture0 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_particlesTexture0
#define SC_SOFTWARE_WRAP_MODE_U_particlesTexture0 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_particlesTexture0
#define SC_SOFTWARE_WRAP_MODE_V_particlesTexture0 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_particlesTexture0
#define SC_USE_UV_MIN_MAX_particlesTexture0 0
#elif SC_USE_UV_MIN_MAX_particlesTexture0==1
#undef SC_USE_UV_MIN_MAX_particlesTexture0
#define SC_USE_UV_MIN_MAX_particlesTexture0 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_particlesTexture0
#define SC_USE_CLAMP_TO_BORDER_particlesTexture0 0
#elif SC_USE_CLAMP_TO_BORDER_particlesTexture0==1
#undef SC_USE_CLAMP_TO_BORDER_particlesTexture0
#define SC_USE_CLAMP_TO_BORDER_particlesTexture0 1
#endif
#ifndef particlesTexture1UV
#define particlesTexture1UV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_particlesTexture1
#define SC_USE_UV_TRANSFORM_particlesTexture1 0
#elif SC_USE_UV_TRANSFORM_particlesTexture1==1
#undef SC_USE_UV_TRANSFORM_particlesTexture1
#define SC_USE_UV_TRANSFORM_particlesTexture1 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_particlesTexture1
#define SC_SOFTWARE_WRAP_MODE_U_particlesTexture1 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_particlesTexture1
#define SC_SOFTWARE_WRAP_MODE_V_particlesTexture1 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_particlesTexture1
#define SC_USE_UV_MIN_MAX_particlesTexture1 0
#elif SC_USE_UV_MIN_MAX_particlesTexture1==1
#undef SC_USE_UV_MIN_MAX_particlesTexture1
#define SC_USE_UV_MIN_MAX_particlesTexture1 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_particlesTexture1
#define SC_USE_CLAMP_TO_BORDER_particlesTexture1 0
#elif SC_USE_CLAMP_TO_BORDER_particlesTexture1==1
#undef SC_USE_CLAMP_TO_BORDER_particlesTexture1
#define SC_USE_CLAMP_TO_BORDER_particlesTexture1 1
#endif
#ifndef particlesTexture2UV
#define particlesTexture2UV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_particlesTexture2
#define SC_USE_UV_TRANSFORM_particlesTexture2 0
#elif SC_USE_UV_TRANSFORM_particlesTexture2==1
#undef SC_USE_UV_TRANSFORM_particlesTexture2
#define SC_USE_UV_TRANSFORM_particlesTexture2 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_particlesTexture2
#define SC_SOFTWARE_WRAP_MODE_U_particlesTexture2 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_particlesTexture2
#define SC_SOFTWARE_WRAP_MODE_V_particlesTexture2 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_particlesTexture2
#define SC_USE_UV_MIN_MAX_particlesTexture2 0
#elif SC_USE_UV_MIN_MAX_particlesTexture2==1
#undef SC_USE_UV_MIN_MAX_particlesTexture2
#define SC_USE_UV_MIN_MAX_particlesTexture2 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_particlesTexture2
#define SC_USE_CLAMP_TO_BORDER_particlesTexture2 0
#elif SC_USE_CLAMP_TO_BORDER_particlesTexture2==1
#undef SC_USE_CLAMP_TO_BORDER_particlesTexture2
#define SC_USE_CLAMP_TO_BORDER_particlesTexture2 1
#endif
#ifndef particlesTexture3UV
#define particlesTexture3UV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_particlesTexture3
#define SC_USE_UV_TRANSFORM_particlesTexture3 0
#elif SC_USE_UV_TRANSFORM_particlesTexture3==1
#undef SC_USE_UV_TRANSFORM_particlesTexture3
#define SC_USE_UV_TRANSFORM_particlesTexture3 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_particlesTexture3
#define SC_SOFTWARE_WRAP_MODE_U_particlesTexture3 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_particlesTexture3
#define SC_SOFTWARE_WRAP_MODE_V_particlesTexture3 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_particlesTexture3
#define SC_USE_UV_MIN_MAX_particlesTexture3 0
#elif SC_USE_UV_MIN_MAX_particlesTexture3==1
#undef SC_USE_UV_MIN_MAX_particlesTexture3
#define SC_USE_UV_MIN_MAX_particlesTexture3 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_particlesTexture3
#define SC_USE_CLAMP_TO_BORDER_particlesTexture3 0
#elif SC_USE_CLAMP_TO_BORDER_particlesTexture3==1
#undef SC_USE_CLAMP_TO_BORDER_particlesTexture3
#define SC_USE_CLAMP_TO_BORDER_particlesTexture3 1
#endif
struct sc_Set2
{
texture2d<float> particlesTexture0 [[id(0)]];
texture2d<float> particlesTexture1 [[id(1)]];
texture2d<float> particlesTexture2 [[id(2)]];
texture2d<float> particlesTexture3 [[id(3)]];
sampler particlesTexture0SmpSC [[id(4)]];
sampler particlesTexture1SmpSC [[id(5)]];
sampler particlesTexture2SmpSC [[id(6)]];
sampler particlesTexture3SmpSC [[id(7)]];
constant userUniformsObj* UserUniforms [[id(8)]];
};
struct sc_VertOut
{
sc_SysOut sc_sysOut;
float4 varColor [[user(locn10)]];
float2 varTex2 [[user(locn11)]];
float2 varTex3 [[user(locn12)]];
};
struct sc_VertIn
{
sc_SysAttributes sc_sysAttributes;
float4 color [[attribute(18)]];
float2 inputTextureCoordinate0 [[attribute(19)]];
float2 inputTextureCoordinate1 [[attribute(20)]];
float2 inputTextureCoordinate2 [[attribute(21)]];
float2 inputTextureCoordinate3 [[attribute(22)]];
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
#if (NUM_COLORS>0)
{
sc_vertOut.varColor=sc_vertIn.color;
}
#endif
#if (NUM_TEXTURES>0)
{
float2 l9_0=float2(sc_vertIn.inputTextureCoordinate0.x,1.0-sc_vertIn.inputTextureCoordinate0.y);
sc_vertOut.sc_sysOut.varPackedTex=float4(l9_0.x,l9_0.y,sc_vertOut.sc_sysOut.varPackedTex.z,sc_vertOut.sc_sysOut.varPackedTex.w);
}
#endif
#if (NUM_TEXTURES>1)
{
float2 l9_1=float2(sc_vertIn.inputTextureCoordinate1.x,1.0-sc_vertIn.inputTextureCoordinate1.y);
sc_vertOut.sc_sysOut.varPackedTex=float4(sc_vertOut.sc_sysOut.varPackedTex.x,sc_vertOut.sc_sysOut.varPackedTex.y,l9_1.x,l9_1.y);
}
#endif
#if (NUM_TEXTURES>2)
{
sc_vertOut.varTex2=float2(sc_vertIn.inputTextureCoordinate2.x,1.0-sc_vertIn.inputTextureCoordinate2.y);
}
#endif
#if (NUM_TEXTURES>3)
{
sc_vertOut.varTex3=float2(sc_vertIn.inputTextureCoordinate3.x,1.0-sc_vertIn.inputTextureCoordinate3.y);
}
#endif
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 particlesTexture0Size;
float4 particlesTexture0Dims;
float4 particlesTexture0View;
float3x3 particlesTexture0Transform;
float4 particlesTexture0UvMinMax;
float4 particlesTexture0BorderColor;
float4 particlesTexture1Size;
float4 particlesTexture1Dims;
float4 particlesTexture1View;
float3x3 particlesTexture1Transform;
float4 particlesTexture1UvMinMax;
float4 particlesTexture1BorderColor;
float4 particlesTexture2Size;
float4 particlesTexture2Dims;
float4 particlesTexture2View;
float3x3 particlesTexture2Transform;
float4 particlesTexture2UvMinMax;
float4 particlesTexture2BorderColor;
float4 particlesTexture3Size;
float4 particlesTexture3Dims;
float4 particlesTexture3View;
float3x3 particlesTexture3Transform;
float4 particlesTexture3UvMinMax;
float4 particlesTexture3BorderColor;
};
#ifndef particlesTexture0HasSwappedViews
#define particlesTexture0HasSwappedViews 0
#elif particlesTexture0HasSwappedViews==1
#undef particlesTexture0HasSwappedViews
#define particlesTexture0HasSwappedViews 1
#endif
#ifndef particlesTexture0Layout
#define particlesTexture0Layout 0
#endif
#ifndef particlesTexture1HasSwappedViews
#define particlesTexture1HasSwappedViews 0
#elif particlesTexture1HasSwappedViews==1
#undef particlesTexture1HasSwappedViews
#define particlesTexture1HasSwappedViews 1
#endif
#ifndef particlesTexture1Layout
#define particlesTexture1Layout 0
#endif
#ifndef particlesTexture2HasSwappedViews
#define particlesTexture2HasSwappedViews 0
#elif particlesTexture2HasSwappedViews==1
#undef particlesTexture2HasSwappedViews
#define particlesTexture2HasSwappedViews 1
#endif
#ifndef particlesTexture2Layout
#define particlesTexture2Layout 0
#endif
#ifndef particlesTexture3HasSwappedViews
#define particlesTexture3HasSwappedViews 0
#elif particlesTexture3HasSwappedViews==1
#undef particlesTexture3HasSwappedViews
#define particlesTexture3HasSwappedViews 1
#endif
#ifndef particlesTexture3Layout
#define particlesTexture3Layout 0
#endif
#ifndef NUM_STAGES
#define NUM_STAGES 0
#endif
#ifndef STAGE0_RGB_ARG1
#define STAGE0_RGB_ARG1 0
#endif
#ifndef STAGE0_ALPHA_ARG1
#define STAGE0_ALPHA_ARG1 0
#endif
#ifndef STAGE0_RGB_ARG2
#define STAGE0_RGB_ARG2 0
#endif
#ifndef STAGE0_ALPHA_ARG2
#define STAGE0_ALPHA_ARG2 0
#endif
#ifndef SC_USE_UV_TRANSFORM_particlesTexture0
#define SC_USE_UV_TRANSFORM_particlesTexture0 0
#elif SC_USE_UV_TRANSFORM_particlesTexture0==1
#undef SC_USE_UV_TRANSFORM_particlesTexture0
#define SC_USE_UV_TRANSFORM_particlesTexture0 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_particlesTexture0
#define SC_SOFTWARE_WRAP_MODE_U_particlesTexture0 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_particlesTexture0
#define SC_SOFTWARE_WRAP_MODE_V_particlesTexture0 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_particlesTexture0
#define SC_USE_UV_MIN_MAX_particlesTexture0 0
#elif SC_USE_UV_MIN_MAX_particlesTexture0==1
#undef SC_USE_UV_MIN_MAX_particlesTexture0
#define SC_USE_UV_MIN_MAX_particlesTexture0 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_particlesTexture0
#define SC_USE_CLAMP_TO_BORDER_particlesTexture0 0
#elif SC_USE_CLAMP_TO_BORDER_particlesTexture0==1
#undef SC_USE_CLAMP_TO_BORDER_particlesTexture0
#define SC_USE_CLAMP_TO_BORDER_particlesTexture0 1
#endif
#ifndef STAGE0_RGB_OP
#define STAGE0_RGB_OP 0
#endif
#ifndef STAGE0_ALPHA_OP
#define STAGE0_ALPHA_OP 0
#endif
#ifndef STAGE1_RGB_ARG1
#define STAGE1_RGB_ARG1 0
#endif
#ifndef STAGE1_ALPHA_ARG1
#define STAGE1_ALPHA_ARG1 0
#endif
#ifndef STAGE1_RGB_ARG2
#define STAGE1_RGB_ARG2 0
#endif
#ifndef STAGE1_ALPHA_ARG2
#define STAGE1_ALPHA_ARG2 0
#endif
#ifndef SC_USE_UV_TRANSFORM_particlesTexture1
#define SC_USE_UV_TRANSFORM_particlesTexture1 0
#elif SC_USE_UV_TRANSFORM_particlesTexture1==1
#undef SC_USE_UV_TRANSFORM_particlesTexture1
#define SC_USE_UV_TRANSFORM_particlesTexture1 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_particlesTexture1
#define SC_SOFTWARE_WRAP_MODE_U_particlesTexture1 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_particlesTexture1
#define SC_SOFTWARE_WRAP_MODE_V_particlesTexture1 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_particlesTexture1
#define SC_USE_UV_MIN_MAX_particlesTexture1 0
#elif SC_USE_UV_MIN_MAX_particlesTexture1==1
#undef SC_USE_UV_MIN_MAX_particlesTexture1
#define SC_USE_UV_MIN_MAX_particlesTexture1 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_particlesTexture1
#define SC_USE_CLAMP_TO_BORDER_particlesTexture1 0
#elif SC_USE_CLAMP_TO_BORDER_particlesTexture1==1
#undef SC_USE_CLAMP_TO_BORDER_particlesTexture1
#define SC_USE_CLAMP_TO_BORDER_particlesTexture1 1
#endif
#ifndef STAGE1_RGB_OP
#define STAGE1_RGB_OP 0
#endif
#ifndef STAGE1_ALPHA_OP
#define STAGE1_ALPHA_OP 0
#endif
#ifndef STAGE2_RGB_ARG1
#define STAGE2_RGB_ARG1 0
#endif
#ifndef STAGE2_ALPHA_ARG1
#define STAGE2_ALPHA_ARG1 0
#endif
#ifndef STAGE2_RGB_ARG2
#define STAGE2_RGB_ARG2 0
#endif
#ifndef STAGE2_ALPHA_ARG2
#define STAGE2_ALPHA_ARG2 0
#endif
#ifndef SC_USE_UV_TRANSFORM_particlesTexture2
#define SC_USE_UV_TRANSFORM_particlesTexture2 0
#elif SC_USE_UV_TRANSFORM_particlesTexture2==1
#undef SC_USE_UV_TRANSFORM_particlesTexture2
#define SC_USE_UV_TRANSFORM_particlesTexture2 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_particlesTexture2
#define SC_SOFTWARE_WRAP_MODE_U_particlesTexture2 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_particlesTexture2
#define SC_SOFTWARE_WRAP_MODE_V_particlesTexture2 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_particlesTexture2
#define SC_USE_UV_MIN_MAX_particlesTexture2 0
#elif SC_USE_UV_MIN_MAX_particlesTexture2==1
#undef SC_USE_UV_MIN_MAX_particlesTexture2
#define SC_USE_UV_MIN_MAX_particlesTexture2 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_particlesTexture2
#define SC_USE_CLAMP_TO_BORDER_particlesTexture2 0
#elif SC_USE_CLAMP_TO_BORDER_particlesTexture2==1
#undef SC_USE_CLAMP_TO_BORDER_particlesTexture2
#define SC_USE_CLAMP_TO_BORDER_particlesTexture2 1
#endif
#ifndef STAGE2_RGB_OP
#define STAGE2_RGB_OP 0
#endif
#ifndef STAGE2_ALPHA_OP
#define STAGE2_ALPHA_OP 0
#endif
#ifndef STAGE3_RGB_ARG1
#define STAGE3_RGB_ARG1 0
#endif
#ifndef STAGE3_ALPHA_ARG1
#define STAGE3_ALPHA_ARG1 0
#endif
#ifndef STAGE3_RGB_ARG2
#define STAGE3_RGB_ARG2 0
#endif
#ifndef STAGE3_ALPHA_ARG2
#define STAGE3_ALPHA_ARG2 0
#endif
#ifndef SC_USE_UV_TRANSFORM_particlesTexture3
#define SC_USE_UV_TRANSFORM_particlesTexture3 0
#elif SC_USE_UV_TRANSFORM_particlesTexture3==1
#undef SC_USE_UV_TRANSFORM_particlesTexture3
#define SC_USE_UV_TRANSFORM_particlesTexture3 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_particlesTexture3
#define SC_SOFTWARE_WRAP_MODE_U_particlesTexture3 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_particlesTexture3
#define SC_SOFTWARE_WRAP_MODE_V_particlesTexture3 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_particlesTexture3
#define SC_USE_UV_MIN_MAX_particlesTexture3 0
#elif SC_USE_UV_MIN_MAX_particlesTexture3==1
#undef SC_USE_UV_MIN_MAX_particlesTexture3
#define SC_USE_UV_MIN_MAX_particlesTexture3 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_particlesTexture3
#define SC_USE_CLAMP_TO_BORDER_particlesTexture3 0
#elif SC_USE_CLAMP_TO_BORDER_particlesTexture3==1
#undef SC_USE_CLAMP_TO_BORDER_particlesTexture3
#define SC_USE_CLAMP_TO_BORDER_particlesTexture3 1
#endif
#ifndef STAGE3_RGB_OP
#define STAGE3_RGB_OP 0
#endif
#ifndef STAGE3_ALPHA_OP
#define STAGE3_ALPHA_OP 0
#endif
#ifndef ALPHATEST
#define ALPHATEST 0
#elif ALPHATEST==1
#undef ALPHATEST
#define ALPHATEST 1
#endif
#ifndef NUM_COLORS
#define NUM_COLORS 0
#endif
#ifndef NUM_TEXTURES
#define NUM_TEXTURES 0
#endif
#ifndef particlesTexture0UV
#define particlesTexture0UV 0
#endif
#ifndef particlesTexture1UV
#define particlesTexture1UV 0
#endif
#ifndef particlesTexture2UV
#define particlesTexture2UV 0
#endif
#ifndef particlesTexture3UV
#define particlesTexture3UV 0
#endif
struct sc_Set2
{
texture2d<float> particlesTexture0 [[id(0)]];
texture2d<float> particlesTexture1 [[id(1)]];
texture2d<float> particlesTexture2 [[id(2)]];
texture2d<float> particlesTexture3 [[id(3)]];
sampler particlesTexture0SmpSC [[id(4)]];
sampler particlesTexture1SmpSC [[id(5)]];
sampler particlesTexture2SmpSC [[id(6)]];
sampler particlesTexture3SmpSC [[id(7)]];
constant userUniformsObj* UserUniforms [[id(8)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
float4 varColor [[user(locn10)]];
float2 varTex2 [[user(locn11)]];
float2 varTex3 [[user(locn12)]];
};
float2 particlesTexture0GetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.particlesTexture0Dims.xy;
}
int particlesTexture0GetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (particlesTexture0HasSwappedViews)
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
float2 particlesTexture1GetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.particlesTexture1Dims.xy;
}
int particlesTexture1GetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (particlesTexture1HasSwappedViews)
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
float2 particlesTexture2GetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.particlesTexture2Dims.xy;
}
int particlesTexture2GetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (particlesTexture2HasSwappedViews)
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
float2 particlesTexture3GetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.particlesTexture3Dims.xy;
}
int particlesTexture3GetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (particlesTexture3HasSwappedViews)
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
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float4 color;
#if (NUM_STAGES==0)
{
color=sc_fragIn.varColor;
}
#endif
float4 colorTex;
float4 arg1;
float4 arg2;
#if (NUM_STAGES>0)
{
#if ((((STAGE0_RGB_ARG1==2)||(STAGE0_ALPHA_ARG1==2))||(STAGE0_RGB_ARG2==2))||(STAGE0_ALPHA_ARG2==2))
{
float2 param=particlesTexture0GetDims2D((*sc_set2.UserUniforms));
int param_1=particlesTexture0Layout;
int param_2=particlesTexture0GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=(int(SC_USE_UV_TRANSFORM_particlesTexture0)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).particlesTexture0Transform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_particlesTexture0,SC_SOFTWARE_WRAP_MODE_V_particlesTexture0);
bool param_7=(int(SC_USE_UV_MIN_MAX_particlesTexture0)!=0);
float4 param_8=(*sc_set2.UserUniforms).particlesTexture0UvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_particlesTexture0)!=0);
float4 param_10=(*sc_set2.UserUniforms).particlesTexture0BorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.particlesTexture0,sc_set2.particlesTexture0SmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 particlesTexture0Sample=l9_0;
colorTex=particlesTexture0Sample;
}
#endif
#if (STAGE0_RGB_ARG1==0)
{
arg1=float4(color.xyz.x,color.xyz.y,color.xyz.z,arg1.w);
}
#else
{
#if (STAGE0_RGB_ARG1==1)
{
arg1=float4(sc_fragIn.varColor.xyz.x,sc_fragIn.varColor.xyz.y,sc_fragIn.varColor.xyz.z,arg1.w);
}
#else
{
#if (STAGE0_RGB_ARG1==2)
{
arg1=float4(colorTex.xyz.x,colorTex.xyz.y,colorTex.xyz.z,arg1.w);
}
#endif
}
#endif
}
#endif
#if (STAGE0_ALPHA_ARG1==0)
{
arg1.w=color.w;
}
#else
{
#if (STAGE0_ALPHA_ARG1==1)
{
arg1.w=sc_fragIn.varColor.w;
}
#else
{
#if (STAGE0_ALPHA_ARG1==2)
{
arg1.w=colorTex.w;
}
#endif
}
#endif
}
#endif
#if (STAGE0_RGB_ARG2==0)
{
arg2=float4(color.xyz.x,color.xyz.y,color.xyz.z,arg2.w);
}
#else
{
#if (STAGE0_RGB_ARG2==1)
{
arg2=float4(sc_fragIn.varColor.xyz.x,sc_fragIn.varColor.xyz.y,sc_fragIn.varColor.xyz.z,arg2.w);
}
#else
{
#if (STAGE0_RGB_ARG2==2)
{
arg2=float4(colorTex.xyz.x,colorTex.xyz.y,colorTex.xyz.z,arg2.w);
}
#endif
}
#endif
}
#endif
#if (STAGE0_ALPHA_ARG2==0)
{
arg2.w=color.w;
}
#else
{
#if (STAGE0_ALPHA_ARG2==1)
{
arg2.w=sc_fragIn.varColor.w;
}
#else
{
#if (STAGE0_ALPHA_ARG2==2)
{
arg2.w=colorTex.w;
}
#endif
}
#endif
}
#endif
#if (STAGE0_RGB_OP==0)
{
color=float4(arg1.xyz.x,arg1.xyz.y,arg1.xyz.z,color.w);
}
#else
{
#if (STAGE0_RGB_OP==1)
{
float3 l9_2=arg1.xyz+arg2.xyz;
color=float4(l9_2.x,l9_2.y,l9_2.z,color.w);
}
#else
{
#if (STAGE0_RGB_OP==2)
{
float3 l9_3=arg1.xyz-arg2.xyz;
color=float4(l9_3.x,l9_3.y,l9_3.z,color.w);
}
#else
{
#if (STAGE0_RGB_OP==3)
{
float3 l9_4=arg1.xyz*arg2.xyz;
color=float4(l9_4.x,l9_4.y,l9_4.z,color.w);
}
#else
{
#if (STAGE0_RGB_OP==4)
{
float3 l9_5=arg1.xyz*arg2.xyz;
color=float4(l9_5.x,l9_5.y,l9_5.z,color.w);
float3 l9_6=color.xyz+color.xyz;
color=float4(l9_6.x,l9_6.y,l9_6.z,color.w);
}
#else
{
float3 l9_7=arg1.xyz*arg2.xyz;
color=float4(l9_7.x,l9_7.y,l9_7.z,color.w);
float3 l9_8=color.xyz*4.0;
color=float4(l9_8.x,l9_8.y,l9_8.z,color.w);
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
#if (STAGE0_ALPHA_OP==0)
{
color.w=arg1.w;
}
#else
{
#if (STAGE0_ALPHA_OP==1)
{
color.w=arg1.w+arg2.w;
}
#else
{
#if (STAGE0_ALPHA_OP==2)
{
color.w=arg1.w-arg2.w;
}
#else
{
#if (STAGE0_ALPHA_OP==3)
{
color.w=arg1.w*arg2.w;
}
#else
{
#if (STAGE0_ALPHA_OP==4)
{
color.w=arg1.w*arg2.w;
color.w+=color.w;
}
#else
{
color.w=arg1.w*arg2.w;
color.w*=4.0;
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
#if (NUM_STAGES>1)
{
#if ((((STAGE1_RGB_ARG1==2)||(STAGE1_ALPHA_ARG1==2))||(STAGE1_RGB_ARG2==2))||(STAGE1_ALPHA_ARG2==2))
{
float2 param_12=particlesTexture1GetDims2D((*sc_set2.UserUniforms));
int param_13=particlesTexture1Layout;
int param_14=particlesTexture1GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_15=sc_fragIn.sc_sysIn.varPackedTex.zw;
bool param_16=(int(SC_USE_UV_TRANSFORM_particlesTexture1)!=0);
float3x3 param_17=(*sc_set2.UserUniforms).particlesTexture1Transform;
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_particlesTexture1,SC_SOFTWARE_WRAP_MODE_V_particlesTexture1);
bool param_19=(int(SC_USE_UV_MIN_MAX_particlesTexture1)!=0);
float4 param_20=(*sc_set2.UserUniforms).particlesTexture1UvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_particlesTexture1)!=0);
float4 param_22=(*sc_set2.UserUniforms).particlesTexture1BorderColor;
float param_23=0.0;
float4 l9_9=sc_SampleTextureBiasOrLevel(sc_set2.particlesTexture1,sc_set2.particlesTexture1SmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_10=l9_9;
float4 particlesTexture1Sample=l9_9;
colorTex=particlesTexture1Sample;
}
#endif
#if (STAGE1_RGB_ARG1==0)
{
arg1=float4(color.xyz.x,color.xyz.y,color.xyz.z,arg1.w);
}
#else
{
#if (STAGE1_RGB_ARG1==1)
{
arg1=float4(sc_fragIn.varColor.xyz.x,sc_fragIn.varColor.xyz.y,sc_fragIn.varColor.xyz.z,arg1.w);
}
#else
{
#if (STAGE1_RGB_ARG1==2)
{
arg1=float4(colorTex.xyz.x,colorTex.xyz.y,colorTex.xyz.z,arg1.w);
}
#endif
}
#endif
}
#endif
#if (STAGE1_ALPHA_ARG1==0)
{
arg1.w=color.w;
}
#else
{
#if (STAGE1_ALPHA_ARG1==1)
{
arg1.w=sc_fragIn.varColor.w;
}
#else
{
#if (STAGE1_ALPHA_ARG1==2)
{
arg1.w=colorTex.w;
}
#endif
}
#endif
}
#endif
#if (STAGE1_RGB_ARG2==0)
{
arg2=float4(color.xyz.x,color.xyz.y,color.xyz.z,arg2.w);
}
#else
{
#if (STAGE1_RGB_ARG2==1)
{
arg2=float4(sc_fragIn.varColor.xyz.x,sc_fragIn.varColor.xyz.y,sc_fragIn.varColor.xyz.z,arg2.w);
}
#else
{
#if (STAGE1_RGB_ARG2==2)
{
arg2=float4(colorTex.xyz.x,colorTex.xyz.y,colorTex.xyz.z,arg2.w);
}
#endif
}
#endif
}
#endif
#if (STAGE1_ALPHA_ARG2==0)
{
arg2.w=color.w;
}
#else
{
#if (STAGE1_ALPHA_ARG2==1)
{
arg2.w=sc_fragIn.varColor.w;
}
#else
{
#if (STAGE1_ALPHA_ARG2==2)
{
arg2.w=colorTex.w;
}
#endif
}
#endif
}
#endif
#if (STAGE1_RGB_OP==0)
{
color=float4(arg1.xyz.x,arg1.xyz.y,arg1.xyz.z,color.w);
}
#else
{
#if (STAGE1_RGB_OP==1)
{
float3 l9_11=arg1.xyz+arg2.xyz;
color=float4(l9_11.x,l9_11.y,l9_11.z,color.w);
}
#else
{
#if (STAGE1_RGB_OP==2)
{
float3 l9_12=arg1.xyz-arg2.xyz;
color=float4(l9_12.x,l9_12.y,l9_12.z,color.w);
}
#else
{
#if (STAGE1_RGB_OP==3)
{
float3 l9_13=arg1.xyz*arg2.xyz;
color=float4(l9_13.x,l9_13.y,l9_13.z,color.w);
}
#else
{
#if (STAGE1_RGB_OP==4)
{
float3 l9_14=arg1.xyz*arg2.xyz;
color=float4(l9_14.x,l9_14.y,l9_14.z,color.w);
float3 l9_15=color.xyz+color.xyz;
color=float4(l9_15.x,l9_15.y,l9_15.z,color.w);
}
#else
{
float3 l9_16=arg1.xyz*arg2.xyz;
color=float4(l9_16.x,l9_16.y,l9_16.z,color.w);
float3 l9_17=color.xyz*4.0;
color=float4(l9_17.x,l9_17.y,l9_17.z,color.w);
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
#if (STAGE1_ALPHA_OP==0)
{
color.w=arg1.w;
}
#else
{
#if (STAGE1_ALPHA_OP==1)
{
color.w=arg1.w+arg2.w;
}
#else
{
#if (STAGE1_ALPHA_OP==2)
{
color.w=arg1.w-arg2.w;
}
#else
{
#if (STAGE1_ALPHA_OP==3)
{
color.w=arg1.w*arg2.w;
}
#else
{
#if (STAGE1_ALPHA_OP==4)
{
color.w=arg1.w*arg2.w;
color.w+=color.w;
}
#else
{
color.w=arg1.w*arg2.w;
color.w*=4.0;
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
#if (NUM_STAGES>2)
{
#if ((((STAGE2_RGB_ARG1==2)||(STAGE2_ALPHA_ARG1==2))||(STAGE2_RGB_ARG2==2))||(STAGE2_ALPHA_ARG2==2))
{
float2 param_24=particlesTexture2GetDims2D((*sc_set2.UserUniforms));
int param_25=particlesTexture2Layout;
int param_26=particlesTexture2GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_27=sc_fragIn.varTex2;
bool param_28=(int(SC_USE_UV_TRANSFORM_particlesTexture2)!=0);
float3x3 param_29=(*sc_set2.UserUniforms).particlesTexture2Transform;
int2 param_30=int2(SC_SOFTWARE_WRAP_MODE_U_particlesTexture2,SC_SOFTWARE_WRAP_MODE_V_particlesTexture2);
bool param_31=(int(SC_USE_UV_MIN_MAX_particlesTexture2)!=0);
float4 param_32=(*sc_set2.UserUniforms).particlesTexture2UvMinMax;
bool param_33=(int(SC_USE_CLAMP_TO_BORDER_particlesTexture2)!=0);
float4 param_34=(*sc_set2.UserUniforms).particlesTexture2BorderColor;
float param_35=0.0;
float4 l9_18=sc_SampleTextureBiasOrLevel(sc_set2.particlesTexture2,sc_set2.particlesTexture2SmpSC,param_24,param_25,param_26,param_27,param_28,param_29,param_30,param_31,param_32,param_33,param_34,param_35);
float4 l9_19=l9_18;
float4 particlesTexture2Sample=l9_18;
colorTex=particlesTexture2Sample;
}
#endif
#if (STAGE2_RGB_ARG1==0)
{
arg1=float4(color.xyz.x,color.xyz.y,color.xyz.z,arg1.w);
}
#else
{
#if (STAGE2_RGB_ARG1==1)
{
arg1=float4(sc_fragIn.varColor.xyz.x,sc_fragIn.varColor.xyz.y,sc_fragIn.varColor.xyz.z,arg1.w);
}
#else
{
#if (STAGE2_RGB_ARG1==2)
{
arg1=float4(colorTex.xyz.x,colorTex.xyz.y,colorTex.xyz.z,arg1.w);
}
#endif
}
#endif
}
#endif
#if (STAGE2_ALPHA_ARG1==0)
{
arg1.w=color.w;
}
#else
{
#if (STAGE2_ALPHA_ARG1==1)
{
arg1.w=sc_fragIn.varColor.w;
}
#else
{
#if (STAGE2_ALPHA_ARG1==2)
{
arg1.w=colorTex.w;
}
#endif
}
#endif
}
#endif
#if (STAGE2_RGB_ARG2==0)
{
arg2=float4(color.xyz.x,color.xyz.y,color.xyz.z,arg2.w);
}
#else
{
#if (STAGE2_RGB_ARG2==1)
{
arg2=float4(sc_fragIn.varColor.xyz.x,sc_fragIn.varColor.xyz.y,sc_fragIn.varColor.xyz.z,arg2.w);
}
#else
{
#if (STAGE2_RGB_ARG2==2)
{
arg2=float4(colorTex.xyz.x,colorTex.xyz.y,colorTex.xyz.z,arg2.w);
}
#endif
}
#endif
}
#endif
#if (STAGE2_ALPHA_ARG2==0)
{
arg2.w=color.w;
}
#else
{
#if (STAGE2_ALPHA_ARG2==1)
{
arg2.w=sc_fragIn.varColor.w;
}
#else
{
#if (STAGE2_ALPHA_ARG2==2)
{
arg2.w=colorTex.w;
}
#endif
}
#endif
}
#endif
#if (STAGE2_RGB_OP==0)
{
color=float4(arg1.xyz.x,arg1.xyz.y,arg1.xyz.z,color.w);
}
#else
{
#if (STAGE2_RGB_OP==1)
{
float3 l9_20=arg1.xyz+arg2.xyz;
color=float4(l9_20.x,l9_20.y,l9_20.z,color.w);
}
#else
{
#if (STAGE2_RGB_OP==2)
{
float3 l9_21=arg1.xyz-arg2.xyz;
color=float4(l9_21.x,l9_21.y,l9_21.z,color.w);
}
#else
{
#if (STAGE2_RGB_OP==3)
{
float3 l9_22=arg1.xyz*arg2.xyz;
color=float4(l9_22.x,l9_22.y,l9_22.z,color.w);
}
#else
{
#if (STAGE2_RGB_OP==4)
{
float3 l9_23=arg1.xyz*arg2.xyz;
color=float4(l9_23.x,l9_23.y,l9_23.z,color.w);
float3 l9_24=color.xyz+color.xyz;
color=float4(l9_24.x,l9_24.y,l9_24.z,color.w);
}
#else
{
float3 l9_25=arg1.xyz*arg2.xyz;
color=float4(l9_25.x,l9_25.y,l9_25.z,color.w);
float3 l9_26=color.xyz*4.0;
color=float4(l9_26.x,l9_26.y,l9_26.z,color.w);
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
#if (STAGE2_ALPHA_OP==0)
{
color.w=arg1.w;
}
#else
{
#if (STAGE2_ALPHA_OP==1)
{
color.w=arg1.w+arg2.w;
}
#else
{
#if (STAGE2_ALPHA_OP==2)
{
color.w=arg1.w-arg2.w;
}
#else
{
#if (STAGE2_ALPHA_OP==3)
{
color.w=arg1.w*arg2.w;
}
#else
{
#if (STAGE2_ALPHA_OP==4)
{
color.w=arg1.w*arg2.w;
color.w+=color.w;
}
#else
{
color.w=arg1.w*arg2.w;
color.w*=4.0;
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
#if (NUM_STAGES>3)
{
#if ((((STAGE3_RGB_ARG1==2)||(STAGE3_ALPHA_ARG1==2))||(STAGE3_RGB_ARG2==2))||(STAGE3_ALPHA_ARG2==2))
{
float2 param_36=particlesTexture3GetDims2D((*sc_set2.UserUniforms));
int param_37=particlesTexture3Layout;
int param_38=particlesTexture3GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_39=sc_fragIn.varTex3;
bool param_40=(int(SC_USE_UV_TRANSFORM_particlesTexture3)!=0);
float3x3 param_41=(*sc_set2.UserUniforms).particlesTexture3Transform;
int2 param_42=int2(SC_SOFTWARE_WRAP_MODE_U_particlesTexture3,SC_SOFTWARE_WRAP_MODE_V_particlesTexture3);
bool param_43=(int(SC_USE_UV_MIN_MAX_particlesTexture3)!=0);
float4 param_44=(*sc_set2.UserUniforms).particlesTexture3UvMinMax;
bool param_45=(int(SC_USE_CLAMP_TO_BORDER_particlesTexture3)!=0);
float4 param_46=(*sc_set2.UserUniforms).particlesTexture3BorderColor;
float param_47=0.0;
float4 l9_27=sc_SampleTextureBiasOrLevel(sc_set2.particlesTexture3,sc_set2.particlesTexture3SmpSC,param_36,param_37,param_38,param_39,param_40,param_41,param_42,param_43,param_44,param_45,param_46,param_47);
float4 l9_28=l9_27;
float4 particlesTexture3Sample=l9_27;
colorTex=particlesTexture3Sample;
}
#endif
#if (STAGE3_RGB_ARG1==0)
{
arg1=float4(color.xyz.x,color.xyz.y,color.xyz.z,arg1.w);
}
#else
{
#if (STAGE3_RGB_ARG1==1)
{
arg1=float4(sc_fragIn.varColor.xyz.x,sc_fragIn.varColor.xyz.y,sc_fragIn.varColor.xyz.z,arg1.w);
}
#else
{
#if (STAGE3_RGB_ARG1==2)
{
arg1=float4(colorTex.xyz.x,colorTex.xyz.y,colorTex.xyz.z,arg1.w);
}
#endif
}
#endif
}
#endif
#if (STAGE3_ALPHA_ARG1==0)
{
arg1.w=color.w;
}
#else
{
#if (STAGE3_ALPHA_ARG1==1)
{
arg1.w=sc_fragIn.varColor.w;
}
#else
{
#if (STAGE3_ALPHA_ARG1==2)
{
arg1.w=colorTex.w;
}
#endif
}
#endif
}
#endif
#if (STAGE3_RGB_ARG2==0)
{
arg2=float4(color.xyz.x,color.xyz.y,color.xyz.z,arg2.w);
}
#else
{
#if (STAGE3_RGB_ARG2==1)
{
arg2=float4(sc_fragIn.varColor.xyz.x,sc_fragIn.varColor.xyz.y,sc_fragIn.varColor.xyz.z,arg2.w);
}
#else
{
#if (STAGE3_RGB_ARG2==2)
{
arg2=float4(colorTex.xyz.x,colorTex.xyz.y,colorTex.xyz.z,arg2.w);
}
#endif
}
#endif
}
#endif
#if (STAGE3_ALPHA_ARG2==0)
{
arg2.w=color.w;
}
#else
{
#if (STAGE3_ALPHA_ARG2==1)
{
arg2.w=sc_fragIn.varColor.w;
}
#else
{
#if (STAGE3_ALPHA_ARG2==2)
{
arg2.w=colorTex.w;
}
#endif
}
#endif
}
#endif
#if (STAGE3_RGB_OP==0)
{
color=float4(arg1.xyz.x,arg1.xyz.y,arg1.xyz.z,color.w);
}
#else
{
#if (STAGE3_RGB_OP==1)
{
float3 l9_29=arg1.xyz+arg2.xyz;
color=float4(l9_29.x,l9_29.y,l9_29.z,color.w);
}
#else
{
#if (STAGE3_RGB_OP==2)
{
float3 l9_30=arg1.xyz-arg2.xyz;
color=float4(l9_30.x,l9_30.y,l9_30.z,color.w);
}
#else
{
#if (STAGE3_RGB_OP==3)
{
float3 l9_31=arg1.xyz*arg2.xyz;
color=float4(l9_31.x,l9_31.y,l9_31.z,color.w);
}
#else
{
#if (STAGE3_RGB_OP==4)
{
float3 l9_32=arg1.xyz*arg2.xyz;
color=float4(l9_32.x,l9_32.y,l9_32.z,color.w);
float3 l9_33=color.xyz+color.xyz;
color=float4(l9_33.x,l9_33.y,l9_33.z,color.w);
}
#else
{
float3 l9_34=arg1.xyz*arg2.xyz;
color=float4(l9_34.x,l9_34.y,l9_34.z,color.w);
float3 l9_35=color.xyz*4.0;
color=float4(l9_35.x,l9_35.y,l9_35.z,color.w);
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
#if (STAGE3_ALPHA_OP==0)
{
color.w=arg1.w;
}
#else
{
#if (STAGE3_ALPHA_OP==1)
{
color.w=arg1.w+arg2.w;
}
#else
{
#if (STAGE3_ALPHA_OP==2)
{
color.w=arg1.w-arg2.w;
}
#else
{
#if (STAGE3_ALPHA_OP==3)
{
color.w=arg1.w*arg2.w;
}
#else
{
#if (STAGE3_ALPHA_OP==4)
{
color.w=arg1.w*arg2.w;
color.w+=color.w;
}
#else
{
color.w=arg1.w*arg2.w;
color.w*=4.0;
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
}
#endif
bool l9_36;
#if (ALPHATEST)
{
l9_36=color.w==0.0;
}
#else
{
l9_36=(int(ALPHATEST)!=0);
}
#endif
if (l9_36)
{
discard_fragment();
}
float4 param_48=color;
sc_writeFragData0(param_48,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

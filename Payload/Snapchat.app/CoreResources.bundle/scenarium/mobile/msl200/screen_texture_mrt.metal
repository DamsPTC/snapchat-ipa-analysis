#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "std2_vs.metal"
#include "std2_fs.metal"
#include "std2_texture.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler screenTexture0SmpSC 2:4
//sampler sampler screenTexture1SmpSC 2:5
//sampler sampler screenTexture2SmpSC 2:6
//sampler sampler screenTexture3SmpSC 2:7
//texture texture2D screenTexture0 2:0:2:4
//texture texture2D screenTexture1 2:1:2:5
//texture texture2D screenTexture2 2:2:2:6
//texture texture2D screenTexture3 2:3:2:7
//ubo float UserUniforms 2:8:688 {
//float4 screenTexture0Size 0
//float4 screenTexture0Dims 16
//float4 screenTexture0View 32
//float3x3 screenTexture0Transform 48
//float4 screenTexture0UvMinMax 96
//float4 screenTexture0BorderColor 112
//float screenTexture0LOD 128
//float4 color0 144
//float4 screenTexture1Size 160
//float4 screenTexture1Dims 176
//float4 screenTexture1View 192
//float3x3 screenTexture1Transform 208
//float4 screenTexture1UvMinMax 256
//float4 screenTexture1BorderColor 272
//float screenTexture1LOD 288
//float4 color1 304
//float4 screenTexture2Size 320
//float4 screenTexture2Dims 336
//float4 screenTexture2View 352
//float3x3 screenTexture2Transform 368
//float4 screenTexture2UvMinMax 416
//float4 screenTexture2BorderColor 432
//float screenTexture2LOD 448
//float4 color2 464
//float4 screenTexture3Size 480
//float4 screenTexture3Dims 496
//float4 screenTexture3View 512
//float3x3 screenTexture3Transform 528
//float4 screenTexture3UvMinMax 576
//float4 screenTexture3BorderColor 592
//float screenTexture3LOD 608
//float4 color3 624
//float3x3 meshTransform 640
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 screenTexture0Size;
float4 screenTexture0Dims;
float4 screenTexture0View;
float3x3 screenTexture0Transform;
float4 screenTexture0UvMinMax;
float4 screenTexture0BorderColor;
float screenTexture0LOD;
float4 color0;
float4 screenTexture1Size;
float4 screenTexture1Dims;
float4 screenTexture1View;
float3x3 screenTexture1Transform;
float4 screenTexture1UvMinMax;
float4 screenTexture1BorderColor;
float screenTexture1LOD;
float4 color1;
float4 screenTexture2Size;
float4 screenTexture2Dims;
float4 screenTexture2View;
float3x3 screenTexture2Transform;
float4 screenTexture2UvMinMax;
float4 screenTexture2BorderColor;
float screenTexture2LOD;
float4 color2;
float4 screenTexture3Size;
float4 screenTexture3Dims;
float4 screenTexture3View;
float3x3 screenTexture3Transform;
float4 screenTexture3UvMinMax;
float4 screenTexture3BorderColor;
float screenTexture3LOD;
float4 color3;
float3x3 meshTransform;
};
#ifndef screenTexture0HasSwappedViews
#define screenTexture0HasSwappedViews 0
#elif screenTexture0HasSwappedViews==1
#undef screenTexture0HasSwappedViews
#define screenTexture0HasSwappedViews 1
#endif
#ifndef screenTexture0Layout
#define screenTexture0Layout 0
#endif
#ifndef screenTexture1HasSwappedViews
#define screenTexture1HasSwappedViews 0
#elif screenTexture1HasSwappedViews==1
#undef screenTexture1HasSwappedViews
#define screenTexture1HasSwappedViews 1
#endif
#ifndef screenTexture1Layout
#define screenTexture1Layout 0
#endif
#ifndef screenTexture2HasSwappedViews
#define screenTexture2HasSwappedViews 0
#elif screenTexture2HasSwappedViews==1
#undef screenTexture2HasSwappedViews
#define screenTexture2HasSwappedViews 1
#endif
#ifndef screenTexture2Layout
#define screenTexture2Layout 0
#endif
#ifndef screenTexture3HasSwappedViews
#define screenTexture3HasSwappedViews 0
#elif screenTexture3HasSwappedViews==1
#undef screenTexture3HasSwappedViews
#define screenTexture3HasSwappedViews 1
#endif
#ifndef screenTexture3Layout
#define screenTexture3Layout 0
#endif
#ifndef USE_MESH_TRANSFORM
#define USE_MESH_TRANSFORM 0
#elif USE_MESH_TRANSFORM==1
#undef USE_MESH_TRANSFORM
#define USE_MESH_TRANSFORM 1
#endif
#ifndef ONLY_VERTEX_ATTRIBUTE
#define ONLY_VERTEX_ATTRIBUTE 0
#elif ONLY_VERTEX_ATTRIBUTE==1
#undef ONLY_VERTEX_ATTRIBUTE
#define ONLY_VERTEX_ATTRIBUTE 1
#endif
#ifndef SWAP_R_B_CHANNELS
#define SWAP_R_B_CHANNELS 0
#elif SWAP_R_B_CHANNELS==1
#undef SWAP_R_B_CHANNELS
#define SWAP_R_B_CHANNELS 1
#endif
#ifndef GRAYSCALE_AS_ALPHA
#define GRAYSCALE_AS_ALPHA 0
#elif GRAYSCALE_AS_ALPHA==1
#undef GRAYSCALE_AS_ALPHA
#define GRAYSCALE_AS_ALPHA 1
#endif
#ifndef sc_MultipleRenderTarget
#define sc_MultipleRenderTarget 1
#endif
#ifndef screenTexture0UV
#define screenTexture0UV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_screenTexture0
#define SC_USE_UV_TRANSFORM_screenTexture0 0
#elif SC_USE_UV_TRANSFORM_screenTexture0==1
#undef SC_USE_UV_TRANSFORM_screenTexture0
#define SC_USE_UV_TRANSFORM_screenTexture0 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_screenTexture0
#define SC_SOFTWARE_WRAP_MODE_U_screenTexture0 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_screenTexture0
#define SC_SOFTWARE_WRAP_MODE_V_screenTexture0 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_screenTexture0
#define SC_USE_UV_MIN_MAX_screenTexture0 0
#elif SC_USE_UV_MIN_MAX_screenTexture0==1
#undef SC_USE_UV_MIN_MAX_screenTexture0
#define SC_USE_UV_MIN_MAX_screenTexture0 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_screenTexture0
#define SC_USE_CLAMP_TO_BORDER_screenTexture0 0
#elif SC_USE_CLAMP_TO_BORDER_screenTexture0==1
#undef SC_USE_CLAMP_TO_BORDER_screenTexture0
#define SC_USE_CLAMP_TO_BORDER_screenTexture0 1
#endif
#ifndef screenTexture1UV
#define screenTexture1UV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_screenTexture1
#define SC_USE_UV_TRANSFORM_screenTexture1 0
#elif SC_USE_UV_TRANSFORM_screenTexture1==1
#undef SC_USE_UV_TRANSFORM_screenTexture1
#define SC_USE_UV_TRANSFORM_screenTexture1 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_screenTexture1
#define SC_SOFTWARE_WRAP_MODE_U_screenTexture1 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_screenTexture1
#define SC_SOFTWARE_WRAP_MODE_V_screenTexture1 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_screenTexture1
#define SC_USE_UV_MIN_MAX_screenTexture1 0
#elif SC_USE_UV_MIN_MAX_screenTexture1==1
#undef SC_USE_UV_MIN_MAX_screenTexture1
#define SC_USE_UV_MIN_MAX_screenTexture1 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_screenTexture1
#define SC_USE_CLAMP_TO_BORDER_screenTexture1 0
#elif SC_USE_CLAMP_TO_BORDER_screenTexture1==1
#undef SC_USE_CLAMP_TO_BORDER_screenTexture1
#define SC_USE_CLAMP_TO_BORDER_screenTexture1 1
#endif
#ifndef screenTexture2UV
#define screenTexture2UV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_screenTexture2
#define SC_USE_UV_TRANSFORM_screenTexture2 0
#elif SC_USE_UV_TRANSFORM_screenTexture2==1
#undef SC_USE_UV_TRANSFORM_screenTexture2
#define SC_USE_UV_TRANSFORM_screenTexture2 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_screenTexture2
#define SC_SOFTWARE_WRAP_MODE_U_screenTexture2 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_screenTexture2
#define SC_SOFTWARE_WRAP_MODE_V_screenTexture2 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_screenTexture2
#define SC_USE_UV_MIN_MAX_screenTexture2 0
#elif SC_USE_UV_MIN_MAX_screenTexture2==1
#undef SC_USE_UV_MIN_MAX_screenTexture2
#define SC_USE_UV_MIN_MAX_screenTexture2 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_screenTexture2
#define SC_USE_CLAMP_TO_BORDER_screenTexture2 0
#elif SC_USE_CLAMP_TO_BORDER_screenTexture2==1
#undef SC_USE_CLAMP_TO_BORDER_screenTexture2
#define SC_USE_CLAMP_TO_BORDER_screenTexture2 1
#endif
#ifndef screenTexture3UV
#define screenTexture3UV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_screenTexture3
#define SC_USE_UV_TRANSFORM_screenTexture3 0
#elif SC_USE_UV_TRANSFORM_screenTexture3==1
#undef SC_USE_UV_TRANSFORM_screenTexture3
#define SC_USE_UV_TRANSFORM_screenTexture3 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_screenTexture3
#define SC_SOFTWARE_WRAP_MODE_U_screenTexture3 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_screenTexture3
#define SC_SOFTWARE_WRAP_MODE_V_screenTexture3 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_screenTexture3
#define SC_USE_UV_MIN_MAX_screenTexture3 0
#elif SC_USE_UV_MIN_MAX_screenTexture3==1
#undef SC_USE_UV_MIN_MAX_screenTexture3
#define SC_USE_UV_MIN_MAX_screenTexture3 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_screenTexture3
#define SC_USE_CLAMP_TO_BORDER_screenTexture3 0
#elif SC_USE_CLAMP_TO_BORDER_screenTexture3==1
#undef SC_USE_CLAMP_TO_BORDER_screenTexture3
#define SC_USE_CLAMP_TO_BORDER_screenTexture3 1
#endif
struct sc_Set2
{
texture2d<float> screenTexture0 [[id(0)]];
texture2d<float> screenTexture1 [[id(1)]];
texture2d<float> screenTexture2 [[id(2)]];
texture2d<float> screenTexture3 [[id(3)]];
sampler screenTexture0SmpSC [[id(4)]];
sampler screenTexture1SmpSC [[id(5)]];
sampler screenTexture2SmpSC [[id(6)]];
sampler screenTexture3SmpSC [[id(7)]];
constant userUniformsObj* UserUniforms [[id(8)]];
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
float4 unmodifiedPosition=v.position;
#if (USE_MESH_TRANSFORM)
{
float3 l9_0=(*sc_set2.UserUniforms).meshTransform*float3(v.position.xy,1.0);
v.position=float4(l9_0.x,l9_0.y,l9_0.z,v.position.w);
}
#endif
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
#if (ONLY_VERTEX_ATTRIBUTE)
{
float2 l9_1=(unmodifiedPosition.xy+float2(1.0))*0.5;
sc_vertOut.sc_sysOut.varPackedTex=float4(l9_1.x,l9_1.y,sc_vertOut.sc_sysOut.varPackedTex.z,sc_vertOut.sc_sysOut.varPackedTex.w);
}
#endif
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 screenTexture0Size;
float4 screenTexture0Dims;
float4 screenTexture0View;
float3x3 screenTexture0Transform;
float4 screenTexture0UvMinMax;
float4 screenTexture0BorderColor;
float screenTexture0LOD;
float4 color0;
float4 screenTexture1Size;
float4 screenTexture1Dims;
float4 screenTexture1View;
float3x3 screenTexture1Transform;
float4 screenTexture1UvMinMax;
float4 screenTexture1BorderColor;
float screenTexture1LOD;
float4 color1;
float4 screenTexture2Size;
float4 screenTexture2Dims;
float4 screenTexture2View;
float3x3 screenTexture2Transform;
float4 screenTexture2UvMinMax;
float4 screenTexture2BorderColor;
float screenTexture2LOD;
float4 color2;
float4 screenTexture3Size;
float4 screenTexture3Dims;
float4 screenTexture3View;
float3x3 screenTexture3Transform;
float4 screenTexture3UvMinMax;
float4 screenTexture3BorderColor;
float screenTexture3LOD;
float4 color3;
float3x3 meshTransform;
};
#ifndef screenTexture0HasSwappedViews
#define screenTexture0HasSwappedViews 0
#elif screenTexture0HasSwappedViews==1
#undef screenTexture0HasSwappedViews
#define screenTexture0HasSwappedViews 1
#endif
#ifndef screenTexture0Layout
#define screenTexture0Layout 0
#endif
#ifndef screenTexture1HasSwappedViews
#define screenTexture1HasSwappedViews 0
#elif screenTexture1HasSwappedViews==1
#undef screenTexture1HasSwappedViews
#define screenTexture1HasSwappedViews 1
#endif
#ifndef screenTexture1Layout
#define screenTexture1Layout 0
#endif
#ifndef screenTexture2HasSwappedViews
#define screenTexture2HasSwappedViews 0
#elif screenTexture2HasSwappedViews==1
#undef screenTexture2HasSwappedViews
#define screenTexture2HasSwappedViews 1
#endif
#ifndef screenTexture2Layout
#define screenTexture2Layout 0
#endif
#ifndef screenTexture3HasSwappedViews
#define screenTexture3HasSwappedViews 0
#elif screenTexture3HasSwappedViews==1
#undef screenTexture3HasSwappedViews
#define screenTexture3HasSwappedViews 1
#endif
#ifndef screenTexture3Layout
#define screenTexture3Layout 0
#endif
#ifndef SWAP_R_B_CHANNELS
#define SWAP_R_B_CHANNELS 0
#elif SWAP_R_B_CHANNELS==1
#undef SWAP_R_B_CHANNELS
#define SWAP_R_B_CHANNELS 1
#endif
#ifndef GRAYSCALE_AS_ALPHA
#define GRAYSCALE_AS_ALPHA 0
#elif GRAYSCALE_AS_ALPHA==1
#undef GRAYSCALE_AS_ALPHA
#define GRAYSCALE_AS_ALPHA 1
#endif
#ifndef sc_MultipleRenderTarget
#define sc_MultipleRenderTarget 1
#endif
#ifndef SC_USE_UV_TRANSFORM_screenTexture0
#define SC_USE_UV_TRANSFORM_screenTexture0 0
#elif SC_USE_UV_TRANSFORM_screenTexture0==1
#undef SC_USE_UV_TRANSFORM_screenTexture0
#define SC_USE_UV_TRANSFORM_screenTexture0 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_screenTexture0
#define SC_SOFTWARE_WRAP_MODE_U_screenTexture0 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_screenTexture0
#define SC_SOFTWARE_WRAP_MODE_V_screenTexture0 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_screenTexture0
#define SC_USE_UV_MIN_MAX_screenTexture0 0
#elif SC_USE_UV_MIN_MAX_screenTexture0==1
#undef SC_USE_UV_MIN_MAX_screenTexture0
#define SC_USE_UV_MIN_MAX_screenTexture0 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_screenTexture0
#define SC_USE_CLAMP_TO_BORDER_screenTexture0 0
#elif SC_USE_CLAMP_TO_BORDER_screenTexture0==1
#undef SC_USE_CLAMP_TO_BORDER_screenTexture0
#define SC_USE_CLAMP_TO_BORDER_screenTexture0 1
#endif
#ifndef SC_USE_UV_TRANSFORM_screenTexture1
#define SC_USE_UV_TRANSFORM_screenTexture1 0
#elif SC_USE_UV_TRANSFORM_screenTexture1==1
#undef SC_USE_UV_TRANSFORM_screenTexture1
#define SC_USE_UV_TRANSFORM_screenTexture1 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_screenTexture1
#define SC_SOFTWARE_WRAP_MODE_U_screenTexture1 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_screenTexture1
#define SC_SOFTWARE_WRAP_MODE_V_screenTexture1 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_screenTexture1
#define SC_USE_UV_MIN_MAX_screenTexture1 0
#elif SC_USE_UV_MIN_MAX_screenTexture1==1
#undef SC_USE_UV_MIN_MAX_screenTexture1
#define SC_USE_UV_MIN_MAX_screenTexture1 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_screenTexture1
#define SC_USE_CLAMP_TO_BORDER_screenTexture1 0
#elif SC_USE_CLAMP_TO_BORDER_screenTexture1==1
#undef SC_USE_CLAMP_TO_BORDER_screenTexture1
#define SC_USE_CLAMP_TO_BORDER_screenTexture1 1
#endif
#ifndef SC_USE_UV_TRANSFORM_screenTexture2
#define SC_USE_UV_TRANSFORM_screenTexture2 0
#elif SC_USE_UV_TRANSFORM_screenTexture2==1
#undef SC_USE_UV_TRANSFORM_screenTexture2
#define SC_USE_UV_TRANSFORM_screenTexture2 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_screenTexture2
#define SC_SOFTWARE_WRAP_MODE_U_screenTexture2 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_screenTexture2
#define SC_SOFTWARE_WRAP_MODE_V_screenTexture2 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_screenTexture2
#define SC_USE_UV_MIN_MAX_screenTexture2 0
#elif SC_USE_UV_MIN_MAX_screenTexture2==1
#undef SC_USE_UV_MIN_MAX_screenTexture2
#define SC_USE_UV_MIN_MAX_screenTexture2 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_screenTexture2
#define SC_USE_CLAMP_TO_BORDER_screenTexture2 0
#elif SC_USE_CLAMP_TO_BORDER_screenTexture2==1
#undef SC_USE_CLAMP_TO_BORDER_screenTexture2
#define SC_USE_CLAMP_TO_BORDER_screenTexture2 1
#endif
#ifndef SC_USE_UV_TRANSFORM_screenTexture3
#define SC_USE_UV_TRANSFORM_screenTexture3 0
#elif SC_USE_UV_TRANSFORM_screenTexture3==1
#undef SC_USE_UV_TRANSFORM_screenTexture3
#define SC_USE_UV_TRANSFORM_screenTexture3 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_screenTexture3
#define SC_SOFTWARE_WRAP_MODE_U_screenTexture3 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_screenTexture3
#define SC_SOFTWARE_WRAP_MODE_V_screenTexture3 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_screenTexture3
#define SC_USE_UV_MIN_MAX_screenTexture3 0
#elif SC_USE_UV_MIN_MAX_screenTexture3==1
#undef SC_USE_UV_MIN_MAX_screenTexture3
#define SC_USE_UV_MIN_MAX_screenTexture3 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_screenTexture3
#define SC_USE_CLAMP_TO_BORDER_screenTexture3 0
#elif SC_USE_CLAMP_TO_BORDER_screenTexture3==1
#undef SC_USE_CLAMP_TO_BORDER_screenTexture3
#define SC_USE_CLAMP_TO_BORDER_screenTexture3 1
#endif
#ifndef ONLY_VERTEX_ATTRIBUTE
#define ONLY_VERTEX_ATTRIBUTE 0
#elif ONLY_VERTEX_ATTRIBUTE==1
#undef ONLY_VERTEX_ATTRIBUTE
#define ONLY_VERTEX_ATTRIBUTE 1
#endif
#ifndef USE_MESH_TRANSFORM
#define USE_MESH_TRANSFORM 0
#elif USE_MESH_TRANSFORM==1
#undef USE_MESH_TRANSFORM
#define USE_MESH_TRANSFORM 1
#endif
#ifndef screenTexture0UV
#define screenTexture0UV 0
#endif
#ifndef screenTexture1UV
#define screenTexture1UV 0
#endif
#ifndef screenTexture2UV
#define screenTexture2UV 0
#endif
#ifndef screenTexture3UV
#define screenTexture3UV 0
#endif
struct sc_Set2
{
texture2d<float> screenTexture0 [[id(0)]];
texture2d<float> screenTexture1 [[id(1)]];
texture2d<float> screenTexture2 [[id(2)]];
texture2d<float> screenTexture3 [[id(3)]];
sampler screenTexture0SmpSC [[id(4)]];
sampler screenTexture1SmpSC [[id(5)]];
sampler screenTexture2SmpSC [[id(6)]];
sampler screenTexture3SmpSC [[id(7)]];
constant userUniformsObj* UserUniforms [[id(8)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
};
float4 applyColorSettings(thread const float4& color)
{
#if (SWAP_R_B_CHANNELS)
{
return color.zyxw;
}
#else
{
#if (GRAYSCALE_AS_ALPHA)
{
return float4(1.0,1.0,1.0,color.x);
}
#endif
}
#endif
return color;
}
float2 screenTexture0GetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.screenTexture0Dims.xy;
}
int screenTexture0GetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (screenTexture0HasSwappedViews)
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
float2 screenTexture1GetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.screenTexture1Dims.xy;
}
int screenTexture1GetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (screenTexture1HasSwappedViews)
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
float2 screenTexture2GetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.screenTexture2Dims.xy;
}
int screenTexture2GetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (screenTexture2HasSwappedViews)
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
float2 screenTexture3GetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.screenTexture3Dims.xy;
}
int screenTexture3GetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (screenTexture3HasSwappedViews)
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
#if ((sc_MultipleRenderTarget<1)||(sc_MultipleRenderTarget>4))
{
float4 param=float4(1.0,0.0,1.0,1.0);
float4 param_1=applyColorSettings(param);
sc_writeFragData0(param_1,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
}
#else
{
float2 param_2=screenTexture0GetDims2D((*sc_set2.UserUniforms));
int param_3=screenTexture0Layout;
int param_4=screenTexture0GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_5=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_6=(int(SC_USE_UV_TRANSFORM_screenTexture0)!=0);
float3x3 param_7=(*sc_set2.UserUniforms).screenTexture0Transform;
int2 param_8=int2(SC_SOFTWARE_WRAP_MODE_U_screenTexture0,SC_SOFTWARE_WRAP_MODE_V_screenTexture0);
bool param_9=(int(SC_USE_UV_MIN_MAX_screenTexture0)!=0);
float4 param_10=(*sc_set2.UserUniforms).screenTexture0UvMinMax;
bool param_11=(int(SC_USE_CLAMP_TO_BORDER_screenTexture0)!=0);
float4 param_12=(*sc_set2.UserUniforms).screenTexture0BorderColor;
float param_13=(*sc_set2.UserUniforms).screenTexture0LOD;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.screenTexture0,sc_set2.screenTexture0SmpSC,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11,param_12,param_13);
float4 l9_1=l9_0;
float4 screenTexture0Sample=l9_0;
float4 result0=screenTexture0Sample*(*sc_set2.UserUniforms).color0;
float4 param_14=result0;
float4 param_15=applyColorSettings(param_14);
sc_writeFragData0(param_15,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
#if (sc_MultipleRenderTarget>=2)
{
float2 param_16=screenTexture1GetDims2D((*sc_set2.UserUniforms));
int param_17=screenTexture1Layout;
int param_18=screenTexture1GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_19=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_20=(int(SC_USE_UV_TRANSFORM_screenTexture1)!=0);
float3x3 param_21=(*sc_set2.UserUniforms).screenTexture1Transform;
int2 param_22=int2(SC_SOFTWARE_WRAP_MODE_U_screenTexture1,SC_SOFTWARE_WRAP_MODE_V_screenTexture1);
bool param_23=(int(SC_USE_UV_MIN_MAX_screenTexture1)!=0);
float4 param_24=(*sc_set2.UserUniforms).screenTexture1UvMinMax;
bool param_25=(int(SC_USE_CLAMP_TO_BORDER_screenTexture1)!=0);
float4 param_26=(*sc_set2.UserUniforms).screenTexture1BorderColor;
float param_27=(*sc_set2.UserUniforms).screenTexture1LOD;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.screenTexture1,sc_set2.screenTexture1SmpSC,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23,param_24,param_25,param_26,param_27);
float4 l9_3=l9_2;
float4 screenTexture1Sample=l9_2;
float4 result1=screenTexture1Sample*(*sc_set2.UserUniforms).color1;
float4 param_28=result1;
float4 param_29=applyColorSettings(param_28);
sc_writeFragData1(param_29,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
}
#endif
#if (sc_MultipleRenderTarget>=3)
{
float2 param_30=screenTexture2GetDims2D((*sc_set2.UserUniforms));
int param_31=screenTexture2Layout;
int param_32=screenTexture2GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_33=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_34=(int(SC_USE_UV_TRANSFORM_screenTexture2)!=0);
float3x3 param_35=(*sc_set2.UserUniforms).screenTexture2Transform;
int2 param_36=int2(SC_SOFTWARE_WRAP_MODE_U_screenTexture2,SC_SOFTWARE_WRAP_MODE_V_screenTexture2);
bool param_37=(int(SC_USE_UV_MIN_MAX_screenTexture2)!=0);
float4 param_38=(*sc_set2.UserUniforms).screenTexture2UvMinMax;
bool param_39=(int(SC_USE_CLAMP_TO_BORDER_screenTexture2)!=0);
float4 param_40=(*sc_set2.UserUniforms).screenTexture2BorderColor;
float param_41=(*sc_set2.UserUniforms).screenTexture2LOD;
float4 l9_4=sc_SampleTextureBiasOrLevel(sc_set2.screenTexture2,sc_set2.screenTexture2SmpSC,param_30,param_31,param_32,param_33,param_34,param_35,param_36,param_37,param_38,param_39,param_40,param_41);
float4 l9_5=l9_4;
float4 screenTexture2Sample=l9_4;
float4 result2=screenTexture2Sample*(*sc_set2.UserUniforms).color2;
float4 param_42=result2;
float4 param_43=applyColorSettings(param_42);
sc_writeFragData2(param_43,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
}
#endif
#if (sc_MultipleRenderTarget>=4)
{
float2 param_44=screenTexture3GetDims2D((*sc_set2.UserUniforms));
int param_45=screenTexture3Layout;
int param_46=screenTexture3GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_47=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_48=(int(SC_USE_UV_TRANSFORM_screenTexture3)!=0);
float3x3 param_49=(*sc_set2.UserUniforms).screenTexture3Transform;
int2 param_50=int2(SC_SOFTWARE_WRAP_MODE_U_screenTexture3,SC_SOFTWARE_WRAP_MODE_V_screenTexture3);
bool param_51=(int(SC_USE_UV_MIN_MAX_screenTexture3)!=0);
float4 param_52=(*sc_set2.UserUniforms).screenTexture3UvMinMax;
bool param_53=(int(SC_USE_CLAMP_TO_BORDER_screenTexture3)!=0);
float4 param_54=(*sc_set2.UserUniforms).screenTexture3BorderColor;
float param_55=(*sc_set2.UserUniforms).screenTexture3LOD;
float4 l9_6=sc_SampleTextureBiasOrLevel(sc_set2.screenTexture3,sc_set2.screenTexture3SmpSC,param_44,param_45,param_46,param_47,param_48,param_49,param_50,param_51,param_52,param_53,param_54,param_55);
float4 l9_7=l9_6;
float4 screenTexture3Sample=l9_6;
float4 result3=screenTexture3Sample*(*sc_set2.UserUniforms).color3;
float4 param_56=result3;
float4 param_57=applyColorSettings(param_56);
sc_writeFragData3(param_57,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
}
#endif
}
#endif
return sc_fragOut;
}
} // FRAGMENT SHADER

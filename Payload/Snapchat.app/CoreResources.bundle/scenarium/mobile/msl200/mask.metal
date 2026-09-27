#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#include "std2.metal"
#include "std2_fs.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler maskTextureSmpSC 2:1
//texture texture2D maskTexture 2:0:2:1
//ubo float UserUniforms 2:2:160 {
//float4 maskTextureSize 0
//float4 maskTextureDims 16
//float4 maskTextureView 32
//float3x3 maskTextureTransform 48
//float4 maskTextureUvMinMax 96
//float4 maskTextureBorderColor 112
//float4 mainColor 128
//float backgroundCornerRadius 144
//float2 backgroundSize 152
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 maskTextureSize;
float4 maskTextureDims;
float4 maskTextureView;
float3x3 maskTextureTransform;
float4 maskTextureUvMinMax;
float4 maskTextureBorderColor;
float4 mainColor;
float backgroundCornerRadius;
float2 backgroundSize;
};
#ifndef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 0
#elif maskTextureHasSwappedViews==1
#undef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 1
#endif
#ifndef maskTextureLayout
#define maskTextureLayout 0
#endif
#ifndef NOMASK
#define NOMASK 0
#elif NOMASK==1
#undef NOMASK
#define NOMASK 1
#endif
#ifndef maskTextureUV
#define maskTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_maskTexture
#define SC_USE_UV_TRANSFORM_maskTexture 0
#elif SC_USE_UV_TRANSFORM_maskTexture==1
#undef SC_USE_UV_TRANSFORM_maskTexture
#define SC_USE_UV_TRANSFORM_maskTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_maskTexture
#define SC_SOFTWARE_WRAP_MODE_U_maskTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_maskTexture
#define SC_SOFTWARE_WRAP_MODE_V_maskTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_maskTexture
#define SC_USE_UV_MIN_MAX_maskTexture 0
#elif SC_USE_UV_MIN_MAX_maskTexture==1
#undef SC_USE_UV_MIN_MAX_maskTexture
#define SC_USE_UV_MIN_MAX_maskTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_maskTexture
#define SC_USE_CLAMP_TO_BORDER_maskTexture 0
#elif SC_USE_CLAMP_TO_BORDER_maskTexture==1
#undef SC_USE_CLAMP_TO_BORDER_maskTexture
#define SC_USE_CLAMP_TO_BORDER_maskTexture 1
#endif
struct sc_Set2
{
texture2d<float> maskTexture [[id(0)]];
sampler maskTextureSmpSC [[id(1)]];
constant userUniformsObj* UserUniforms [[id(2)]];
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
float4 maskTextureSize;
float4 maskTextureDims;
float4 maskTextureView;
float3x3 maskTextureTransform;
float4 maskTextureUvMinMax;
float4 maskTextureBorderColor;
float4 mainColor;
float backgroundCornerRadius;
float2 backgroundSize;
};
#ifndef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 0
#elif maskTextureHasSwappedViews==1
#undef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 1
#endif
#ifndef maskTextureLayout
#define maskTextureLayout 0
#endif
#ifndef NOMASK
#define NOMASK 0
#elif NOMASK==1
#undef NOMASK
#define NOMASK 1
#endif
#ifndef SC_USE_UV_TRANSFORM_maskTexture
#define SC_USE_UV_TRANSFORM_maskTexture 0
#elif SC_USE_UV_TRANSFORM_maskTexture==1
#undef SC_USE_UV_TRANSFORM_maskTexture
#define SC_USE_UV_TRANSFORM_maskTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_maskTexture
#define SC_SOFTWARE_WRAP_MODE_U_maskTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_maskTexture
#define SC_SOFTWARE_WRAP_MODE_V_maskTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_maskTexture
#define SC_USE_UV_MIN_MAX_maskTexture 0
#elif SC_USE_UV_MIN_MAX_maskTexture==1
#undef SC_USE_UV_MIN_MAX_maskTexture
#define SC_USE_UV_MIN_MAX_maskTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_maskTexture
#define SC_USE_CLAMP_TO_BORDER_maskTexture 0
#elif SC_USE_CLAMP_TO_BORDER_maskTexture==1
#undef SC_USE_CLAMP_TO_BORDER_maskTexture
#define SC_USE_CLAMP_TO_BORDER_maskTexture 1
#endif
#ifndef maskTextureUV
#define maskTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> maskTexture [[id(0)]];
sampler maskTextureSmpSC [[id(1)]];
constant userUniformsObj* UserUniforms [[id(2)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
};
float2 maskTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.maskTextureDims.xy;
}
int maskTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (maskTextureHasSwappedViews)
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
if (length(abs(corner-(sc_sysIn.varPackedTex.xy*UserUniforms.backgroundSize)))>UserUniforms.backgroundCornerRadius)
{
return 1.0;
}
float2 squareCorner=abs(float2(corner.x-UserUniforms.backgroundCornerRadius,corner.y-UserUniforms.backgroundCornerRadius));
float radiusPercentage=length(abs(squareCorner-(sc_sysIn.varPackedTex.xy*UserUniforms.backgroundSize)))/UserUniforms.backgroundCornerRadius;
if (radiusPercentage<=1.0)
{
return radiusPercentage;
}
return 0.0;
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float4 color=float4(0.0);
color=(*sc_set2.UserUniforms).mainColor;
#if (!NOMASK)
{
float2 param=maskTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=maskTextureLayout;
int param_2=maskTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.zw;
bool param_4=(int(SC_USE_UV_TRANSFORM_maskTexture)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).maskTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_maskTexture,SC_SOFTWARE_WRAP_MODE_V_maskTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_maskTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).maskTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_maskTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).maskTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.maskTexture,sc_set2.maskTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
color.w*=l9_0.x;
}
#endif
float cornerFade=1.0;
float2 param_12=float2(0.0);
cornerFade*=getCornerFade(param_12,(*sc_set2.UserUniforms),sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_13=float2((*sc_set2.UserUniforms).backgroundSize.x,0.0);
cornerFade*=getCornerFade(param_13,(*sc_set2.UserUniforms),sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_14=float2((*sc_set2.UserUniforms).backgroundSize.x,(*sc_set2.UserUniforms).backgroundSize.y);
cornerFade*=getCornerFade(param_14,(*sc_set2.UserUniforms),sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_15=float2(0.0,(*sc_set2.UserUniforms).backgroundSize.y);
cornerFade*=getCornerFade(param_15,(*sc_set2.UserUniforms),sc_fragIn.sc_sysIn,sc_set0,sc_set1);
if (cornerFade<=0.0)
{
discard_fragment();
}
float4 param_16=color;
sc_writeFragData0(param_16,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

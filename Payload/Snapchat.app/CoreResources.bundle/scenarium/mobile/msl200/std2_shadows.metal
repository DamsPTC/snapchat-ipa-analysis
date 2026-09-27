#pragma once
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "std2.metal"
//SG_REFLECTION_BEGIN(100)
//SG_REFLECTION_END

namespace SNAP_VS {
float2 getProjectedTexCoords(thread const float4& vertexPosition,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 worldPos=vertexPosition;
#if (sc_RenderingSpace==1)
{
worldPos=(*sc_set0.LibraryUniforms).sc_ModelMatrix*vertexPosition;
}
#endif
float4 projectedUVs=(*sc_set0.LibraryUniforms).sc_ProjectorMatrix*worldPos;
return ((projectedUVs.xy/float2(projectedUVs.w))*0.5)+float2(0.5);
}
} // VERTEX SHADER


namespace SNAP_FS {
float getShadowAlpha(thread const float4& color)
{
float shadowAlpha=1.0;
#if (((sc_BlendMode_Normal||sc_BlendMode_AlphaToCoverage)||sc_BlendMode_PremultipliedAlphaHardware)||sc_BlendMode_PremultipliedAlphaAuto)
{
shadowAlpha=color.w;
}
#else
{
#if (sc_BlendMode_PremultipliedAlpha)
{
shadowAlpha=fast::clamp(color.w*2.0,0.0,1.0);
}
#else
{
#if (sc_BlendMode_AddWithAlphaFactor)
{
shadowAlpha=fast::clamp(dot(color.xyz,float3(color.w)),0.0,1.0);
}
#else
{
#if (sc_BlendMode_AlphaTest)
{
shadowAlpha=1.0;
}
#else
{
#if (sc_BlendMode_Multiply)
{
shadowAlpha=(1.0-dot(color.xyz,float3(0.33333001)))*color.w;
}
#else
{
#if (sc_BlendMode_MultiplyOriginal)
{
shadowAlpha=(1.0-fast::clamp(dot(color.xyz,float3(1.0)),0.0,1.0))*color.w;
}
#else
{
#if (sc_BlendMode_ColoredGlass)
{
shadowAlpha=fast::clamp(dot(color.xyz,float3(1.0)),0.0,1.0)*color.w;
}
#else
{
#if (sc_BlendMode_Add)
{
shadowAlpha=fast::clamp(dot(color.xyz,float3(1.0)),0.0,1.0);
}
#else
{
#if (sc_BlendMode_AddWithAlphaFactor)
{
shadowAlpha=fast::clamp(dot(color.xyz,float3(1.0)),0.0,1.0)*color.w;
}
#else
{
#if (sc_BlendMode_Screen)
{
shadowAlpha=dot(color.xyz,float3(0.33333001))*color.w;
}
#else
{
#if (sc_BlendMode_Min)
{
shadowAlpha=1.0-fast::clamp(dot(color.xyz,float3(1.0)),0.0,1.0);
}
#else
{
#if (sc_BlendMode_Max)
{
shadowAlpha=fast::clamp(dot(color.xyz,float3(1.0)),0.0,1.0);
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
return shadowAlpha;
}
float4 evaluateShadowCasterColor(thread const float4& shadowCasterColor,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 param=shadowCasterColor;
float alpha=getShadowAlpha(param);
float shadowTerm=(*sc_set0.LibraryUniforms).sc_ShadowDensity*alpha;
float3 shadowColor=mix((*sc_set0.LibraryUniforms).sc_ShadowColor.xyz,(*sc_set0.LibraryUniforms).sc_ShadowColor.xyz*shadowCasterColor.xyz,float3((*sc_set0.LibraryUniforms).sc_ShadowColor.w));
return float4(shadowColor.x,shadowColor.y,shadowColor.z,shadowTerm);
}
float getShadowTexClipFactor(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 uv=abs(sc_sysIn.varShadowTex-float2(0.5));
float clipFactor=fast::max(uv.x,uv.y);
return step(clipFactor,0.5);
}
float3 evaluateShadow(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float3 result;
#if (sc_ProjectiveShadowsReceiver)
{
float4 shadowSample=sc_set0.sc_ShadowTexture.sample(sc_set0.sc_ShadowTextureSmpSC,sc_sysIn.varShadowTex)*getShadowTexClipFactor(sc_sysIn,sc_set0,sc_set1);
float3 shadowColor=mix((*sc_set0.LibraryUniforms).sc_ShadowColor.xyz,(*sc_set0.LibraryUniforms).sc_ShadowColor.xyz*shadowSample.xyz,float3((*sc_set0.LibraryUniforms).sc_ShadowColor.w));
float shadowDensity=shadowSample.w*(*sc_set0.LibraryUniforms).sc_ShadowDensity;
result=mix(float3(1.0),shadowColor,float3(shadowDensity));
}
#else
{
result=float3(1.0);
}
#endif
return result;
}
float3 evaluateRayTracedShadow(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float2 p=sc_GetGlobalScreenCoords(sc_sysIn,sc_set0,sc_set1);
float2 param=p;
float shadow=sc_RayTracedShadowTextureSampleView(param,sc_sysIn,sc_set0,sc_set1).x;
return float3(shadow);
}
} // FRAGMENT SHADER

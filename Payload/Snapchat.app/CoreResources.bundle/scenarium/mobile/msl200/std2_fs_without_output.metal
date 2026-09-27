#pragma once
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "std2.metal"
//SG_REFLECTION_BEGIN(100)
//SG_REFLECTION_END

namespace SNAP_VS {
} // VERTEX SHADER


namespace SNAP_FS {
float4 sc_ApplyBlendModeModifications(thread const float4& color)
{
float4 result;
#if (sc_BlendMode_MultiplyOriginal)
{
result=float4(mix(float3(1.0),color.xyz,float3(color.w)),color.w);
}
#else
{
#if (sc_BlendMode_Screen||sc_BlendMode_PremultipliedAlphaAuto)
{
float alpha=color.w;
#if (sc_BlendMode_PremultipliedAlphaAuto)
{
alpha=fast::clamp(alpha,0.0,1.0);
}
#endif
result=float4(color.xyz*alpha,alpha);
}
#else
{
result=color;
}
#endif
}
#endif
return result;
}
void sc_DiscardStereoFragment(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
#if ((sc_StereoRenderingMode==1)&&(sc_StereoRendering_IsClipDistanceEnabled==0))
{
if (sc_sysIn.varClipDistance<0.0)
{
discard_fragment();
}
}
#endif
}
float4 getPixelRenderingCost(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 result;
#if (sc_ShaderComplexityAnalyzer)
{
result=float4((*sc_set0.LibraryUniforms).shaderComplexityValue/255.0,0.0,0.0,1.0);
}
#else
{
result=float4(0.0);
}
#endif
return result;
}
void sc_MainInjector()
{
}
void sc_CallLensFragmentMain()
{
}
void sc_StereoFragmentMain(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
sc_DiscardStereoFragment(sc_sysIn,sc_set0,sc_set1);
sc_CallLensFragmentMain();
}
} // FRAGMENT SHADER

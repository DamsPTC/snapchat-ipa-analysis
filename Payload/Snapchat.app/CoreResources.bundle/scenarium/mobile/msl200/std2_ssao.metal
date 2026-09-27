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
float3 evaluateSSAO(thread const float3& positionWS,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
#if (sc_SSAOEnabled)
{
float4 clipSpaceCoord=(*sc_set0.LibraryUniforms).sc_ViewProjectionMatrixArray[sc_GetStereoViewIndex(sc_sysIn,sc_set0,sc_set1)]*float4(positionWS,1.0);
float3 l9_0=clipSpaceCoord.xyz/float3(clipSpaceCoord.w);
clipSpaceCoord=float4(l9_0.x,l9_0.y,l9_0.z,clipSpaceCoord.w);
float4 shadowSample=sc_set0.sc_SSAOTexture.sample(sc_set0.sc_SSAOTextureSmpSC,((clipSpaceCoord.xy*0.5)+float2(0.5)));
return float3(shadowSample.x);
}
#else
{
return float3(1.0);
}
#endif
}
} // FRAGMENT SHADER

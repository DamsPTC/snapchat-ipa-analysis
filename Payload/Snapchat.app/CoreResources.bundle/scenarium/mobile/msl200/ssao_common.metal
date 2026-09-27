#pragma once
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
//SG_REFLECTION_BEGIN(100)
//SG_REFLECTION_END

namespace SNAP_VS {
} // VERTEX SHADER


namespace SNAP_FS {
float interleavedGradientNoise(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
return fract(52.982918*fract(dot(sc_sysIn.gl_FragCoord.xy,float2(0.067110561,0.0058371499))));
}
} // FRAGMENT SHADER

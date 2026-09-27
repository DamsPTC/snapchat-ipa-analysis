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
struct sc_SysOut
{
float gl_FragDepth [[depth(any)]];
};
void sc_writeFragDepth(thread const float& dep,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
sc_sysOut.gl_FragDepth=dep;
}
} // FRAGMENT SHADER

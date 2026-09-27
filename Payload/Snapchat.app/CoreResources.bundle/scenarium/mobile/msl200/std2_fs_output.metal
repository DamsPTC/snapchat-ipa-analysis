#pragma once
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "std2.metal"
//SG_REFLECTION_BEGIN(100)
//output vec4 FragColor0 0
//output vec4 FragColor1 1
//output vec4 FragColor2 2
//output vec4 FragColor3 3
//SG_REFLECTION_END

namespace SNAP_VS {
} // VERTEX SHADER


namespace SNAP_FS {
#if SC_RT_RECEIVER_MODE
#else // #if SC_RT_RECEIVER_MODE
#ifndef sc_UseFragDepth
#define sc_UseFragDepth 0
#elif sc_UseFragDepth==1
#undef sc_UseFragDepth
#define sc_UseFragDepth 1
#endif
struct sc_SysOut
{
float4 FragColor0 [[color(0)]];
float4 FragColor1 [[color(1)]];
float4 FragColor2 [[color(2)]];
float4 FragColor3 [[color(3)]];
#if sc_UseFragDepth
float gl_FragDepth [[depth(any)]];
#endif
};
void sc_writeFragData0(thread const float4& col,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
sc_sysOut.FragColor0=col;
}
void sc_writeFragData1(thread const float4& col,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
sc_sysOut.FragColor1=col;
}
void sc_writeFragData2(thread const float4& col,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
sc_sysOut.FragColor2=col;
}
void sc_writeFragData3(thread const float4& col,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
sc_sysOut.FragColor3=col;
}
float4 sc_readFragData0_Platform(thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
return sc_sysOut.FragColor0;
}
float4 sc_readFragData1_Platform(thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
return sc_sysOut.FragColor1;
}
float4 sc_readFragData2_Platform(thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
return sc_sysOut.FragColor2;
}
float4 sc_readFragData3_Platform(thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
return sc_sysOut.FragColor3;
}
void sc_writeFragDepth(thread const float& dep,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
#if (sc_UseFragDepth)
{
sc_sysOut.gl_FragDepth=dep;
}
#endif
}
float4 sc_readFragData0(thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 result=sc_readFragData0_Platform(sc_sysIn,sc_sysOut,sc_set0,sc_set1);
#if (sc_UseFramebufferFetchMarker)
{
result.x+=(*sc_set0.LibraryUniforms)._sc_framebufferFetchMarker;
}
#endif
return result;
}
float4 sc_readFragData1(thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 result=sc_readFragData1_Platform(sc_sysIn,sc_sysOut,sc_set0,sc_set1);
#if (sc_UseFramebufferFetchMarker)
{
result.x+=(*sc_set0.LibraryUniforms)._sc_framebufferFetchMarker;
}
#endif
return result;
}
float4 sc_readFragData2(thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 result=sc_readFragData2_Platform(sc_sysIn,sc_sysOut,sc_set0,sc_set1);
#if (sc_UseFramebufferFetchMarker)
{
result.x+=(*sc_set0.LibraryUniforms)._sc_framebufferFetchMarker;
}
#endif
return result;
}
float4 sc_readFragData3(thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 result=sc_readFragData3_Platform(sc_sysIn,sc_sysOut,sc_set0,sc_set1);
#if (sc_UseFramebufferFetchMarker)
{
result.x+=(*sc_set0.LibraryUniforms)._sc_framebufferFetchMarker;
}
#endif
return result;
}
float4 sc_GetFramebufferColor(thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 result;
#if (sc_FramebufferFetch)
{
result=sc_readFragData0(sc_sysIn,sc_sysOut,sc_set0,sc_set1);
}
#else
{
float2 param=sc_GetViewScreenCoords(sc_sysIn,sc_set0,sc_set1);
result=sc_ScreenTextureSampleView(param,sc_sysIn,sc_set0,sc_set1);
}
#endif
#if (((sc_IsEditor&&sc_GetFramebufferColorInvalidUsageMarker)&&(!sc_BlendMode_Software))&&(!sc_BlendMode_ColoredGlass))
{
result.x+=(*sc_set0.LibraryUniforms)._sc_GetFramebufferColorInvalidUsageMarker;
}
#endif
return result;
}
float4 getFramebufferColor(thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
return sc_GetFramebufferColor(sc_sysIn,sc_sysOut,sc_set0,sc_set1);
}
#endif // #if SC_RT_RECEIVER_MODE
} // FRAGMENT SHADER

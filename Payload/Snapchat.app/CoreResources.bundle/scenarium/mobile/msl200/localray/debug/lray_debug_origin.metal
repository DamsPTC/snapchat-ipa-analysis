#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "required2.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//output vec4 fragColor 0
//sampler sampler receivers0Smp 2:20
//texture utexture2D receivers0 2:6:2:20
//ubo float UserUniforms 2:28:48 {
//float4 searchParamResultsSize 0
//float4 colorInputSize 16
//float4 aoBufferTextureSize 32
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 searchParamResultsSize;
float4 colorInputSize;
float4 aoBufferTextureSize;
};
struct sc_Set2
{
texture2d<uint> receivers0 [[id(6)]];
sampler receivers0Smp [[id(20)]];
constant userUniformsObj* UserUniforms [[id(28)]];
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
float4 param=float4(sc_sysIn.sc_sysAttributes.position.xy,0.0,1.0);
sc_SetClipPosition(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 searchParamResultsSize;
float4 colorInputSize;
float4 aoBufferTextureSize;
};
struct sc_Set2
{
texture2d<uint> receivers0 [[id(6)]];
sampler receivers0Smp [[id(20)]];
constant userUniformsObj* UserUniforms [[id(28)]];
};
struct sc_FragOut
{
float4 fragColor [[color(0)]];
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
};
uint4 lray_readReceivers0(thread const int2& screenPos,thread texture2d<uint> receivers0,thread sampler receivers0Smp)
{
return receivers0.read(uint2(screenPos),0);
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
int2 screenPos=int2(sc_GetGlFragCoord(sc_fragIn.sc_sysIn,sc_set0,sc_set1).xy);
int2 param=screenPos;
uint4 raw=lray_readReceivers0(param,sc_set2.receivers0,sc_set2.receivers0Smp);
uint l9_0=raw.x;
bool l9_1=l9_0==0u;
bool l9_2;
if (l9_1)
{
l9_2=raw.y==0u;
}
else
{
l9_2=l9_1;
}
bool l9_3;
if (l9_2)
{
l9_3=raw.z==0u;
}
else
{
l9_3=l9_2;
}
if (l9_3)
{
sc_fragOut.fragColor=float4(0.0,0.0,0.0,1.0);
}
else
{
float3 col=float3(raw.xyz)/float3(65535.0);
sc_fragOut.fragColor=float4(col,1.0);
}
uint mask=raw.w;
if (mask==0u)
{
int2 m=(screenPos/int2(4))%int2(2);
sc_fragOut.fragColor*=float4(float(abs(m.x-m.y)));
}
return sc_fragOut;
}
} // FRAGMENT SHADER

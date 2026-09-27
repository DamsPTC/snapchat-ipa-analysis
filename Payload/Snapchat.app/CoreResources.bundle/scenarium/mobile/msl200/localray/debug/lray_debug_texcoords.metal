#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "std2.metal"
#include "std2_vs.metal"
#include "std2_proxy.metal"
//SG_REFLECTION_BEGIN(100)
//output vec4 fragColor 0
//ubo float UserUniforms 2:0:16 {
//float depthRef 0
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float depthRef;
};
struct sc_Set2
{
constant userUniformsObj* UserUniforms [[id(0)]];
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
float4 param=float4(sc_sysIn.sc_sysAttributes.position.xy,(*sc_set2.UserUniforms).depthRef,1.0);
sc_SetClipPosition(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
#ifndef DEBUG_UV1
#define DEBUG_UV1 0
#elif DEBUG_UV1==1
#undef DEBUG_UV1
#define DEBUG_UV1 1
#endif
struct userUniformsObj
{
float depthRef;
};
struct sc_Set2
{
constant userUniformsObj* UserUniforms [[id(0)]];
};
struct sc_FragOut
{
float4 fragColor [[color(0)]];
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
};
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
RayHitPayload rhp=GetRayTracingHitData(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 l9_0;
#if (DEBUG_UV1)
{
l9_0=rhp.uv1;
}
#else
{
l9_0=rhp.uv0;
}
#endif
float2 uv=l9_0;
sc_fragOut.fragColor=float4(uv,0.0,1.0);
return sc_fragOut;
}
} // FRAGMENT SHADER

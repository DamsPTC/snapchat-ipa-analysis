#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "required2.metal"
#include "std2_vs.metal"
#include "std2.metal"
//SG_REFLECTION_BEGIN(100)
//output vec4 fragColor 0
//ubo int UserUniforms 2:0:16 {
//int maxEmitterId 0
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
int maxEmitterId;
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
float4 param=float4(sc_sysIn.sc_sysAttributes.position.xy,-1.0,1.0);
sc_SetClipPosition(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
int maxEmitterId;
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
int2 screenPos=int2(sc_GetGlFragCoord(sc_fragIn.sc_sysIn,sc_set0,sc_set1).xy);
int2 param=screenPos;
uint4 id_and_barycentric=lray_readHitIdAndBarycentric(param,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
uint emitter_id=id_and_barycentric.x&16383u;
if (emitter_id==0u)
{
sc_fragOut.fragColor=float4(1.0,0.0,1.0,1.0);
}
else
{
float v=float(emitter_id)/float((*sc_set2.UserUniforms).maxEmitterId);
sc_fragOut.fragColor=float4(v,v,1.0,1.0);
}
return sc_fragOut;
}
} // FRAGMENT SHADER

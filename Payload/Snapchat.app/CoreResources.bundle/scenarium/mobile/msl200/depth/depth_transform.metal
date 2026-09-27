#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "std2.metal"
#include "std2_vs.metal"
#include "std2_fs.metal"
//SG_REFLECTION_BEGIN(100)
//SG_REFLECTION_END

namespace SNAP_VS {
struct sc_Set2
{
texture2d<float> mainTexture [[id(1)]];
sampler mainTextureSmplr [[id(2)]];
};
struct sc_VertOut
{
sc_SysOut sc_sysOut;
float varDepth [[user(locn10)]];
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
float depth=sc_set2.mainTexture.sample(sc_set2.mainTextureSmplr,v.texture0,level(0.0)).x;
float3 l9_0=v.position.xyz*depth;
v.position=float4(l9_0.x,l9_0.y,l9_0.z,v.position.w);
sc_vertOut.varDepth=v.position.z;
v.position.y=-v.position.y;
v.position.z=-v.position.z;
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct sc_Set2
{
texture2d<float> mainTexture [[id(1)]];
sampler mainTextureSmplr [[id(2)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
float varDepth [[user(locn10)]];
};
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
int depth=int(fast::min(sc_fragIn.varDepth,65535.0));
int upper=depth/256;
int lower=depth-(upper*256);
float4 param=float4(float(upper)/255.0,float(lower)/255.0,0.0,1.0);
sc_writeFragData0(param,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "std2_vs.metal"
#include "std2_fs.metal"
//SG_REFLECTION_BEGIN(100)
//ubo float UserUniforms 2:0:16 {
//float3 uniMainTextureSize 0
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float3 uniMainTextureSize;
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
sc_Vertex_t v=sc_LoadVertexAttributes(sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float3 uniMainTextureSize;
};
struct sc_Set2
{
constant userUniformsObj* UserUniforms [[id(0)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
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
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float4 pixel=float4(0.0,0.0,1.0,1.0);
float2 uvAbsolute=sc_fragIn.sc_sysIn.varPackedTex.xy*(*sc_set2.UserUniforms).uniMainTextureSize.xy;
float2 uvdx=dfdx(uvAbsolute);
float2 uvdy=dfdy(uvAbsolute);
float uLength2=dot(uvdx,uvdx);
float vLength2=dot(uvdy,uvdy);
float lengthMax=fast::max(uLength2,vLength2);
bool baseLevelPass=false;
float mipLevel=(0.5*log2(lengthMax))-0.5;
if ((*sc_set2.UserUniforms).uniMainTextureSize.z==1.0)
{
baseLevelPass=mipLevel<0.0;
}
else
{
float mipThreshold=0.1;
baseLevelPass=mipLevel<mipThreshold;
}
if (baseLevelPass)
{
pixel=float4(float3(0.0,1.0,0.0).x,float3(0.0,1.0,0.0).y,float3(0.0,1.0,0.0).z,pixel.w);
}
else
{
pixel=float4(float3(1.0,0.0,0.0).x,float3(1.0,0.0,0.0).y,float3(1.0,0.0,0.0).z,pixel.w);
}
float4 param=pixel;
sc_writeFragData0(param,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

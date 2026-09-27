#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "required2.metal"
#include "std2_texture.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//output vec4 fragColor 0
//sampler sampler searchParamResultsSmp 2:24
//texture texture2D searchParamResults 2:10:2:24
//ubo float UserUniforms 2:28:64 {
//float4 searchParamResultsSize 0
//float4 colorInputSize 16
//float4 aoBufferTextureSize 32
//float maxFilterDiameter 48
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 searchParamResultsSize;
float4 colorInputSize;
float4 aoBufferTextureSize;
float maxFilterDiameter;
};
struct sc_Set2
{
texture2d<float> searchParamResults [[id(10)]];
sampler searchParamResultsSmp [[id(24)]];
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
float4 param=float4(sc_sysIn.sc_sysAttributes.position.xy,-1.0,1.0);
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
float maxFilterDiameter;
};
struct sc_Set2
{
texture2d<float> searchParamResults [[id(10)]];
sampler searchParamResultsSmp [[id(24)]];
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
float2 lray_readSearchParamResults(thread const int2& screenPos,constant userUniformsObj& UserUniforms,thread texture2d<float> searchParamResults,thread sampler searchParamResultsSmp)
{
float2 samplePos=float2(screenPos)+float2(0.5);
float2 searchParamResultsInvDims=UserUniforms.searchParamResultsSize.zw;
return searchParamResults.sample(searchParamResultsSmp,(samplePos*searchParamResultsInvDims)).xy;
}
float3 get_debug_color(thread const float& t)
{
if (t==0.0)
{
return float3(0.2);
}
else
{
if (t<0.050000001)
{
return float3(0.0,0.0,1.0);
}
else
{
if (t<0.1)
{
return float3(0.0,0.75,1.0);
}
else
{
if (t<0.2)
{
return float3(0.0,0.94999999,1.0);
}
else
{
if (t<0.40000001)
{
return float3(0.0,1.0,0.80000001);
}
else
{
if (t<0.60000002)
{
return float3(0.0,1.0,0.15000001);
}
else
{
if (t<0.80000001)
{
return float3(0.75,1.0,0.0);
}
else
{
if (t<0.98000002)
{
return float3(1.0,0.64999998,0.0);
}
else
{
return float3(1.0,0.0,0.0);
}
}
}
}
}
}
}
}
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
int2 screenPos=int2(sc_GetGlFragCoord(sc_fragIn.sc_sysIn,sc_set0,sc_set1).xy);
int2 param=screenPos;
float search_result=lray_readSearchParamResults(param,(*sc_set2.UserUniforms),sc_set2.searchParamResults,sc_set2.searchParamResultsSmp).x;
float param_1=(search_result*255.0)/(*sc_set2.UserUniforms).maxFilterDiameter;
sc_fragOut.fragColor=float4(get_debug_color(param_1),1.0);
return sc_fragOut;
}
} // FRAGMENT SHADER

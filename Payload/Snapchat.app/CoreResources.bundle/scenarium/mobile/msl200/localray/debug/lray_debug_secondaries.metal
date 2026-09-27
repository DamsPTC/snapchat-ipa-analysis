#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "required2.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//output vec4 fragColor 0
//sampler sampler colorInputSmp 2:15
//texture texture2D colorInput 2:1:2:15
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
texture2d<float> colorInput [[id(1)]];
sampler colorInputSmp [[id(15)]];
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
};
#ifndef DEBUG_HDR
#define DEBUG_HDR 0
#elif DEBUG_HDR==1
#undef DEBUG_HDR
#define DEBUG_HDR 1
#endif
struct sc_Set2
{
texture2d<float> colorInput [[id(1)]];
sampler colorInputSmp [[id(15)]];
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
float4 lray_readColorInput(thread const int2& screenPos,constant userUniformsObj& UserUniforms,thread texture2d<float> colorInput,thread sampler colorInputSmp)
{
float2 samplePos=float2(screenPos)+float2(0.5);
float2 colorInputInvDims=UserUniforms.colorInputSize.zw;
return colorInput.sample(colorInputSmp,(samplePos*colorInputInvDims));
}
float3 hsv2rgb(thread const float& hue,thread const float& saturation,thread const float& value)
{
float4 K=float4(1.0,0.66666669,0.33333334,3.0);
float3 p=abs((fract(float3(hue)+K.xyz)*6.0)-K.www);
return float3(value)*mix(K.xxx,fast::clamp(p-K.xxx,float3(0.0),float3(1.0)),float3(saturation));
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
int2 screenPos=int2(sc_GetGlFragCoord(sc_fragIn.sc_sysIn,sc_set0,sc_set1).xy);
int2 param=screenPos;
float4 rgbae=lray_readColorInput(param,(*sc_set2.UserUniforms),sc_set2.colorInput,sc_set2.colorInputSmp);
float4 col=rgbae;
#if (DEBUG_HDR)
{
float m=fast::max(col.x,fast::max(col.y,col.z));
if (m<=1.0)
{
float h=0.0;
float s=0.0;
float v=mix(0.5,1.0,m);
float param_1=h;
float param_2=s;
float param_3=v;
float3 l9_0=hsv2rgb(param_1,param_2,param_3);
sc_fragOut.fragColor=float4(l9_0.x,l9_0.y,l9_0.z,sc_fragOut.fragColor.w);
}
else
{
float h_1=0.40000001-(0.40000001*fast::clamp(m/10.0,0.0,1.0));
float s_1=0.5+(0.5*fast::clamp((m-5.0)/10.0,0.0,1.0));
float v_1=1.0;
float param_4=h_1;
float param_5=s_1;
float param_6=v_1;
float3 l9_1=hsv2rgb(param_4,param_5,param_6);
sc_fragOut.fragColor=float4(l9_1.x,l9_1.y,l9_1.z,sc_fragOut.fragColor.w);
}
}
#else
{
int2 m_1=(screenPos/int2(16))%int2(2);
float3 squares=float3(mix(0.60000002,0.69999999,float(abs(m_1.x-m_1.y))));
float3 l9_2=mix(squares,col.xyz,float3(col.w));
col=float4(l9_2.x,l9_2.y,l9_2.z,col.w);
sc_fragOut.fragColor=float4(col.xyz,1.0);
}
#endif
return sc_fragOut;
}
} // FRAGMENT SHADER

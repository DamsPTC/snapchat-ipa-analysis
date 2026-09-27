#pragma once
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#include "std2.metal"
//SG_REFLECTION_BEGIN(100)
//output uvec4 position_and_mask 0
//output uvec4 normal_and_more 1
//SG_REFLECTION_END

namespace SNAP_VS {
} // VERTEX SHADER


namespace SNAP_FS {
#if SC_RT_RECEIVER_MODE
struct sc_SysOut
{
uint4 position_and_mask [[color(0)]];
uint4 normal_and_more [[color(1)]];
};
float2 encode_direction(thread float3& d)
{
float l1norm=dot(abs(d),float3(1.0));
d/=float3(l1norm);
float t=fast::clamp(-d.z,0.0,1.0);
float2 ret=d.xy;
float l9_0;
if (d.x>=0.0)
{
l9_0=t;
}
else
{
l9_0=-t;
}
ret.x+=l9_0;
float l9_1;
if (d.y>=0.0)
{
l9_1=t;
}
else
{
l9_1=-t;
}
ret.y+=l9_1;
return ret;
}
void sc_WriteReceiverData(thread const float3& positionWS,thread const float3& normalWS,thread const float& roughness,thread sc_SysIn& sc_sysIn,thread sc_SysOut& sc_sysOut,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float3 view=normalize((*sc_set0.LibraryUniforms).sc_Camera.position-positionWS);
if (dot(view,normalWS)>=(-0.050000001))
{
uint3 l9_0=uint3(round((positionWS-(*sc_set0.LibraryUniforms).OriginNormalizationOffset)*(*sc_set0.LibraryUniforms).OriginNormalizationScale));
sc_sysOut.position_and_mask=uint4(l9_0.x,l9_0.y,l9_0.z,sc_sysOut.position_and_mask.w);
sc_sysOut.position_and_mask.w=uint((*sc_set0.LibraryUniforms).receiver_mask);
float3 param=normalWS;
float2 l9_1=encode_direction(param);
float2 encoded_normal=l9_1;
uint2 l9_2=uint2(as_type<uint>(half2(float2(encoded_normal.x,0.0))),as_type<uint>(half2(float2(encoded_normal.y,0.0))));
sc_sysOut.normal_and_more=uint4(l9_2.x,l9_2.y,sc_sysOut.normal_and_more.z,sc_sysOut.normal_and_more.w);
sc_sysOut.normal_and_more.z=as_type<uint>(half2(float2(0.0)));
uint l9_3;
if (roughness<0.0)
{
l9_3=1023u;
}
else
{
l9_3=uint(fast::clamp(roughness,0.0,1.0)*1000.0);
}
uint w=l9_3;
w |= uint(((*sc_set0.LibraryUniforms).receiverId%32)<<int(10u));
sc_sysOut.normal_and_more.w=w;
}
else
{
sc_sysOut.position_and_mask=uint4(0u);
sc_sysOut.normal_and_more=uint4(0u);
}
}
#else // #if SC_RT_RECEIVER_MODE
#endif // #if SC_RT_RECEIVER_MODE
} // FRAGMENT SHADER

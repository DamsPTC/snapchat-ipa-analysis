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
float2 encodeMotionVectorValue(thread const float& delta)
{
float normalizedDelta=(delta+2.0)*0.25;
return float2(floor(mod(normalizedDelta*256.0,256.0))/255.0,floor(mod(normalizedDelta*65536.0,256.0))/255.0);
}
float4 encodeMotionVector(thread const float2& vector)
{
float param=vector.x;
float param_1=vector.y;
return float4(encodeMotionVectorValue(param),encodeMotionVectorValue(param_1));
}
float decodeMotionVectorValue(thread const float2& vector)
{
float normalizedValue=((vector.x*255.0)+((vector.y*255.0)/256.0))/256.0;
return ((normalizedValue*4.0)-2.0)*0.5;
}
float2 decodeMotionVector(thread const float4& encodedVector)
{
float2 param=encodedVector.xy;
float2 param_1=encodedVector.zw;
return float2(decodeMotionVectorValue(param),decodeMotionVectorValue(param_1));
}
float4 computeMotionVector(thread const float3& surfacePosObjectSpace,thread float4& surfacePosScreenSpace,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 prevFramePos=((*sc_set0.LibraryUniforms).sc_PrevFrameViewProjectionMatrixArray[sc_GetStereoViewIndex(sc_sysIn,sc_set0,sc_set1)]*(*sc_set0.LibraryUniforms).sc_PrevFrameModelMatrix)*float4(surfacePosObjectSpace,1.0);
prevFramePos/=float4(prevFramePos.w);
surfacePosScreenSpace/=float4(surfacePosScreenSpace.w);
float2 param=surfacePosScreenSpace.xy-prevFramePos.xy;
return encodeMotionVector(param);
}
float4 processTAA(thread const float3& surfacePosObjectSpace,thread const float4& surfacePosScreenSpace,thread const float4& shaderOutputColor,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
#if (sc_MotionVectorsPass)
{
float3 param=surfacePosObjectSpace;
float4 param_1=surfacePosScreenSpace;
float4 l9_0=computeMotionVector(param,param_1,sc_sysIn,sc_set0,sc_set1);
return l9_0;
}
#else
{
return shaderOutputColor;
}
#endif
}
} // FRAGMENT SHADER

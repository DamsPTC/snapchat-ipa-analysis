#pragma once
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
    #ifndef sc_TextureRenderingLayout_Regular
        #define sc_TextureRenderingLayout_Regular 0
        #define sc_TextureRenderingLayout_StereoInstancedClipped 1
        #define sc_TextureRenderingLayout_StereoMultiview 2
    #endif
    #define depthToGlobal   depthScreenToViewSpace
    #define depthToLocal    depthViewToScreenSpace
    #ifndef quantizeUV
        #define quantizeUV sc_QuantizeUV
        #define sc_platformUVFlip sc_PlatformFlipV
        #define sc_PlatformFlipUV sc_PlatformFlipV
    #endif
    #ifndef sc_SampleTexture
        #define sc_SampleTexture sc_SampleTextureBiasOrLevel
    #endif
    #ifndef sc_texture2DLod
        #define sc_texture2DLod sc_InternalTextureLevel
        #define sc_textureLod sc_InternalTextureLevel
        #define sc_textureBias sc_InternalTextureBiasOrLevel
        #define sc_texture sc_InternalTexture
    #endif
#include "required2.metal"
#include "std2_texture_sub.metal"
//SG_REFLECTION_BEGIN(100)
//SG_REFLECTION_END

namespace SNAP_VS {
float2 sc_PlatformFlipV(thread const float2& uv)
{
return uv;
}
float3 sc_PlatformFlipV(thread const float3& uvi)
{
return uvi;
}
float4 sc_InternalTextureLevelCombined(thread const texture2d<float> combinedSmp,thread const sampler combinedSmpSmplr,thread const float2& texSize,thread const float2& uv,thread const float& level_)
{
return combinedSmp.sample(combinedSmpSmplr,uv,level(level_));
}
float4 sc_InternalTextureLevel(thread const texture2d<float> tex,thread const sampler smp,thread const float2& texSize,thread const float2& uv,thread const float& level_)
{
return tex.sample(smp,uv,level(level_));
}
float4 sc_InternalTextureBiasOrLevel(thread const texture2d<float> tex,thread const sampler smp,thread const float2& texSize,thread const float2& uv,thread const float& biasOrLevel)
{
float2 param=texSize;
float2 param_1=uv;
float param_2=biasOrLevel;
return sc_InternalTextureLevel(tex,smp,param,param_1,param_2);
}
float4 sc_InternalTextureLevel(thread const texture2d<float> tex,thread const sampler smp,thread const float2& uv,thread const float& level_)
{
float4 result=tex.sample(smp,uv,level(level_));
return result;
}
float4 sc_InternalTextureLevel(thread const texture2d_array<float> tex,thread const sampler smp,thread const float3& uv,thread const float& level_)
{
float4 result=tex.sample(smp,uv.xy,uint(round(uv.z)),level(level_));
return result;
}
float4 sc_InternalTextureLevel(thread const texture3d<float> tex,thread const sampler smp,thread const float3& uv,thread const float& level_)
{
float4 result=tex.sample(smp,uv,level(level_));
return result;
}
float4 sc_InternalTextureLevel(thread const texturecube<float> tex,thread const sampler smp,thread const float3& uv,thread const float& level_)
{
float4 result=tex.sample(smp,uv,level(level_));
return result;
}
float4 sc_InternalTextureBiasOrLevel(thread const texture2d<float> tex,thread const sampler smp,thread const float2& uv,thread const float& biasOrLevel)
{
float2 param=uv;
float param_1=biasOrLevel;
return sc_InternalTextureLevel(tex,smp,param,param_1);
}
float4 sc_InternalTextureBiasOrLevel(thread const texture2d_array<float> tex,thread const sampler smp,thread const float3& uv,thread const float& biasOrLevel)
{
float3 param=uv;
float param_1=biasOrLevel;
return sc_InternalTextureLevel(tex,smp,param,param_1);
}
float4 sc_InternalTextureBiasOrLevel(thread const texture3d<float> tex,thread const sampler smp,thread const float3& uv,thread const float& biasOrLevel)
{
float3 param=uv;
float param_1=biasOrLevel;
return sc_InternalTextureLevel(tex,smp,param,param_1);
}
float4 sc_InternalTextureBiasOrLevel(thread const texturecube<float> tex,thread const sampler smp,thread const float3& uv,thread const float& biasOrLevel)
{
float3 param=uv;
float param_1=biasOrLevel;
return sc_InternalTextureLevel(tex,smp,param,param_1);
}
float3 sc_SamplingCoordsViewToGlobal(thread const float2& uv,thread const int& renderingLayout,thread const int& viewIndex)
{
float3 result;
if (renderingLayout==0)
{
result=float3(uv,0.0);
}
else
{
if (renderingLayout==1)
{
result=float3(uv.x,(uv.y*0.5)+(0.5-(float(viewIndex)*0.5)),0.0);
}
else
{
result=float3(uv,float(viewIndex));
}
}
return result;
}
float4 sc_SampleViewLevel(thread const texture2d<float> tex,thread const sampler smp,thread const float2& texSize,thread const float2& uv,thread const int& renderingLayout,thread const int& viewIndex,thread const float& level_)
{
float2 param=uv;
int param_1=renderingLayout;
int param_2=viewIndex;
float3 uvi=sc_SamplingCoordsViewToGlobal(param,param_1,param_2);
float2 param_3=texSize;
float2 param_4=uvi.xy;
float param_5=level_;
return sc_InternalTextureLevel(tex,smp,param_3,param_4,param_5);
}
float4 sc_SampleView(thread const texture2d<float> tex,thread const sampler smp,thread const float2& texSize,thread const float2& uv,thread const int& renderingLayout,thread const int& viewIndex,thread const float& bias0)
{
float2 param=uv;
int param_1=renderingLayout;
int param_2=viewIndex;
float3 uvi=sc_SamplingCoordsViewToGlobal(param,param_1,param_2);
float2 param_3=texSize;
float2 param_4=uvi.xy;
float param_5=bias0;
return sc_InternalTextureBiasOrLevel(tex,smp,param_3,param_4,param_5);
}
float4 sc_SampleViewLevel(thread const texture2d_array<float> tex,thread const sampler smp,thread const float2& texSize,thread const float2& uv,thread const int& renderingLayout,thread const int& viewIndex,thread const float& level_)
{
float2 param=uv;
int param_1=renderingLayout;
int param_2=viewIndex;
float3 uvi=sc_SamplingCoordsViewToGlobal(param,param_1,param_2);
float3 param_3=uvi;
float param_4=level_;
return sc_InternalTextureLevel(tex,smp,param_3,param_4);
}
float4 sc_SampleView(thread const texture2d_array<float> tex,thread const sampler smp,thread const float2& texSize,thread const float2& uv,thread const int& renderingLayout,thread const int& viewIndex,thread const float& bias0)
{
float2 param=uv;
int param_1=renderingLayout;
int param_2=viewIndex;
float3 uvi=sc_SamplingCoordsViewToGlobal(param,param_1,param_2);
float3 param_3=uvi;
float param_4=bias0;
return sc_InternalTextureBiasOrLevel(tex,smp,param_3,param_4);
}
void sc_ClampUV(thread float& value,thread const float& minValue,thread const float& maxValue,thread const bool& useClampToBorder,thread float& clampToBorderFactor)
{
float clampedValue=fast::clamp(value,minValue,maxValue);
float factor=step(abs(value-clampedValue),9.9999997e-06);
clampToBorderFactor*=(factor+((1.0-float(useClampToBorder))*(1.0-factor)));
value=clampedValue;
}
void sc_SoftwareWrapEarly(thread float& uv,thread const int& softwareWrapMode)
{
if (softwareWrapMode==1)
{
uv=fract(uv);
}
else
{
if (softwareWrapMode==2)
{
float uvFract=fract(uv);
float uvInt=uv-uvFract;
float uvOdd=step(0.25,fract(uvInt*0.5));
uv=mix(uvFract,1.0-uvFract,fast::clamp(uvOdd,0.0,1.0));
}
}
}
void sc_SoftwareWrapLate(thread float& uv,thread const int& softwareWrapMode,thread const bool& useClampToBorder,thread float& clampToBorderFactor)
{
if ((softwareWrapMode==0)||(softwareWrapMode==3))
{
float param=uv;
float param_1=0.0;
float param_2=1.0;
bool param_3=useClampToBorder;
float param_4=clampToBorderFactor;
sc_ClampUV(param,param_1,param_2,param_3,param_4);
uv=param;
clampToBorderFactor=param_4;
}
}
float2 sc_QuantizeUV(thread const float2& uv)
{
return uv;
}
float2 sc_TransformUV(thread float2& uv,thread const bool& useUvTransform,thread const float3x3& uvTransform)
{
if (useUvTransform)
{
uv=float2((uvTransform*float3(uv,1.0)).xy);
}
float2 param=uv;
return sc_QuantizeUV(param);
}
float4 sc_SampleTextureBiasOrLevel(thread const texture2d<float> texture_,thread const sampler sampler_,thread const float2& samplerDims,thread const int& renderingLayout,thread const int& viewIndex,thread float2& uv,thread const bool& useUvTransform,thread const float3x3& uvTransform,thread const int2& softwareWrapModes,thread const bool& useUvMinMax,thread const float4& uvMinMax,thread const bool& useClampToBorder,thread const float4& borderColor,thread const float& biasOrLevel)
{
bool useClampToBorderForWrap=useClampToBorder&&(!useUvMinMax);
float clampToBorderFactor=1.0;
float param=uv.x;
int param_1=softwareWrapModes.x;
sc_SoftwareWrapEarly(param,param_1);
uv.x=param;
float param_2=uv.y;
int param_3=softwareWrapModes.y;
sc_SoftwareWrapEarly(param_2,param_3);
uv.y=param_2;
if (useUvMinMax)
{
bool l9_0=useClampToBorder;
bool l9_1;
if (l9_0)
{
l9_1=softwareWrapModes.x==3;
}
else
{
l9_1=l9_0;
}
float param_4=uv.x;
float param_5=uvMinMax.x;
float param_6=uvMinMax.z;
bool param_7=l9_1;
float param_8=clampToBorderFactor;
sc_ClampUV(param_4,param_5,param_6,param_7,param_8);
uv.x=param_4;
clampToBorderFactor=param_8;
bool l9_2=useClampToBorder;
bool l9_3;
if (l9_2)
{
l9_3=softwareWrapModes.y==3;
}
else
{
l9_3=l9_2;
}
float param_9=uv.y;
float param_10=uvMinMax.y;
float param_11=uvMinMax.w;
bool param_12=l9_3;
float param_13=clampToBorderFactor;
sc_ClampUV(param_9,param_10,param_11,param_12,param_13);
uv.y=param_9;
clampToBorderFactor=param_13;
}
float2 param_14=uv;
bool param_15=useUvTransform;
float3x3 param_16=uvTransform;
float2 l9_4=sc_TransformUV(param_14,param_15,param_16);
uv=l9_4;
float param_17=uv.x;
int param_18=softwareWrapModes.x;
bool param_19=useClampToBorderForWrap;
float param_20=clampToBorderFactor;
sc_SoftwareWrapLate(param_17,param_18,param_19,param_20);
uv.x=param_17;
clampToBorderFactor=param_20;
float param_21=uv.y;
int param_22=softwareWrapModes.y;
bool param_23=useClampToBorderForWrap;
float param_24=clampToBorderFactor;
sc_SoftwareWrapLate(param_21,param_22,param_23,param_24);
uv.y=param_21;
clampToBorderFactor=param_24;
float2 param_25=samplerDims;
float2 param_26=uv;
int param_27=renderingLayout;
int param_28=viewIndex;
float param_29=biasOrLevel;
float4 tex=sc_SampleView(texture_,sampler_,param_25,param_26,param_27,param_28,param_29);
if (useClampToBorder)
{
tex=mix(borderColor,tex,float4(clampToBorderFactor));
}
return tex;
}
float4 sc_SampleTextureBiasOrLevel(thread const texture2d_array<float> texture_,thread const sampler sampler_,thread const float2& samplerDims,thread const int& renderingLayout,thread const int& viewIndex,thread float2& uv,thread const bool& useUvTransform,thread const float3x3& uvTransform,thread const int2& softwareWrapModes,thread const bool& useUvMinMax,thread const float4& uvMinMax,thread const bool& useClampToBorder,thread const float4& borderColor,thread const float& biasOrLevel)
{
bool useClampToBorderForWrap=useClampToBorder&&(!useUvMinMax);
float clampToBorderFactor=1.0;
float param=uv.x;
int param_1=softwareWrapModes.x;
sc_SoftwareWrapEarly(param,param_1);
uv.x=param;
float param_2=uv.y;
int param_3=softwareWrapModes.y;
sc_SoftwareWrapEarly(param_2,param_3);
uv.y=param_2;
if (useUvMinMax)
{
bool l9_0=useClampToBorder;
bool l9_1;
if (l9_0)
{
l9_1=softwareWrapModes.x==3;
}
else
{
l9_1=l9_0;
}
float param_4=uv.x;
float param_5=uvMinMax.x;
float param_6=uvMinMax.z;
bool param_7=l9_1;
float param_8=clampToBorderFactor;
sc_ClampUV(param_4,param_5,param_6,param_7,param_8);
uv.x=param_4;
clampToBorderFactor=param_8;
bool l9_2=useClampToBorder;
bool l9_3;
if (l9_2)
{
l9_3=softwareWrapModes.y==3;
}
else
{
l9_3=l9_2;
}
float param_9=uv.y;
float param_10=uvMinMax.y;
float param_11=uvMinMax.w;
bool param_12=l9_3;
float param_13=clampToBorderFactor;
sc_ClampUV(param_9,param_10,param_11,param_12,param_13);
uv.y=param_9;
clampToBorderFactor=param_13;
}
float2 param_14=uv;
bool param_15=useUvTransform;
float3x3 param_16=uvTransform;
float2 l9_4=sc_TransformUV(param_14,param_15,param_16);
uv=l9_4;
float param_17=uv.x;
int param_18=softwareWrapModes.x;
bool param_19=useClampToBorderForWrap;
float param_20=clampToBorderFactor;
sc_SoftwareWrapLate(param_17,param_18,param_19,param_20);
uv.x=param_17;
clampToBorderFactor=param_20;
float param_21=uv.y;
int param_22=softwareWrapModes.y;
bool param_23=useClampToBorderForWrap;
float param_24=clampToBorderFactor;
sc_SoftwareWrapLate(param_21,param_22,param_23,param_24);
uv.y=param_21;
clampToBorderFactor=param_24;
float2 param_25=samplerDims;
float2 param_26=uv;
int param_27=renderingLayout;
int param_28=viewIndex;
float param_29=biasOrLevel;
float4 tex=sc_SampleView(texture_,sampler_,param_25,param_26,param_27,param_28,param_29);
if (useClampToBorder)
{
tex=mix(borderColor,tex,float4(clampToBorderFactor));
}
return tex;
}
float4 sc_SampleTextureLevel(thread const texture2d<float> texture_,thread const sampler sampler_,thread const float2& samplerDims,thread const int& renderingLayout,thread const int& viewIndex,thread float2& uv,thread const bool& useUvTransform,thread const float3x3& uvTransform,thread const int2& softwareWrapModes,thread const bool& useUvMinMax,thread const float4& uvMinMax,thread const bool& useClampToBorder,thread const float4& borderColor,thread const float& level_)
{
bool useClampToBorderForWrap=useClampToBorder&&(!useUvMinMax);
float clampToBorderFactor=1.0;
float param=uv.x;
int param_1=softwareWrapModes.x;
sc_SoftwareWrapEarly(param,param_1);
uv.x=param;
float param_2=uv.y;
int param_3=softwareWrapModes.y;
sc_SoftwareWrapEarly(param_2,param_3);
uv.y=param_2;
if (useUvMinMax)
{
bool l9_0=useClampToBorder;
bool l9_1;
if (l9_0)
{
l9_1=softwareWrapModes.x==3;
}
else
{
l9_1=l9_0;
}
float param_4=uv.x;
float param_5=uvMinMax.x;
float param_6=uvMinMax.z;
bool param_7=l9_1;
float param_8=clampToBorderFactor;
sc_ClampUV(param_4,param_5,param_6,param_7,param_8);
uv.x=param_4;
clampToBorderFactor=param_8;
bool l9_2=useClampToBorder;
bool l9_3;
if (l9_2)
{
l9_3=softwareWrapModes.y==3;
}
else
{
l9_3=l9_2;
}
float param_9=uv.y;
float param_10=uvMinMax.y;
float param_11=uvMinMax.w;
bool param_12=l9_3;
float param_13=clampToBorderFactor;
sc_ClampUV(param_9,param_10,param_11,param_12,param_13);
uv.y=param_9;
clampToBorderFactor=param_13;
}
float2 param_14=uv;
bool param_15=useUvTransform;
float3x3 param_16=uvTransform;
float2 l9_4=sc_TransformUV(param_14,param_15,param_16);
uv=l9_4;
float param_17=uv.x;
int param_18=softwareWrapModes.x;
bool param_19=useClampToBorderForWrap;
float param_20=clampToBorderFactor;
sc_SoftwareWrapLate(param_17,param_18,param_19,param_20);
uv.x=param_17;
clampToBorderFactor=param_20;
float param_21=uv.y;
int param_22=softwareWrapModes.y;
bool param_23=useClampToBorderForWrap;
float param_24=clampToBorderFactor;
sc_SoftwareWrapLate(param_21,param_22,param_23,param_24);
uv.y=param_21;
clampToBorderFactor=param_24;
float2 param_25=samplerDims;
float2 param_26=uv;
int param_27=renderingLayout;
int param_28=viewIndex;
float param_29=level_;
float4 tex=sc_SampleViewLevel(texture_,sampler_,param_25,param_26,param_27,param_28,param_29);
if (useClampToBorder)
{
tex=mix(borderColor,tex,float4(clampToBorderFactor));
}
return tex;
}
float4 sc_SampleTextureLevel(thread const texture2d_array<float> texture_,thread const sampler sampler_,thread const float2& samplerDims,thread const int& renderingLayout,thread const int& viewIndex,thread float2& uv,thread const bool& useUvTransform,thread const float3x3& uvTransform,thread const int2& softwareWrapModes,thread const bool& useUvMinMax,thread const float4& uvMinMax,thread const bool& useClampToBorder,thread const float4& borderColor,thread const float& level_)
{
bool useClampToBorderForWrap=useClampToBorder&&(!useUvMinMax);
float clampToBorderFactor=1.0;
float param=uv.x;
int param_1=softwareWrapModes.x;
sc_SoftwareWrapEarly(param,param_1);
uv.x=param;
float param_2=uv.y;
int param_3=softwareWrapModes.y;
sc_SoftwareWrapEarly(param_2,param_3);
uv.y=param_2;
if (useUvMinMax)
{
bool l9_0=useClampToBorder;
bool l9_1;
if (l9_0)
{
l9_1=softwareWrapModes.x==3;
}
else
{
l9_1=l9_0;
}
float param_4=uv.x;
float param_5=uvMinMax.x;
float param_6=uvMinMax.z;
bool param_7=l9_1;
float param_8=clampToBorderFactor;
sc_ClampUV(param_4,param_5,param_6,param_7,param_8);
uv.x=param_4;
clampToBorderFactor=param_8;
bool l9_2=useClampToBorder;
bool l9_3;
if (l9_2)
{
l9_3=softwareWrapModes.y==3;
}
else
{
l9_3=l9_2;
}
float param_9=uv.y;
float param_10=uvMinMax.y;
float param_11=uvMinMax.w;
bool param_12=l9_3;
float param_13=clampToBorderFactor;
sc_ClampUV(param_9,param_10,param_11,param_12,param_13);
uv.y=param_9;
clampToBorderFactor=param_13;
}
float2 param_14=uv;
bool param_15=useUvTransform;
float3x3 param_16=uvTransform;
float2 l9_4=sc_TransformUV(param_14,param_15,param_16);
uv=l9_4;
float param_17=uv.x;
int param_18=softwareWrapModes.x;
bool param_19=useClampToBorderForWrap;
float param_20=clampToBorderFactor;
sc_SoftwareWrapLate(param_17,param_18,param_19,param_20);
uv.x=param_17;
clampToBorderFactor=param_20;
float param_21=uv.y;
int param_22=softwareWrapModes.y;
bool param_23=useClampToBorderForWrap;
float param_24=clampToBorderFactor;
sc_SoftwareWrapLate(param_21,param_22,param_23,param_24);
uv.y=param_21;
clampToBorderFactor=param_24;
float2 param_25=samplerDims;
float2 param_26=uv;
int param_27=renderingLayout;
int param_28=viewIndex;
float param_29=level_;
float4 tex=sc_SampleViewLevel(texture_,sampler_,param_25,param_26,param_27,param_28,param_29);
if (useClampToBorder)
{
tex=mix(borderColor,tex,float4(clampToBorderFactor));
}
return tex;
}
float4 sc_SampleTextureBiasOrLevel(thread const texture2d_array<float> tex,thread const sampler smp,thread float3& uv,thread const bool& shouldSampleLevel,thread const float& level_,thread const bool& useUvTransform,thread const float3x3& uvTransform)
{
float2 param=uv.xy;
bool param_1=useUvTransform;
float3x3 param_2=uvTransform;
float2 l9_0=sc_TransformUV(param,param_1,param_2);
uv=float3(l9_0.x,l9_0.y,uv.z);
float3 param_3=uv;
float param_4=level_;
float4 l9_1=sc_InternalTextureLevel(tex,smp,param_3,param_4);
float4 l9_2=l9_1;
return l9_1;
}
float4 sc_SampleTextureBiasOrLevel(thread const texture3d<float> tex,thread const sampler smp,thread const float3& uv,thread const bool& shouldSampleLevel,thread const float& level_)
{
float3 param=uv;
float param_1=level_;
float4 l9_0=sc_InternalTextureLevel(tex,smp,param,param_1);
float4 l9_1=l9_0;
return l9_0;
}
float4 sc_SampleTextureBiasOrLevel(thread const texturecube<float> tex,thread const sampler smp,thread const float3& uv,thread const bool& shouldSampleLevel,thread const float& level_)
{
float3 param=uv;
float param_1=level_;
float4 l9_0=sc_InternalTextureLevel(tex,smp,param,param_1);
float4 l9_1=l9_0;
return l9_0;
}
float depthScreenToViewSpace(thread float& depth,thread const float2& projectionMatrixTerms)
{
float m22=projectionMatrixTerms.x;
float m32=projectionMatrixTerms.y;
depth=(depth*2.0)-1.0;
return m32/((-depth)-m22);
}
float depthViewToScreenSpace(thread float& depth,thread const float2& projectionMatrixTerms)
{
float m22=projectionMatrixTerms.x;
float m32=projectionMatrixTerms.y;
float l9_0;
if (depth!=0.0)
{
l9_0=(-m22)-(m32/depth);
}
else
{
l9_0=0.0;
}
depth=l9_0;
return (depth*0.5)+0.5;
}
float4 sampleTextureWithTransform(thread const texture2d<float> tex,thread const sampler smp,thread float2& uv,thread const bool& useUvTransform,thread const float3x3& uvTransform)
{
float2 param=uv;
bool param_1=useUvTransform;
float3x3 param_2=uvTransform;
float2 l9_0=sc_TransformUV(param,param_1,param_2);
uv=l9_0;
float2 param_3=uv;
float param_4=0.0;
return sc_InternalTextureBiasOrLevel(tex,smp,param_3,param_4);
}
} // VERTEX SHADER


namespace SNAP_FS {
float2 sc_PlatformFlipV(thread const float2& uv)
{
return uv;
}
float3 sc_PlatformFlipV(thread const float3& uvi)
{
return uvi;
}
float4 sc_InternalTextureLevelCombined(thread const texture2d<float> combinedSmp,thread const sampler combinedSmpSmplr,thread const float2& texSize,thread const float2& uv,thread const float& level_)
{
return combinedSmp.sample(combinedSmpSmplr,uv,level(level_));
}
float4 sc_InternalTextureLevel(thread const texture2d<float> tex,thread const sampler smp,thread const float2& texSize,thread const float2& uv,thread const float& level_)
{
return tex.sample(smp,uv,level(level_));
}
float4 sc_InternalTextureBiasOrLevel(thread const texture2d<float> tex,thread const sampler smp,thread const float2& texSize,thread const float2& uv,thread const float& biasOrLevel)
{
return tex.sample(smp,uv,bias(biasOrLevel));
}
float4 sc_InternalTextureLevel(thread const texture2d<float> tex,thread const sampler smp,thread const float2& uv,thread const float& level_)
{
float4 result=tex.sample(smp,uv,level(level_));
return result;
}
float4 sc_InternalTextureLevel(thread const texture2d_array<float> tex,thread const sampler smp,thread const float3& uv,thread const float& level_)
{
float4 result=tex.sample(smp,uv.xy,uint(round(uv.z)),level(level_));
return result;
}
float4 sc_InternalTextureLevel(thread const texture3d<float> tex,thread const sampler smp,thread const float3& uv,thread const float& level_)
{
float4 result=tex.sample(smp,uv,level(level_));
return result;
}
float4 sc_InternalTextureLevel(thread const texturecube<float> tex,thread const sampler smp,thread const float3& uv,thread const float& level_)
{
float4 result=tex.sample(smp,uv,level(level_));
return result;
}
float4 sc_InternalTextureBiasOrLevel(thread const texture2d<float> tex,thread const sampler smp,thread const float2& uv,thread const float& biasOrLevel)
{
return tex.sample(smp,uv,bias(biasOrLevel));
}
float4 sc_InternalTextureBiasOrLevel(thread const texture2d_array<float> tex,thread const sampler smp,thread const float3& uv,thread const float& biasOrLevel)
{
return tex.sample(smp,uv.xy,uint(round(uv.z)),bias(biasOrLevel));
}
float4 sc_InternalTextureBiasOrLevel(thread const texture3d<float> tex,thread const sampler smp,thread const float3& uv,thread const float& biasOrLevel)
{
return tex.sample(smp,uv,bias(biasOrLevel));
}
float4 sc_InternalTextureBiasOrLevel(thread const texturecube<float> tex,thread const sampler smp,thread const float3& uv,thread const float& biasOrLevel)
{
return tex.sample(smp,uv,bias(biasOrLevel));
}
float3 sc_SamplingCoordsViewToGlobal(thread const float2& uv,thread const int& renderingLayout,thread const int& viewIndex)
{
float3 result;
if (renderingLayout==0)
{
result=float3(uv,0.0);
}
else
{
if (renderingLayout==1)
{
result=float3(uv.x,(uv.y*0.5)+(0.5-(float(viewIndex)*0.5)),0.0);
}
else
{
result=float3(uv,float(viewIndex));
}
}
return result;
}
float4 sc_SampleViewLevel(thread const texture2d<float> tex,thread const sampler smp,thread const float2& texSize,thread const float2& uv,thread const int& renderingLayout,thread const int& viewIndex,thread const float& level_)
{
float2 param=uv;
int param_1=renderingLayout;
int param_2=viewIndex;
float3 uvi=sc_SamplingCoordsViewToGlobal(param,param_1,param_2);
float2 param_3=texSize;
float2 param_4=uvi.xy;
float param_5=level_;
return sc_InternalTextureLevel(tex,smp,param_3,param_4,param_5);
}
float4 sc_SampleView(thread const texture2d<float> tex,thread const sampler smp,thread const float2& texSize,thread const float2& uv,thread const int& renderingLayout,thread const int& viewIndex,thread const float& bias0)
{
float2 param=uv;
int param_1=renderingLayout;
int param_2=viewIndex;
float3 uvi=sc_SamplingCoordsViewToGlobal(param,param_1,param_2);
float2 param_3=texSize;
float2 param_4=uvi.xy;
float param_5=bias0;
return sc_InternalTextureBiasOrLevel(tex,smp,param_3,param_4,param_5);
}
float4 sc_SampleViewLevel(thread const texture2d_array<float> tex,thread const sampler smp,thread const float2& texSize,thread const float2& uv,thread const int& renderingLayout,thread const int& viewIndex,thread const float& level_)
{
float2 param=uv;
int param_1=renderingLayout;
int param_2=viewIndex;
float3 uvi=sc_SamplingCoordsViewToGlobal(param,param_1,param_2);
float3 param_3=uvi;
float param_4=level_;
return sc_InternalTextureLevel(tex,smp,param_3,param_4);
}
float4 sc_SampleView(thread const texture2d_array<float> tex,thread const sampler smp,thread const float2& texSize,thread const float2& uv,thread const int& renderingLayout,thread const int& viewIndex,thread const float& bias0)
{
float2 param=uv;
int param_1=renderingLayout;
int param_2=viewIndex;
float3 uvi=sc_SamplingCoordsViewToGlobal(param,param_1,param_2);
float3 param_3=uvi;
float param_4=bias0;
return sc_InternalTextureBiasOrLevel(tex,smp,param_3,param_4);
}
void sc_ClampUV(thread float& value,thread const float& minValue,thread const float& maxValue,thread const bool& useClampToBorder,thread float& clampToBorderFactor)
{
float clampedValue=fast::clamp(value,minValue,maxValue);
float factor=step(abs(value-clampedValue),9.9999997e-06);
clampToBorderFactor*=(factor+((1.0-float(useClampToBorder))*(1.0-factor)));
value=clampedValue;
}
void sc_SoftwareWrapEarly(thread float& uv,thread const int& softwareWrapMode)
{
if (softwareWrapMode==1)
{
uv=fract(uv);
}
else
{
if (softwareWrapMode==2)
{
float uvFract=fract(uv);
float uvInt=uv-uvFract;
float uvOdd=step(0.25,fract(uvInt*0.5));
uv=mix(uvFract,1.0-uvFract,fast::clamp(uvOdd,0.0,1.0));
}
}
}
void sc_SoftwareWrapLate(thread float& uv,thread const int& softwareWrapMode,thread const bool& useClampToBorder,thread float& clampToBorderFactor)
{
if ((softwareWrapMode==0)||(softwareWrapMode==3))
{
float param=uv;
float param_1=0.0;
float param_2=1.0;
bool param_3=useClampToBorder;
float param_4=clampToBorderFactor;
sc_ClampUV(param,param_1,param_2,param_3,param_4);
uv=param;
clampToBorderFactor=param_4;
}
}
float2 sc_QuantizeUV(thread const float2& uv)
{
return uv;
}
float2 sc_TransformUV(thread float2& uv,thread const bool& useUvTransform,thread const float3x3& uvTransform)
{
if (useUvTransform)
{
uv=float2((uvTransform*float3(uv,1.0)).xy);
}
float2 param=uv;
return sc_QuantizeUV(param);
}
float4 sc_SampleTextureBiasOrLevel(thread const texture2d<float> texture_,thread const sampler sampler_,thread const float2& samplerDims,thread const int& renderingLayout,thread const int& viewIndex,thread float2& uv,thread const bool& useUvTransform,thread const float3x3& uvTransform,thread const int2& softwareWrapModes,thread const bool& useUvMinMax,thread const float4& uvMinMax,thread const bool& useClampToBorder,thread const float4& borderColor,thread const float& biasOrLevel)
{
bool useClampToBorderForWrap=useClampToBorder&&(!useUvMinMax);
float clampToBorderFactor=1.0;
float param=uv.x;
int param_1=softwareWrapModes.x;
sc_SoftwareWrapEarly(param,param_1);
uv.x=param;
float param_2=uv.y;
int param_3=softwareWrapModes.y;
sc_SoftwareWrapEarly(param_2,param_3);
uv.y=param_2;
if (useUvMinMax)
{
bool l9_0=useClampToBorder;
bool l9_1;
if (l9_0)
{
l9_1=softwareWrapModes.x==3;
}
else
{
l9_1=l9_0;
}
float param_4=uv.x;
float param_5=uvMinMax.x;
float param_6=uvMinMax.z;
bool param_7=l9_1;
float param_8=clampToBorderFactor;
sc_ClampUV(param_4,param_5,param_6,param_7,param_8);
uv.x=param_4;
clampToBorderFactor=param_8;
bool l9_2=useClampToBorder;
bool l9_3;
if (l9_2)
{
l9_3=softwareWrapModes.y==3;
}
else
{
l9_3=l9_2;
}
float param_9=uv.y;
float param_10=uvMinMax.y;
float param_11=uvMinMax.w;
bool param_12=l9_3;
float param_13=clampToBorderFactor;
sc_ClampUV(param_9,param_10,param_11,param_12,param_13);
uv.y=param_9;
clampToBorderFactor=param_13;
}
float2 param_14=uv;
bool param_15=useUvTransform;
float3x3 param_16=uvTransform;
float2 l9_4=sc_TransformUV(param_14,param_15,param_16);
uv=l9_4;
float param_17=uv.x;
int param_18=softwareWrapModes.x;
bool param_19=useClampToBorderForWrap;
float param_20=clampToBorderFactor;
sc_SoftwareWrapLate(param_17,param_18,param_19,param_20);
uv.x=param_17;
clampToBorderFactor=param_20;
float param_21=uv.y;
int param_22=softwareWrapModes.y;
bool param_23=useClampToBorderForWrap;
float param_24=clampToBorderFactor;
sc_SoftwareWrapLate(param_21,param_22,param_23,param_24);
uv.y=param_21;
clampToBorderFactor=param_24;
float2 param_25=samplerDims;
float2 param_26=uv;
int param_27=renderingLayout;
int param_28=viewIndex;
float param_29=biasOrLevel;
float4 tex=sc_SampleView(texture_,sampler_,param_25,param_26,param_27,param_28,param_29);
if (useClampToBorder)
{
tex=mix(borderColor,tex,float4(clampToBorderFactor));
}
return tex;
}
float4 sc_SampleTextureBiasOrLevel(thread const texture2d_array<float> texture_,thread const sampler sampler_,thread const float2& samplerDims,thread const int& renderingLayout,thread const int& viewIndex,thread float2& uv,thread const bool& useUvTransform,thread const float3x3& uvTransform,thread const int2& softwareWrapModes,thread const bool& useUvMinMax,thread const float4& uvMinMax,thread const bool& useClampToBorder,thread const float4& borderColor,thread const float& biasOrLevel)
{
bool useClampToBorderForWrap=useClampToBorder&&(!useUvMinMax);
float clampToBorderFactor=1.0;
float param=uv.x;
int param_1=softwareWrapModes.x;
sc_SoftwareWrapEarly(param,param_1);
uv.x=param;
float param_2=uv.y;
int param_3=softwareWrapModes.y;
sc_SoftwareWrapEarly(param_2,param_3);
uv.y=param_2;
if (useUvMinMax)
{
bool l9_0=useClampToBorder;
bool l9_1;
if (l9_0)
{
l9_1=softwareWrapModes.x==3;
}
else
{
l9_1=l9_0;
}
float param_4=uv.x;
float param_5=uvMinMax.x;
float param_6=uvMinMax.z;
bool param_7=l9_1;
float param_8=clampToBorderFactor;
sc_ClampUV(param_4,param_5,param_6,param_7,param_8);
uv.x=param_4;
clampToBorderFactor=param_8;
bool l9_2=useClampToBorder;
bool l9_3;
if (l9_2)
{
l9_3=softwareWrapModes.y==3;
}
else
{
l9_3=l9_2;
}
float param_9=uv.y;
float param_10=uvMinMax.y;
float param_11=uvMinMax.w;
bool param_12=l9_3;
float param_13=clampToBorderFactor;
sc_ClampUV(param_9,param_10,param_11,param_12,param_13);
uv.y=param_9;
clampToBorderFactor=param_13;
}
float2 param_14=uv;
bool param_15=useUvTransform;
float3x3 param_16=uvTransform;
float2 l9_4=sc_TransformUV(param_14,param_15,param_16);
uv=l9_4;
float param_17=uv.x;
int param_18=softwareWrapModes.x;
bool param_19=useClampToBorderForWrap;
float param_20=clampToBorderFactor;
sc_SoftwareWrapLate(param_17,param_18,param_19,param_20);
uv.x=param_17;
clampToBorderFactor=param_20;
float param_21=uv.y;
int param_22=softwareWrapModes.y;
bool param_23=useClampToBorderForWrap;
float param_24=clampToBorderFactor;
sc_SoftwareWrapLate(param_21,param_22,param_23,param_24);
uv.y=param_21;
clampToBorderFactor=param_24;
float2 param_25=samplerDims;
float2 param_26=uv;
int param_27=renderingLayout;
int param_28=viewIndex;
float param_29=biasOrLevel;
float4 tex=sc_SampleView(texture_,sampler_,param_25,param_26,param_27,param_28,param_29);
if (useClampToBorder)
{
tex=mix(borderColor,tex,float4(clampToBorderFactor));
}
return tex;
}
float4 sc_SampleTextureLevel(thread const texture2d<float> texture_,thread const sampler sampler_,thread const float2& samplerDims,thread const int& renderingLayout,thread const int& viewIndex,thread float2& uv,thread const bool& useUvTransform,thread const float3x3& uvTransform,thread const int2& softwareWrapModes,thread const bool& useUvMinMax,thread const float4& uvMinMax,thread const bool& useClampToBorder,thread const float4& borderColor,thread const float& level_)
{
bool useClampToBorderForWrap=useClampToBorder&&(!useUvMinMax);
float clampToBorderFactor=1.0;
float param=uv.x;
int param_1=softwareWrapModes.x;
sc_SoftwareWrapEarly(param,param_1);
uv.x=param;
float param_2=uv.y;
int param_3=softwareWrapModes.y;
sc_SoftwareWrapEarly(param_2,param_3);
uv.y=param_2;
if (useUvMinMax)
{
bool l9_0=useClampToBorder;
bool l9_1;
if (l9_0)
{
l9_1=softwareWrapModes.x==3;
}
else
{
l9_1=l9_0;
}
float param_4=uv.x;
float param_5=uvMinMax.x;
float param_6=uvMinMax.z;
bool param_7=l9_1;
float param_8=clampToBorderFactor;
sc_ClampUV(param_4,param_5,param_6,param_7,param_8);
uv.x=param_4;
clampToBorderFactor=param_8;
bool l9_2=useClampToBorder;
bool l9_3;
if (l9_2)
{
l9_3=softwareWrapModes.y==3;
}
else
{
l9_3=l9_2;
}
float param_9=uv.y;
float param_10=uvMinMax.y;
float param_11=uvMinMax.w;
bool param_12=l9_3;
float param_13=clampToBorderFactor;
sc_ClampUV(param_9,param_10,param_11,param_12,param_13);
uv.y=param_9;
clampToBorderFactor=param_13;
}
float2 param_14=uv;
bool param_15=useUvTransform;
float3x3 param_16=uvTransform;
float2 l9_4=sc_TransformUV(param_14,param_15,param_16);
uv=l9_4;
float param_17=uv.x;
int param_18=softwareWrapModes.x;
bool param_19=useClampToBorderForWrap;
float param_20=clampToBorderFactor;
sc_SoftwareWrapLate(param_17,param_18,param_19,param_20);
uv.x=param_17;
clampToBorderFactor=param_20;
float param_21=uv.y;
int param_22=softwareWrapModes.y;
bool param_23=useClampToBorderForWrap;
float param_24=clampToBorderFactor;
sc_SoftwareWrapLate(param_21,param_22,param_23,param_24);
uv.y=param_21;
clampToBorderFactor=param_24;
float2 param_25=samplerDims;
float2 param_26=uv;
int param_27=renderingLayout;
int param_28=viewIndex;
float param_29=level_;
float4 tex=sc_SampleViewLevel(texture_,sampler_,param_25,param_26,param_27,param_28,param_29);
if (useClampToBorder)
{
tex=mix(borderColor,tex,float4(clampToBorderFactor));
}
return tex;
}
float4 sc_SampleTextureLevel(thread const texture2d_array<float> texture_,thread const sampler sampler_,thread const float2& samplerDims,thread const int& renderingLayout,thread const int& viewIndex,thread float2& uv,thread const bool& useUvTransform,thread const float3x3& uvTransform,thread const int2& softwareWrapModes,thread const bool& useUvMinMax,thread const float4& uvMinMax,thread const bool& useClampToBorder,thread const float4& borderColor,thread const float& level_)
{
bool useClampToBorderForWrap=useClampToBorder&&(!useUvMinMax);
float clampToBorderFactor=1.0;
float param=uv.x;
int param_1=softwareWrapModes.x;
sc_SoftwareWrapEarly(param,param_1);
uv.x=param;
float param_2=uv.y;
int param_3=softwareWrapModes.y;
sc_SoftwareWrapEarly(param_2,param_3);
uv.y=param_2;
if (useUvMinMax)
{
bool l9_0=useClampToBorder;
bool l9_1;
if (l9_0)
{
l9_1=softwareWrapModes.x==3;
}
else
{
l9_1=l9_0;
}
float param_4=uv.x;
float param_5=uvMinMax.x;
float param_6=uvMinMax.z;
bool param_7=l9_1;
float param_8=clampToBorderFactor;
sc_ClampUV(param_4,param_5,param_6,param_7,param_8);
uv.x=param_4;
clampToBorderFactor=param_8;
bool l9_2=useClampToBorder;
bool l9_3;
if (l9_2)
{
l9_3=softwareWrapModes.y==3;
}
else
{
l9_3=l9_2;
}
float param_9=uv.y;
float param_10=uvMinMax.y;
float param_11=uvMinMax.w;
bool param_12=l9_3;
float param_13=clampToBorderFactor;
sc_ClampUV(param_9,param_10,param_11,param_12,param_13);
uv.y=param_9;
clampToBorderFactor=param_13;
}
float2 param_14=uv;
bool param_15=useUvTransform;
float3x3 param_16=uvTransform;
float2 l9_4=sc_TransformUV(param_14,param_15,param_16);
uv=l9_4;
float param_17=uv.x;
int param_18=softwareWrapModes.x;
bool param_19=useClampToBorderForWrap;
float param_20=clampToBorderFactor;
sc_SoftwareWrapLate(param_17,param_18,param_19,param_20);
uv.x=param_17;
clampToBorderFactor=param_20;
float param_21=uv.y;
int param_22=softwareWrapModes.y;
bool param_23=useClampToBorderForWrap;
float param_24=clampToBorderFactor;
sc_SoftwareWrapLate(param_21,param_22,param_23,param_24);
uv.y=param_21;
clampToBorderFactor=param_24;
float2 param_25=samplerDims;
float2 param_26=uv;
int param_27=renderingLayout;
int param_28=viewIndex;
float param_29=level_;
float4 tex=sc_SampleViewLevel(texture_,sampler_,param_25,param_26,param_27,param_28,param_29);
if (useClampToBorder)
{
tex=mix(borderColor,tex,float4(clampToBorderFactor));
}
return tex;
}
float4 sc_SampleTextureBiasOrLevel(thread const texture2d_array<float> tex,thread const sampler smp,thread float3& uv,thread const bool& shouldSampleLevel,thread const float& level_,thread const bool& useUvTransform,thread const float3x3& uvTransform)
{
float2 param=uv.xy;
bool param_1=useUvTransform;
float3x3 param_2=uvTransform;
float2 l9_0=sc_TransformUV(param,param_1,param_2);
uv=float3(l9_0.x,l9_0.y,uv.z);
float4 l9_1;
if (shouldSampleLevel)
{
float3 param_3=uv;
float param_4=level_;
l9_1=sc_InternalTextureLevel(tex,smp,param_3,param_4);
}
else
{
float3 param_5=uv;
float param_6=level_;
l9_1=sc_InternalTextureBiasOrLevel(tex,smp,param_5,param_6);
}
return l9_1;
}
float4 sc_SampleTextureBiasOrLevel(thread const texture3d<float> tex,thread const sampler smp,thread const float3& uv,thread const bool& shouldSampleLevel,thread const float& level_)
{
float4 l9_0;
if (shouldSampleLevel)
{
float3 param=uv;
float param_1=level_;
l9_0=sc_InternalTextureLevel(tex,smp,param,param_1);
}
else
{
float3 param_2=uv;
float param_3=level_;
l9_0=sc_InternalTextureBiasOrLevel(tex,smp,param_2,param_3);
}
return l9_0;
}
float4 sc_SampleTextureBiasOrLevel(thread const texturecube<float> tex,thread const sampler smp,thread const float3& uv,thread const bool& shouldSampleLevel,thread const float& level_)
{
float4 l9_0;
if (shouldSampleLevel)
{
float3 param=uv;
float param_1=level_;
l9_0=sc_InternalTextureLevel(tex,smp,param,param_1);
}
else
{
float3 param_2=uv;
float param_3=level_;
l9_0=sc_InternalTextureBiasOrLevel(tex,smp,param_2,param_3);
}
return l9_0;
}
float depthScreenToViewSpace(thread float& depth,thread const float2& projectionMatrixTerms)
{
float m22=projectionMatrixTerms.x;
float m32=projectionMatrixTerms.y;
depth=(depth*2.0)-1.0;
return m32/((-depth)-m22);
}
float depthViewToScreenSpace(thread float& depth,thread const float2& projectionMatrixTerms)
{
float m22=projectionMatrixTerms.x;
float m32=projectionMatrixTerms.y;
float l9_0;
if (depth!=0.0)
{
l9_0=(-m22)-(m32/depth);
}
else
{
l9_0=0.0;
}
depth=l9_0;
return (depth*0.5)+0.5;
}
float4 sampleTextureWithTransform(thread const texture2d<float> tex,thread const sampler smp,thread float2& uv,thread const bool& useUvTransform,thread const float3x3& uvTransform)
{
float2 param=uv;
bool param_1=useUvTransform;
float3x3 param_2=uvTransform;
float2 l9_0=sc_TransformUV(param,param_1,param_2);
uv=l9_0;
float2 param_3=uv;
float param_4=0.0;
return sc_InternalTextureBiasOrLevel(tex,smp,param_3,param_4);
}
} // FRAGMENT SHADER

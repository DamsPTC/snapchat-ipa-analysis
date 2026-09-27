#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE0 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "std2_vs.metal"
#include "std2_fs.metal"
#include "std2_texture.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler sc_OITAlpha0SmpSC 2:2
//sampler sampler sc_OITAlpha1SmpSC 2:3
//texture texture2D sc_OITAlpha0 2:0:2:2
//texture texture2D sc_OITAlpha1 2:1:2:3
//ubo float UserUniforms 2:4:256 {
//float4 sc_OITAlpha0Size 0
//float4 sc_OITAlpha0Dims 16
//float4 sc_OITAlpha0View 32
//float3x3 sc_OITAlpha0Transform 48
//float4 sc_OITAlpha0UvMinMax 96
//float4 sc_OITAlpha0BorderColor 112
//float4 sc_OITAlpha1Size 128
//float4 sc_OITAlpha1Dims 144
//float4 sc_OITAlpha1View 160
//float3x3 sc_OITAlpha1Transform 176
//float4 sc_OITAlpha1UvMinMax 224
//float4 sc_OITAlpha1BorderColor 240
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 sc_OITAlpha0Size;
float4 sc_OITAlpha0Dims;
float4 sc_OITAlpha0View;
float3x3 sc_OITAlpha0Transform;
float4 sc_OITAlpha0UvMinMax;
float4 sc_OITAlpha0BorderColor;
float4 sc_OITAlpha1Size;
float4 sc_OITAlpha1Dims;
float4 sc_OITAlpha1View;
float3x3 sc_OITAlpha1Transform;
float4 sc_OITAlpha1UvMinMax;
float4 sc_OITAlpha1BorderColor;
};
#ifndef sc_OITAlpha0HasSwappedViews
#define sc_OITAlpha0HasSwappedViews 0
#elif sc_OITAlpha0HasSwappedViews==1
#undef sc_OITAlpha0HasSwappedViews
#define sc_OITAlpha0HasSwappedViews 1
#endif
#ifndef sc_OITAlpha0Layout
#define sc_OITAlpha0Layout 0
#endif
#ifndef sc_OITAlpha1HasSwappedViews
#define sc_OITAlpha1HasSwappedViews 0
#elif sc_OITAlpha1HasSwappedViews==1
#undef sc_OITAlpha1HasSwappedViews
#define sc_OITAlpha1HasSwappedViews 1
#endif
#ifndef sc_OITAlpha1Layout
#define sc_OITAlpha1Layout 0
#endif
#ifndef sc_OITAlpha0UV
#define sc_OITAlpha0UV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_sc_OITAlpha0
#define SC_USE_UV_TRANSFORM_sc_OITAlpha0 0
#elif SC_USE_UV_TRANSFORM_sc_OITAlpha0==1
#undef SC_USE_UV_TRANSFORM_sc_OITAlpha0
#define SC_USE_UV_TRANSFORM_sc_OITAlpha0 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_sc_OITAlpha0
#define SC_SOFTWARE_WRAP_MODE_U_sc_OITAlpha0 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_sc_OITAlpha0
#define SC_SOFTWARE_WRAP_MODE_V_sc_OITAlpha0 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_sc_OITAlpha0
#define SC_USE_UV_MIN_MAX_sc_OITAlpha0 0
#elif SC_USE_UV_MIN_MAX_sc_OITAlpha0==1
#undef SC_USE_UV_MIN_MAX_sc_OITAlpha0
#define SC_USE_UV_MIN_MAX_sc_OITAlpha0 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_sc_OITAlpha0
#define SC_USE_CLAMP_TO_BORDER_sc_OITAlpha0 0
#elif SC_USE_CLAMP_TO_BORDER_sc_OITAlpha0==1
#undef SC_USE_CLAMP_TO_BORDER_sc_OITAlpha0
#define SC_USE_CLAMP_TO_BORDER_sc_OITAlpha0 1
#endif
#ifndef sc_OITAlpha1UV
#define sc_OITAlpha1UV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_sc_OITAlpha1
#define SC_USE_UV_TRANSFORM_sc_OITAlpha1 0
#elif SC_USE_UV_TRANSFORM_sc_OITAlpha1==1
#undef SC_USE_UV_TRANSFORM_sc_OITAlpha1
#define SC_USE_UV_TRANSFORM_sc_OITAlpha1 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_sc_OITAlpha1
#define SC_SOFTWARE_WRAP_MODE_U_sc_OITAlpha1 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_sc_OITAlpha1
#define SC_SOFTWARE_WRAP_MODE_V_sc_OITAlpha1 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_sc_OITAlpha1
#define SC_USE_UV_MIN_MAX_sc_OITAlpha1 0
#elif SC_USE_UV_MIN_MAX_sc_OITAlpha1==1
#undef SC_USE_UV_MIN_MAX_sc_OITAlpha1
#define SC_USE_UV_MIN_MAX_sc_OITAlpha1 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_sc_OITAlpha1
#define SC_USE_CLAMP_TO_BORDER_sc_OITAlpha1 0
#elif SC_USE_CLAMP_TO_BORDER_sc_OITAlpha1==1
#undef SC_USE_CLAMP_TO_BORDER_sc_OITAlpha1
#define SC_USE_CLAMP_TO_BORDER_sc_OITAlpha1 1
#endif
struct sc_Set2
{
texture2d<float> sc_OITAlpha0 [[id(0)]];
texture2d<float> sc_OITAlpha1 [[id(1)]];
sampler sc_OITAlpha0SmpSC [[id(2)]];
sampler sc_OITAlpha1SmpSC [[id(3)]];
constant userUniformsObj* UserUniforms [[id(4)]];
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
float2 l9_0=(v.position.xy*0.5)+float2(0.5);
sc_vertOut.sc_sysOut.varPackedTex=float4(l9_0.x,l9_0.y,sc_vertOut.sc_sysOut.varPackedTex.z,sc_vertOut.sc_sysOut.varPackedTex.w);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 sc_OITAlpha0Size;
float4 sc_OITAlpha0Dims;
float4 sc_OITAlpha0View;
float3x3 sc_OITAlpha0Transform;
float4 sc_OITAlpha0UvMinMax;
float4 sc_OITAlpha0BorderColor;
float4 sc_OITAlpha1Size;
float4 sc_OITAlpha1Dims;
float4 sc_OITAlpha1View;
float3x3 sc_OITAlpha1Transform;
float4 sc_OITAlpha1UvMinMax;
float4 sc_OITAlpha1BorderColor;
};
#ifndef sc_OITAlpha0HasSwappedViews
#define sc_OITAlpha0HasSwappedViews 0
#elif sc_OITAlpha0HasSwappedViews==1
#undef sc_OITAlpha0HasSwappedViews
#define sc_OITAlpha0HasSwappedViews 1
#endif
#ifndef sc_OITAlpha0Layout
#define sc_OITAlpha0Layout 0
#endif
#ifndef sc_OITAlpha1HasSwappedViews
#define sc_OITAlpha1HasSwappedViews 0
#elif sc_OITAlpha1HasSwappedViews==1
#undef sc_OITAlpha1HasSwappedViews
#define sc_OITAlpha1HasSwappedViews 1
#endif
#ifndef sc_OITAlpha1Layout
#define sc_OITAlpha1Layout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_sc_OITAlpha0
#define SC_USE_UV_TRANSFORM_sc_OITAlpha0 0
#elif SC_USE_UV_TRANSFORM_sc_OITAlpha0==1
#undef SC_USE_UV_TRANSFORM_sc_OITAlpha0
#define SC_USE_UV_TRANSFORM_sc_OITAlpha0 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_sc_OITAlpha0
#define SC_SOFTWARE_WRAP_MODE_U_sc_OITAlpha0 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_sc_OITAlpha0
#define SC_SOFTWARE_WRAP_MODE_V_sc_OITAlpha0 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_sc_OITAlpha0
#define SC_USE_UV_MIN_MAX_sc_OITAlpha0 0
#elif SC_USE_UV_MIN_MAX_sc_OITAlpha0==1
#undef SC_USE_UV_MIN_MAX_sc_OITAlpha0
#define SC_USE_UV_MIN_MAX_sc_OITAlpha0 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_sc_OITAlpha0
#define SC_USE_CLAMP_TO_BORDER_sc_OITAlpha0 0
#elif SC_USE_CLAMP_TO_BORDER_sc_OITAlpha0==1
#undef SC_USE_CLAMP_TO_BORDER_sc_OITAlpha0
#define SC_USE_CLAMP_TO_BORDER_sc_OITAlpha0 1
#endif
#ifndef SC_USE_UV_TRANSFORM_sc_OITAlpha1
#define SC_USE_UV_TRANSFORM_sc_OITAlpha1 0
#elif SC_USE_UV_TRANSFORM_sc_OITAlpha1==1
#undef SC_USE_UV_TRANSFORM_sc_OITAlpha1
#define SC_USE_UV_TRANSFORM_sc_OITAlpha1 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_sc_OITAlpha1
#define SC_SOFTWARE_WRAP_MODE_U_sc_OITAlpha1 -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_sc_OITAlpha1
#define SC_SOFTWARE_WRAP_MODE_V_sc_OITAlpha1 -1
#endif
#ifndef SC_USE_UV_MIN_MAX_sc_OITAlpha1
#define SC_USE_UV_MIN_MAX_sc_OITAlpha1 0
#elif SC_USE_UV_MIN_MAX_sc_OITAlpha1==1
#undef SC_USE_UV_MIN_MAX_sc_OITAlpha1
#define SC_USE_UV_MIN_MAX_sc_OITAlpha1 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_sc_OITAlpha1
#define SC_USE_CLAMP_TO_BORDER_sc_OITAlpha1 0
#elif SC_USE_CLAMP_TO_BORDER_sc_OITAlpha1==1
#undef SC_USE_CLAMP_TO_BORDER_sc_OITAlpha1
#define SC_USE_CLAMP_TO_BORDER_sc_OITAlpha1 1
#endif
#ifndef sc_OITAlpha0UV
#define sc_OITAlpha0UV 0
#endif
#ifndef sc_OITAlpha1UV
#define sc_OITAlpha1UV 0
#endif
struct sc_Set2
{
texture2d<float> sc_OITAlpha0 [[id(0)]];
texture2d<float> sc_OITAlpha1 [[id(1)]];
sampler sc_OITAlpha0SmpSC [[id(2)]];
sampler sc_OITAlpha1SmpSC [[id(3)]];
constant userUniformsObj* UserUniforms [[id(4)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
};
// Implementation of the GLSL mod() function,which is slightly different than Metal fmod()
template<typename Tx,typename Ty>
Tx mod(Tx x,Ty y)
{
return x-y*floor(x/y);
}
// Implementation of an array copy function to cover GLSL's ability to copy an array via assignment.
template<typename T,uint N>
void spvArrayCopyFromStack1(thread T (&dst)[N],thread const T (&src)[N])
{
for (uint i=0; i<N; dst[i]=src[i],i++);
}
template<typename T,uint N>
void spvArrayCopyFromConstant1(thread T (&dst)[N],constant T (&src)[N])
{
for (uint i=0; i<N; dst[i]=src[i],i++);
}
float2 sc_OITAlpha0GetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.sc_OITAlpha0Dims.xy;
}
int sc_OITAlpha0GetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (sc_OITAlpha0HasSwappedViews)
{
result=1-sc_GetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
}
#else
{
result=sc_GetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
}
#endif
return result;
}
float2 sc_OITAlpha1GetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.sc_OITAlpha1Dims.xy;
}
int sc_OITAlpha1GetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (sc_OITAlpha1HasSwappedViews)
{
result=1-sc_GetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
}
#else
{
result=sc_GetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
}
#endif
return result;
}
void unpackValues(thread float& channel,thread const int& passIndex,thread int (&values)[((int(sc_OITMaxLayers8)!=0) ? 2 : 1)*4])
{
channel=floor((channel*255.0)+0.5);
int i=((passIndex+1)*4)-1;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (i>=(passIndex*4))
{
values[i]=(values[i]*4)+int(floor(mod(channel,4.0)));
channel=floor(channel/4.0);
i--;
continue;
}
else
{
break;
}
}
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
#if (sc_OITMaxLayersVisualizeLayerCount)
{
float2 param=sc_OITAlpha0GetDims2D((*sc_set2.UserUniforms));
int param_1=sc_OITAlpha0Layout;
int param_2=sc_OITAlpha0GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=(int(SC_USE_UV_TRANSFORM_sc_OITAlpha0)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).sc_OITAlpha0Transform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_sc_OITAlpha0,SC_SOFTWARE_WRAP_MODE_V_sc_OITAlpha0);
bool param_7=(int(SC_USE_UV_MIN_MAX_sc_OITAlpha0)!=0);
float4 param_8=(*sc_set2.UserUniforms).sc_OITAlpha0UvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_sc_OITAlpha0)!=0);
float4 param_10=(*sc_set2.UserUniforms).sc_OITAlpha0BorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.sc_OITAlpha0,sc_set2.sc_OITAlpha0SmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 sc_OITAlpha0Sample=l9_0;
float4 alphaSample=sc_OITAlpha0Sample;
float4 result=float4(0.0);
if (alphaSample.x==0.0)
{
result=float4(0.0,0.0,0.0,1.0);
}
else
{
if (alphaSample.x<=0.015686275)
{
result=float4(0.0,1.0,0.0,1.0);
}
else
{
if (alphaSample.x<=0.031372551)
{
result=float4(1.0,1.0,0.0,1.0);
}
else
{
result=float4(1.0,0.0,0.0,1.0);
}
}
}
float4 param_12=result;
sc_writeFragData0(param_12,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
#endif
int alphas[((int(sc_OITMaxLayers8)!=0) ? 2 : 1)*4];
int i=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (i<(((int(sc_OITMaxLayers8)!=0) ? 2 : 1)*4))
{
alphas[i]=0;
i++;
continue;
}
else
{
break;
}
}
float4 alphaSample_1;
int pass=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (pass<((int(sc_OITMaxLayers8)!=0) ? 2 : 1))
{
if (pass==0)
{
float2 param_13=sc_OITAlpha0GetDims2D((*sc_set2.UserUniforms));
int param_14=sc_OITAlpha0Layout;
int param_15=sc_OITAlpha0GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_16=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_17=(int(SC_USE_UV_TRANSFORM_sc_OITAlpha0)!=0);
float3x3 param_18=(*sc_set2.UserUniforms).sc_OITAlpha0Transform;
int2 param_19=int2(SC_SOFTWARE_WRAP_MODE_U_sc_OITAlpha0,SC_SOFTWARE_WRAP_MODE_V_sc_OITAlpha0);
bool param_20=(int(SC_USE_UV_MIN_MAX_sc_OITAlpha0)!=0);
float4 param_21=(*sc_set2.UserUniforms).sc_OITAlpha0UvMinMax;
bool param_22=(int(SC_USE_CLAMP_TO_BORDER_sc_OITAlpha0)!=0);
float4 param_23=(*sc_set2.UserUniforms).sc_OITAlpha0BorderColor;
float param_24=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(sc_set2.sc_OITAlpha0,sc_set2.sc_OITAlpha0SmpSC,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23,param_24);
float4 l9_3=l9_2;
float4 sc_OITAlpha0Sample_1=l9_2;
alphaSample_1=sc_OITAlpha0Sample_1;
}
else
{
if ((int(sc_OITMaxLayers8)!=0)&&(pass==1))
{
float2 param_25=sc_OITAlpha1GetDims2D((*sc_set2.UserUniforms));
int param_26=sc_OITAlpha1Layout;
int param_27=sc_OITAlpha1GetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_28=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_29=(int(SC_USE_UV_TRANSFORM_sc_OITAlpha1)!=0);
float3x3 param_30=(*sc_set2.UserUniforms).sc_OITAlpha1Transform;
int2 param_31=int2(SC_SOFTWARE_WRAP_MODE_U_sc_OITAlpha1,SC_SOFTWARE_WRAP_MODE_V_sc_OITAlpha1);
bool param_32=(int(SC_USE_UV_MIN_MAX_sc_OITAlpha1)!=0);
float4 param_33=(*sc_set2.UserUniforms).sc_OITAlpha1UvMinMax;
bool param_34=(int(SC_USE_CLAMP_TO_BORDER_sc_OITAlpha1)!=0);
float4 param_35=(*sc_set2.UserUniforms).sc_OITAlpha1BorderColor;
float param_36=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(sc_set2.sc_OITAlpha1,sc_set2.sc_OITAlpha1SmpSC,param_25,param_26,param_27,param_28,param_29,param_30,param_31,param_32,param_33,param_34,param_35,param_36);
float4 l9_5=l9_4;
float4 sc_OITAlpha1Sample=l9_4;
alphaSample_1=sc_OITAlpha1Sample;
}
}
float param_37=alphaSample_1.w;
int param_38=pass;
int param_39[((int(sc_OITMaxLayers8)!=0) ? 2 : 1)*4];
spvArrayCopyFromStack1(param_39,alphas);
unpackValues(param_37,param_38,param_39);
spvArrayCopyFromStack1(alphas,param_39);
float param_40=alphaSample_1.z;
int param_41=pass;
int param_42[((int(sc_OITMaxLayers8)!=0) ? 2 : 1)*4];
spvArrayCopyFromStack1(param_42,alphas);
unpackValues(param_40,param_41,param_42);
spvArrayCopyFromStack1(alphas,param_42);
float param_43=alphaSample_1.y;
int param_44=pass;
int param_45[((int(sc_OITMaxLayers8)!=0) ? 2 : 1)*4];
spvArrayCopyFromStack1(param_45,alphas);
unpackValues(param_43,param_44,param_45);
spvArrayCopyFromStack1(alphas,param_45);
float param_46=alphaSample_1.x;
int param_47=pass;
int param_48[((int(sc_OITMaxLayers8)!=0) ? 2 : 1)*4];
spvArrayCopyFromStack1(param_48,alphas);
unpackValues(param_46,param_47,param_48);
spvArrayCopyFromStack1(alphas,param_48);
pass++;
continue;
}
else
{
break;
}
}
float alphas_normalized[((int(sc_OITMaxLayers8)!=0) ? 2 : 1)*4];
int i_1=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (i_1<(((int(sc_OITMaxLayers8)!=0) ? 2 : 1)*4))
{
alphas_normalized[i_1]=float(alphas[i_1])/255.0;
i_1++;
continue;
}
else
{
break;
}
}
float backgroundAlpha=1.0;
int i_2=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (i_2<(((int(sc_OITMaxLayers8)!=0) ? 2 : 1)*4))
{
backgroundAlpha=(1.0-alphas_normalized[i_2])*backgroundAlpha;
i_2++;
continue;
}
else
{
break;
}
}
float4 param_49=float4(backgroundAlpha,backgroundAlpha,backgroundAlpha,1.0);
sc_writeFragData0(param_49,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "required2.metal"
#include "std2_fs.metal"
#include "std2_texture.metal"
#include "std2_vs.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler baseTexSmpSC 2:1
//texture texture2D baseTex 2:0:2:1
//ubo float UserUniforms 2:2:160 {
//float4 baseTexSize 0
//float4 baseTexDims 16
//float4 baseTexView 32
//float3x3 baseTexTransform 48
//float4 baseTexUvMinMax 96
//float4 baseTexBorderColor 112
//float3 lightDir 128
//float3 skyColor 144
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 baseTexSize;
float4 baseTexDims;
float4 baseTexView;
float3x3 baseTexTransform;
float4 baseTexUvMinMax;
float4 baseTexBorderColor;
float3 lightDir;
float3 skyColor;
};
#ifndef baseTexHasSwappedViews
#define baseTexHasSwappedViews 0
#elif baseTexHasSwappedViews==1
#undef baseTexHasSwappedViews
#define baseTexHasSwappedViews 1
#endif
#ifndef baseTexLayout
#define baseTexLayout 0
#endif
#ifndef baseTexUV
#define baseTexUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 0
#elif SC_USE_UV_TRANSFORM_baseTex==1
#undef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_baseTex
#define SC_SOFTWARE_WRAP_MODE_U_baseTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_baseTex
#define SC_SOFTWARE_WRAP_MODE_V_baseTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 0
#elif SC_USE_UV_MIN_MAX_baseTex==1
#undef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 0
#elif SC_USE_CLAMP_TO_BORDER_baseTex==1
#undef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 1
#endif
struct sc_Set2
{
texture2d<float> baseTex [[id(0)]];
sampler baseTexSmpSC [[id(1)]];
constant userUniformsObj* UserUniforms [[id(2)]];
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
v.position=float4((sc_sysIn.sc_sysAttributes.texture0*2.0)-float2(1.0),0.0,1.0);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
sc_vertOut.sc_sysOut.varPackedTex=float4(sc_vertOut.sc_sysOut.varPackedTex.x,sc_vertOut.sc_sysOut.varPackedTex.y,sc_sysIn.sc_sysAttributes.texture0.x,sc_sysIn.sc_sysAttributes.texture0.y);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 baseTexSize;
float4 baseTexDims;
float4 baseTexView;
float3x3 baseTexTransform;
float4 baseTexUvMinMax;
float4 baseTexBorderColor;
float3 lightDir;
float3 skyColor;
};
#ifndef baseTexHasSwappedViews
#define baseTexHasSwappedViews 0
#elif baseTexHasSwappedViews==1
#undef baseTexHasSwappedViews
#define baseTexHasSwappedViews 1
#endif
#ifndef baseTexLayout
#define baseTexLayout 0
#endif
#ifndef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 0
#elif SC_USE_UV_TRANSFORM_baseTex==1
#undef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_baseTex
#define SC_SOFTWARE_WRAP_MODE_U_baseTex -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_baseTex
#define SC_SOFTWARE_WRAP_MODE_V_baseTex -1
#endif
#ifndef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 0
#elif SC_USE_UV_MIN_MAX_baseTex==1
#undef SC_USE_UV_MIN_MAX_baseTex
#define SC_USE_UV_MIN_MAX_baseTex 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 0
#elif SC_USE_CLAMP_TO_BORDER_baseTex==1
#undef SC_USE_CLAMP_TO_BORDER_baseTex
#define SC_USE_CLAMP_TO_BORDER_baseTex 1
#endif
#ifndef baseTexUV
#define baseTexUV 0
#endif
struct sc_Set2
{
texture2d<float> baseTex [[id(0)]];
sampler baseTexSmpSC [[id(1)]];
constant userUniformsObj* UserUniforms [[id(2)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
};
float2 baseTexGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.baseTexDims.xy;
}
int baseTexGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (baseTexHasSwappedViews)
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
float srgbToLinear(thread const float& x)
{
return pow(x,2.2);
}
float3 srgbToLinear(thread const float3& color)
{
float param=color.x;
float param_1=color.y;
float param_2=color.z;
return float3(srgbToLinear(param),srgbToLinear(param_1),srgbToLinear(param_2));
}
float luma(thread const float3& c)
{
return dot(c,float3(0.21259999,0.71520001,0.0722));
}
float ensureIsNotZero(thread const float& num)
{
float add0=1.0-fast::max(abs(sign(num)),0.99900001);
return num+add0;
}
float calcHDR(thread const float& t)
{
float t042=t*0.64999998;
float h=pow(2.7179999,t*3.0)/10.0;
float t065=0.19+fast::max(pow(h,2.3),0.0);
float t082=0.34+fast::max(pow(h,4.0),0.0);
float t100=(-0.27000001)+fast::max(pow(h,5.8000002),0.0);
float flag0=step(t,0.41999999);
float flag1=step(t,0.64999998);
float flag2=step(t,0.81999999);
return mix(mix(mix(t100,t082,flag2),t065,flag1),t042,flag0);
}
float3 inverseACESToneMapping(thread const float3& LDR)
{
float3 param=LDR;
float LDR_Luma=luma(param);
float param_1=LDR_Luma;
float LDR_val=ensureIsNotZero(param_1);
float param_2=LDR_val;
float HDR_val=calcHDR(param_2);
return (LDR*HDR_val)/float3(LDR_val);
}
float3 getDir(thread const float2& latlon)
{
float2 sinv=sin(latlon);
float2 cosv=cos(latlon);
return float3(cosv.x*cosv.y,sinv.x*cosv.y,sinv.y);
}
float4 encodeRGBD(thread const float3& rgb)
{
float maxRGB=fast::max(1.0,fast::max(rgb.x,fast::max(rgb.y,rgb.z)));
float D=1.0/maxRGB;
D=fast::max(D,0.0039607845);
return float4(rgb*D,D);
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
float2 param=baseTexGetDims2D((*sc_set2.UserUniforms));
int param_1=baseTexLayout;
int param_2=baseTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.xy;
bool param_4=(int(SC_USE_UV_TRANSFORM_baseTex)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).baseTexTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex);
bool param_7=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
float4 param_8=(*sc_set2.UserUniforms).baseTexUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
float4 param_10=(*sc_set2.UserUniforms).baseTexBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.baseTex,sc_set2.baseTexSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 reprojColor=l9_0;
float4 finColor=reprojColor;
float3 param_12=finColor.xyz;
finColor=float4(srgbToLinear(param_12),finColor.w);
float3 param_13=finColor.xyz;
finColor=float4(inverseACESToneMapping(param_13),finColor.w);
float2 skyLatlon=((sc_fragIn.sc_sysIn.varPackedTex.zw*2.0)-float2(1.0))*1.5707999;
float2 param_14=skyLatlon;
float skyFactor=0.1*fast::max(0.0,dot((*sc_set2.UserUniforms).lightDir,getDir(param_14)));
float3 l9_2=mix(finColor.xyz,(*sc_set2.UserUniforms).skyColor,float3(skyFactor));
finColor=float4(l9_2.x,l9_2.y,l9_2.z,finColor.w);
float3 param_15=finColor.xyz;
finColor=encodeRGBD(param_15);
float4 param_16=finColor;
sc_writeFragData0(param_16,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

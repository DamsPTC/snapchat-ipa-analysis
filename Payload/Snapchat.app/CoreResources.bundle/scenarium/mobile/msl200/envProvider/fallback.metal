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
//ubo float UserUniforms 2:2:192 {
//float4x4 script_modelMatrix 0
//float4 baseTexSize 64
//float4 baseTexDims 80
//float4 baseTexView 96
//float3x3 baseTexTransform 112
//float4 baseTexUvMinMax 160
//float4 baseTexBorderColor 176
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4x4 script_modelMatrix;
float4 baseTexSize;
float4 baseTexDims;
float4 baseTexView;
float3x3 baseTexTransform;
float4 baseTexUvMinMax;
float4 baseTexBorderColor;
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
float4x4 rotationMatrix=float4x4(float4(1.0,0.0,0.0,0.0),float4(0.0,1.0,0.0,0.0),float4(0.0,0.0,1.0,0.0),float4(0.0,0.0,0.0,1.0));
rotationMatrix[0]=float4(0.0,0.0,1.0,0.0);
rotationMatrix[2]=float4(-1.0,0.0,0.0,0.0);
float3 normal=normalize(sc_sysIn.sc_sysAttributes.position.xyz);
v.normal=normalize((((*sc_set2.UserUniforms).script_modelMatrix*rotationMatrix)*float4(normal,0.0)).xyz);
float2 modifiedTexCoords=sc_sysIn.sc_sysAttributes.texture0*1.002;
v.position=float4((modifiedTexCoords*2.0)-float2(1.0),0.0,1.0);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4x4 script_modelMatrix;
float4 baseTexSize;
float4 baseTexDims;
float4 baseTexView;
float3x3 baseTexTransform;
float4 baseTexUvMinMax;
float4 baseTexBorderColor;
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
float2 calculateEnvmapScreenToCube(thread float3& V)
{
V.y=-V.y;
V.z=abs(V.z);
float3 vAbs=abs(V);
float l9_0=vAbs.z;
float l9_1=vAbs.x;
bool l9_2=l9_0>=l9_1;
bool l9_3;
if (l9_2)
{
l9_3=vAbs.z>=vAbs.y;
}
else
{
l9_3=l9_2;
}
float2 uv;
if (l9_3)
{
float ma=0.5/vAbs.z;
uv=float2(V.x,V.y)*ma;
uv=(uv*0.5)+float2(0.5);
}
else
{
if (vAbs.y>=vAbs.x)
{
float ma_1=0.5/vAbs.y;
uv=float2(V.x,-V.z)*ma_1;
uv.x*=mix(0.5,1.0,1.0-(abs(uv.y)*2.0));
uv.x+=0.5;
uv.y*=0.5;
uv.y=abs(uv.y);
if (V.y>0.0)
{
uv.y=1.0-uv.y;
}
}
else
{
float ma_2=0.5/vAbs.x;
float l9_4;
if (V.x<0.0)
{
l9_4=V.z;
}
else
{
l9_4=-V.z;
}
uv=float2(l9_4,V.y)*ma_2;
uv.y*=mix(0.5,1.0,1.0-(abs(uv.x)*2.0));
uv.y+=0.5;
uv.x*=0.5;
uv.x=abs(uv.x);
if (V.x>0.0)
{
uv.x=1.0-uv.x;
}
}
}
return uv;
}
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
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
float4 cameraCubeColor=float4(0.0);
float3 param=-sc_fragIn.sc_sysIn.varNormal;
float2 l9_0=calculateEnvmapScreenToCube(param);
float2 cubeCoord=l9_0;
cubeCoord=fast::clamp(cubeCoord,float2(0.0020000001),float2(0.99800003));
float2 param_1=baseTexGetDims2D((*sc_set2.UserUniforms));
int param_2=baseTexLayout;
int param_3=baseTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_4=cubeCoord;
bool param_5=(int(SC_USE_UV_TRANSFORM_baseTex)!=0);
float3x3 param_6=(*sc_set2.UserUniforms).baseTexTransform;
int2 param_7=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex);
bool param_8=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
float4 param_9=(*sc_set2.UserUniforms).baseTexUvMinMax;
bool param_10=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
float4 param_11=(*sc_set2.UserUniforms).baseTexBorderColor;
float param_12=0.0;
float4 l9_1=sc_SampleTextureBiasOrLevel(sc_set2.baseTex,sc_set2.baseTexSmpSC,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11,param_12);
float4 l9_2=l9_1;
cameraCubeColor=l9_1;
cameraCubeColor.w=1.0;
float4 param_13=cameraCubeColor;
sc_writeFragData0(param_13,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

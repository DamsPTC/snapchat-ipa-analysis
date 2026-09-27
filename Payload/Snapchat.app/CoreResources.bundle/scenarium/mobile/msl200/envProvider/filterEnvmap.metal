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
//ubo float UserUniforms 2:2:224 {
//float4 baseTexSize 0
//float4 baseTexDims 16
//float4 baseTexView 32
//float3x3 baseTexTransform 48
//float4 baseTexUvMinMax 96
//float4 baseTexBorderColor 112
//float mipLevel 128
//float3 lightVec 144:[]:16
//float4x4 fMipLevelsMat :[]:64
//}
//SG_REFLECTION_END

namespace SNAP_VS {
#ifndef SAMPLE_COUNT
#define SAMPLE_COUNT 0
#endif
struct userUniformsObj
{
float4 baseTexSize;
float4 baseTexDims;
float4 baseTexView;
float3x3 baseTexTransform;
float4 baseTexUvMinMax;
float4 baseTexBorderColor;
float mipLevel;
float3 lightVec[SAMPLE_COUNT];
float4x4 fMipLevelsMat[SAMPLE_COUNT/16];
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
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
#ifndef SAMPLE_COUNT
#define SAMPLE_COUNT 0
#endif
struct userUniformsObj
{
float4 baseTexSize;
float4 baseTexDims;
float4 baseTexView;
float3x3 baseTexTransform;
float4 baseTexUvMinMax;
float4 baseTexBorderColor;
float mipLevel;
float3 lightVec[SAMPLE_COUNT];
float4x4 fMipLevelsMat[SAMPLE_COUNT/16];
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
float2 stretchCoordToOne(thread float2& uv,thread const float2& origTexturePxSize,thread const float& lod)
{
float2 a=uv-float2(0.5);
float2 b=origTexturePxSize*exp2(lod);
uv=(float2(0.5)+a)+((sign(a)*b)*0.5);
return uv;
}
float3 calcDirFromPanoramicTexCoords(thread const float2& uv)
{
float a=6.2831855*uv.x;
float b=3.1415927*uv.y;
float x=sin(a)*sin(b);
float y=cos(b);
float z=cos(a)*sin(b);
return float3(z,y,x);
}
float saturate0(thread const float& value)
{
return fast::clamp(value,0.0,1.0);
}
float _atan2(thread const float& x,thread const float& y)
{
float signx=(x<0.0) ? (-1.0) : 1.0;
return signx*acos(fast::clamp(y/length(float2(x,y)),-1.0,1.0));
}
float2 calcPanoramicTexCoordsFromDir(thread const float3& reflDir)
{
float3 R=normalize(reflDir);
float param=R.x;
float param_1=-R.z;
float2 uv;
uv.x=_atan2(param,param_1)-1.5707964;
uv.y=acos(R.y);
uv/=float2(6.2831855,3.1415927);
return uv;
}
float getMat4ValByIndex(thread const float4x4& mat,thread const int& index)
{
int row=index/4;
int col=index-(row*4);
return mat[row][col];
}
float getMipLevel(thread const int& index,constant userUniformsObj& UserUniforms)
{
int indexMat=index/16;
int indexVal=index-(indexMat*16);
float4x4 param=UserUniforms.fMipLevelsMat[indexMat];
int param_1=indexVal;
return getMat4ValByIndex(param,param_1);
}
float2 calcSeamlessPanoramicUvsForConvolution(thread const float2& uv,thread const float2& topMipRes,thread const float& lod)
{
float2 thisMipRes=fast::max(float2(1.0),topMipRes/float2(exp2(lod)));
return ((uv*thisMipRes)-float2(0.5))/(thisMipRes-float2(1.0));
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
float3 decodeRGBD(thread const float4& rgbd)
{
return rgbd.xyz*(1.0/rgbd.w);
}
float4 encodeRGBD(thread const float3& rgb)
{
float maxRGB=fast::max(1.0,fast::max(rgb.x,fast::max(rgb.y,rgb.z)));
float D=1.0/maxRGB;
D=fast::max(D,0.0039607845);
return float4(rgb*D,D);
}
float4 filterEnvmap1(thread const float3& targetN,constant userUniformsObj& UserUniforms,thread texture2d<float> baseTex,thread sampler baseTexSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float fTotalWeight=0.0;
float3 vPrefilteredColor=float3(0.0);
int i=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (i<SAMPLE_COUNT)
{
float3 vLight=UserUniforms.lightVec[i];
float param=vLight.y;
float NoL=saturate0(param);
bool3 l9_0=bool3(abs(targetN.y)<0.99900001);
float3 UpVector=float3(l9_0.x ? float3(0.0,1.0,0.0).x : float3(0.0,0.0,1.0).x,l9_0.y ? float3(0.0,1.0,0.0).y : float3(0.0,0.0,1.0).y,l9_0.z ? float3(0.0,1.0,0.0).z : float3(0.0,0.0,1.0).z);
float3 TangentX=normalize(cross(UpVector,targetN));
float3 TangentZ=cross(targetN,TangentX);
vLight=((TangentX*vLight.x)+(targetN*vLight.y))+(TangentZ*vLight.z);
float3 param_1=vLight;
float2 uv=calcPanoramicTexCoordsFromDir(param_1);
int param_2=i;
float fMipLevel=getMipLevel(param_2,UserUniforms);
float2 param_3=uv;
float2 param_4=UserUniforms.baseTexSize.xy;
float param_5=fMipLevel;
uv=calcSeamlessPanoramicUvsForConvolution(param_3,param_4,param_5);
float2 param_6=baseTexGetDims2D(UserUniforms);
int param_7=baseTexLayout;
int param_8=baseTexGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_9=uv;
bool param_10=(int(SC_USE_UV_TRANSFORM_baseTex)!=0);
float3x3 param_11=UserUniforms.baseTexTransform;
int2 param_12=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex);
bool param_13=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
float4 param_14=UserUniforms.baseTexUvMinMax;
bool param_15=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
float4 param_16=UserUniforms.baseTexBorderColor;
float param_17=fMipLevel;
float4 l9_1=sc_SampleTextureLevel(baseTex,baseTexSmpSC,param_6,param_7,param_8,param_9,param_10,param_11,param_12,param_13,param_14,param_15,param_16,param_17);
float4 l9_2=l9_1;
float4 param_18=l9_1;
vPrefilteredColor+=(decodeRGBD(param_18)*NoL);
fTotalWeight+=NoL;
i++;
continue;
}
else
{
break;
}
}
float3 param_19=vPrefilteredColor/float3(fTotalWeight);
return encodeRGBD(param_19);
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
float2 param=sc_fragIn.sc_sysIn.varPackedTex.xy;
float2 param_1=(*sc_set2.UserUniforms).baseTexSize.zw;
float param_2=(*sc_set2.UserUniforms).mipLevel;
float2 l9_0=stretchCoordToOne(param,param_1,param_2);
float2 param_3=l9_0;
float3 targetN=normalize(calcDirFromPanoramicTexCoords(param_3));
float3 param_4=targetN;
float4 param_5=filterEnvmap1(param_4,(*sc_set2.UserUniforms),sc_set2.baseTex,sc_set2.baseTexSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
sc_writeFragData0(param_5,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

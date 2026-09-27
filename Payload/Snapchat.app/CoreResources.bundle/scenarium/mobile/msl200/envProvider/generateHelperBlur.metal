#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "std2.metal"
#include "std2_vs.metal"
#include "std2_fs.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler baseTexSmpSC 2:1
//texture texture2D baseTex 2:0:2:1
//ubo float UserUniforms 2:2:128 {
//float4 baseTexSize 0
//float4 baseTexDims 16
//float4 baseTexView 32
//float3x3 baseTexTransform 48
//float4 baseTexUvMinMax 96
//float4 baseTexBorderColor 112
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
v.position=float4((v.texture0*2.0)-float2(1.0),0.0,1.0);
float2 l9_0=float2(((*sc_set2.UserUniforms).baseTexTransform*float3(v.texture0,1.0)).xy);
sc_vertOut.sc_sysOut.varPackedTex=float4(sc_vertOut.sc_sysOut.varPackedTex.x,sc_vertOut.sc_sysOut.varPackedTex.y,l9_0.x,l9_0.y);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
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
#ifndef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 0
#elif SC_USE_UV_TRANSFORM_baseTex==1
#undef SC_USE_UV_TRANSFORM_baseTex
#define SC_USE_UV_TRANSFORM_baseTex 1
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
float random(thread const float2& st)
{
return fract(sin(dot(st,float2(12.9898,78.233002)))*43758.547);
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
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
float2 param=sc_fragIn.sc_sysIn.varPackedTex.zw;
float2 param_1=(*sc_set2.UserUniforms).baseTexSize.zw;
float param_2=0.0;
float2 l9_0=stretchCoordToOne(param,param_1,param_2);
float2 uv=l9_0;
float2 param_3=uv;
float3 vecNormal=calcDirFromPanoramicTexCoords(param_3);
vecNormal=normalize(vecNormal);
float2 pixelUpwardsShift=float2(0.0,1.0/(*sc_set2.UserUniforms).baseTexSize.y);
float2 texCoord=uv;
float2 upShiftTexCoord=texCoord+pixelUpwardsShift;
float2 downShiftTexCoord=texCoord-pixelUpwardsShift;
float l9_1=upShiftTexCoord.y;
bool l9_2=l9_1>0.0;
bool l9_3;
if (l9_2)
{
l9_3=upShiftTexCoord.y<1.0;
}
else
{
l9_3=l9_2;
}
bool2 l9_4=bool2(l9_3);
float2 shiftedCoordToUse=float2(l9_4.x ? upShiftTexCoord.x : downShiftTexCoord.x,l9_4.y ? upShiftTexCoord.y : downShiftTexCoord.y);
float2 param_4=shiftedCoordToUse;
float3 vecShifted=calcDirFromPanoramicTexCoords(param_4);
vecShifted=normalize(vecShifted);
float shiftAngle=3.1415927/(*sc_set2.UserUniforms).baseTexSize.y;
float normLength=cos(shiftAngle);
float shiftLength=sin(shiftAngle);
float3 upShiftVec=vecShifted-(vecNormal*normLength);
float3 TangentY=normalize(upShiftVec);
float3 TangentX=normalize(cross(vecNormal,TangentY));
float3 TangentZ=vecNormal;
upShiftVec=vecNormal+((TangentY*shiftLength)*(-1.0));
float3 shiftY=TangentY*shiftLength;
float3 shiftX=TangentX*shiftLength;
float coeff=0.70710677;
float2 param_5=uv;
float rand=random(param_5);
float3 start=vecNormal+mix(shiftX*0.1,shiftY*0.1,float3(rand));
float3 shiftedVectors[9];
shiftedVectors[0]=start;
shiftedVectors[1]=start+shiftX;
shiftedVectors[2]=start+shiftY;
shiftedVectors[3]=start-shiftX;
shiftedVectors[4]=start-shiftY;
shiftedVectors[5]=(start+(shiftY*coeff))+(shiftX*coeff);
shiftedVectors[6]=(start-(shiftY*coeff))-(shiftX*coeff);
shiftedVectors[7]=(start+(shiftY*coeff))-(shiftX*coeff);
shiftedVectors[8]=(start-(shiftY*coeff))+(shiftX*coeff);
float3 accumColor=float3(0.0);
int i=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (i<9)
{
float3 param_6=shiftedVectors[i];
float2 shiftedCoord=calcPanoramicTexCoordsFromDir(param_6);
float2 param_7=baseTexGetDims2D((*sc_set2.UserUniforms));
int param_8=baseTexLayout;
int param_9=baseTexGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_10=shiftedCoord;
bool param_11=false;
float3x3 param_12=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
int2 param_13=int2(SC_SOFTWARE_WRAP_MODE_U_baseTex,SC_SOFTWARE_WRAP_MODE_V_baseTex);
bool param_14=(int(SC_USE_UV_MIN_MAX_baseTex)!=0);
float4 param_15=(*sc_set2.UserUniforms).baseTexUvMinMax;
bool param_16=(int(SC_USE_CLAMP_TO_BORDER_baseTex)!=0);
float4 param_17=(*sc_set2.UserUniforms).baseTexBorderColor;
float param_18=0.0;
float4 l9_5=sc_SampleTextureBiasOrLevel(sc_set2.baseTex,sc_set2.baseTexSmpSC,param_7,param_8,param_9,param_10,param_11,param_12,param_13,param_14,param_15,param_16,param_17,param_18);
float4 l9_6=l9_5;
float4 baseTexSample=l9_5;
float4 param_19=baseTexSample;
accumColor+=decodeRGBD(param_19);
i++;
continue;
}
else
{
break;
}
}
float3 param_20=accumColor/float3(9.0);
float4 finColor=encodeRGBD(param_20);
float4 param_21=finColor;
sc_writeFragData0(param_21,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

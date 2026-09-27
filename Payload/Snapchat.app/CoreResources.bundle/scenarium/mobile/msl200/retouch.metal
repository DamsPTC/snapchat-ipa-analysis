#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE0 1
#include "std2.metal"
#include "std2_vs.metal"
#include "std2_fs.metal"
//SG_REFLECTION_BEGIN(100)
//sampler sampler lookupTextureSmpSC 2:2
//sampler sampler maskTextureSmpSC 2:3
//texture texture2D lookupTexture 2:0:2:2
//texture texture2D maskTexture 2:1:2:3
//ubo float UserUniforms 2:4:288 {
//float4 lookupTextureSize 0
//float4 lookupTextureDims 16
//float4 lookupTextureView 32
//float3x3 lookupTextureTransform 48
//float4 lookupTextureUvMinMax 96
//float4 lookupTextureBorderColor 112
//float4 maskTextureSize 128
//float4 maskTextureDims 144
//float4 maskTextureView 160
//float3x3 maskTextureTransform 176
//float4 maskTextureUvMinMax 224
//float4 maskTextureBorderColor 240
//float softSkinRadius 256
//float softSkinIntensity 260
//float teethWhiteningIntensity 264
//float eyeWhiteningIntensity 268
//float sharpenEyeIntensity 272
//}
//SG_REFLECTION_END

namespace SNAP_VS {
struct userUniformsObj
{
float4 lookupTextureSize;
float4 lookupTextureDims;
float4 lookupTextureView;
float3x3 lookupTextureTransform;
float4 lookupTextureUvMinMax;
float4 lookupTextureBorderColor;
float4 maskTextureSize;
float4 maskTextureDims;
float4 maskTextureView;
float3x3 maskTextureTransform;
float4 maskTextureUvMinMax;
float4 maskTextureBorderColor;
float softSkinRadius;
float softSkinIntensity;
float teethWhiteningIntensity;
float eyeWhiteningIntensity;
float sharpenEyeIntensity;
};
#ifndef lookupTextureHasSwappedViews
#define lookupTextureHasSwappedViews 0
#elif lookupTextureHasSwappedViews==1
#undef lookupTextureHasSwappedViews
#define lookupTextureHasSwappedViews 1
#endif
#ifndef lookupTextureLayout
#define lookupTextureLayout 0
#endif
#ifndef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 0
#elif maskTextureHasSwappedViews==1
#undef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 1
#endif
#ifndef maskTextureLayout
#define maskTextureLayout 0
#endif
#ifndef SOFT_SKIN
#define SOFT_SKIN 0
#elif SOFT_SKIN==1
#undef SOFT_SKIN
#define SOFT_SKIN 1
#endif
#ifndef EYE_SHARPEN
#define EYE_SHARPEN 0
#elif EYE_SHARPEN==1
#undef EYE_SHARPEN
#define EYE_SHARPEN 1
#endif
#ifndef EYE_WHITENING
#define EYE_WHITENING 0
#elif EYE_WHITENING==1
#undef EYE_WHITENING
#define EYE_WHITENING 1
#endif
#ifndef TEETH_WHITENING
#define TEETH_WHITENING 0
#elif TEETH_WHITENING==1
#undef TEETH_WHITENING
#define TEETH_WHITENING 1
#endif
#ifndef ADD_NOISE
#define ADD_NOISE 1
#elif ADD_NOISE==1
#undef ADD_NOISE
#define ADD_NOISE 1
#endif
#ifndef IS_LEGACY_LOOKUP
#define IS_LEGACY_LOOKUP 0
#elif IS_LEGACY_LOOKUP==1
#undef IS_LEGACY_LOOKUP
#define IS_LEGACY_LOOKUP 1
#endif
#ifndef lookupTextureUV
#define lookupTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_lookupTexture
#define SC_USE_UV_TRANSFORM_lookupTexture 0
#elif SC_USE_UV_TRANSFORM_lookupTexture==1
#undef SC_USE_UV_TRANSFORM_lookupTexture
#define SC_USE_UV_TRANSFORM_lookupTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_lookupTexture
#define SC_SOFTWARE_WRAP_MODE_U_lookupTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_lookupTexture
#define SC_SOFTWARE_WRAP_MODE_V_lookupTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_lookupTexture
#define SC_USE_UV_MIN_MAX_lookupTexture 0
#elif SC_USE_UV_MIN_MAX_lookupTexture==1
#undef SC_USE_UV_MIN_MAX_lookupTexture
#define SC_USE_UV_MIN_MAX_lookupTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_lookupTexture
#define SC_USE_CLAMP_TO_BORDER_lookupTexture 0
#elif SC_USE_CLAMP_TO_BORDER_lookupTexture==1
#undef SC_USE_CLAMP_TO_BORDER_lookupTexture
#define SC_USE_CLAMP_TO_BORDER_lookupTexture 1
#endif
#ifndef maskTextureUV
#define maskTextureUV 0
#endif
#ifndef SC_USE_UV_TRANSFORM_maskTexture
#define SC_USE_UV_TRANSFORM_maskTexture 0
#elif SC_USE_UV_TRANSFORM_maskTexture==1
#undef SC_USE_UV_TRANSFORM_maskTexture
#define SC_USE_UV_TRANSFORM_maskTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_maskTexture
#define SC_SOFTWARE_WRAP_MODE_U_maskTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_maskTexture
#define SC_SOFTWARE_WRAP_MODE_V_maskTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_maskTexture
#define SC_USE_UV_MIN_MAX_maskTexture 0
#elif SC_USE_UV_MIN_MAX_maskTexture==1
#undef SC_USE_UV_MIN_MAX_maskTexture
#define SC_USE_UV_MIN_MAX_maskTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_maskTexture
#define SC_USE_CLAMP_TO_BORDER_maskTexture 0
#elif SC_USE_CLAMP_TO_BORDER_maskTexture==1
#undef SC_USE_CLAMP_TO_BORDER_maskTexture
#define SC_USE_CLAMP_TO_BORDER_maskTexture 1
#endif
struct sc_Set2
{
texture2d<float> lookupTexture [[id(0)]];
texture2d<float> maskTexture [[id(1)]];
sampler lookupTextureSmpSC [[id(2)]];
sampler maskTextureSmpSC [[id(3)]];
constant userUniformsObj* UserUniforms [[id(4)]];
};
struct sc_VertOut
{
sc_SysOut sc_sysOut;
float4 varCustomTex0 [[user(locn10)]];
float4 varCustomTex1 [[user(locn11)]];
float4 varCustomTex2 [[user(locn12)]];
float4 varCustomTex3 [[user(locn13)]];
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
float2 l9_0=((v.position.xy/float2(v.position.w))*0.5)+float2(0.5);
sc_vertOut.sc_sysOut.varPackedTex=float4(l9_0.x,l9_0.y,sc_vertOut.sc_sysOut.varPackedTex.z,sc_vertOut.sc_sysOut.varPackedTex.w);
#if (SOFT_SKIN)
{
float2 l9_1=sc_vertOut.sc_sysOut.varPackedTex.xy+float2(-0.0069444398,-0.00390625);
sc_vertOut.varCustomTex0=float4(l9_1.x,l9_1.y,sc_vertOut.varCustomTex0.z,sc_vertOut.varCustomTex0.w);
float2 l9_2=sc_vertOut.sc_sysOut.varPackedTex.xy+float2(-0.0069444398,0.0054687499);
sc_vertOut.varCustomTex1=float4(l9_2.x,l9_2.y,sc_vertOut.varCustomTex1.z,sc_vertOut.varCustomTex1.w);
float2 l9_3=sc_vertOut.sc_sysOut.varPackedTex.xy+float2(0.0097222198,-0.00390625);
sc_vertOut.varCustomTex2=float4(l9_3.x,l9_3.y,sc_vertOut.varCustomTex2.z,sc_vertOut.varCustomTex2.w);
float2 l9_4=sc_vertOut.sc_sysOut.varPackedTex.xy+float2(0.0097222198,0.0054687499);
sc_vertOut.varCustomTex3=float4(l9_4.x,l9_4.y,sc_vertOut.varCustomTex3.z,sc_vertOut.varCustomTex3.w);
}
#endif
#if (EYE_SHARPEN)
{
float2 delta=float2((*sc_set0.LibraryUniforms).sc_Camera.aspect/1280.0,0.00078125001);
float2 l9_5=sc_vertOut.sc_sysOut.varPackedTex.xy+float2(-delta.x,-delta.y);
sc_vertOut.varCustomTex0=float4(sc_vertOut.varCustomTex0.x,sc_vertOut.varCustomTex0.y,l9_5.x,l9_5.y);
float2 l9_6=sc_vertOut.sc_sysOut.varPackedTex.xy+float2(delta.x,-delta.y);
sc_vertOut.varCustomTex1=float4(sc_vertOut.varCustomTex1.x,sc_vertOut.varCustomTex1.y,l9_6.x,l9_6.y);
float2 l9_7=sc_vertOut.sc_sysOut.varPackedTex.xy+float2(-delta.x,delta.y);
sc_vertOut.varCustomTex2=float4(sc_vertOut.varCustomTex2.x,sc_vertOut.varCustomTex2.y,l9_7.x,l9_7.y);
float2 l9_8=sc_vertOut.sc_sysOut.varPackedTex.xy+float2(delta.x,delta.y);
sc_vertOut.varCustomTex3=float4(sc_vertOut.varCustomTex3.x,sc_vertOut.varCustomTex3.y,l9_8.x,l9_8.y);
}
#endif
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct userUniformsObj
{
float4 lookupTextureSize;
float4 lookupTextureDims;
float4 lookupTextureView;
float3x3 lookupTextureTransform;
float4 lookupTextureUvMinMax;
float4 lookupTextureBorderColor;
float4 maskTextureSize;
float4 maskTextureDims;
float4 maskTextureView;
float3x3 maskTextureTransform;
float4 maskTextureUvMinMax;
float4 maskTextureBorderColor;
float softSkinRadius;
float softSkinIntensity;
float teethWhiteningIntensity;
float eyeWhiteningIntensity;
float sharpenEyeIntensity;
};
#ifndef lookupTextureHasSwappedViews
#define lookupTextureHasSwappedViews 0
#elif lookupTextureHasSwappedViews==1
#undef lookupTextureHasSwappedViews
#define lookupTextureHasSwappedViews 1
#endif
#ifndef lookupTextureLayout
#define lookupTextureLayout 0
#endif
#ifndef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 0
#elif maskTextureHasSwappedViews==1
#undef maskTextureHasSwappedViews
#define maskTextureHasSwappedViews 1
#endif
#ifndef maskTextureLayout
#define maskTextureLayout 0
#endif
#ifndef IS_LEGACY_LOOKUP
#define IS_LEGACY_LOOKUP 0
#elif IS_LEGACY_LOOKUP==1
#undef IS_LEGACY_LOOKUP
#define IS_LEGACY_LOOKUP 1
#endif
#ifndef SC_USE_UV_TRANSFORM_lookupTexture
#define SC_USE_UV_TRANSFORM_lookupTexture 0
#elif SC_USE_UV_TRANSFORM_lookupTexture==1
#undef SC_USE_UV_TRANSFORM_lookupTexture
#define SC_USE_UV_TRANSFORM_lookupTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_lookupTexture
#define SC_SOFTWARE_WRAP_MODE_U_lookupTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_lookupTexture
#define SC_SOFTWARE_WRAP_MODE_V_lookupTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_lookupTexture
#define SC_USE_UV_MIN_MAX_lookupTexture 0
#elif SC_USE_UV_MIN_MAX_lookupTexture==1
#undef SC_USE_UV_MIN_MAX_lookupTexture
#define SC_USE_UV_MIN_MAX_lookupTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_lookupTexture
#define SC_USE_CLAMP_TO_BORDER_lookupTexture 0
#elif SC_USE_CLAMP_TO_BORDER_lookupTexture==1
#undef SC_USE_CLAMP_TO_BORDER_lookupTexture
#define SC_USE_CLAMP_TO_BORDER_lookupTexture 1
#endif
#ifndef ADD_NOISE
#define ADD_NOISE 1
#elif ADD_NOISE==1
#undef ADD_NOISE
#define ADD_NOISE 1
#endif
#ifndef SC_USE_UV_TRANSFORM_maskTexture
#define SC_USE_UV_TRANSFORM_maskTexture 0
#elif SC_USE_UV_TRANSFORM_maskTexture==1
#undef SC_USE_UV_TRANSFORM_maskTexture
#define SC_USE_UV_TRANSFORM_maskTexture 1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_U_maskTexture
#define SC_SOFTWARE_WRAP_MODE_U_maskTexture -1
#endif
#ifndef SC_SOFTWARE_WRAP_MODE_V_maskTexture
#define SC_SOFTWARE_WRAP_MODE_V_maskTexture -1
#endif
#ifndef SC_USE_UV_MIN_MAX_maskTexture
#define SC_USE_UV_MIN_MAX_maskTexture 0
#elif SC_USE_UV_MIN_MAX_maskTexture==1
#undef SC_USE_UV_MIN_MAX_maskTexture
#define SC_USE_UV_MIN_MAX_maskTexture 1
#endif
#ifndef SC_USE_CLAMP_TO_BORDER_maskTexture
#define SC_USE_CLAMP_TO_BORDER_maskTexture 0
#elif SC_USE_CLAMP_TO_BORDER_maskTexture==1
#undef SC_USE_CLAMP_TO_BORDER_maskTexture
#define SC_USE_CLAMP_TO_BORDER_maskTexture 1
#endif
#ifndef SOFT_SKIN
#define SOFT_SKIN 0
#elif SOFT_SKIN==1
#undef SOFT_SKIN
#define SOFT_SKIN 1
#endif
#ifndef EYE_SHARPEN
#define EYE_SHARPEN 0
#elif EYE_SHARPEN==1
#undef EYE_SHARPEN
#define EYE_SHARPEN 1
#endif
#ifndef EYE_WHITENING
#define EYE_WHITENING 0
#elif EYE_WHITENING==1
#undef EYE_WHITENING
#define EYE_WHITENING 1
#endif
#ifndef TEETH_WHITENING
#define TEETH_WHITENING 0
#elif TEETH_WHITENING==1
#undef TEETH_WHITENING
#define TEETH_WHITENING 1
#endif
#ifndef lookupTextureUV
#define lookupTextureUV 0
#endif
#ifndef maskTextureUV
#define maskTextureUV 0
#endif
struct sc_Set2
{
texture2d<float> lookupTexture [[id(0)]];
texture2d<float> maskTexture [[id(1)]];
sampler lookupTextureSmpSC [[id(2)]];
sampler maskTextureSmpSC [[id(3)]];
constant userUniformsObj* UserUniforms [[id(4)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
float4 varCustomTex0 [[user(locn10)]];
float4 varCustomTex1 [[user(locn11)]];
float4 varCustomTex2 [[user(locn12)]];
float4 varCustomTex3 [[user(locn13)]];
};
float2 maskTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.maskTextureDims.xy;
}
int maskTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (maskTextureHasSwappedViews)
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
float getLuminance(thread const float4& color)
{
return dot(color,float4(0.29899999,0.58700001,0.114,0.0));
}
float4 getLuminance4(thread const float4x4& color)
{
return float4(0.29899999,0.58700001,0.114,0.0)*color;
}
float4 getWeight(thread const float& intens,thread const float4& nextIntens,constant userUniformsObj& UserUniforms)
{
float4 lg=log(nextIntens/float4(intens+1e-06));
lg*=lg;
return exp(lg*((-1.0)/((2.0*UserUniforms.softSkinRadius)*UserUniforms.softSkinRadius)));
}
float rand(thread const float2& co)
{
return fract(sin(dot(co,float2(12.9898,78.233002)))*43758.547);
}
float4 softSkin(thread const float4& originalColor,thread const float& factor,constant userUniformsObj& UserUniforms,thread float4& varCustomTex0,thread float4& varCustomTex1,thread float4& varCustomTex2,thread float4& varCustomTex3,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 screenColor=originalColor;
float4 param=screenColor;
float intens=getLuminance(param);
float sum=1.0;
float2 param_1=varCustomTex0.xy;
float4x4 nextColor;
nextColor[0]=sc_ScreenTextureSampleView(param_1,sc_sysIn,sc_set0,sc_set1);
float2 param_2=varCustomTex1.xy;
nextColor[1]=sc_ScreenTextureSampleView(param_2,sc_sysIn,sc_set0,sc_set1);
float2 param_3=varCustomTex2.xy;
nextColor[2]=sc_ScreenTextureSampleView(param_3,sc_sysIn,sc_set0,sc_set1);
float2 param_4=varCustomTex3.xy;
nextColor[3]=sc_ScreenTextureSampleView(param_4,sc_sysIn,sc_set0,sc_set1);
float4x4 param_5=nextColor;
float4 nextIntens=getLuminance4(param_5);
float param_6=intens;
float4 param_7=nextIntens;
float4 curr=getWeight(param_6,param_7,UserUniforms)*0.36787945;
sum+=dot(curr,float4(1.0));
screenColor+=(nextColor*curr);
#if (ADD_NOISE)
{
float2 param_8=sc_sysIn.varPackedTex.xy;
float _noise=(rand(param_8)-0.5)/30.0;
screenColor=(screenColor/float4(sum))+float4(_noise,_noise,_noise,1.0);
}
#else
{
screenColor/=float4(sum);
}
#endif
screenColor=mix(originalColor,screenColor,float4(factor));
return screenColor;
}
float4 sharpen(thread const float4& originalColor,thread const float& factor,thread float4& varCustomTex0,thread float4& varCustomTex1,thread float4& varCustomTex2,thread float4& varCustomTex3,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 accum=originalColor*5.0;
float2 param=varCustomTex0.zw;
accum-=sc_ScreenTextureSampleView(param,sc_sysIn,sc_set0,sc_set1);
float2 param_1=varCustomTex1.zw;
accum-=sc_ScreenTextureSampleView(param_1,sc_sysIn,sc_set0,sc_set1);
float2 param_2=varCustomTex2.zw;
accum-=sc_ScreenTextureSampleView(param_2,sc_sysIn,sc_set0,sc_set1);
float2 param_3=varCustomTex3.zw;
accum-=sc_ScreenTextureSampleView(param_3,sc_sysIn,sc_set0,sc_set1);
float4 result=mix(originalColor,accum,float4(factor));
return fast::clamp(result,float4(0.0),float4(1.0));
}
float2 lookupTextureGetDims2D(constant userUniformsObj& UserUniforms)
{
return UserUniforms.lookupTextureDims.xy;
}
int lookupTextureGetStereoViewIndex(thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
int result;
#if (lookupTextureHasSwappedViews)
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
float3 mapColor(thread const float3& orgColor,constant userUniformsObj& UserUniforms,thread texture2d<float> lookupTexture,thread sampler lookupTextureSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float4 uv=float4(0.0);
float bValue=0.0;
float2 mulB=float2(0.0);
#if (IS_LEGACY_LOOKUP)
{
bValue=(orgColor.z*255.0)/4.0;
mulB=fast::clamp(float2(floor(bValue))+float2(0.0,1.0),float2(0.0),float2(63.0));
float2 row=floor((mulB/float2(8.0))+float2(1e-06));
float4 row_col=float4(row,mulB-(row*8.0));
float4 lookup=((orgColor.yyxx*0.12304688)+(row_col*0.125))+float4(0.0009765625);
float2 l9_0=float2(lookup.z,1.0-lookup.x);
uv=float4(l9_0.x,l9_0.y,uv.z,uv.w);
float2 l9_1=float2(lookup.w,1.0-lookup.y);
uv=float4(uv.x,uv.y,l9_1.x,l9_1.y);
}
#else
{
bValue=orgColor.z*15.0;
mulB=fast::clamp(float2(floor(bValue))+float2(0.0,1.0),float2(0.0),float2(15.0));
float3 lookup_1=((orgColor.xxy*float3(0.05859375,0.05859375,0.9375))+float3(mulB*0.0625,0.0))+float3(0.001953125,0.001953125,0.03125);
uv=float4(lookup_1.xz.x,lookup_1.xz.y,uv.z,uv.w);
uv=float4(uv.x,uv.y,lookup_1.yz.x,lookup_1.yz.y);
}
#endif
float b1w=bValue-mulB.x;
float2 param=lookupTextureGetDims2D(UserUniforms);
int param_1=lookupTextureLayout;
int param_2=lookupTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_3=uv.xy;
bool param_4=(int(SC_USE_UV_TRANSFORM_lookupTexture)!=0);
float3x3 param_5=UserUniforms.lookupTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_lookupTexture,SC_SOFTWARE_WRAP_MODE_V_lookupTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_lookupTexture)!=0);
float4 param_8=UserUniforms.lookupTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_lookupTexture)!=0);
float4 param_10=UserUniforms.lookupTextureBorderColor;
float param_11=0.0;
float4 l9_2=sc_SampleTextureBiasOrLevel(lookupTexture,lookupTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_3=l9_2;
float3 sampled1=l9_2.xyz;
float2 param_12=lookupTextureGetDims2D(UserUniforms);
int param_13=lookupTextureLayout;
int param_14=lookupTextureGetStereoViewIndex(sc_sysIn,sc_set0,sc_set1);
float2 param_15=uv.zw;
bool param_16=(int(SC_USE_UV_TRANSFORM_lookupTexture)!=0);
float3x3 param_17=UserUniforms.lookupTextureTransform;
int2 param_18=int2(SC_SOFTWARE_WRAP_MODE_U_lookupTexture,SC_SOFTWARE_WRAP_MODE_V_lookupTexture);
bool param_19=(int(SC_USE_UV_MIN_MAX_lookupTexture)!=0);
float4 param_20=UserUniforms.lookupTextureUvMinMax;
bool param_21=(int(SC_USE_CLAMP_TO_BORDER_lookupTexture)!=0);
float4 param_22=UserUniforms.lookupTextureBorderColor;
float param_23=0.0;
float4 l9_4=sc_SampleTextureBiasOrLevel(lookupTexture,lookupTextureSmpSC,param_12,param_13,param_14,param_15,param_16,param_17,param_18,param_19,param_20,param_21,param_22,param_23);
float4 l9_5=l9_4;
float3 sampled2=l9_4.xyz;
return mix(sampled1,sampled2,float3(b1w));
}
float4 whitening(thread const float4& originalColor,thread const float& factor,constant userUniformsObj& UserUniforms,thread texture2d<float> lookupTexture,thread sampler lookupTextureSmpSC,thread sc_SysIn& sc_sysIn,const constant sc_Set0& sc_set0,const constant sc_Set1& sc_set1)
{
float3 param=originalColor.xyz;
float4 color=float4(mapColor(param,UserUniforms,lookupTexture,lookupTextureSmpSC,sc_sysIn,sc_set0,sc_set1),originalColor.w);
return mix(originalColor,color,float4(factor));
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float4 originalColor=getFramebufferColor(sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
float4 res=originalColor;
float4 maskColor=float4(0.0);
float whiteningAlpha=0.0;
float2 param=maskTextureGetDims2D((*sc_set2.UserUniforms));
int param_1=maskTextureLayout;
int param_2=maskTextureGetStereoViewIndex(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param_3=sc_fragIn.sc_sysIn.varPackedTex.zw;
bool param_4=(int(SC_USE_UV_TRANSFORM_maskTexture)!=0);
float3x3 param_5=(*sc_set2.UserUniforms).maskTextureTransform;
int2 param_6=int2(SC_SOFTWARE_WRAP_MODE_U_maskTexture,SC_SOFTWARE_WRAP_MODE_V_maskTexture);
bool param_7=(int(SC_USE_UV_MIN_MAX_maskTexture)!=0);
float4 param_8=(*sc_set2.UserUniforms).maskTextureUvMinMax;
bool param_9=(int(SC_USE_CLAMP_TO_BORDER_maskTexture)!=0);
float4 param_10=(*sc_set2.UserUniforms).maskTextureBorderColor;
float param_11=0.0;
float4 l9_0=sc_SampleTextureBiasOrLevel(sc_set2.maskTexture,sc_set2.maskTextureSmpSC,param,param_1,param_2,param_3,param_4,param_5,param_6,param_7,param_8,param_9,param_10,param_11);
float4 l9_1=l9_0;
float4 maskTextureSample=l9_0;
maskColor=maskTextureSample;
#if (SOFT_SKIN)
{
float4 param_12=res;
float param_13=maskColor.x*(*sc_set2.UserUniforms).softSkinIntensity;
res=softSkin(param_12,param_13,(*sc_set2.UserUniforms),sc_fragIn.varCustomTex0,sc_fragIn.varCustomTex1,sc_fragIn.varCustomTex2,sc_fragIn.varCustomTex3,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
}
#endif
#if (EYE_SHARPEN)
{
float4 param_14=res;
float param_15=maskColor.z*(*sc_set2.UserUniforms).sharpenEyeIntensity;
res=sharpen(param_14,param_15,sc_fragIn.varCustomTex0,sc_fragIn.varCustomTex1,sc_fragIn.varCustomTex2,sc_fragIn.varCustomTex3,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
}
#endif
#if (EYE_WHITENING)
{
whiteningAlpha+=(maskColor.z*(*sc_set2.UserUniforms).eyeWhiteningIntensity);
}
#endif
#if (TEETH_WHITENING)
{
whiteningAlpha+=(maskColor.y*(*sc_set2.UserUniforms).teethWhiteningIntensity);
}
#endif
#if (EYE_WHITENING||TEETH_WHITENING)
{
float4 param_16=res;
float param_17=whiteningAlpha;
res=whitening(param_16,param_17,(*sc_set2.UserUniforms),sc_set2.lookupTexture,sc_set2.lookupTextureSmpSC,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
}
#endif
float4 param_18=res;
sc_writeFragData0(param_18,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

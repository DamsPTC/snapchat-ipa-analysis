#version 100 sc_convert_to 300 es
//SG_REFLECTION_BEGIN(100)
//attribute vec4 atbCoord2d 18
//SG_REFLECTION_END
#if defined VERTEX_SHADER
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include <required2.glsl>
#include <std2_vs.glsl>
#include <std2_fs.glsl>
#include <std2_texture.glsl>
#ifndef CAMERA_ORTHO
#define CAMERA_ORTHO 0
#elif CAMERA_ORTHO==1
#undef CAMERA_ORTHO
#define CAMERA_ORTHO 1
#endif
#ifndef LIQUIFY_FACESTRETCH
#define LIQUIFY_FACESTRETCH 0
#elif LIQUIFY_FACESTRETCH==1
#undef LIQUIFY_FACESTRETCH
#define LIQUIFY_FACESTRETCH 1
#endif
#ifndef LIQUIFY_ONLY
#define LIQUIFY_ONLY 0
#elif LIQUIFY_ONLY==1
#undef LIQUIFY_ONLY
#define LIQUIFY_ONLY 1
#endif
#ifndef MAX_LIQUIFY
#define MAX_LIQUIFY 10
#endif
uniform mat4 ptsInvMat[10];
uniform vec3 camDirO[10];
uniform vec4 coeffs[10];
attribute vec4 atbCoord2d;
varying vec2 varScreenSpacePointsPos0;
varying vec2 varScreenSpacePointsPos1;
varying vec2 varScreenSpacePointsPos2;
varying vec2 varScreenSpacePointsPos3;
varying vec2 varScreenSpacePointsPos4;
varying vec2 varScreenSpacePointsPos5;
varying vec2 varScreenSpacePointsPos6;
varying vec2 varScreenSpacePointsPos7;
varying vec2 varScreenSpacePointsPos8;
varying vec2 varScreenSpacePointsPos9;
void main()
{
sc_Vertex_t l9_0=sc_LoadVertexAttributes();
sc_ProcessVertex(sc_Vertex_t(vec4(atbCoord2d.xy,0.0,1.0),l9_0.normal,l9_0.tangent,l9_0.texture0,l9_0.texture1));
varScreenPos=atbCoord2d;
vec4 l9_1=vec4(atbCoord2d.xy,-1.0,1.0);
vec2 l9_2=vec2(atbCoord2d.z,atbCoord2d.w);
vec4 l9_3;
vec2 l9_4;
#if (LIQUIFY_FACESTRETCH)
{
vec2 l9_5=varScreenPos.xy+l9_2;
varScreenPos=vec4(l9_5.x,l9_5.y,varScreenPos.z,varScreenPos.w);
vec2 l9_6=l9_1.xy+l9_2;
l9_4=l9_2;
l9_3=vec4(l9_6.x,l9_6.y,l9_1.z,l9_1.w);
}
#else
{
vec2 l9_7;
#if (LIQUIFY_ONLY)
{
varScreenPos=vec4(varScreenPos.x,varScreenPos.y,vec2(0.0).x,vec2(0.0).y);
l9_7=vec2(0.0);
}
#else
{
l9_7=l9_2;
}
#endif
l9_4=l9_7;
l9_3=l9_1;
}
#endif
vec4 l9_8=sc_ViewProjectionMatrixInverseArray[sc_GetStereoViewIndex()]*l9_3;
vec3 l9_9=l9_8.xyz/vec3(l9_8.w);
vec4 l9_10=vec4(l9_9.x,l9_9.y,l9_9.z,l9_8.w);
l9_10.w=1.0;
#if (MAX_LIQUIFY>0)
{
vec4 l9_11=ptsInvMat[0]*l9_10;
vec3 l9_12;
vec4 l9_13;
#if (CAMERA_ORTHO)
{
l9_13=l9_11-vec4(camDirO[0],0.0);
l9_12=camDirO[0];
}
#else
{
vec4 l9_14=ptsInvMat[0]*vec4(sc_Camera.position,1.0);
l9_13=l9_14;
l9_12=normalize(l9_11.xyz-l9_14.xyz);
}
#endif
float l9_15;
if (l9_12.z!=0.0)
{
l9_15=(-l9_13.z)/l9_12.z;
}
else
{
l9_15=10000.0;
}
float l9_16;
if (l9_15<0.0)
{
l9_16=10000.0;
}
else
{
l9_16=l9_15;
}
varScreenSpacePointsPos0=l9_13.xy+(l9_12.xy*l9_16);
}
#endif
#if (MAX_LIQUIFY>1)
{
vec4 l9_17=ptsInvMat[1]*l9_10;
vec3 l9_18;
vec4 l9_19;
#if (CAMERA_ORTHO)
{
l9_19=l9_17-vec4(camDirO[1],0.0);
l9_18=camDirO[1];
}
#else
{
vec4 l9_20=ptsInvMat[1]*vec4(sc_Camera.position,1.0);
l9_19=l9_20;
l9_18=normalize(l9_17.xyz-l9_20.xyz);
}
#endif
float l9_21;
if (l9_18.z!=0.0)
{
l9_21=(-l9_19.z)/l9_18.z;
}
else
{
l9_21=10000.0;
}
float l9_22;
if (l9_21<0.0)
{
l9_22=10000.0;
}
else
{
l9_22=l9_21;
}
varScreenSpacePointsPos1=l9_19.xy+(l9_18.xy*l9_22);
}
#endif
#if (MAX_LIQUIFY>2)
{
vec4 l9_23=ptsInvMat[2]*l9_10;
vec3 l9_24;
vec4 l9_25;
#if (CAMERA_ORTHO)
{
l9_25=l9_23-vec4(camDirO[2],0.0);
l9_24=camDirO[2];
}
#else
{
vec4 l9_26=ptsInvMat[2]*vec4(sc_Camera.position,1.0);
l9_25=l9_26;
l9_24=normalize(l9_23.xyz-l9_26.xyz);
}
#endif
float l9_27;
if (l9_24.z!=0.0)
{
l9_27=(-l9_25.z)/l9_24.z;
}
else
{
l9_27=10000.0;
}
float l9_28;
if (l9_27<0.0)
{
l9_28=10000.0;
}
else
{
l9_28=l9_27;
}
varScreenSpacePointsPos2=l9_25.xy+(l9_24.xy*l9_28);
}
#endif
#if (MAX_LIQUIFY>3)
{
vec4 l9_29=ptsInvMat[3]*l9_10;
vec3 l9_30;
vec4 l9_31;
#if (CAMERA_ORTHO)
{
l9_31=l9_29-vec4(camDirO[3],0.0);
l9_30=camDirO[3];
}
#else
{
vec4 l9_32=ptsInvMat[3]*vec4(sc_Camera.position,1.0);
l9_31=l9_32;
l9_30=normalize(l9_29.xyz-l9_32.xyz);
}
#endif
float l9_33;
if (l9_30.z!=0.0)
{
l9_33=(-l9_31.z)/l9_30.z;
}
else
{
l9_33=10000.0;
}
float l9_34;
if (l9_33<0.0)
{
l9_34=10000.0;
}
else
{
l9_34=l9_33;
}
varScreenSpacePointsPos3=l9_31.xy+(l9_30.xy*l9_34);
}
#endif
#if (MAX_LIQUIFY>4)
{
vec4 l9_35=ptsInvMat[4]*l9_10;
vec3 l9_36;
vec4 l9_37;
#if (CAMERA_ORTHO)
{
l9_37=l9_35-vec4(camDirO[4],0.0);
l9_36=camDirO[4];
}
#else
{
vec4 l9_38=ptsInvMat[4]*vec4(sc_Camera.position,1.0);
l9_37=l9_38;
l9_36=normalize(l9_35.xyz-l9_38.xyz);
}
#endif
float l9_39;
if (l9_36.z!=0.0)
{
l9_39=(-l9_37.z)/l9_36.z;
}
else
{
l9_39=10000.0;
}
float l9_40;
if (l9_39<0.0)
{
l9_40=10000.0;
}
else
{
l9_40=l9_39;
}
varScreenSpacePointsPos4=l9_37.xy+(l9_36.xy*l9_40);
}
#endif
#if (MAX_LIQUIFY>5)
{
vec4 l9_41=ptsInvMat[5]*l9_10;
vec3 l9_42;
vec4 l9_43;
#if (CAMERA_ORTHO)
{
l9_43=l9_41-vec4(camDirO[5],0.0);
l9_42=camDirO[5];
}
#else
{
vec4 l9_44=ptsInvMat[5]*vec4(sc_Camera.position,1.0);
l9_43=l9_44;
l9_42=normalize(l9_41.xyz-l9_44.xyz);
}
#endif
float l9_45;
if (l9_42.z!=0.0)
{
l9_45=(-l9_43.z)/l9_42.z;
}
else
{
l9_45=10000.0;
}
float l9_46;
if (l9_45<0.0)
{
l9_46=10000.0;
}
else
{
l9_46=l9_45;
}
varScreenSpacePointsPos5=l9_43.xy+(l9_42.xy*l9_46);
}
#endif
#if (MAX_LIQUIFY>6)
{
vec4 l9_47=ptsInvMat[6]*l9_10;
vec3 l9_48;
vec4 l9_49;
#if (CAMERA_ORTHO)
{
l9_49=l9_47-vec4(camDirO[6],0.0);
l9_48=camDirO[6];
}
#else
{
vec4 l9_50=ptsInvMat[6]*vec4(sc_Camera.position,1.0);
l9_49=l9_50;
l9_48=normalize(l9_47.xyz-l9_50.xyz);
}
#endif
float l9_51;
if (l9_48.z!=0.0)
{
l9_51=(-l9_49.z)/l9_48.z;
}
else
{
l9_51=10000.0;
}
float l9_52;
if (l9_51<0.0)
{
l9_52=10000.0;
}
else
{
l9_52=l9_51;
}
varScreenSpacePointsPos6=l9_49.xy+(l9_48.xy*l9_52);
}
#endif
#if (MAX_LIQUIFY>7)
{
vec4 l9_53=ptsInvMat[7]*l9_10;
vec3 l9_54;
vec4 l9_55;
#if (CAMERA_ORTHO)
{
l9_55=l9_53-vec4(camDirO[7],0.0);
l9_54=camDirO[7];
}
#else
{
vec4 l9_56=ptsInvMat[7]*vec4(sc_Camera.position,1.0);
l9_55=l9_56;
l9_54=normalize(l9_53.xyz-l9_56.xyz);
}
#endif
float l9_57;
if (l9_54.z!=0.0)
{
l9_57=(-l9_55.z)/l9_54.z;
}
else
{
l9_57=10000.0;
}
float l9_58;
if (l9_57<0.0)
{
l9_58=10000.0;
}
else
{
l9_58=l9_57;
}
varScreenSpacePointsPos7=l9_55.xy+(l9_54.xy*l9_58);
}
#endif
#if (MAX_LIQUIFY>8)
{
vec4 l9_59=ptsInvMat[8]*l9_10;
vec3 l9_60;
vec4 l9_61;
#if (CAMERA_ORTHO)
{
l9_61=l9_59-vec4(camDirO[8],0.0);
l9_60=camDirO[8];
}
#else
{
vec4 l9_62=ptsInvMat[8]*vec4(sc_Camera.position,1.0);
l9_61=l9_62;
l9_60=normalize(l9_59.xyz-l9_62.xyz);
}
#endif
float l9_63;
if (l9_60.z!=0.0)
{
l9_63=(-l9_61.z)/l9_60.z;
}
else
{
l9_63=10000.0;
}
float l9_64;
if (l9_63<0.0)
{
l9_64=10000.0;
}
else
{
l9_64=l9_63;
}
varScreenSpacePointsPos8=l9_61.xy+(l9_60.xy*l9_64);
}
#endif
#if (MAX_LIQUIFY>9)
{
vec4 l9_65=ptsInvMat[9]*l9_10;
vec3 l9_66;
vec4 l9_67;
#if (CAMERA_ORTHO)
{
l9_67=l9_65-vec4(camDirO[9],0.0);
l9_66=camDirO[9];
}
#else
{
vec4 l9_68=ptsInvMat[9]*vec4(sc_Camera.position,1.0);
l9_67=l9_68;
l9_66=normalize(l9_65.xyz-l9_68.xyz);
}
#endif
float l9_69;
if (l9_66.z!=0.0)
{
l9_69=(-l9_67.z)/l9_66.z;
}
else
{
l9_69=10000.0;
}
float l9_70;
if (l9_69<0.0)
{
l9_70=10000.0;
}
else
{
l9_70=l9_69;
}
varScreenSpacePointsPos9=l9_67.xy+(l9_66.xy*l9_70);
}
#endif
#if (!LIQUIFY_FACESTRETCH)
{
vec2 l9_71=l9_4*0.5;
varScreenPos=vec4(varScreenPos.x,varScreenPos.y,l9_71.x,l9_71.y);
}
#endif
}
#elif defined FRAGMENT_SHADER // #if defined VERTEX_SHADER
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include <required2.glsl>
#include <std2_vs.glsl>
#include <std2_fs.glsl>
#include <std2_texture.glsl>
#ifndef MAX_LIQUIFY
#define MAX_LIQUIFY 10
#endif
#ifndef LIQUIFY_ONLY
#define LIQUIFY_ONLY 0
#elif LIQUIFY_ONLY==1
#undef LIQUIFY_ONLY
#define LIQUIFY_ONLY 1
#endif
#ifndef LIQUIFY_FACESTRETCH
#define LIQUIFY_FACESTRETCH 0
#elif LIQUIFY_FACESTRETCH==1
#undef LIQUIFY_FACESTRETCH
#define LIQUIFY_FACESTRETCH 1
#endif
uniform vec4 coeffs[10];
uniform mat4 ptsInvMat[10];
uniform vec3 camDirO[10];
varying vec2 varScreenSpacePointsPos0;
varying vec2 varScreenSpacePointsPos1;
varying vec2 varScreenSpacePointsPos2;
varying vec2 varScreenSpacePointsPos3;
varying vec2 varScreenSpacePointsPos4;
varying vec2 varScreenSpacePointsPos5;
varying vec2 varScreenSpacePointsPos6;
varying vec2 varScreenSpacePointsPos7;
varying vec2 varScreenSpacePointsPos8;
varying vec2 varScreenSpacePointsPos9;
void main()
{
sc_DiscardStereoFragment();
vec2 l9_0;
#if (MAX_LIQUIFY>0)
{
float l9_1=dot(varScreenSpacePointsPos0,varScreenSpacePointsPos0);
l9_0=vec2(0.0)+((varScreenPos.xy-coeffs[0].xy)*((pow(clamp(l9_1/coeffs[0].w,0.00078125001,1.0),coeffs[0].z)-1.0)*step(l9_1,coeffs[0].w)));
}
#else
{
l9_0=vec2(0.0);
}
#endif
vec2 l9_2;
#if (MAX_LIQUIFY>1)
{
float l9_3=dot(varScreenSpacePointsPos1,varScreenSpacePointsPos1);
l9_2=l9_0+((varScreenPos.xy-coeffs[1].xy)*((pow(clamp(l9_3/coeffs[1].w,0.00078125001,1.0),coeffs[1].z)-1.0)*step(l9_3,coeffs[1].w)));
}
#else
{
l9_2=l9_0;
}
#endif
vec2 l9_4;
#if (MAX_LIQUIFY>2)
{
float l9_5=dot(varScreenSpacePointsPos2,varScreenSpacePointsPos2);
l9_4=l9_2+((varScreenPos.xy-coeffs[2].xy)*((pow(clamp(l9_5/coeffs[2].w,0.00078125001,1.0),coeffs[2].z)-1.0)*step(l9_5,coeffs[2].w)));
}
#else
{
l9_4=l9_2;
}
#endif
vec2 l9_6;
#if (MAX_LIQUIFY>3)
{
float l9_7=dot(varScreenSpacePointsPos3,varScreenSpacePointsPos3);
l9_6=l9_4+((varScreenPos.xy-coeffs[3].xy)*((pow(clamp(l9_7/coeffs[3].w,0.00078125001,1.0),coeffs[3].z)-1.0)*step(l9_7,coeffs[3].w)));
}
#else
{
l9_6=l9_4;
}
#endif
vec2 l9_8;
#if (MAX_LIQUIFY>4)
{
float l9_9=dot(varScreenSpacePointsPos4,varScreenSpacePointsPos4);
l9_8=l9_6+((varScreenPos.xy-coeffs[4].xy)*((pow(clamp(l9_9/coeffs[4].w,0.00078125001,1.0),coeffs[4].z)-1.0)*step(l9_9,coeffs[4].w)));
}
#else
{
l9_8=l9_6;
}
#endif
vec2 l9_10;
#if (MAX_LIQUIFY>5)
{
float l9_11=dot(varScreenSpacePointsPos5,varScreenSpacePointsPos5);
l9_10=l9_8+((varScreenPos.xy-coeffs[5].xy)*((pow(clamp(l9_11/coeffs[5].w,0.00078125001,1.0),coeffs[5].z)-1.0)*step(l9_11,coeffs[5].w)));
}
#else
{
l9_10=l9_8;
}
#endif
vec2 l9_12;
#if (MAX_LIQUIFY>6)
{
float l9_13=dot(varScreenSpacePointsPos6,varScreenSpacePointsPos6);
l9_12=l9_10+((varScreenPos.xy-coeffs[6].xy)*((pow(clamp(l9_13/coeffs[6].w,0.00078125001,1.0),coeffs[6].z)-1.0)*step(l9_13,coeffs[6].w)));
}
#else
{
l9_12=l9_10;
}
#endif
vec2 l9_14;
#if (MAX_LIQUIFY>7)
{
float l9_15=dot(varScreenSpacePointsPos7,varScreenSpacePointsPos7);
l9_14=l9_12+((varScreenPos.xy-coeffs[7].xy)*((pow(clamp(l9_15/coeffs[7].w,0.00078125001,1.0),coeffs[7].z)-1.0)*step(l9_15,coeffs[7].w)));
}
#else
{
l9_14=l9_12;
}
#endif
vec2 l9_16;
#if (MAX_LIQUIFY>8)
{
float l9_17=dot(varScreenSpacePointsPos8,varScreenSpacePointsPos8);
l9_16=l9_14+((varScreenPos.xy-coeffs[8].xy)*((pow(clamp(l9_17/coeffs[8].w,0.00078125001,1.0),coeffs[8].z)-1.0)*step(l9_17,coeffs[8].w)));
}
#else
{
l9_16=l9_14;
}
#endif
vec2 l9_18;
#if (MAX_LIQUIFY>9)
{
float l9_19=dot(varScreenSpacePointsPos9,varScreenSpacePointsPos9);
l9_18=l9_16+((varScreenPos.xy-coeffs[9].xy)*((pow(clamp(l9_19/coeffs[9].w,0.00078125001,1.0),coeffs[9].z)-1.0)*step(l9_19,coeffs[9].w)));
}
#else
{
l9_18=l9_16;
}
#endif
vec2 l9_20=varScreenPos.xy+l9_18;
vec2 l9_21=(l9_20*vec2(0.5))+vec2(0.5);
vec2 l9_22;
#if (!LIQUIFY_ONLY)
{
vec2 l9_23;
#if (!LIQUIFY_FACESTRETCH)
{
l9_23=l9_21+varScreenPos.zw;
}
#else
{
l9_23=l9_21;
}
#endif
l9_22=l9_23;
}
#else
{
l9_22=l9_21;
}
#endif
sc_writeFragData0(sc_ScreenTextureSampleView(l9_22));
}
#endif // #elif defined FRAGMENT_SHADER // #if defined VERTEX_SHADER

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
//ubo float UserUniforms 2:0:560 {
//float4x4 script_modelMatrix 0
//float4x4 script_viewProjectionMatrix 64
//float3 uniSphereCenter 128
//float3 uniCameraPos 144
//float4 sgColorAndSharpness 160:[]:16
//float3 sgAxis :[]:16
//float3 sgAmbientLight
//}
//SG_REFLECTION_END

namespace SNAP_VS {
#ifndef N_SPHERICAL_GAUSSIANS
#define N_SPHERICAL_GAUSSIANS 12
#endif
struct userUniformsObj
{
float4x4 script_modelMatrix;
float4x4 script_viewProjectionMatrix;
float3 uniSphereCenter;
float3 uniCameraPos;
float4 sgColorAndSharpness[N_SPHERICAL_GAUSSIANS];
float3 sgAxis[N_SPHERICAL_GAUSSIANS];
float3 sgAmbientLight;
};
struct sc_Set2
{
constant userUniformsObj* UserUniforms [[id(0)]];
};
struct sc_VertOut
{
sc_SysOut sc_sysOut;
float3 varCustomNormal [[user(locn10)]];
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
float4 newPosition=rotationMatrix*v.position;
float4x4 scaleMatrix=float4x4(float4(12.0,0.0,0.0,0.0),float4(0.0,12.0,0.0,0.0),float4(0.0,0.0,12.0,0.0),float4(0.0,0.0,0.0,12.0));
scaleMatrix[3].w=1.0;
newPosition=scaleMatrix*newPosition;
float3 normal=normalize(sc_sysIn.sc_sysAttributes.position.xyz);
sc_vertOut.varCustomNormal=normalize((((*sc_set2.UserUniforms).script_modelMatrix*rotationMatrix)*float4(normal,0.0)).xyz);
v.position=float4(((v.texture0*1.002)*2.0)-float2(1.0),0.0,1.0);
sc_Vertex_t param=v;
sc_ProcessVertex(param,sc_sysIn,sc_vertOut.sc_sysOut,sc_set0,sc_set1);
return sc_vertOut;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct SphericalGaussian
{
float3 Amplitude;
float3 Axis;
float Sharpness;
};
#ifndef N_SPHERICAL_GAUSSIANS
#define N_SPHERICAL_GAUSSIANS 12
#endif
struct userUniformsObj
{
float4x4 script_modelMatrix;
float4x4 script_viewProjectionMatrix;
float3 uniSphereCenter;
float3 uniCameraPos;
float4 sgColorAndSharpness[N_SPHERICAL_GAUSSIANS];
float3 sgAxis[N_SPHERICAL_GAUSSIANS];
float3 sgAmbientLight;
};
struct sc_Set2
{
constant userUniformsObj* UserUniforms [[id(0)]];
};
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
float3 varCustomNormal [[user(locn10)]];
};
SphericalGaussian getSphericalGaussian(thread const int& index,constant userUniformsObj& UserUniforms)
{
SphericalGaussian sg;
sg.Axis=UserUniforms.sgAxis[index];
sg.Sharpness=UserUniforms.sgColorAndSharpness[index].w;
sg.Amplitude=UserUniforms.sgColorAndSharpness[index].xyz;
return sg;
}
float3 evaluateSphericalGaussian(thread const float3& pos,thread const int& idx,constant userUniformsObj& UserUniforms)
{
int param=idx;
SphericalGaussian sg=getSphericalGaussian(param,UserUniforms);
return sg.Amplitude*exp(sg.Sharpness*(dot(sg.Axis,pos)-1.0));
}
float4 encodeRGBD(thread const float3& rgb)
{
float maxRGB=fast::max(1.0,fast::max(rgb.x,fast::max(rgb.y,rgb.z)));
float D=1.0/maxRGB;
D=fast::max(D,0.0039607845);
return float4(rgb*D,D);
}
float4 evaluateGaussians(constant userUniformsObj& UserUniforms,thread float3& varCustomNormal)
{
float3 color=UserUniforms.sgAmbientLight;
float3 pos=normalize(varCustomNormal);
int i=0;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (i<N_SPHERICAL_GAUSSIANS)
{
float3 param=pos;
int param_1=i;
color+=evaluateSphericalGaussian(param,param_1,UserUniforms);
i++;
continue;
}
else
{
break;
}
}
float3 param_2=color;
return encodeRGBD(param_2);
}
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],constant sc_Set2& sc_set2 [[buffer(2)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
float4 param=evaluateGaussians((*sc_set2.UserUniforms),sc_fragIn.varCustomNormal);
sc_writeFragData0(param,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

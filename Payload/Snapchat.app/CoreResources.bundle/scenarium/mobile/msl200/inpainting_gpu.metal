#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
#define STD_DISABLE_VERTEX_NORMAL 1
#define STD_DISABLE_VERTEX_TANGENT 1
#define STD_DISABLE_VERTEX_TEXTURE0 1
#define STD_DISABLE_VERTEX_TEXTURE1 1
#include "std2.metal"
#include "std2_vs.metal"
#include "std2_fs.metal"
#include "std2_texture.metal"
//SG_REFLECTION_BEGIN(100)
//SG_REFLECTION_END

namespace SNAP_VS {
struct sc_VertOut
{
sc_SysOut sc_sysOut;
};
struct sc_VertIn
{
sc_SysAttributes sc_sysAttributes;
};
vertex sc_VertOut main_vert(sc_VertIn sc_vertIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],uint gl_InstanceIndex [[instance_id]],uint gl_VertexIndex [[vertex_id]])
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
struct sc_FragOut
{
sc_SysOut sc_sysOut;
};
struct sc_FragIn
{
sc_SysIn sc_sysIn;
};
fragment sc_FragOut main_frag(sc_FragIn sc_fragIn [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],constant sc_Set1& sc_set1 [[buffer(1)]],float4 gl_FragCoord [[position]],bool gl_FrontFacing [[front_facing]])
{
sc_fragIn.sc_sysIn.gl_FragCoord=gl_FragCoord;
sc_fragIn.sc_sysIn.gl_FrontFacing=gl_FrontFacing;
sc_FragOut sc_fragOut={};
sc_DiscardStereoFragment(sc_fragIn.sc_sysIn,sc_set0,sc_set1);
float2 param=sc_fragIn.sc_sysIn.varPackedTex.xy;
float4 dstColor=sc_ScreenTextureSampleView(param,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
if (all(dstColor.xyz==float3(1.0,0.0,0.0)))
{
float4 sum=float4(0.0);
float nCount=0.0;
float size=(*sc_set0.LibraryUniforms).sc_ScreenTextureSize.x;
int radius=0;
int stepSize=1;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (all(sum==float4(0.0))&&(radius<24))
{
radius=(radius+stepSize)+2;
int i=(-1)*radius;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (i<=radius)
{
int j=(-1)*radius;
for (int snapLoopIndex=0; snapLoopIndex==0; snapLoopIndex+=0)
{
if (j<=radius)
{
if ((i!=0)||(j!=0))
{
float x=sc_fragIn.sc_sysIn.varPackedTex.x+(float(j)/size);
float y=sc_fragIn.sc_sysIn.varPackedTex.y+(float(i)/size);
float l9_0=x;
float l9_1=x;
bool l9_2=(l9_0>=0.0)&&(l9_1<=1.0);
bool l9_3;
if (l9_2)
{
l9_3=(y>=0.0)&&(y<=1.0);
}
else
{
l9_3=l9_2;
}
if (l9_3)
{
float2 param_1=float2(x,y);
float4 colorSample=sc_ScreenTextureSampleView(param_1,sc_fragIn.sc_sysIn,sc_set0,sc_set1);
bool l9_4=any(colorSample.xyz!=float3(1.0,0.0,0.0));
bool l9_5;
if (l9_4)
{
l9_5=any(colorSample.xyz!=float3(0.0));
}
else
{
l9_5=l9_4;
}
if (l9_5)
{
sum+=colorSample;
nCount+=1.0;
}
}
}
j+=stepSize;
continue;
}
else
{
break;
}
}
i+=stepSize;
continue;
}
else
{
break;
}
}
stepSize+=8;
continue;
}
else
{
break;
}
}
sum/=float4(nCount);
dstColor=sum;
}
float4 param_2=dstColor;
sc_writeFragData0(param_2,sc_fragIn.sc_sysIn,sc_fragOut.sc_sysOut,sc_set0,sc_set1);
return sc_fragOut;
}
} // FRAGMENT SHADER

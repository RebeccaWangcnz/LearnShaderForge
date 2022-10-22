// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:34119,y:32332,varname:node_3138,prsc:2|emission-2476-OUT;n:type:ShaderForge.SFN_Tex2d,id:2165,x:31556,y:32767,ptovrint:False,ptlb:NormalMap,ptin:_NormalMap,varname:node_2165,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Transform,id:1229,x:31744,y:32767,varname:node_1229,prsc:2,tffrom:2,tfto:0|IN-2165-RGB;n:type:ShaderForge.SFN_LightVector,id:3710,x:31678,y:32517,varname:node_3710,prsc:2;n:type:ShaderForge.SFN_Dot,id:9402,x:31970,y:32733,varname:node_9402,prsc:2,dt:0|A-3710-OUT,B-1229-XYZ;n:type:ShaderForge.SFN_Color,id:5950,x:32106,y:33135,ptovrint:False,ptlb:BaseColor,ptin:_BaseColor,varname:node_5950,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:1036,x:32441,y:32732,cmnt:Lambert,varname:node_1036,prsc:2|A-1456-OUT,B-4181-OUT;n:type:ShaderForge.SFN_Dot,id:7159,x:31965,y:32250,varname:node_7159,prsc:2,dt:0|A-8529-OUT,B-3710-OUT;n:type:ShaderForge.SFN_Color,id:5889,x:32233,y:32098,ptovrint:False,ptlb:SpecularColor,ptin:_SpecularColor,varname:node_5889,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:8141,x:32505,y:32100,cmnt:Phong,varname:node_8141,prsc:2|A-5889-RGB,B-1583-OUT;n:type:ShaderForge.SFN_Add,id:2476,x:33867,y:32428,varname:node_2476,prsc:2|A-7991-OUT,B-9529-OUT;n:type:ShaderForge.SFN_Power,id:1583,x:32340,y:32250,varname:node_1583,prsc:2|VAL-9901-OUT,EXP-5187-OUT;n:type:ShaderForge.SFN_Slider,id:5187,x:32025,y:32513,ptovrint:False,ptlb:SpecularPower,ptin:_SpecularPower,varname:node_5187,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.1,cur:1,max:9;n:type:ShaderForge.SFN_Max,id:9901,x:32160,y:32250,varname:node_9901,prsc:2|A-7159-OUT,B-3641-OUT;n:type:ShaderForge.SFN_Vector1,id:3641,x:31993,y:32412,varname:node_3641,prsc:2,v1:0;n:type:ShaderForge.SFN_Max,id:1456,x:32146,y:32733,varname:node_1456,prsc:2|A-3641-OUT,B-9402-OUT;n:type:ShaderForge.SFN_ComponentMask,id:119,x:31976,y:33153,varname:node_119,prsc:2,cc1:1,cc2:-1,cc3:-1,cc4:-1|IN-1229-XYZ;n:type:ShaderForge.SFN_Multiply,id:9118,x:32162,y:33324,varname:node_9118,prsc:2|A-119-OUT,B-7806-OUT;n:type:ShaderForge.SFN_Vector1,id:7806,x:31976,y:33343,varname:node_7806,prsc:2,v1:-1;n:type:ShaderForge.SFN_Vector1,id:4695,x:31976,y:33493,varname:node_4695,prsc:2,v1:1;n:type:ShaderForge.SFN_Max,id:5067,x:32363,y:33135,cmnt:UpperMask,varname:node_5067,prsc:2|A-3641-OUT,B-119-OUT;n:type:ShaderForge.SFN_Max,id:435,x:32363,y:33306,cmnt:DownMask,varname:node_435,prsc:2|A-3641-OUT,B-9118-OUT;n:type:ShaderForge.SFN_Subtract,id:2917,x:32213,y:33493,varname:node_2917,prsc:2|A-4695-OUT,B-5067-OUT;n:type:ShaderForge.SFN_Subtract,id:5466,x:32397,y:33493,cmnt:SideMask,varname:node_5466,prsc:2|A-2917-OUT,B-435-OUT;n:type:ShaderForge.SFN_Color,id:8210,x:32374,y:33858,ptovrint:False,ptlb:SideCol,ptin:_SideCol,varname:node_8210,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Color,id:1268,x:32374,y:34049,ptovrint:False,ptlb:DownCol,ptin:_DownCol,varname:node_1268,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0.4220598,c3:1,c4:1;n:type:ShaderForge.SFN_Color,id:4299,x:32374,y:33677,ptovrint:False,ptlb:UpperCol,ptin:_UpperCol,varname:node_4299,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:1081,x:32626,y:33293,varname:node_1081,prsc:2|A-5067-OUT,B-4299-RGB;n:type:ShaderForge.SFN_Multiply,id:7315,x:32626,y:33493,varname:node_7315,prsc:2|A-435-OUT,B-1268-RGB;n:type:ShaderForge.SFN_Multiply,id:1277,x:32626,y:33681,varname:node_1277,prsc:2|A-5466-OUT,B-8210-RGB;n:type:ShaderForge.SFN_Add,id:1487,x:32845,y:33454,varname:node_1487,prsc:2|A-1081-OUT,B-7315-OUT,C-1277-OUT;n:type:ShaderForge.SFN_Slider,id:8175,x:32767,y:33663,ptovrint:False,ptlb:EnvInt,ptin:_EnvInt,varname:node_8175,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.2,max:1;n:type:ShaderForge.SFN_Multiply,id:1745,x:33078,y:33454,cmnt:3ColEnv,varname:node_1745,prsc:2|A-1487-OUT,B-8175-OUT;n:type:ShaderForge.SFN_Tex2d,id:6655,x:33499,y:33300,ptovrint:False,ptlb:AmbientOcclusion,ptin:_AmbientOcclusion,varname:node_6655,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:9529,x:33653,y:33219,varname:node_9529,prsc:2|A-6314-OUT,B-6655-RGB;n:type:ShaderForge.SFN_Add,id:2618,x:32793,y:32363,varname:node_2618,prsc:2|A-8141-OUT,B-1036-OUT;n:type:ShaderForge.SFN_Color,id:9863,x:32793,y:32539,ptovrint:False,ptlb:LightColor,ptin:_LightColor,varname:node_9863,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:1193,x:33001,y:32421,varname:node_1193,prsc:2|A-2618-OUT,B-9863-RGB;n:type:ShaderForge.SFN_Cubemap,id:9682,x:32233,y:31868,ptovrint:False,ptlb:Cubemap,ptin:_Cubemap,varname:node_9682,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,pvfc:0|DIR-8529-OUT,MIP-719-OUT;n:type:ShaderForge.SFN_Multiply,id:2995,x:31605,y:31869,varname:node_2995,prsc:2|A-8056-OUT,B-3593-OUT;n:type:ShaderForge.SFN_Vector1,id:8056,x:31422,y:31869,varname:node_8056,prsc:2,v1:-1;n:type:ShaderForge.SFN_ViewVector,id:3593,x:31422,y:31942,varname:node_3593,prsc:2;n:type:ShaderForge.SFN_Reflect,id:8529,x:31787,y:31869,varname:node_8529,prsc:2|A-2995-OUT,B-1229-XYZ;n:type:ShaderForge.SFN_Slider,id:719,x:31764,y:32068,ptovrint:False,ptlb:MipLevel,ptin:_MipLevel,varname:node_719,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:1,max:7;n:type:ShaderForge.SFN_Fresnel,id:1887,x:32233,y:31643,varname:node_1887,prsc:2|NRM-1229-XYZ,EXP-294-OUT;n:type:ShaderForge.SFN_Slider,id:294,x:31773,y:31666,ptovrint:False,ptlb:FresnelPower,ptin:_FresnelPower,varname:node_294,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_Multiply,id:1611,x:32518,y:31761,cmnt:Cubemap,varname:node_1611,prsc:2|A-1887-OUT,B-9682-RGB;n:type:ShaderForge.SFN_Tex2d,id:6250,x:32106,y:32941,ptovrint:False,ptlb:BaseColorMap,ptin:_BaseColorMap,varname:node_6250,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:4181,x:32281,y:32995,varname:node_4181,prsc:2|A-6250-RGB,B-5950-RGB;n:type:ShaderForge.SFN_Slider,id:8596,x:32336,y:31574,ptovrint:False,ptlb:EnvSpecularInt,ptin:_EnvSpecularInt,varname:node_8596,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.2,max:5;n:type:ShaderForge.SFN_Multiply,id:9470,x:32719,y:31671,varname:node_9470,prsc:2|A-8596-OUT,B-1611-OUT;n:type:ShaderForge.SFN_Multiply,id:5053,x:33253,y:33429,varname:node_5053,prsc:2|A-4181-OUT,B-1745-OUT;n:type:ShaderForge.SFN_Add,id:6314,x:33423,y:32798,varname:node_6314,prsc:2|A-9470-OUT,B-5053-OUT;n:type:ShaderForge.SFN_Multiply,id:7991,x:33234,y:32421,varname:node_7991,prsc:2|A-1193-OUT,B-7513-OUT;n:type:ShaderForge.SFN_LightAttenuation,id:7513,x:33014,y:32640,cmnt:shadow,varname:node_7513,prsc:2;proporder:2165-6250-5950-5889-5187-8210-1268-4299-8175-6655-9863-9682-719-294-8596;pass:END;sub:END;*/

Shader "Shader Forge/OldSchoolPro" {
    Properties {
        _NormalMap ("NormalMap", 2D) = "bump" {}
        _BaseColorMap ("BaseColorMap", 2D) = "white" {}
        _BaseColor ("BaseColor", Color) = (1,1,1,1)
        _SpecularColor ("SpecularColor", Color) = (0.5,0.5,0.5,1)
        _SpecularPower ("SpecularPower", Range(0.1, 9)) = 1
        _SideCol ("SideCol", Color) = (0.5,0.5,0.5,1)
        _DownCol ("DownCol", Color) = (0,0.4220598,1,1)
        _UpperCol ("UpperCol", Color) = (1,0,0,1)
        _EnvInt ("EnvInt", Range(0, 1)) = 0.2
        _AmbientOcclusion ("AmbientOcclusion", 2D) = "white" {}
        _LightColor ("LightColor", Color) = (1,1,1,1)
        _Cubemap ("Cubemap", Cube) = "_Skybox" {}
        _MipLevel ("MipLevel", Range(1, 7)) = 1
        _FresnelPower ("FresnelPower", Range(0, 10)) = 1
        _EnvSpecularInt ("EnvSpecularInt", Range(0, 5)) = 0.2
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform sampler2D _AmbientOcclusion; uniform float4 _AmbientOcclusion_ST;
            uniform samplerCUBE _Cubemap;
            uniform sampler2D _BaseColorMap; uniform float4 _BaseColorMap_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _BaseColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _SpecularColor)
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecularPower)
                UNITY_DEFINE_INSTANCED_PROP( float4, _SideCol)
                UNITY_DEFINE_INSTANCED_PROP( float4, _DownCol)
                UNITY_DEFINE_INSTANCED_PROP( float4, _UpperCol)
                UNITY_DEFINE_INSTANCED_PROP( float, _EnvInt)
                UNITY_DEFINE_INSTANCED_PROP( float4, _LightColor)
                UNITY_DEFINE_INSTANCED_PROP( float, _MipLevel)
                UNITY_DEFINE_INSTANCED_PROP( float, _FresnelPower)
                UNITY_DEFINE_INSTANCED_PROP( float, _EnvSpecularInt)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
////// Emissive:
                float4 _SpecularColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _SpecularColor );
                float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
                float3 node_1229 = mul( _NormalMap_var.rgb, tangentTransform ).xyz;
                float3 node_8529 = reflect(((-1.0)*viewDirection),node_1229.rgb);
                float node_3641 = 0.0;
                float _SpecularPower_var = UNITY_ACCESS_INSTANCED_PROP( Props, _SpecularPower );
                float4 _BaseColorMap_var = tex2D(_BaseColorMap,TRANSFORM_TEX(i.uv0, _BaseColorMap));
                float4 _BaseColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _BaseColor );
                float3 node_4181 = (_BaseColorMap_var.rgb*_BaseColor_var.rgb);
                float4 _LightColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _LightColor );
                float _EnvSpecularInt_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvSpecularInt );
                float _FresnelPower_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FresnelPower );
                float _MipLevel_var = UNITY_ACCESS_INSTANCED_PROP( Props, _MipLevel );
                float node_119 = node_1229.rgb.g;
                float node_5067 = max(node_3641,node_119); // UpperMask
                float4 _UpperCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _UpperCol );
                float node_435 = max(node_3641,(node_119*(-1.0))); // DownMask
                float4 _DownCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _DownCol );
                float4 _SideCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _SideCol );
                float _EnvInt_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvInt );
                float4 _AmbientOcclusion_var = tex2D(_AmbientOcclusion,TRANSFORM_TEX(i.uv0, _AmbientOcclusion));
                float3 emissive = (((((_SpecularColor_var.rgb*pow(max(dot(node_8529,lightDirection),node_3641),_SpecularPower_var))+(max(node_3641,dot(lightDirection,node_1229.rgb))*node_4181))*_LightColor_var.rgb)*attenuation)+(((_EnvSpecularInt_var*(pow(1.0-max(0,dot(node_1229.rgb, viewDirection)),_FresnelPower_var)*texCUBElod(_Cubemap,float4(node_8529,_MipLevel_var)).rgb))+(node_4181*(((node_5067*_UpperCol_var.rgb)+(node_435*_DownCol_var.rgb)+(((1.0-node_5067)-node_435)*_SideCol_var.rgb))*_EnvInt_var)))*_AmbientOcclusion_var.rgb));
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}

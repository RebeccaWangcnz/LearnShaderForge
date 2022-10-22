// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33169,y:32712,varname:node_3138,prsc:2|emission-3604-OUT;n:type:ShaderForge.SFN_Transform,id:5639,x:31817,y:32806,varname:node_5639,prsc:2,tffrom:2,tfto:0|IN-6049-RGB;n:type:ShaderForge.SFN_Tex2d,id:6049,x:31598,y:32806,ptovrint:False,ptlb:NormalMap,ptin:_NormalMap,varname:node_6049,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:270f24cf0e9d444469c5a6eff7e22a87,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Transform,id:8518,x:32007,y:32665,varname:node_8518,prsc:2,tffrom:0,tfto:3|IN-5639-XYZ;n:type:ShaderForge.SFN_RemapRange,id:332,x:32368,y:32665,varname:node_332,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-8455-OUT;n:type:ShaderForge.SFN_Tex2d,id:401,x:32546,y:32665,ptovrint:False,ptlb:MatcapTex,ptin:_MatcapTex,varname:node_401,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:97bdf1d5f7ab0b2458d69db88ca6a494,ntxv:1,isnm:False|UVIN-332-OUT;n:type:ShaderForge.SFN_ComponentMask,id:8455,x:32180,y:32665,varname:node_8455,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-8518-XYZ;n:type:ShaderForge.SFN_Fresnel,id:1051,x:32349,y:32819,varname:node_1051,prsc:2|NRM-5639-XYZ,EXP-7597-OUT;n:type:ShaderForge.SFN_Slider,id:7597,x:31990,y:32985,ptovrint:False,ptlb:FresnelPower,ptin:_FresnelPower,varname:node_7597,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_Multiply,id:1929,x:32773,y:32733,varname:node_1929,prsc:2|A-401-RGB,B-1051-OUT;n:type:ShaderForge.SFN_Multiply,id:3604,x:32933,y:32812,varname:node_3604,prsc:2|A-1929-OUT,B-746-OUT;n:type:ShaderForge.SFN_Slider,id:746,x:32582,y:32939,ptovrint:False,ptlb:EnvSpecInt,ptin:_EnvSpecInt,varname:node_746,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:5;proporder:6049-401-7597-746;pass:END;sub:END;*/

Shader "Shader Forge/Matcap" {
    Properties {
        _NormalMap ("NormalMap", 2D) = "bump" {}
        _MatcapTex ("MatcapTex", 2D) = "gray" {}
        _FresnelPower ("FresnelPower", Range(0, 10)) = 1
        _EnvSpecInt ("EnvSpecInt", Range(0, 5)) = 1
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform sampler2D _MatcapTex; uniform float4 _MatcapTex_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _FresnelPower)
                UNITY_DEFINE_INSTANCED_PROP( float, _EnvSpecInt)
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
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
                float3 node_5639 = mul( _NormalMap_var.rgb, tangentTransform ).xyz;
                float2 node_332 = (mul( UNITY_MATRIX_V, float4(node_5639.rgb,0) ).xyz.rgb.rg*0.5+0.5);
                float4 _MatcapTex_var = tex2D(_MatcapTex,TRANSFORM_TEX(node_332, _MatcapTex));
                float _FresnelPower_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FresnelPower );
                float _EnvSpecInt_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvSpecInt );
                float3 emissive = ((_MatcapTex_var.rgb*pow(1.0-max(0,dot(node_5639.rgb, viewDirection)),_FresnelPower_var))*_EnvSpecInt_var);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}

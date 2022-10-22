// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-6450-OUT;n:type:ShaderForge.SFN_Cubemap,id:481,x:31936,y:32786,ptovrint:False,ptlb:Cubemap,ptin:_Cubemap,varname:node_481,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,pvfc:0|DIR-5438-OUT,MIP-4688-OUT;n:type:ShaderForge.SFN_Slider,id:4688,x:31505,y:32895,ptovrint:False,ptlb:MipLevel,ptin:_MipLevel,varname:node_4688,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_ViewVector,id:9506,x:31103,y:32556,varname:node_9506,prsc:2;n:type:ShaderForge.SFN_Multiply,id:6415,x:31289,y:32632,varname:node_6415,prsc:2|A-9506-OUT,B-3708-OUT;n:type:ShaderForge.SFN_Vector1,id:3708,x:31120,y:32729,varname:node_3708,prsc:2,v1:-1;n:type:ShaderForge.SFN_Tex2d,id:2278,x:30897,y:32862,ptovrint:False,ptlb:NormalMap,ptin:_NormalMap,varname:node_2278,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Transform,id:1663,x:31089,y:32862,varname:node_1663,prsc:2,tffrom:2,tfto:0|IN-2278-RGB;n:type:ShaderForge.SFN_Reflect,id:5438,x:31480,y:32731,varname:node_5438,prsc:2|A-6415-OUT,B-1663-XYZ;n:type:ShaderForge.SFN_Fresnel,id:480,x:32073,y:32930,varname:node_480,prsc:2|NRM-1663-XYZ,EXP-6719-OUT;n:type:ShaderForge.SFN_Slider,id:6719,x:31674,y:33028,ptovrint:False,ptlb:FresnelPower,ptin:_FresnelPower,varname:node_6719,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:5;n:type:ShaderForge.SFN_Multiply,id:382,x:32304,y:32852,varname:node_382,prsc:2|A-481-RGB,B-480-OUT;n:type:ShaderForge.SFN_Multiply,id:6450,x:32513,y:32995,varname:node_6450,prsc:2|A-382-OUT,B-4994-OUT;n:type:ShaderForge.SFN_Slider,id:4994,x:32152,y:33078,ptovrint:False,ptlb:EnvSpecularInt,ptin:_EnvSpecularInt,varname:node_4994,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:10;proporder:481-4688-2278-6719-4994;pass:END;sub:END;*/

Shader "Shader Forge/Cubemap" {
    Properties {
        _Cubemap ("Cubemap", Cube) = "_Skybox" {}
        _MipLevel ("MipLevel", Range(0, 1)) = 0
        _NormalMap ("NormalMap", 2D) = "bump" {}
        _FresnelPower ("FresnelPower", Range(0, 5)) = 0
        _EnvSpecularInt ("EnvSpecularInt", Range(0, 10)) = 0
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
            uniform samplerCUBE _Cubemap;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
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
                float3 node_1663 = mul( _NormalMap_var.rgb, tangentTransform ).xyz;
                float _MipLevel_var = UNITY_ACCESS_INSTANCED_PROP( Props, _MipLevel );
                float _FresnelPower_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FresnelPower );
                float _EnvSpecularInt_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvSpecularInt );
                float3 emissive = ((texCUBElod(_Cubemap,float4(reflect((viewDirection*(-1.0)),node_1663.rgb),_MipLevel_var)).rgb*pow(1.0-max(0,dot(node_1663.rgb, viewDirection)),_FresnelPower_var))*_EnvSpecularInt_var);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}

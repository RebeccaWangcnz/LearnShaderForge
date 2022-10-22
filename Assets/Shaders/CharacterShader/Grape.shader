// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33024,y:32907,varname:node_3138,prsc:2|emission-3268-OUT;n:type:ShaderForge.SFN_LightVector,id:4929,x:31707,y:32617,varname:node_4929,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:8693,x:31707,y:32792,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:6589,x:31968,y:32662,varname:node_6589,prsc:2,dt:0|A-4929-OUT,B-8693-OUT;n:type:ShaderForge.SFN_Append,id:118,x:32155,y:32738,varname:node_118,prsc:2|A-6589-OUT,B-4867-OUT;n:type:ShaderForge.SFN_Vector1,id:4867,x:31987,y:32856,varname:node_4867,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Tex2d,id:3320,x:32317,y:32738,ptovrint:False,ptlb:RampTexture,ptin:_RampTexture,varname:node_3320,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:4ca4ab7523d334a488e7127db55c578c,ntxv:0,isnm:False|UVIN-118-OUT;n:type:ShaderForge.SFN_Tex2d,id:9525,x:32361,y:33024,ptovrint:False,ptlb:Basemap,ptin:_Basemap,varname:node_9525,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:8011926bac56e3c47acd0be3c01d1fd4,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Blend,id:6248,x:32551,y:32866,varname:node_6248,prsc:2,blmd:8,clmp:True|SRC-3320-RGB,DST-9525-RGB;n:type:ShaderForge.SFN_HalfVector,id:8717,x:31700,y:33125,varname:node_8717,prsc:2;n:type:ShaderForge.SFN_Dot,id:7105,x:31905,y:33023,varname:node_7105,prsc:2,dt:0|A-8693-OUT,B-8717-OUT;n:type:ShaderForge.SFN_Slider,id:9124,x:31700,y:33324,ptovrint:False,ptlb:power,ptin:_power,varname:node_9124,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:30,max:90;n:type:ShaderForge.SFN_Power,id:8011,x:32349,y:33194,varname:node_8011,prsc:2|VAL-2671-OUT,EXP-9124-OUT;n:type:ShaderForge.SFN_Add,id:3268,x:32755,y:33010,varname:node_3268,prsc:2|A-3320-RGB,B-8011-OUT;n:type:ShaderForge.SFN_Max,id:2671,x:32131,y:33091,varname:node_2671,prsc:2|A-7105-OUT,B-2717-OUT;n:type:ShaderForge.SFN_Vector1,id:2717,x:31875,y:33191,varname:node_2717,prsc:2,v1:0;proporder:3320-9525-9124;pass:END;sub:END;*/

Shader "Shader Forge/Grape" {
    Properties {
        _RampTexture ("RampTexture", 2D) = "white" {}
        _Basemap ("Basemap", 2D) = "white" {}
        _power ("power", Range(1, 90)) = 30
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _RampTexture; uniform float4 _RampTexture_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _power)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
////// Emissive:
                float2 node_118 = float2(dot(lightDirection,i.normalDir),0.1);
                float4 _RampTexture_var = tex2D(_RampTexture,TRANSFORM_TEX(node_118, _RampTexture));
                float _power_var = UNITY_ACCESS_INSTANCED_PROP( Props, _power );
                float3 emissive = (_RampTexture_var.rgb+pow(max(dot(i.normalDir,halfDirection),0.0),_power_var));
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            uniform sampler2D _RampTexture; uniform float4 _RampTexture_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _power)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float3 finalColor = 0;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}

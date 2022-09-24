// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33011,y:32602,varname:node_3138,prsc:2|emission-8820-RGB;n:type:ShaderForge.SFN_Dot,id:8393,x:31959,y:32653,varname:node_8393,prsc:2,dt:0|A-4563-OUT,B-7779-OUT;n:type:ShaderForge.SFN_NormalVector,id:7779,x:31777,y:32799,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:4563,x:31777,y:32653,varname:node_4563,prsc:2;n:type:ShaderForge.SFN_Multiply,id:2385,x:32135,y:32663,varname:node_2385,prsc:2|A-8393-OUT,B-5725-OUT;n:type:ShaderForge.SFN_Vector1,id:5725,x:31985,y:32833,varname:node_5725,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Add,id:4238,x:32292,y:32709,varname:node_4238,prsc:2|A-2385-OUT,B-5725-OUT;n:type:ShaderForge.SFN_Append,id:7327,x:32646,y:32714,varname:node_7327,prsc:2|A-4238-OUT,B-146-OUT;n:type:ShaderForge.SFN_Vector1,id:146,x:32327,y:32888,varname:node_146,prsc:2,v1:0;n:type:ShaderForge.SFN_Tex2d,id:8820,x:32805,y:32714,ptovrint:False,ptlb:node_8820,ptin:_node_8820,varname:node_8820,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:762a46e884eccb84bac5bfe7d2c83424,ntxv:0,isnm:False|UVIN-7327-OUT;n:type:ShaderForge.SFN_Step,id:6040,x:32421,y:32560,varname:node_6040,prsc:2;proporder:8820;pass:END;sub:END;*/

Shader "Shader Forge/HalfLambert" {
    Properties {
        _node_8820 ("node_8820", 2D) = "white" {}
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
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_8820; uniform float4 _node_8820_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float node_5725 = 0.5;
                float2 node_7327 = float2(((dot(lightDirection,i.normalDir)*node_5725)+node_5725),0.0);
                float4 _node_8820_var = tex2D(_node_8820,TRANSFORM_TEX(node_7327, _node_8820));
                float3 emissive = _node_8820_var.rgb;
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
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_8820; uniform float4 _node_8820_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
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

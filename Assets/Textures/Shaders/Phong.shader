// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32819,y:32449,varname:node_3138,prsc:2|emission-3835-OUT;n:type:ShaderForge.SFN_LightVector,id:3937,x:31567,y:32534,varname:node_3937,prsc:2;n:type:ShaderForge.SFN_ViewVector,id:47,x:32135,y:32640,varname:node_47,prsc:2;n:type:ShaderForge.SFN_Reflect,id:6290,x:31975,y:32474,varname:node_6290,prsc:2|A-6927-OUT,B-899-OUT;n:type:ShaderForge.SFN_Dot,id:7598,x:32300,y:32531,cmnt:Specular,varname:node_7598,prsc:2,dt:0|A-4706-OUT,B-47-OUT;n:type:ShaderForge.SFN_Normalize,id:4706,x:32135,y:32474,varname:node_4706,prsc:2|IN-6290-OUT;n:type:ShaderForge.SFN_Vector1,id:8094,x:31584,y:32414,varname:node_8094,prsc:2,v1:-1;n:type:ShaderForge.SFN_Multiply,id:6927,x:31776,y:32474,varname:node_6927,prsc:2|A-8094-OUT,B-3937-OUT;n:type:ShaderForge.SFN_NormalVector,id:899,x:31567,y:32660,prsc:2,pt:False;n:type:ShaderForge.SFN_Power,id:3835,x:32529,y:32531,varname:node_3835,prsc:2|VAL-7598-OUT,EXP-5621-OUT;n:type:ShaderForge.SFN_Slider,id:5621,x:32189,y:32837,ptovrint:False,ptlb:node_5621,ptin:_node_5621,varname:node_5621,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:30,max:90;n:type:ShaderForge.SFN_LightVector,id:8062,x:32142,y:32039,varname:node_8062,prsc:2;n:type:ShaderForge.SFN_ViewReflectionVector,id:367,x:32143,y:32232,varname:node_367,prsc:2;n:type:ShaderForge.SFN_Dot,id:5059,x:32337,y:32122,cmnt:same effect,varname:node_5059,prsc:2,dt:0|A-8062-OUT,B-367-OUT;proporder:5621;pass:END;sub:END;*/

Shader "Shader Forge/Phong" {
    Properties {
        _node_5621 ("node_5621", Range(0, 90)) = 30
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
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _node_5621)
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
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float _node_5621_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_5621 );
                float node_3835 = pow(dot(normalize(reflect(((-1.0)*lightDirection),i.normalDir)),viewDirection),_node_5621_var);
                float3 emissive = float3(node_3835,node_3835,node_3835);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}

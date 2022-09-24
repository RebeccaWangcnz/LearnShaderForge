// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33477,y:32792,varname:node_3138,prsc:2|emission-307-OUT;n:type:ShaderForge.SFN_LightVector,id:2104,x:32028,y:32802,varname:node_2104,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:9361,x:32035,y:33004,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:8116,x:32274,y:32906,varname:node_8116,prsc:2,dt:0|A-2104-OUT,B-9361-OUT;n:type:ShaderForge.SFN_Step,id:987,x:32457,y:32810,varname:node_987,prsc:2|A-6566-OUT,B-8116-OUT;n:type:ShaderForge.SFN_Slider,id:6566,x:32115,y:32649,ptovrint:False,ptlb:BrightPartLimit,ptin:_BrightPartLimit,varname:node_6566,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.4024016,max:1;n:type:ShaderForge.SFN_Color,id:5036,x:32478,y:32647,ptovrint:False,ptlb:BrightPart,ptin:_BrightPart,varname:node_5036,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:8825,x:32686,y:32788,varname:node_8825,prsc:2|A-5036-RGB,B-987-OUT;n:type:ShaderForge.SFN_Slider,id:3237,x:32161,y:33214,ptovrint:False,ptlb:DarkPartLimit,ptin:_DarkPartLimit,varname:node_3237,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:-0.1846218,max:0;n:type:ShaderForge.SFN_Step,id:7724,x:32478,y:33042,varname:node_7724,prsc:2|A-8116-OUT,B-3237-OUT;n:type:ShaderForge.SFN_Multiply,id:7233,x:32702,y:33042,varname:node_7233,prsc:2|A-7724-OUT,B-5846-RGB;n:type:ShaderForge.SFN_Color,id:5846,x:32489,y:33242,ptovrint:False,ptlb:DarkPark,ptin:_DarkPark,varname:node_5846,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0.2055333,c3:0.509434,c4:1;n:type:ShaderForge.SFN_Add,id:3666,x:32950,y:32893,varname:node_3666,prsc:2|A-8825-OUT,B-7233-OUT;n:type:ShaderForge.SFN_Multiply,id:9921,x:33082,y:33231,varname:node_9921,prsc:2|A-1130-OUT,B-856-RGB;n:type:ShaderForge.SFN_Color,id:856,x:32900,y:33450,ptovrint:False,ptlb:MidllePart,ptin:_MidllePart,varname:node_856,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_RemapRange,id:928,x:32900,y:33231,varname:node_928,prsc:2,frmn:0,frmx:1,tomn:1,tomx:0|IN-2176-OUT;n:type:ShaderForge.SFN_Add,id:2176,x:32702,y:33231,varname:node_2176,prsc:2|A-987-OUT,B-7724-OUT;n:type:ShaderForge.SFN_Add,id:307,x:33242,y:32893,varname:node_307,prsc:2|A-3666-OUT,B-9921-OUT;n:type:ShaderForge.SFN_OneMinus,id:1130,x:32900,y:33102,varname:node_1130,prsc:2|IN-2176-OUT;proporder:6566-5036-3237-5846-856;pass:END;sub:END;*/

Shader "Shader Forge/Cartoon01" {
    Properties {
        _BrightPartLimit ("BrightPartLimit", Range(0, 1)) = 0.4024016
        _BrightPart ("BrightPart", Color) = (1,0,0,1)
        _DarkPartLimit ("DarkPartLimit", Range(-1, 0)) = -0.1846218
        _DarkPark ("DarkPark", Color) = (0,0.2055333,0.509434,1)
        _MidllePart ("MidllePart", Color) = (0.5,0.5,0.5,1)
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
                UNITY_DEFINE_INSTANCED_PROP( float, _BrightPartLimit)
                UNITY_DEFINE_INSTANCED_PROP( float4, _BrightPart)
                UNITY_DEFINE_INSTANCED_PROP( float, _DarkPartLimit)
                UNITY_DEFINE_INSTANCED_PROP( float4, _DarkPark)
                UNITY_DEFINE_INSTANCED_PROP( float4, _MidllePart)
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
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float4 _BrightPart_var = UNITY_ACCESS_INSTANCED_PROP( Props, _BrightPart );
                float _BrightPartLimit_var = UNITY_ACCESS_INSTANCED_PROP( Props, _BrightPartLimit );
                float node_8116 = dot(lightDirection,i.normalDir);
                float node_987 = step(_BrightPartLimit_var,node_8116);
                float _DarkPartLimit_var = UNITY_ACCESS_INSTANCED_PROP( Props, _DarkPartLimit );
                float node_7724 = step(node_8116,_DarkPartLimit_var);
                float4 _DarkPark_var = UNITY_ACCESS_INSTANCED_PROP( Props, _DarkPark );
                float3 node_3666 = ((_BrightPart_var.rgb*node_987)+(node_7724*_DarkPark_var.rgb));
                float node_2176 = (node_987+node_7724);
                float4 _MidllePart_var = UNITY_ACCESS_INSTANCED_PROP( Props, _MidllePart );
                float3 emissive = (node_3666+((1.0 - node_2176)*_MidllePart_var.rgb));
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
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _BrightPartLimit)
                UNITY_DEFINE_INSTANCED_PROP( float4, _BrightPart)
                UNITY_DEFINE_INSTANCED_PROP( float, _DarkPartLimit)
                UNITY_DEFINE_INSTANCED_PROP( float4, _DarkPark)
                UNITY_DEFINE_INSTANCED_PROP( float4, _MidllePart)
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

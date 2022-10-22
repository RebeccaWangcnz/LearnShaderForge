// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33940,y:32661,varname:node_3138,prsc:2|emission-7614-OUT;n:type:ShaderForge.SFN_NormalVector,id:8027,x:32003,y:32836,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:61,x:32359,y:32957,varname:node_61,prsc:2;n:type:ShaderForge.SFN_Dot,id:8424,x:32560,y:32839,varname:node_8424,prsc:2,dt:0|A-8027-OUT,B-61-OUT;n:type:ShaderForge.SFN_Max,id:1045,x:32750,y:32839,cmnt:Lambert,varname:node_1045,prsc:2|A-8424-OUT,B-8106-OUT;n:type:ShaderForge.SFN_Vector1,id:8106,x:32560,y:33008,varname:node_8106,prsc:2,v1:0;n:type:ShaderForge.SFN_ViewReflectionVector,id:1452,x:32359,y:33121,varname:node_1452,prsc:2;n:type:ShaderForge.SFN_Dot,id:8996,x:32544,y:33101,varname:node_8996,prsc:2,dt:0|A-61-OUT,B-1452-OUT;n:type:ShaderForge.SFN_Max,id:5154,x:32737,y:33081,varname:node_5154,prsc:2|A-8106-OUT,B-8996-OUT;n:type:ShaderForge.SFN_Power,id:3067,x:32936,y:33081,varname:node_3067,prsc:2|VAL-5154-OUT,EXP-712-OUT;n:type:ShaderForge.SFN_Slider,id:712,x:32601,y:33282,ptovrint:False,ptlb:power,ptin:_power,varname:node_712,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:30,max:90;n:type:ShaderForge.SFN_Add,id:652,x:33096,y:32843,varname:node_652,prsc:2|A-1288-OUT,B-3067-OUT;n:type:ShaderForge.SFN_ComponentMask,id:9296,x:32171,y:32643,cmnt:UpMask,varname:node_9296,prsc:2,cc1:1,cc2:-1,cc3:-1,cc4:-1|IN-8027-OUT;n:type:ShaderForge.SFN_Multiply,id:7192,x:32354,y:32519,cmnt:DownMask,varname:node_7192,prsc:2|A-4319-OUT,B-9296-OUT;n:type:ShaderForge.SFN_Vector1,id:4319,x:32176,y:32519,varname:node_4319,prsc:2,v1:-1;n:type:ShaderForge.SFN_Color,id:303,x:32318,y:31985,ptovrint:False,ptlb:upColor,ptin:_upColor,varname:node_303,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.8679245,c2:0.1514774,c3:0.1514774,c4:1;n:type:ShaderForge.SFN_Color,id:6218,x:32318,y:32144,ptovrint:False,ptlb:MiddleColor,ptin:_MiddleColor,varname:node_6218,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Color,id:257,x:32318,y:32306,ptovrint:False,ptlb:DownColor,ptin:_DownColor,varname:node_257,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.4959846,c2:0.5754717,c3:0.2795924,c4:1;n:type:ShaderForge.SFN_Multiply,id:7474,x:32775,y:32302,varname:node_7474,prsc:2|A-303-RGB,B-4571-OUT;n:type:ShaderForge.SFN_Multiply,id:1424,x:32775,y:32494,varname:node_1424,prsc:2|A-257-RGB,B-9428-OUT;n:type:ShaderForge.SFN_Vector1,id:4560,x:32676,y:32621,varname:node_4560,prsc:2,v1:1;n:type:ShaderForge.SFN_Subtract,id:4538,x:32705,y:32693,varname:node_4538,prsc:2|A-4560-OUT,B-4571-OUT;n:type:ShaderForge.SFN_Subtract,id:793,x:32873,y:32693,cmnt:MiddleMask,varname:node_793,prsc:2|A-4538-OUT,B-9428-OUT;n:type:ShaderForge.SFN_Multiply,id:7928,x:32775,y:32156,varname:node_7928,prsc:2|A-6218-RGB,B-793-OUT;n:type:ShaderForge.SFN_Add,id:3455,x:33031,y:32282,varname:node_3455,prsc:2|A-7928-OUT,B-7474-OUT,C-1424-OUT;n:type:ShaderForge.SFN_Color,id:1431,x:33108,y:33071,ptovrint:False,ptlb:LightColor,ptin:_LightColor,varname:node_1431,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:5574,x:33263,y:32946,varname:node_5574,prsc:2|A-652-OUT,B-1431-RGB;n:type:ShaderForge.SFN_Multiply,id:4360,x:33438,y:32946,varname:node_4360,prsc:2|A-5574-OUT,B-6312-OUT;n:type:ShaderForge.SFN_LightAttenuation,id:6312,x:33248,y:33136,varname:node_6312,prsc:2;n:type:ShaderForge.SFN_Tex2d,id:268,x:33171,y:32502,ptovrint:False,ptlb:Occlusion,ptin:_Occlusion,varname:node_268,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:7678,x:33426,y:32482,varname:node_7678,prsc:2|A-3447-OUT,B-268-RGB;n:type:ShaderForge.SFN_Max,id:4571,x:32354,y:32643,varname:node_4571,prsc:2|A-9296-OUT,B-9269-OUT;n:type:ShaderForge.SFN_Vector1,id:9269,x:32176,y:32801,varname:node_9269,prsc:2,v1:0;n:type:ShaderForge.SFN_Max,id:9428,x:32552,y:32519,varname:node_9428,prsc:2|A-7192-OUT,B-9269-OUT;n:type:ShaderForge.SFN_Add,id:7614,x:33712,y:32756,varname:node_7614,prsc:2|A-7678-OUT,B-4360-OUT;n:type:ShaderForge.SFN_Color,id:5640,x:32750,y:32986,ptovrint:False,ptlb:BaseColor,ptin:_BaseColor,varname:node_5640,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:1288,x:32925,y:32843,varname:node_1288,prsc:2|A-1045-OUT,B-5640-RGB;n:type:ShaderForge.SFN_Slider,id:386,x:32952,y:32130,ptovrint:False,ptlb:EnvIntensity,ptin:_EnvIntensity,varname:node_386,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Multiply,id:9436,x:33274,y:32304,varname:node_9436,prsc:2|A-386-OUT,B-3455-OUT;n:type:ShaderForge.SFN_Multiply,id:3447,x:33445,y:32304,varname:node_3447,prsc:2|A-9436-OUT,B-5640-RGB;proporder:712-303-6218-257-1431-268-5640-386;pass:END;sub:END;*/

Shader "Shader Forge/OldSchoolPlus" {
    Properties {
        _power ("power", Range(1, 90)) = 30
        _upColor ("upColor", Color) = (0.8679245,0.1514774,0.1514774,1)
        _MiddleColor ("MiddleColor", Color) = (0.5,0.5,0.5,1)
        _DownColor ("DownColor", Color) = (0.4959846,0.5754717,0.2795924,1)
        _LightColor ("LightColor", Color) = (0.5,0.5,0.5,1)
        _Occlusion ("Occlusion", 2D) = "white" {}
        _BaseColor ("BaseColor", Color) = (0.5,0.5,0.5,1)
        _EnvIntensity ("EnvIntensity", Range(0, 1)) = 0.5
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
            uniform sampler2D _Occlusion; uniform float4 _Occlusion_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _power)
                UNITY_DEFINE_INSTANCED_PROP( float4, _upColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _MiddleColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _DownColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _LightColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _BaseColor)
                UNITY_DEFINE_INSTANCED_PROP( float, _EnvIntensity)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
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
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
////// Emissive:
                float _EnvIntensity_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvIntensity );
                float4 _MiddleColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _MiddleColor );
                float node_9296 = i.normalDir.g; // UpMask
                float node_9269 = 0.0;
                float node_4571 = max(node_9296,node_9269);
                float node_9428 = max(((-1.0)*node_9296),node_9269);
                float4 _upColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _upColor );
                float4 _DownColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _DownColor );
                float4 _BaseColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _BaseColor );
                float4 _Occlusion_var = tex2D(_Occlusion,TRANSFORM_TEX(i.uv0, _Occlusion));
                float node_8106 = 0.0;
                float _power_var = UNITY_ACCESS_INSTANCED_PROP( Props, _power );
                float4 _LightColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _LightColor );
                float3 emissive = ((((_EnvIntensity_var*((_MiddleColor_var.rgb*((1.0-node_4571)-node_9428))+(_upColor_var.rgb*node_4571)+(_DownColor_var.rgb*node_9428)))*_BaseColor_var.rgb)*_Occlusion_var.rgb)+((((max(dot(i.normalDir,lightDirection),node_8106)*_BaseColor_var.rgb)+pow(max(node_8106,dot(lightDirection,viewReflectDirection)),_power_var))*_LightColor_var.rgb)*attenuation));
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
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            uniform sampler2D _Occlusion; uniform float4 _Occlusion_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _power)
                UNITY_DEFINE_INSTANCED_PROP( float4, _upColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _MiddleColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _DownColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _LightColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _BaseColor)
                UNITY_DEFINE_INSTANCED_PROP( float, _EnvIntensity)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
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
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 finalColor = 0;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}

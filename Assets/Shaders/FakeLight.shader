// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33035,y:32558,varname:node_3138,prsc:2|emission-8248-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32049,y:32884,ptovrint:False,ptlb:Fake Light Color,ptin:_FakeLightColor,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.07843138,c2:0.3921569,c3:0.7843137,c4:1;n:type:ShaderForge.SFN_Vector4Property,id:7301,x:31303,y:32533,ptovrint:False,ptlb:Fake LightDir,ptin:_FakeLightDir,varname:node_7301,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:0,v3:0,v4:0;n:type:ShaderForge.SFN_NormalVector,id:906,x:31520,y:32735,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:1567,x:31788,y:32641,varname:node_1567,prsc:2,dt:0|A-3278-OUT,B-906-OUT;n:type:ShaderForge.SFN_Multiply,id:9572,x:32272,y:32735,varname:node_9572,prsc:2|A-9003-OUT,B-7241-RGB;n:type:ShaderForge.SFN_Tex2d,id:7828,x:32471,y:32566,ptovrint:False,ptlb:Main Texture,ptin:_MainTexture,varname:node_7828,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:b66bceaf0cc0ace4e9bdc92f14bba709,ntxv:0,isnm:False|UVIN-4307-UVOUT;n:type:ShaderForge.SFN_Multiply,id:6816,x:32662,y:32677,varname:node_6816,prsc:2|A-7828-RGB,B-9143-OUT;n:type:ShaderForge.SFN_Normalize,id:3278,x:31520,y:32533,varname:node_3278,prsc:2|IN-7301-XYZ;n:type:ShaderForge.SFN_RemapRange,id:9003,x:32049,y:32640,cmnt:Half Lambert,varname:node_9003,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-1567-OUT;n:type:ShaderForge.SFN_Multiply,id:9143,x:32435,y:32873,varname:node_9143,prsc:2|A-9572-OUT,B-4657-OUT;n:type:ShaderForge.SFN_Slider,id:4657,x:32049,y:33091,ptovrint:False,ptlb:Fake Light Intensity,ptin:_FakeLightIntensity,varname:node_4657,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_TexCoord,id:4307,x:32272,y:32566,varname:node_4307,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_SwitchProperty,id:8248,x:32844,y:32657,ptovrint:False,ptlb:FakeLight Switch,ptin:_FakeLightSwitch,varname:node_8248,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-7828-RGB,B-6816-OUT;proporder:7241-7301-7828-4657-8248;pass:END;sub:END;*/

Shader "Shader Forge/FakeLight" {
    Properties {
        _FakeLightColor ("Fake Light Color", Color) = (0.07843138,0.3921569,0.7843137,1)
        _FakeLightDir ("Fake LightDir", Vector) = (0,0,0,0)
        _MainTexture ("Main Texture", 2D) = "white" {}
        _FakeLightIntensity ("Fake Light Intensity", Range(0, 1)) = 0.5
        [MaterialToggle] _FakeLightSwitch ("FakeLight Switch", Float ) = 0
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
            uniform sampler2D _MainTexture; uniform float4 _MainTexture_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _FakeLightColor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _FakeLightDir)
                UNITY_DEFINE_INSTANCED_PROP( float, _FakeLightIntensity)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _FakeLightSwitch)
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
                float3 normalDir : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float4 _MainTexture_var = tex2D(_MainTexture,TRANSFORM_TEX(i.uv0, _MainTexture));
                float4 _FakeLightDir_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FakeLightDir );
                float node_1567 = dot(normalize(_FakeLightDir_var.rgb),i.normalDir);
                float4 _FakeLightColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FakeLightColor );
                float _FakeLightIntensity_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FakeLightIntensity );
                float3 _FakeLightSwitch_var = lerp( _MainTexture_var.rgb, (_MainTexture_var.rgb*(((node_1567*0.5+0.5)*_FakeLightColor_var.rgb)*_FakeLightIntensity_var)), UNITY_ACCESS_INSTANCED_PROP( Props, _FakeLightSwitch ) );
                float3 emissive = _FakeLightSwitch_var;
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}

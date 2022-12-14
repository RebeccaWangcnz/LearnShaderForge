// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32927,y:32420,varname:node_3138,prsc:2|emission-599-OUT;n:type:ShaderForge.SFN_Dot,id:4306,x:32384,y:32804,varname:node_4306,prsc:2,dt:0|A-9662-OUT,B-6995-OUT;n:type:ShaderForge.SFN_LightVector,id:6995,x:32117,y:32853,varname:node_6995,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:9662,x:32117,y:32670,prsc:2,pt:False;n:type:ShaderForge.SFN_Clamp01,id:1578,x:32565,y:32804,varname:node_1578,prsc:2|IN-4306-OUT;n:type:ShaderForge.SFN_Color,id:1249,x:32382,y:32513,ptovrint:False,ptlb:node_1249,ptin:_node_1249,varname:node_1249,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:599,x:32722,y:32520,varname:node_599,prsc:2|A-1249-RGB,B-1578-OUT;proporder:1249;pass:END;sub:END;*/

Shader "Shader Custom/NormalMap2" {
    Properties 
    {
        _NormalMap ("Normal Map", 2D) = "bump"{}
    }
    SubShader 
    {
        Tags 
        {
            "RenderType"="Opaque"
        }
        Pass 
        {
            Name "FORWARD"
            Tags 
            {
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
            
            uniform sampler2D _NormalMap;
            struct VertexInput 
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent:TANGENT;
                float2 uv:TEXCOORD0;
            };
            struct VertexOutput 
            {
                float4 pos : SV_POSITION;
                float3 nDirWS : TEXCOORD1;
                float2 uv:TEXCOORD2;
                float3 tDirWS:TEXCOORD3;
                float3 bDirWS:TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) 
            {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv=v.uv;
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                o.tDirWS = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w);               
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //????????
                float3 nDirTS=UnpackNormal(tex2D(_NormalMap,i.uv));
                float3x3 TBN=float3x3(i.tDirWS,i.bDirWS,i.nDirWS);
                float3 nDir=normalize(mul(nDirTS,TBN));
                float3 lDir=normalize(_WorldSpaceLightPos0.xyz);

                float nDotl=dot(nDir,lDir);
                return fixed4(nDotl,nDotl,nDotl,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}

Shader "Shader Custom/CubemapShader" {
    Properties 
    {
        _Cubemap ("Cubemap", Cube) = "_Skybox" {}
        _MipLevel ("MipLevel", Range(0, 1)) = 0
        _NormalMap ("NormalMap", 2D) = "bump" {}
        _AmbientOclusion ("AO", 2D) = "white" {}
        _FresnelPower ("FresnelPower", Range(0, 5)) = 0
        _EnvSpecularInt ("EnvSpecularInt", Range(0, 10)) = 0
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
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            //Input Parameter
            uniform samplerCUBE _Cubemap;
            uniform sampler2D _NormalMap;
            uniform sampler2D _AmbientOclusion;
            uniform float4 _NormalMap_ST;
            uniform float _MipLevel;
            uniform float _FresnelPower;
            uniform float _EnvSpecularInt;
            //Vertex Input Para
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv:TEXCOORD0;
                float4 tangent:TANGENT;
            };
            //Vertex Output Para
            struct VertexOutput {
                float4 posCS : SV_POSITION;
                float4 posWS : TEXCOORD0;
                float3 normalDir:TEXCOORD1;
                float2 uv:TEXCOORD2;
                float3 tangentDir:TEXCOORD3;
                float3 bitangentDir:TEXCOORD4;
            };
            //Vertex shader
            VertexOutput vert (VertexInput v) 
            {
                VertexOutput o = (VertexOutput)0;
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                //这个一定要有挖
                o.posCS = UnityObjectToClipPos( v.vertex );
                o.uv=v.uv;
                o.normalDir=UnityObjectToWorldNormal(v.normal);
                o.tangentDir=normalize(mul(unity_ObjectToWorld,float4(v.tangent.xyz,0.0)).xyz);
                o.bitangentDir=normalize(cross(o.normalDir,o.tangentDir)*v.tangent.w);
                return o;
            }
            //fragment shader
            float4 frag(VertexOutput i) : COLOR 
            {
                //准备向量
                float3x3 TBN=float3x3(i.tangentDir,i.bitangentDir,i.normalDir);
                float3 vDir=normalize(_WorldSpaceCameraPos.xyz-i.posWS.xyz);
                float3 nDirTS=UnpackNormal(tex2D(_NormalMap,i.uv));
                float3 nDirWS=mul(nDirTS,TBN);
                float3 vrDirWS=reflect(-vDir,nDirWS);

                //cubemap
                float4 cubemap=texCUBElod(_Cubemap,float4(vrDirWS,_MipLevel));
                float3 ao=tex2D(_AmbientOclusion,i.uv);                
                //Fresnel
                float3 fresnel=pow((1-dot(vDir,nDirWS)),_FresnelPower);

                //结果输出
                float3 finalColor=fresnel*cubemap*_EnvSpecularInt*ao;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}

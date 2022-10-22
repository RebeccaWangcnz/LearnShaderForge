Shader "Shader Custom/MatcapShader" {
    Properties 
    {
        _NormalMap ("NormalMap", 2D) = "bump" {}
        _MatcapTex ("MatcapTex", 2D) = "gray" {}
        _FresnelPower ("FresnelPower", Range(0, 10)) = 1
        _EnvSpecInt ("EnvSpecInt", Range(0, 5)) = 1
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
            uniform sampler2D _NormalMap;
            uniform float4 _NormalMap_ST;
            uniform sampler2D _MatcapTex;
            uniform float4 _MatcapTex_ST;
            uniform float _FresnelPower;
            uniform float _EnvSpecInt;
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
                float3x3 tangentTransform=float3x3(i.tangentDir,i.bitangentDir,i.normalDir);
                float3 vDir=normalize(_WorldSpaceCameraPos.xyz-i.posWS.xyz);

                //normal map
                float3 normalMap=UnpackNormal(tex2D(_NormalMap,i.uv));
                float3 nDirWS=mul(normalMap,tangentTransform);
                float2 nDirVSrg=mul(UNITY_MATRIX_V,float4(nDirWS.rgb,0)).rg*0.5+0.5;//UNITY_MATRIX_V是一个4*4矩阵
                //matcap map
                float3 matCap=tex2D(_MatcapTex,nDirVSrg);
                //Fresnel
                float3 fresnel=pow((1-dot(vDir,nDirWS)),_FresnelPower);

                //结果输出
                float3 finalColor=fresnel*matCap*_EnvSpecInt;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}

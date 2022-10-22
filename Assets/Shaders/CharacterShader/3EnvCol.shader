Shader "Shader Custom/3EnvCol" 
{
    Properties 
    {
        _UpCol ("UpColor", Color) = (0.5,0.5,0.5,1)
        _MiddleCol ("MiddleColor", Color) = (0.5,0.5,0.5,1)
        _DownCol ("DownColor", Color) = (0.5,0.5,0.5,1)
        _AO("Occulusion",2d)="white"{}
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
            
            //parameter
            uniform float4 _UpCol;
            uniform float4 _MiddleCol;
            uniform float4 _DownCol;
            uniform sampler2D _AO;

            //struct
            struct VertexInput 
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv:TEXCOORD0;
            };
            struct VertexOutput 
            {
                float4 pos : SV_POSITION;
                float4 posWS : TEXCOORD0;
                float3 nDirWS : TEXCOORD1;
                float2 uv:TEXCOORD2;
                SHADOW_COORDS(3)//投影用坐标信息其中3,4和上面的TEXCOORD后面标号一样
            };
            VertexOutput vert (VertexInput v) 
            {
                VertexOutput o = (VertexOutput)0;
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv=v.uv;
                TRANSFER_SHADOW(o)//UNITY封装
                return o;
            }
            float4 frag(VertexOutput i) : COLOR 
            {
                float3 upMask=max(0,i.nDirWS.g);
                float3 downMask=max(0,-i.nDirWS.g);
                float3 middleMask=1.0-upMask-downMask;

                float3 finalColor=upMask*_UpCol+downMask*_DownCol+middleMask*_MiddleCol;
                float occulusion=tex2D(_AO,i.uv);
                float3 finalCOlorwithAO=finalColor*occulusion;

                float shadow=LIGHT_ATTENUATION(i);

                return fixed4(finalCOlorwithAO,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}

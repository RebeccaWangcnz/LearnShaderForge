Shader "Shader Custom/PBR/Metalic_Roughness"
{
    Properties
    {
        [Header(Texture)]
        _MainTex    ("Main Texture", 2D) = "white"{}
        _NormTex    ("Normal Texture", 2D) = "white"{}
        _HeightTex  ("Height Texture", 2D) = "white"{}
        _RoughTex   ("Roughness Texture", 2D) = "white"{}
        _MetalTex   ("Metallic Texture", 2D) = "white"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200
        pass
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
            #include "Lighting.cginc"

            uniform sampler2D _MainTex;
            uniform float4 _MainTex_ST;            
            uniform sampler2D _NormTex;
            uniform float4 _NormTex_ST;            
            uniform sampler2D _HeightTex;
            uniform float4 _HeightTex_ST;            
            uniform sampler2D _RoughTex;
            uniform float4 _RoughTex_ST;
            uniform sampler2D _MetalTex;
            uniform float4 _MetalTex_ST;

            struct VertexInput {
                float4 vertex   :POSITION;
                float4 normal   :NORMAL;
                float4 tangent  :TANGENT;
                float2 uv       :TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos      :SV_POSITION;
                float4 posWS    :TEXCOORD0;
                float2 uv       :TEXCOORD1;
                float3 nDirWS   :TEXCOORD2;
                float3 tDirWS   :TEXCOORD3;
                float3 bDirWS   :TEXCOORD4;
                SHADOW_COORDS(5)
            };

             VertexOutput vert (VertexInput v) 
             {
                VertexOutput o = (VertexOutput)0;
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv=v.uv;
                o.nDirWS=UnityObjectToWorldNormal(v.normal);
                o.tDirWS=normalize(mul(unity_ObjectToWorld,float4(v.tangent.xyz,0.0)).xyz);
                o.bDirWS=normalize(cross(o.nDirWS,o.tDirWS)*v.tangent.w);
                TRANSFER_SHADOW(o);
                return o;
             }
            float4 frag(VertexOutput i) : COLOR 
            {   
                //prepare vector
                float3x3 TBN=float3x3(i.tDirWS,i.bDirWS,i.nDirWS);
                //middle calculate
                //sample texture
                //distract information
                //lighting model
                //finale mix
                float3 finalRGB=float3(1,1,1);
                return fixed4(finalRGB,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}

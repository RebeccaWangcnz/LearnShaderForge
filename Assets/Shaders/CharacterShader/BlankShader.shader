Shader "Shader Custom/BlankShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
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

            uniform float4 _Color;

            struct VertexInput {
                float4 vertex   :POSITION;
            };
            struct VertexOutput {
                float4 pos    :SV_POSITION;
                float4 posWS    :TEXCOORD0;
            };

             VertexOutput vert (VertexInput v) 
             {
                VertexOutput o = (VertexOutput)0;
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
             }
            float4 frag(VertexOutput i) : COLOR 
            {                
                float3 finalRGB=_Color.rgb;
                return fixed4(finalRGB,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}

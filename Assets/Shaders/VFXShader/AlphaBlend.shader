Shader "Shader Custom/AlphaBlend" {
    Properties 
    {
       _MainTex("rgb:颜色 A：透贴",2d)="white"{}
       _Opacity("opacity",range(0,1))=0.5
    }
    SubShader 
    {
        Tags 
        {
            "Queue"="Transparent"
            "RenderType"="TransparentCutout"
            "ForceNoShadowCasting"="True"
            "IgnoreProjector"="True"
        }
        Pass 
        {
            Name "FORWARD"
            Tags 
            {
                "LightMode"="ForwardBase"
            }
            Blend One OneMinusSrcAlpha
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            //输入参数
            uniform sampler2D _MainTex;
            uniform float4 _MainTex_ST;
            uniform float _Opacity;

            struct VertexInput 
            {
                float4 vertex : POSITION;
                float2 uv:TEXCOORD0;//uv 一定要用float
            };
            struct VertexOutput 
            {
                float4 pos : SV_POSITION;
                float2 uv:TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) 
            {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv=TRANSFORM_TEX(v.uv,_MainTex);            
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //采样贴图
                float4 var_MainTex=tex2D(_MainTex,i.uv);
                float3 finalRGB=var_MainTex.rgb;
                //获取参数
                float transparent=var_MainTex.a*_Opacity;
                return float4(finalRGB*transparent,transparent);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}

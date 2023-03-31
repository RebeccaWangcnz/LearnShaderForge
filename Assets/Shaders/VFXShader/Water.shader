Shader "Shader Custom/Water" {
    Properties 
    {
       _MainTex     ("Main Texture",2d)="white"{}
       _WarpTex     ("Warp Texture",2d)="white"{}
       _Speed       ("x: water speed x y:water speed y",vector)=(1.0,1.0,0.5,1.0)
       _Warp1Params ("x:size y:flow speed x z:flow speed y w:intensity",vector)=(1.0,1.0,0.5,1.0)
       _Warp2Params ("x:size y:flow speed x z:flow speed y w:intensity",vector)=(2.0,0.5,0.5,1.0)
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
            uniform sampler2D _WarpTex;
            uniform float4 _Speed;
            uniform float4 _Warp1Params;
            uniform float4 _Warp2Params;

            struct VertexInput 
            {
                float4 vertex : POSITION;
                float2 uv:TEXCOORD0;//uv 一定要用float
            };
            struct VertexOutput 
            {
                float4 pos : SV_POSITION;
                float2 uv0:TEXCOORD0;
                float2 uv1:TEXCOORD1;
                float2 uv2:TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) 
            {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv0=TRANSFORM_TEX(v.uv,_MainTex)-frac(_Time*_Speed.xy);
                o.uv1=v.uv*_Warp1Params.x-frac(_Time*_Warp1Params.yz);
                o.uv2=v.uv*_Warp2Params.x-frac(_Time*_Warp2Params.yz);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //采样贴图               
                float3 var_WarpTex1=tex2D(_WarpTex,i.uv1).rgb;
                float3 var_WarpTex2=tex2D(_WarpTex,i.uv2).rgb;
                float2 noise=(var_WarpTex1.xy-0.5)*_Warp1Params.w+(var_WarpTex2-0.5)*_Warp2Params.w;
                float2 uv0=i.uv0+noise;
                float4 var_MainTex=tex2D(_MainTex,uv0);
                //获取参数
                return float4(var_MainTex);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}

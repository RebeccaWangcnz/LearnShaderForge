Shader "Shader Custom/ScreenUVFlow" {
    Properties 
    {
       _MainTex("rgb:color A:opaque",2d)="white"{}
       _Opacity("opacity",range(0,1))=0.5
       _ScreenTex("screen Texture",2d)="white"{}
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
            uniform sampler2D _ScreenTex;
            uniform float4 _ScreenTex_ST;

            struct VertexInput 
            {
                float4 vertex : POSITION;
                float2 uv:TEXCOORD0;//uv 一定要用float
            };
            struct VertexOutput 
            {
                float4 pos : SV_POSITION;
                float2 uv:TEXCOORD0;
                float2 screenUV:TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) 
            {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv=TRANSFORM_TEX(v.uv,_MainTex);   
                float3 posVS=UnityObjectToViewPos(v.vertex).xyz;
                float originPos=UnityObjectToViewPos(float3(0,0,0)).z;
                o.screenUV=posVS.xy/posVS.z*originPos;
                o.screenUV=o.screenUV*_ScreenTex_ST.xy+frac(_Time*_ScreenTex_ST.zw);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //采样贴图
                float4 var_MainTex=tex2D(_MainTex,i.uv);
                float var_ScreenTex=tex2D(_ScreenTex,i.screenUV).r;
                //获取参数
                float transparent=var_MainTex.a*_Opacity*var_ScreenTex;
                return float4(var_MainTex.rgb*transparent,transparent);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}

Shader "Shader Custom/ScreenUVWarp" {
    Properties 
    {
       _MainTex("rgb:颜色 A：透贴",2d)="white"{}
       _Opacity("opacity",range(0,1))=0.5
       _WarpMidVal("Warp middle value",range(0,1) )=0.5
       _WarpInt("Warp Intensity",range(0,1))=0.2
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
        //产生背景纹理
        GrabPass
        {
            "_BGTex"
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
            uniform float _Opacity;
            uniform float _WarpMidVal;
            uniform float _WarpInt;
            uniform sampler2D _BGTex;

            struct VertexInput 
            {
                float4 vertex : POSITION;
                float2 uv:TEXCOORD0;//uv 一定要用float
            };
            struct VertexOutput 
            {
                float4 pos : SV_POSITION;
                float2 uv:TEXCOORD0;
                float4 grabPos:TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) 
            {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv=v.uv;   
                o.grabPos=ComputeGrabScreenPos(o.pos);

                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //采样贴图
                float4 var_MainTex=tex2D(_MainTex,i.uv);
                i.grabPos.xy+=(var_MainTex.b-_WarpMidVal)*_WarpInt*_Opacity;
                float3 var_bgTEX=tex2Dproj(_BGTex,i.grabPos);
                float3 finalRGB=var_MainTex.rgb*var_bgTEX;
                //获取参数
                float transparent=var_MainTex.a*_Opacity;
                return float4(finalRGB*transparent,transparent);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}

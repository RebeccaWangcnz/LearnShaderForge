Shader "Shader Custom/Fire" {
    Properties 
    {
       _Mask        ("r: inner fire g: outter fire b: opacity",2d)="blue"{}
       _Noise       ("R: Noise Texture1 G: Noise Texture2",2d)="gray"{}
       _Noise1Params("NOISE1: x:size y:flow speed z:intensity",vector)=(1.0,0.2,0.2,1.0)
       _Noise2Params("NOISE2: x:size y:flow speed z:intensity",vector)=(1.0,0.2,0.2,1.0)
       [HDR]
       _InnerFireCol("Inner Fire Color",color)=(1.0,1.0,1.0,1.0)
       [HDR]
       _OutterFireCol("Outter Fire Color",color)=(0.5,0.5,0.5,0.5)
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
            uniform sampler2D _Mask;
            uniform sampler2D _Noise;
            uniform float3 _Noise1Params;
            uniform float3 _Noise2Params;
            uniform float4 _InnerFireCol;
            uniform float4 _OutterFireCol;

            struct VertexInput 
            {
                float4 vertex : POSITION;
                float2 uv:TEXCOORD0;        //uv 一定要用float
            };
            struct VertexOutput 
            {
                float4 pos : SV_POSITION;   //顶点信息 必要
                float2 uv0:TEXCOORD0;       //UV信息 采样mask
                float2 uv1:TEXCOORD1;       //UV信息 采样NOISE1
                float2 uv2:TEXCOORD2;       //UV信息 采样Noise2
            };
            VertexOutput vert (VertexInput v) 
            {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv0=v.uv;
                o.uv1=v.uv; 
                o.uv1*=_Noise1Params.x;
                o.uv1.y+=frac(_Time.x*_Noise1Params.y);
                o.uv2=v.uv;  
                o.uv2*=_Noise2Params.x;
                o.uv2.y+=frac(_Time.x*_Noise2Params.y);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //采样贴图
                float mask1=tex2D(_Mask,i.uv0).a;
                float mask2=tex2D(_Noise,i.uv0).a;
                float var_Noise1=tex2D(_Noise,i.uv1).r;
                float var_Noise2=tex2D(_Noise,i.uv2).g;
                //混合噪声
                float noise=var_Noise1*_Noise1Params.z+var_Noise2*_Noise2Params.z;
                //uv扰动
                float2 uv0=i.uv0-float2(0,noise)*mask1*(1-mask2);
                float4 var_Mask=tex2D(_Mask,uv0);
                //获取参数
                float opacity=var_Mask.b;
                float3 finalRGB=var_Mask.g*_InnerFireCol+var_Mask.r*_OutterFireCol;
                return float4(finalRGB*opacity,opacity);
                //return float4(uv0.x,uv0.y,0,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}

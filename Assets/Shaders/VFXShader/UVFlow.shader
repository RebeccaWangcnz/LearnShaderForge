Shader "Shader Custom/UVFlow" {
    Properties 
    {
       _MainTex("rgb:Color A:Opacity",2d)="white"{}
       _Opacity("opacity",range(0,1))=0.5
       _NoiseTex("Noise Texture",2d)="gray"{}
       _NoiseInt("Noise Intensity",range(0,5))=1
       _FlowSpeed("Flow Speed",range(-10,10))=5
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
            //�������
            uniform sampler2D _MainTex;
            uniform float4 _MainTex_ST;
            uniform float _Opacity;
            uniform sampler _NoiseTex;
            uniform float4 _NoiseTex_ST;
            uniform float _NoiseInt;
            uniform float _FlowSpeed;

            struct VertexInput 
            {
                float4 vertex : POSITION;
                float2 uv:TEXCOORD0;//uv һ��Ҫ��float
            };
            struct VertexOutput 
            {
                float4 pos : SV_POSITION;
                float2 uv0:TEXCOORD0;//����mainTexture
                float2 uv1:TEXCOORD1;//����NoiseTexture
            };
            VertexOutput vert (VertexInput v) 
            {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv0 = TRANSFORM_TEX( v.uv,_MainTex);
                o.uv1=TRANSFORM_TEX( v.uv,_NoiseTex);   
                o.uv1.y=o.uv1.y+frac(_Time.x*_FlowSpeed);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                //������ͼ
                float4 var_MainTex=tex2D(_MainTex,i.uv0);
                float4 var_NoiseTex=tex2D(_NoiseTex,i.uv1);

                float noise=lerp(1,var_NoiseTex*2.0,_NoiseInt);
                noise=max(0.0,noise);
                float3 finalRGB=var_MainTex.rgb;
                float opacity=var_MainTex.a*_Opacity*noise;

                return float4(finalRGB*opacity,opacity);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}

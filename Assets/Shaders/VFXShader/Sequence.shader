Shader "Shader Custom/Sequence" {
    Properties 
    {
       _MainTex("rgb:颜色 A：透贴",2d)="white"{}
       _Opacity("opacity",range(0,1))=0.5
       _Sequence("Squence Texture",2d)="gray"{}
       _RowCount("Row Count",int)=1
       _ColCount("Column Count",int)=1
       _Speed("Speed",range(-10,10))=1
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
            Name "FORWARD_AB"
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
                o.uv=v.uv;            
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
        pass
        {
            Name "FORWARD_AD"
            Tags 
            {
                "LightMode"="ForwardBase"
            }
            
            Blend One One
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            //输入参数
            uniform sampler2D _Sequence;
            uniform float4 _Sequence_ST;
            uniform float _RowCount;
            uniform float _ColCount;
            uniform float _Speed;

            struct VertexInput 
            {
                float4 vertex : POSITION;
                float3 normal:NORMAL;
                float2 uv:TEXCOORD0;//uv 一定要用float
            };
            struct VertexOutput 
            {
                float4 pos : SV_POSITION;
                float2 uv:TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) 
            {
                VertexOutput o = (VertexOutput)0;
                    v.vertex.xyz+=v.normal*0.003;
                    o.pos = UnityObjectToClipPos( v.vertex );
                    o.uv=TRANSFORM_TEX(v.uv,_Sequence);   
                    float _SequID=floor(_Time.z*_Speed);
                    float idv=floor(_SequID/_ColCount);
                    float idu=_SequID-idv*_ColCount;
                    float stepU=1.0/_ColCount;
                    float stepV=1.0/_RowCount;
                    float2 initUV=o.uv*float2(stepU,stepV)+float2(0.0,(_RowCount-1)*stepV);
                    o.uv=initUV+float2(idu*stepU,-idv*stepV);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 var_Sequence=tex2D(_Sequence,i.uv);
                float3 finalRGB=var_Sequence.rgb;
                //获取参数
                float transparent=var_Sequence.a;
                return float4(finalRGB*transparent,transparent);
            }
            ENDCG
        }
    }
}

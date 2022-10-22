Shader "Shader Custom/OldSchool" {
    Properties 
    {
         _Color("Color",Color)=(0.1,0.2,0.3,1)
         _Power("SpecularIntensity",Range(1,90))=30
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
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            //Input Parameter
            uniform float3 _Color;
            uniform float _Power;
            //Vertex Input Para
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            //Vertex Output Para
            struct VertexOutput {
                float4 posCS : SV_POSITION;
                float4 posWS : TEXCOORD0;
                float3 nDirWS : TEXCOORD1;
            };
            //Vertex shader
            VertexOutput vert (VertexInput v) 
            {
                VertexOutput o = (VertexOutput)0;
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                o.posCS = UnityObjectToClipPos( v.vertex );
                return o;
            }
            //fragment shader
            float4 frag(VertexOutput i) : COLOR 
            {
                //准备向量
                float3 nDir = i.nDirWS;
                float3 lDir = normalize(_WorldSpaceLightPos0.xyz);
                float3 vDir=normalize(_WorldSpaceCameraPos.xyz-i.posWS.xyz);
                float3 hDir=normalize(vDir+lDir);
                //准备中间数据_点积结果
                float ndotl=dot(nDir,lDir);
                float ndoth=dot(hDir,nDir);
                //光照模型
                float lambert = max(0,ndotl);
                float blinnPhong=pow(max(0,ndoth),_Power);

                //结果输出
                float3 finalColor=_Color* lambert+blinnPhong;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}

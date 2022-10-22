Shader "Shader Custom/OldSchoolPlus2" {
    Properties 
    {
         _BaseColor("Base Color",Color)=(0.1,0.2,0.3,1)
         _LightColor("Light Color",color)=(1,1,1,1)
         _Power("Specular Power",Range(1,90))=30
         _UpCol("Up Color",color)=(1,1,1,1)
         _MiddleCol("Middle Color",color)=(1,1,1,1)
         _DownCol("Down Color",color)=(1,1,1,1)
         _EnvIntensity("Environment Light Intensity",range(0,1))=1
         _AO("Ambient Occlusion",2d)="white"{}

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
            uniform float3 _BaseColor;
            uniform float3 _LightColor;
            uniform float3 _UpCol;
            uniform float3 _MiddleCol;
            uniform float3 _DownCol;
            uniform float _Power;
            uniform float _EnvIntensity;
            uniform sampler2D _AO;
            //Vertex Input Para
            struct VertexInput 
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv:TEXCOORD0;
            };
            //Vertex Output Para
            struct VertexOutput 
            {
                float4 pos : SV_POSITION;
                float4 posWS : TEXCOORD0;
                float3 nDirWS : TEXCOORD1;
                float2 uv:TEXCOORD2;
                SHADOW_COORDS(3)
            };
            //Vertex shader
            VertexOutput vert (VertexInput v) 
            {
                VertexOutput o = (VertexOutput)0;
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv=v.uv;
                TRANSFER_SHADOW(o)
                return o;
            }
            //fragment shader
            float4 frag(VertexOutput i) : COLOR 
            {
                //准备向量
                float3 nDir = i.nDirWS;
                float3 lDir = normalize(_WorldSpaceLightPos0.xyz);
                float3 vDir=normalize(_WorldSpaceCameraPos.xyz-i.posWS.xyz);
                float3 rDir=reflect(-lDir,nDir);

                //准备中间数据_点积结果
                float ndotl=dot(nDir,lDir);
                float rdotv=dot(rDir,vDir);

                float upMask=max(0,nDir.g);
                float downMask=max(0,-nDir.g);
                float middleMask=1-upMask-downMask;

                //光照模型
                float lambert = max(0,ndotl);
                float blinnPhong=pow(max(0,rdotv),_Power);
                float ambient=_EnvIntensity*(upMask*_UpCol+middleMask*_MiddleCol+downMask*_DownCol);

                float ao=tex2D(_AO,i.uv);
                float shadow=LIGHT_ATTENUATION(i);
                //结果输出
                float3 finalColor=(_BaseColor* lambert+blinnPhong)*shadow*_LightColor+ambient*ao;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}

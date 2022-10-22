Shader "Shader Custom/OgreMagiShader" {
    Properties 
    {
        [Header(Texture)]
        _MainTex        ("RGB: Base Color",2D)                          ="white"{}
        _NormTex        ("RGB: Normal Tex", 2D)                         = "bump" {}
        _SpecularExp    ("RGB: Specular power", 2D)                     = "white" {}
        _SpecularMask   ("RGB: Specular Mask",2D)                       ="white"{}
        _EmitTex        ("RGB: Self Illumination Mask", 2D)             = "white" {}
        _TransTex       ("RGB: Translucency Tex",2D)                    ="white"{}
        _MetalMask      ("RGB: Mentalness Mask",2D)                     ="white"{}
        _RimlightTex    ("RGB: Rim Mask",2D)                            ="white"{}
        _BaseTintTex    ("RGB: Base Tint Mask",2D)                      ="white"{}
        _Cubemap        ("RGB: Environment Tex", Cube)                  = "_Skybox" {}
        //[Header(Ramp Texture)]
        //_DiffuseRamp    ("Diffuse Ramp",2D)                             ="white"{}
        //_FesnelRampColor("Fesnel Ramp Color",2D)                        ="white"{}
        //_FesnelRampRim  ("Fesnel Ramp Rim",2D)                          ="white"{}
        //_FesnelRampSpec ("Fesnel Ramp Spec",2D)                         ="white"{}
        [Header(Diffuse)]
        _MainColor      ("Base Color", Color)                           = (0.5,0.5,0.5,1)
        _EnvDiffInt     ("Environment Diffuse Intensity", Range(0, 1))  = 0.2
        _EnvSideCol     ("Environmemt Side Color", Color)               = (0.5,0.5,0.5,1)
        _EnvDownCol     ("Environmrnt Down Color", Color)               = (0,0.4220598,1,1)
        _EnvUpperCol    ("Environment Upper Color", Color)              = (1,0,0,1)
        [Header(Specular)]
        _SpecularPower  ("Specular Power", Range(0.1, 9))               = 1
        _EnvSpecInt     ("Environment Specular Int",Range(0,5))         = 0.2
        _FresnelPower   ("FresnelPower", Range(0, 5))                   = 1
        _MipLevel       ("MipLevel", Range(1, 7))                       = 1
        [Header(Emission)]
        _EmitInt        ("Emission Intensity",range(0,5))              =1

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
            #include "Lighting.cginc"

            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            //Input Parameter
            //Texture
            uniform sampler2D   _NormTex;
            uniform float4      _NormTex_ST;
            uniform sampler2D   _MainTex;
            uniform float4      _MainTex_ST;
            uniform sampler2D   _SpecularExp;
            uniform float4      _SpecularExp_ST;
            uniform sampler2D   _SpecularMask;
            uniform float4      _SpecularMask_ST;
            uniform sampler2D   _EmitTex;
            uniform float4      _EmitTex_ST;
            uniform sampler2D   _TransTex;
            uniform float4      _TransTex_ST;
            uniform sampler2D   _MetalMask;
            uniform float4      _MetalMask_ST;
            uniform sampler2D   _RimlightTex;
            uniform float4      _RimlightTex_ST;
            uniform sampler2D   _BaseTintTex;
            uniform float4      _BaseTintTex_ST;
            uniform samplerCUBE _Cubemap;
            //Diffuse
            uniform float4      _MainColor;
            uniform float       _EnvDiffInt;
            uniform float4      _EnvSideCol;
            uniform float4      _EnvDownCol;
            uniform float4      _EnvUpperCol;
            //Specular
            uniform float       _SpecularPower;
            uniform float       _EnvSpecInt;
            uniform float       _FresnelPower;
            uniform float       _MipLevel;
            //Emission
            uniform float       _EmitInt;


            //Vertex Input Para
            struct VertexInput {
                float4 vertex   :POSITION;
                float4 normal   :NORMAL;
                float2 uv       :TEXCOORD0;
                float4 tangent  :TANGENT;
            };
            //Vertex Output Para
            struct VertexOutput {
                float4 pos    :SV_POSITION;
                float4 posWS    :TEXCOORD0;
                float3 nDirWS   :TEXCOORD1;
                float2 uv       :TEXCOORD2;
                float3 tDirWS   :TEXCOORD3;
                float3 bDirWS   :TEXCOORD4;
                SHADOW_COORDS(5)
            };
            //Vertex shader
            VertexOutput vert (VertexInput v) 
            {
                VertexOutput o = (VertexOutput)0;
                o.posWS = mul(unity_ObjectToWorld, v.vertex);
                //这个一定要有挖
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv=v.uv;
                o.nDirWS=UnityObjectToWorldNormal(v.normal);
                o.tDirWS=normalize(mul(unity_ObjectToWorld,float4(v.tangent.xyz,0.0)).xyz);
                o.bDirWS=normalize(cross(o.nDirWS,o.tDirWS)*v.tangent.w);
                TRANSFER_SHADOW(o);
                return o;
            }
            //fragment shader
            float4 frag(VertexOutput i) : COLOR 
            {
                //准备向量
                float3x3 TBN=float3x3(i.tDirWS,i.bDirWS,i.nDirWS);
                float3 nDirTS=UnpackNormal(tex2D(_NormTex,i.uv));
                float3 nDirWS=normalize(mul(nDirTS,TBN));
                float3 vDir=normalize(_WorldSpaceCameraPos.xyz-i.posWS.xyz);
                float3 lDir=_WorldSpaceLightPos0.xyz;
                float3 vrDir=reflect(-vDir,nDirWS);
          

                //Texture
                float3 var_MainTex=tex2D(_MainTex,i.uv).rgb;
                float3 var_SpecularExp=tex2D(_SpecularExp,i.uv).rgb;
                float3 var_SpecularMask=tex2D(_SpecularMask,i.uv).rgb;
                float3 var_TransTex=tex2D(_TransTex,i.uv).rgb;
                float3 var_MetalMask=tex2D(_MetalMask,i.uv).rgb;
                float3 var_RimlightTex=tex2D(_RimlightTex,i.uv).rgb;
                float3 var_BaseTintTex=tex2D(_BaseTintTex,i.uv).rgb;
                float3 var_EmitTex=tex2D(_EmitTex,i.uv).rgb;
                float3 var_Cubemap=texCUBElod(_Cubemap,float4(vrDir,lerp(_MipLevel,1.0,var_SpecularExp.r))).rgb;//lerp 越光滑反射越清晰 越不光滑 反射越模糊
                

                //中间计算
                float lDotn=dot(lDir,nDirWS);
                float vrDotl=dot(vrDir,lDir);
                float nDotv=dot(vDir,nDirWS);
                
                //光照模型
                    //光源漫反射
                    float3 lambert=max(0,lDotn);
                    //光源镜面反射
                    float3 phong=pow(max(0,vrDotl),lerp(1.0,_SpecularPower,var_SpecularExp.r));
                    //光源反射混合
                    float shadow=LIGHT_ATTENUATION(i);
                    float3 dirLight=(var_MainTex.rgb*_MainColor*lambert+phong*var_BaseTintTex*var_SpecularMask)*_LightColor0*shadow;
                    //环境漫反射
                    float upperMask=max(0,nDirWS.g);
                    float downMask=max(0,-nDirWS.g);
                    float sideMask=1-upperMask-downMask;
                    float3 envCol=_EnvUpperCol*upperMask+_EnvSideCol*sideMask+_EnvDownCol*downMask;
                    float3 envDiff=envCol*var_MainTex.rgb*_MainColor*_EnvDiffInt;
                    //环境镜面反射
                    float fresnel=pow(max(0,(1-nDotv)),_FresnelPower)*var_RimlightTex;
                    float3 envSpec=fresnel*_EnvSpecInt;
                    //环境反射混合
                    float3 envLighting=envDiff+envSpec;
                    //自发光
                    float emission=var_EmitTex*_EmitInt;
                    //最终混合
                    float3 finalRGB=dirLight+envLighting+emission;

                return fixed4(finalRGB,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}

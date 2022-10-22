Shader "Shader Custom/OgreMagiShader2.0" {
    Properties 
    {
        [Header(Texture)]
        _MainTex        ("RGB: Base Color A: Translucency",2D)                                                              = "white" {}
        _NormTex        ("RGB: Normal Tex", 2D)                                                                             = "bump"  {}
        _MaskTex        ("R: Specular Intensity G: Rimlight Intensity B: Specular Tint Color A: Specular Exponent", 2D)     = "black" {}
        _MetalnessMask  ("RGB: Mentalness Mask",2D)                                                                         = "black" {}
        _EmitTex        ("RGB: Self Illumination Mask", 2D)                                                                 = "black" {}
        _DiffuseRampTex ("Diffuse Ramp",2D)                                                                                 = "gray" {}
        _FresnelRampTex ("Fresnel Ramp",2D)                                                                                 = "gray" {}
        _Cubemap        ("RGB: Environment Tex", Cube)                                                                      = "_Skybox" {}
        [Header(Diffuse)]
        _LightCol       ("Light Color",color)                                                                               =(1.0,1.0,1.0,1.0)
        _EnvDiffInt     ("Environment Diffuse Intensity", Range(0, 5))                                                      = 0.2
        _EnvCol         ("Environmemt Color", Color)                                                                        = (0.5,0.5,0.5,1)
        [Header(Specular)]
        _SpecPow        ("Specular Power", Range(0.0, 30))                                                                  = 5
        _SpecInt        ("Specular Intensity", Range(0.0, 10))                                                              = 5
        _EnvSpecInt     ("Environment Specular Int",Range(0,10))                                                            = 0.2
        _MipLevel       ("MipLevel", Range(1, 7))                                                                           = 1
        [Header(RimLight)]                                                               
        [HDR]
        _RimCol        ("RimLight Color",color)                                                                             =(1.0,1.0,1.0,1.0)
        [Header(Emission)]
        _EmitInt        ("Emission Intensity",range(0.0,10.0))                                                              =1.0
        [HideInInspector]
        _Cutoff         ("Alpha cutoff",range(0,1))                                                                         =0.5
        [HideInInspector]
        _Color      ("Main Color",color)=(1,1,1,1)//透贴投影所必须的参数
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
            Cull off //关闭背面剔除            
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
            uniform sampler2D   _MaskTex;
            uniform float4      _MaskTex_ST;
            uniform sampler2D   _MetalnessMask;
            uniform float4      _MetalnessMask_ST;
            uniform sampler2D   _EmitTex;
            uniform float4      _EmitTex_ST;
            uniform sampler2D   _DiffuseRampTex;
            uniform float4      _DiffuseRampTex_ST;
            uniform sampler2D   _FresnelRampTex;
            uniform float4      _FresnelRampTex_ST;
            uniform samplerCUBE _Cubemap;
            //Diffuse
            uniform float3      _LightCol;
            uniform float       _EnvDiffInt;
            uniform float4      _EnvCol;
            //Specular
            uniform float       _SpecPow;
            uniform float       _SpecInt;
            uniform float       _EnvSpecInt;
            uniform float       _MipLevel;
            //Rimlight
            uniform float       _RimInt;
            uniform float4      _RimCol;
            //Emission
            uniform float       _EmitInt;
            //Cutoff
            uniform float       _Cutoff;


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
                
                //中间计算
                float lDotn=dot(lDir,nDirWS);
                float vrDotl=dot(vrDir,lDir);
                float nDotv=dot(vDir,nDirWS);

                //采样纹理
                float4 var_MainTex=tex2D(_MainTex,i.uv);
                float4 var_MaskTex=tex2D(_MaskTex,i.uv);
                float  var_MetalnessMask=tex2D(_MetalnessMask,i.uv).r;
                float  var_EmitTex=tex2D(_EmitTex,i.uv).r;
                float3 var_FresnelRampTex=tex2D(_FresnelRampTex,nDotv);
                float3 var_Cubemap=texCUBElod(_Cubemap,float4(vrDir,lerp(_MipLevel,1.0,var_MaskTex.a))).rgb;//lerp 越光滑反射越清晰 越不光滑 反射越模糊

                //提取信息
                float3 baseCol=var_MainTex.rgb;
                float  opacity=var_MainTex.a;
                float  specInt=var_MaskTex.r;
                float  rimInt=var_MaskTex.g;
                float  specTint=var_MaskTex.b;
                float  specPow=var_MaskTex.a;
                float  metallic=var_MetalnessMask;
                float  emitInt=var_EmitTex;
                float3 envCube=var_Cubemap;
                float  shadow=LIGHT_ATTENUATION(i);
                               
                //光照模型
                    //漫反射颜色，镜面反射颜色
                    half3 diffCol=lerp(baseCol,float3(0.0,0.0,0.0),metallic);//金属度越强 漫反射颜色越弱
                    half3 specCol=lerp(baseCol,float3(0.3,0.3,0.3),specTint);//0.3是经验值，高光颜色的偏移这里是
                    //菲涅尔
                    half3 Fresnel=lerp(var_FresnelRampTex,0.0,metallic);
                    half fresnelCol=Fresnel.r;
                    half fresnelRim=Fresnel.g;
                    half fresnelSpec=Fresnel.b;
                    //光源漫反射
                    float halfLambert=lDotn*0.5+0.5;
                    float  var_DiffuseRampTex=tex2D(_DiffuseRampTex,float2(halfLambert,0.2)).r;
                    float3 dirDiff=diffCol*var_DiffuseRampTex*_LightCol;
                    //主光镜面反射
                    float phong=pow(max(vrDotl,0),specPow*_SpecPow);
                    float spec=phong*max(0.0,lDotn);//想让漫反射黑的地方 镜面反射也黑一点
                    spec=max(spec,fresnelSpec);
                    spec=spec*_SpecInt;
                    float3 dirSpec=specCol*spec*_LightCol;
                    //环境漫反射
                    float3 envDiff=diffCol*_EnvCol*_EnvDiffInt;
                    //环境镜面反射
                    float reflectInt=max(fresnelSpec,metallic)*specInt;
                    float3 envSpec=specCol*reflectInt*envCube*_EnvSpecInt;
                    //轮廓光
                    float3 rimLight=_RimCol*rimInt*fresnelRim*max(0,nDirWS.g);
                    //自发光
                    float3 emission=_EmitInt*emitInt*diffCol;
                    //透明剪切
                    clip(opacity-_Cutoff);
               //最终混合
               float3 finalRGB=(dirDiff+dirSpec)*shadow+envDiff+envSpec+rimLight+emission;

                return fixed4(finalRGB,1);
            }
            ENDCG
        }
    }
    FallBack "Legacy Shaders/Transparent/Cutout/VertexLit"//支持透贴阴影
}

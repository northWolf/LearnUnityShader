Shader "Unlit/TheFirstShader"
{
    Properties
    {
        _MainTex ("我是2D纹理", 2D) = "gray" {}
        _Color("我是Color",Color) = (1,1,1,1)
        [HDR]_Color2("我是Color2",Color) = (1,1,1,1)
        _Int("我是Int",Int) = 1
        _Float("我是Float",Float) = 0.5
        _Float2("我是区间Float",Range(0,0.8)) = 0.1
        [PowerSlider(3)]_Float3("我是带PowerSlider的区间Float",Range(0,0.8)) = 0.1
        [IntRange]_Float4("我是代替Int的Float",Range(0,10)) = 2
        [IntRange][PowerSlider(3)]_Float5("我是带PowerSlider的代替Int的Float",Range(0,10)) = 2
         [Toggle]_Float6("我是开关Float",Float) = 0
         [Enum(UnityEngine.Rendering.CullMode)]_Float7("我是枚举Float",Float) = 0
         _Vector("我是Vector",Vector) = (0,0,0,0)
         [NoScaleOffset][Normal]_NormalTex ("指定用于接受法线贴图", 2D) = "bump" {}
         _Texture3D("我是3D纹理",3D) = ""{}
         _CubeMap("我是Cube纹理",Cube) = ""{}
    }
    
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            float4 _Color;
            
            struct appdata
            {
                float4 vertex:POSITION;
                float2 uv:TEXCOORD;
            };
            
            struct v2f
            {
                float4 pos:SV_POSITION;
                float2 uv:TEXCOORD;
            };
            
            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }
            
            float4 frag(v2f i):SV_TARGET
            {
                return fixed4(i.uv,0,1);
            }
            ENDCG
        }
    }
    
    FallBack "Diffuse"
    CustomEditor "EditorName"
}

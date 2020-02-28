Shader "Learn/SingleTexture"
{
    Properties
    {
        _Diffuse("Diffuse",Color) = (1,1,1,1)
        _Specular("Specular",Color) = (1,1,1,1)
        _Gloss("Gloss",Range(8.0,256)) = 20
        _MainTex("Main Texture",2D) = "white"{}
    }
    
    SubShader
    {
       

        Pass
        {
            Tags {"LightMode" = "ForwardBase"}
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Lighting.cginc"
            
            fixed4 _Diffuse;
            fixed4 _Specular;
            float _Gloss;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            struct a2v
            {
                float4 vertex:POSITION;
                float4 normal:NORMAL;
                float4 texcoord:TexCOORD0;
            };
            
            struct v2f
            {
                float4 pos:SV_POSITION;
                float3 worldNormal:TEXCOORD0;
                float3 worldPos:TEXCOORD1;
                float2 uv:TEXCOORD2;
            };
            
            v2f vert(a2v v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                
                fixed3 worldNormal = mul(v.normal,(float3x3) unity_WorldToObject);
                o.worldNormal = worldNormal;
                o.worldPos = mul(unity_ObjectToWorld,v.vertex).xyz;
                o.uv = v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                
                return o;
            }
            
            fixed4 frag(v2f i):SV_Target
            {
                fixed3 worldNormal = normalize(i.worldNormal);
                fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
                
                fixed3 albedo = tex2D(_MainTex,i.uv).rgb * _Diffuse.rgb;
                
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz * albedo;
                
                fixed3 diffuse = unity_LightColor[0].rgb * albedo * saturate(dot(worldNormal,worldLightDir));
                
                fixed3 reflectDir = normalize(reflect(-worldLightDir,worldNormal));
             
                fixed3 viewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
                fixed3 halfDir = normalize(worldLightDir + viewDir);
                fixed3 specular = unity_LightColor[0].rgb * _Specular.rgb * pow(saturate(dot(reflectDir,halfDir)),_Gloss);
                  
                return fixed4(ambient + diffuse + specular,1.0);
                
            }
            ENDCG
        }
    }
}
